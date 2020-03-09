-- Original: Motenten / Modified: Ballzack
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+` ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--  Abilities:  [ CTRL+- ]          Quick Draw primary shot element cycle forward.
--              [ CTRL+= ]          Quick Draw primary shot element cycle backward.
--              [ ALT+- ]           Quick Draw secondary shot element cycle forward.
--              [ ALT+= ]           Quick Draw secondary shot element cycle backward.
--              [ CTRL+[ ]          Quick Draw toggle target type.
--              [ CTRL+] ]          Quick Draw toggle use secondary shot.
--
--              [ CTRL+C ]          Crooked Cards
--              [ CTRL+` ]          Double-Up
--              [ CTRL+F ]          Fold
--              [ CTRL+S ]          Snake Eye
--              [ CTRL+T ]    Triple Shot
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--              [ WIN+W ]           Toggle Ranged Weapon Lock
--
--  WS:         [ Home ]    Savage Blade
--              [ Delete ]    Last Stand
--              [ End ]    Leaden Salute
--              [ @End ]    Wildfire
--              [ @Home ]    Aeolian Edge
--              [ @Delete ]    Evisceration
--
--  RA:         [ Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c qd                         Uses the currently configured shot on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c qd t                       Uses the currently configured shot on the target, but forces use of <t>.
--
--  gs c cycle mainqd               Cycles through the available steps to use as the primary shot when using
--                                  one of the above commands.
--  gs c cycle altqd                Cycles through the available steps to use for alternating with the
--                                  configured main shot.
--  gs c toggle usealtqd            Toggles whether or not to use an alternate shot.
--  gs c toggle selectqdtarget      Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
--
--  gs c toggle LuzafRing           Toggles use of Luzaf Ring on and off


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- QuickDraw Selector
    state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(false, 'Select Quick Draw Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Enhance', 'Potency', 'TH'}

    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    elemental_ws = S{'Aeolian Edge', 'Leaden Salute', 'Wildfire'}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    define_roll_values()

    lockstyleset = 3
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('STP', 'Normal', 'Acc', 'HighAcc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

    state.WeaponSet = M{['description']='Weapon Set', 'LeadenMelee', 'LeadenRanged', 'LastStandMelee', 'LastStandRanged', 'SavageMelee'}
    state.CP = M(false, "Capacity Points Mode")
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Orichalc. Bullet"
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 10

    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        send_command('lua l gearinfo')
    end

    send_command('bind @t gs c cycle treasuremode')
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind ^c input /ja "Crooked Cards" <me>')
    send_command('bind ^s input /ja "Snake Eye" <me>')
    send_command('bind ^f input /ja "Fold" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command ('bind @` gs c toggle LuzafRing')
--[[
    send_command('bind ^insert gs c cycleback mainqd')
    send_command('bind ^delete gs c cycle mainqd')
    send_command('bind ^home gs c cycle altqd')
    send_command('bind ^end gs c cycleback altqd')
    send_command('bind ^pageup gs c toggle selectqdtarget')
    send_command('bind ^pagedown gs c toggle usealtqd')
--]]
    send_command('bind @c gs c toggle CP')
    send_command('bind @q gs c cycle QDMode')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind ^t input /ja "Triple Shot" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    end

    send_command('bind Home input /ws "Savage Blade" <t>')
    send_command('bind Delete input /ws "Last Stand" <t>')
    send_command('bind End input /ws "Leaden Salute" <t>')
    send_command('bind @End input /ws "Wildfire" <t>')
    send_command('bind @Home input /ws "Aeolian Edge" <t>')
    send_command('bind @Delete input /ws "Evisceration" <t>')

    send_command('bind numpad0 input /ra <t>')

    select_default_macro_book()
    set_lockstyle()

    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @t')
    send_command('unbind ^`')
    send_command('unbind ^c')
    send_command('unbind ^s')
    send_command('unbind ^f')
    send_command('unbind !`')
    send_command('unbind @`')
    --[[send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')--]]
    send_command('unbind @c')
    send_command('unbind @q')
	send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind @w')
    send_command('unbind ^t')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind Home')
    send_command('unbind Delete')
    send_command('unbind End')
    send_command('unbind @End')
    send_command('unbind @Home')
    send_command('unbind @Delete')
    send_command('unbind numpad0')

    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        send_command('lua u gearinfo')
    end

end

-- Define sets and vars used by this job file.
function init_gear_sets()
include('Colonelace-Items.lua')
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}

    sets.precast.CorsairRoll = {
		main={name="Rostam", bag="Wardrobe 1", priority=1},
		sub={name="Nusku Shield", priority=2},
        head="Lanun Tricorne +3",
		neck="Regal Necklace",
        ear1="Genmei Earring", --2/0
        ear2="Etiolation Earring", --0/3
        body="Meg. Cuirie +2", --8/0
        hands="Chasseur's Gants +1",
		ring1="Vocane Ring", --7/7
        ring2="Defending Ring", --10/10
        back=cor_snap_jse_back,
        waist="Flume Belt +1", --4/0
        legs="Desultor Tassets",
        feet="Lanun Bottes +3"} --6/0

    sets.precast.CorsairRoll.Gun = set_combine(sets.precast.CorsairRoll.Engaged, {range="Compensator"})
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

    sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll, {ring1="Luzaf's Ring"})
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}

    sets.precast.Waltz = {
		neck="Phalaina Locket",
        body="Passion Jacket",
        ring1="Asklepian Ring",
        waist="Gishdubar Sash"}

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        head="Carmine Mask +1", --14
		neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        body="Taeon Tabard", --9
        hands="Leyline Gloves", --8
		ring1="Prolix Ring", --2
        ring2="Kishar Ring", --4
		back=cor_fc_jse_back,
        legs="Rawhide Trousers", --5
        feet="Carmine Greaves +1"} --8

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
        ring1="Lebeche Ring"})

    -- (10% Snapshot from JP Gifts)
    sets.precast.RA = {
        ammo=gear.RAbullet,
        head=taeon_snap_head, --10/0
        body="Oshosi Vest +1", --14/0
        hands="Carmine Fin. Ga. +1", --8/11
		back=cor_snap_jse_back, --10/0
        waist="Yemaya Belt", --0/5
        legs=adhemar_d_legs, --9/10
        feet="Meg. Jam. +2", --10/0
        } --61/26

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        body="Laksa. Frac +3", --0/20
        }) --47/46

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        head="Chass. Tricorne +1", --0/14
		waist="Impulse Belt", --3/0
        feet="Pursuer's Gaiters", --0/10
        }) --30/65


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo=gear.WSbullet,
        head="Lanun Tricorne +3",
		neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
		ring1="Epaminondas's Ring",
		ring2="Regal Ring",
        back=cor_agi_wsd_jse_back,
        waist="Fotia Belt",
        legs=herculean_agi_wsd_legs,
        feet="Lanun Bottes +3"}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
         neck="Comm. Charm +2",
		 ear2="Telos Earring",
		 ring1={name="Hajduk Ring +1", bag="wardrobe3"},
		 ring1={name="Hajduk Ring +1", bag="wardrobe4"},
		 waist="K. Kachina Belt +1"})

    sets.precast.WS['Last Stand'] = sets.precast.WS

    sets.precast.WS['Last Stand'].Acc = sets.precast.WS.Acc

    sets.precast.WS['Wildfire'] = {
        ammo=gear.MAbullet,
        head=herculean_mab_wsd_head,
		neck="Comm. Charm +2",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        body="Lanun Frac +3",
        hands=herculean_mab_wsd_hands,
		ring1="Epaminondas's Ring",
        ring2="Dingir Ring",
        back=cor_mab_wsd_jse_back,
        waist="Skrymir Cord",
        legs=herculean_mab_wsd_legs,
        feet="Lanun Bottes +3"}

    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
        head="Pixie Hairpin +1",
        ear1="Moonshade Earring",
        ring1="Archon Ring",
		waist="Svelt. Gouriz +1"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,{
        head="Adhemar Bonnet +1",
        ear2="Mache Earring +1",
        body="Abnoba Kaftan",
        hands="Mummu Wrists +2",
		ring1="Mummu Ring",
        back=cor_da_jse_back,
        legs=herculean_cdmg_legs,
        feet="Mummu Gamash. +2"})

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'],{
        head="Mummu Bonnet +2",
		neck="Combatant's Torque",
		ear2="Telos Earring",
		body="Mummu Jacket +2",
		ring1={name="Ramuh Ring +1", bag="wardrobe3"},
		ring2={name="Ramuh Ring +1", bag="wardrobe4"},
		waist="Grunfeld Rope"})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,{
        head=herculean_str_wsd_head,
		neck="Comm. Charm +2",
		back=cor_str_wsd_jse_back,
		waist="Prosilio Belt +1",
		legs=herculean_str_wsd_legs})

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        head="Meghanada Visor +2",
		neck="Combatant's Torque",
		ear2="Telos Earring",
		waist="Grunfeld Rope"})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",
		ear2="Telos Earring",
		hands="Meg. Gloves +2",
		ring1="Rufescent Ring",
		back=cor_mnd_da_jse_back,
		legs="Meg. Chausses +2",
		feet=herculean_ta_feet}) --MND

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
        head="Meghanada Visor +2",
        waist="Kentarch Belt +1"})

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {
        ear1="Moonshade Earring",
		hands="Carmine Fin. Ga. +1"})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        legs="Carmine Cuisses +1", --20
        ring1="Evanescence Ring"} --5

    sets.midcast.Cure = {}

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.CorsairShot = {
        ammo=gear.QDbullet,
        head=herculean_mab_head,
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body="Lanun Frac +3",
		hands="Carmine Fin. Ga. +1",
		ring1="Fenrir Ring +1",
		ring2="Dingir Ring",
		back=cor_qd_jse_back,
		waist="Skrymir Cord",
		legs=herculean_mab_legs,
		feet="Lanun Bottes +3"}

    sets.midcast.CorsairShot.STP = {
        ammo=gear.QDbullet,
        head="Blood Mask",
		neck="Iskur Gorget",
		ear1="Dedition Earring",
		ear2="Telos Earring",
		body="Oshosi Vest +1",
		hands="Schutzen Mittens",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
		back=cor_qd_jse_back,
		waist="Kentarch Belt +1",
		legs="Chas. Culottes +1",
		feet="Carmine Greaves +1"}

    sets.midcast.CorsairShot.Resistant = set_combine(sets.midcast.CorsairShot, {
        head="Laksa. Tricorne +3",
		neck="Comm. Charm +2",
		ear1="Digni. Earring",
		ear2="Gwati Earring",
		body="Malignance Tabard",
		hands="Laksa. Gants +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2="Regal Ring",
		waist="K. Kachina Belt +1",
		legs="Malignance Tights",
		feet="Laksa. Boots +3"})

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Resistant
    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot.Resistant
    sets.midcast.CorsairShot.Enhance = {head="Blood Mask", feet="Chass. Bottes +1"}

    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.RAbullet,
        head="Meghanada Visor +2",
		neck="Iskur Gorget",
		ear1="Enervating Earring",
		ear2="Telos Earring",
		body="Mummu Jacket +2",
		hands=adhemar_c_hands,
		ring1="Ilabrat Ring",
		ring2="Dingir Ring",
		back=cor_ra_jse_back,
		waist="Yemaya Belt",
		legs=adhemar_c_legs,
		feet="Adhe. Gamashes +1"}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		body="Laksa. Frac +3",
		ring2={name="Hajduk Ring +1", bag="wardrobe4"},
		feet="Meg. Jam. +2"})

    sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {
		neck="Comm. Charm +2",
		hands="Meg. Gloves +2",
        ring1="Regal Ring",
		waist="K. Kachina Belt +1",
		legs="Laksa. Trews +3"})

    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
		body="Meg. Cuirie +2",
		hands="Mummu Wrists +2",
		ring1="Mummu Ring",
		ring2="Begrudging Ring",
		waist="K. Kachina Belt +1",
		legs="Darraigner's Brais",
		feet="Osh. Leggings +1"})

    sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
        ear1="Dedition Earring",
		body="Oshosi Vest +1",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
		feet="Carmine Greaves +1"})

    sets.TripleShot = {
        head="Oshosi Mask +1", --5
        body="Chasseur's Frac +1", --12
        hands="Lanun Gants +3",
        legs="Osh. Trousers +1", --6
        feet="Osh. Leggings +1", --3
        } --27

    sets.TripleShotCritical = {
        head="Meghanada Visor +2",
        waist="K. Kachina Belt +1"}


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
        ammo=gear.MAbullet,
        head="Meghanada Visor +2",
		neck="Loricate Torque +1",
		ear1="Sanare Earring",
		ear2="Hearty Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		ring2={name="Chirich Ring +1", bag="wardrobe4"},
		back="Moonlight Cape",
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Meg. Jam. +2"}

    sets.idle.DT = set_combine(sets.idle, {
        ear1="Genmei Earring", --2/0
        ear2="Etiolation Earring", --0/3
		ring1="Vocane Ring", --7/7
        ring2="Defending Ring"}) --10/10

    sets.idle.Refresh = set_combine(sets.idle, {
        --head=gear.Herc_Idle_head,
        --body="Mekosu. Harness",
        --legs="Rawhide Trousers",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"}})

    --sets.idle.Town = set_combine(sets.idle, {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT

    sets.defense.MDT = {
		head="Volte Cap",
		neck="Warder's Charm +1",
        ear1="Sanare Earring",
        ear2="Etiolation Earring", --0/3
        body="Oshosi Vest +1",
        --hands="Oshosi Gloves +1",
		ring1="Vocane Ring", --7/(-1)
        ring2="Defending Ring", --10/10
        back=cor_snap_jse_back,
        waist="Carrier's Sash",
        legs="Osh. Trousers +1",
        feet="Osh. Leggings +1"}

    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        sub="Nusku Shield",
		head="Adhemar Bonnet +1",
		neck="Iskur Gorget",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body=herculean_ta_body,
		hands=adhemar_b_hands,
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=cor_da_jse_back,
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet=herculean_ta_feet}

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        head="Dampening Tam",
		neck="Combatant's Torque",
        ring2={name="Chirich Ring +1", bag="wardrobe3"}})

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
		ear2="Telos Earring",
        waist="Kentarch Belt +1"})

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        head="Carmine Mask +1",
        ear1="Mache Earring +1",
		ring1={name="Ramuh Ring +1", bag="wardrobe3"},
		waist="Olseni Belt",
		legs="Carmine Cuisses +1"})

    sets.engaged.STP = set_combine(sets.engaged, {
        ear1="Dedition Earring",
		ring2={name="Chirich Ring +1", bag="wardrobe4"},
		waist="Kentarch Belt +1",
		feet="Carmine Greaves +1"})

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        head=herculean_dw_head, --6
		neck="Iskur Gorget",
		ear1="Eabani Earring", --4
		ear2="Suppanomimi", --5
		body="Adhemar Jacket +1", --6
		hands="Floral Gauntlets", --5
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=cor_da_jse_back,
		waist="Reiki Yotai", --7
		legs="Carmine Cuisses +1", --6
		feet=taeon_dw_feet} --9 (48%)

    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {})

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {})

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {})

    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {ring1={name="Chirich Ring +1", bag="wardrobe3"}})

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = {
        head="Adhemar Bonnet +1",
		neck="Iskur Gorget",
		ear1="Eabani Earring", --4
		ear2="Suppanomimi", --5
		body="Adhemar Jacket +1", --6
		hands="Floral Gauntlets", --5
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=cor_da_jse_back,
		waist="Reiki Yotai", --7
		legs="Carmine Cuisses +1", --6
		feet=taeon_dw_feet} --9 (42%)

    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {})

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {})

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {})

    sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {ring1={name="Chirich Ring +1", bag="wardrobe3"}})

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
        head="Adhemar Bonnet +1",
		neck="Iskur Gorget",
		ear1="Eabani Earring", --4
		ear2="Suppanomimi", --5
		body="Adhemar Jacket +1", --6
		hands=adhemar_b_hands,
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=cor_da_jse_back,
		waist="Reiki Yotai", --7
		legs="Samnuha Tights",
		feet=taeon_dw_feet} --9 (31%)

    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {})

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {})

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {})

    sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {ring1={name="Chirich Ring +1", bag="wardrobe3"}})

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
        head="Adhemar Bonnet +1",
		neck="Iskur Gorget",
		ear1="Eabani Earring", --4
		ear2="Cessance Earring", --5
		body="Adhemar Jacket +1", --6
		hands=adhemar_b_hands,
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=cor_da_jse_back,
		waist="Reiki Yotai", --7
		legs="Samnuha Tights",
		feet=taeon_dw_feet} --9 (31%)

    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {})

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {})

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {})

    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {ring1={name="Chirich Ring +1", bag="wardrobe3"}})

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        head="Adhemar Bonnet +1",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Suppanomimi", --5
		body="Adhemar Jacket +1", --6
		hands=adhemar_b_hands,
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=cor_da_jse_back,
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet=herculean_ta_feet} -- (11%)

    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {})

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {})

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {})

    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
		ear1="Dedition Earring",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		waist="Kentarch Belt +1",
        feet="Carmine Greaves +1"})

    sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {back=cor_dw_jse_back})
    sets.engaged.DW.LowAcc.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {back=cor_dw_jse_back})
    sets.engaged.DW.MidAcc.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {back=cor_dw_jse_back})
    sets.engaged.DW.HighAcc.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHaste, {back=cor_dw_jse_back})
    sets.engaged.DW.STP.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHaste, {back=cor_dw_jse_back})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        head=gear.Adhemar_D_head, --4/0
        neck="Loricate Torque +1", --6/6
        ring2="Defending Ring", --10/10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

	sets.FullTP = {ear1="Crematio Earring"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

    sets.TreasureHunter = {head="Wh. Rarab Cap +1", feet=herculean_th_feet, waist="Chaac Belt"}

    sets.LeadenMelee = {main="Rostam", sub="Tauret", ranged="Fomalhaut"}
    sets.LeadenRanged = {main="Naegling", sub="Tauret", ranged="Fomalhaut"}
    sets.LastStandMelee = {main="Naegling", sub="Blurred Knife +1", ranged="Fomalhaut"}
    sets.LastStandRanged = {main="Rostam", sub="Nusku Shield", ranged="Fomalhaut"}
    sets.SavageMelee = {main="Naegling", sub="Blurred Knife +1", ranged="Ataktos"}
	
	--[[
	sets.LeadenMelee = {main="Rostam", sub="Blurred Knife +1", ranged="Death Penalty"}
    sets.LeadenAccMelee = {main="Rostam", sub="Tauret", ranged="Death Penalty"}
    sets.LeadenRanged = {main="Naegling", sub="Tauret", ranged="Death Penalty"}
    sets.LastStandMelee = {main="Rostam", sub="Blurred Knife +1", ranged="Fomalhaut"}
    sets.LastStandRanged = {main="Rostam", sub="Nusku Shield", ranged="Fomalhaut"}
    sets.SavageMelee = {main="Naegling", sub="Blurred Knife +1", ranged="Ataktos"}
	--]]

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- Gear
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' then
            equip(sets.precast.CorsairRoll.Gun)
        end
        if state.LuzafRing.value then
            equip(sets.precast.LuzafRing)
        end
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    end

    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' then
            equip(sets.precast.CorsairRoll.Gun)
        end
    elseif spell.action_type == 'Ranged Attack' then
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
    elseif spell.type == 'WeaponSkill' then
        -- Replace TP-bonus gear if not needed.
        if spell.english == 'Leaden Salute' or spell.english == 'Aeolian Edge' and player.tp > 2900 then
            equip(sets.FullTP)
        end
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
		if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
			-- Matching double weather (w/o day conflict).
			if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
				equip({waist="Hachirin-no-Obi"})
			-- Target distance under 1.7 yalms.
			elseif spell.target.distance < (1.7 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
			-- Matching day and weather.
			elseif spell.element == world.day_element and spell.element == world.weather_element then
				equip({waist="Hachirin-no-Obi"})
			-- Target distance under 8 yalms.
			elseif spell.target.distance < (8 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
			-- Match day or weather.
			elseif spell.element == world.day_element or spell.element == world.weather_element then
				equip({waist="Hachirin-no-Obi"})
			end
		end
        if state.QDMode.value == 'Enhance' then
            equip(sets.midcast.CorsairShot.Enhance)
        elseif state.QDMode.value == 'TH' then
            equip(sets.midcast.CorsairShot)
            equip(sets.TreasureHunter)
        elseif state.QDMode.value == 'STP' then
            equip(sets.midcast.CorsairShot.STP)
        end
    elseif spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Armageddon" then
                equip(sets.TripleShotCritical)
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.main == "Armageddon" then
            equip(sets.midcast.RA.Critical)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and not spell.interrupted then
        display_roll_info(spell)
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            --add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            --send_command('@input /p Doomed.')
            disable('neck','ring1','ring2','waist')
        else
            enable('neck','ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('ranged')
    else
        enable('ranged')
    end

    equip(sets[state.WeaponSet.current])
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    determine_haste_group()
end

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    return idleSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local qd_msg = '(' ..string.sub(state.QDMode.value,1,1).. ')'
    
    local e_msg = state.Mainqd.current
    if state.UseAltqd.value == true then
        e_msg = e_msg .. '/'..state.Altqd.current
    end

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' QD' ..qd_msg.. ': '  ..string.char(31,001)..e_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
    end)

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doqd = ''
        if state.UseAltqd.value == true then
            doqd = state[state.Currentqd.current..'qd'].current
            state.Currentqd:cycle()
        else
            doqd = state.Mainqd.current
        end

        send_command('@input /ja "'..doqd..'" <t>')
    end

    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function define_roll_values()
    rolls = {
        ["Corsair's Roll"] =    {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"] =        {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"] =     {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"] =        {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"] =      {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"] =     {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"] =      {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"] =       {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"] =       {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"] =        {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"] =      {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"] =     {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"] =      {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"] =    {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"] =       {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"] =    {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"] =     {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"] =     {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"] =    {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"] =     {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"] =     {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"] =    {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"] =    {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] =  {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"] =      {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"] =      {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] =  {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"] =    {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and string.char(129,157)) or ''

    if rollinfo then
        add_to_chat(001, string.char(129,115).. '  ' ..string.char(31,210)..spell.english..string.char(31,001)..
            ' : '..rollinfo.bonus.. ' ' ..string.char(129,116).. ' ' ..string.char(129,195)..
            '  Lucky: ' ..string.char(31,204).. tostring(rollinfo.lucky)..string.char(31,001).. ' /' ..
            ' Unlucky: ' ..string.char(31,167).. tostring(rollinfo.unlucky)..string.char(31,002)..
            '  ' ..rollsize)
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

windower.register_event('zone change', 
    function()
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            send_command('gi ugs true')
        end
    end
)

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 2)
	elseif player.sub_job == 'DNC' then
        set_macro_page(2, 2)	
    else
        set_macro_page(1, 2)
    end
end
function set_lockstyle()
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end