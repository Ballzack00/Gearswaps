-- Original: Motenten / Modified: Ballzack
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ CTRL+` ]          Cycle Treasure Hunter Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ ALT+` ]           Flee
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--              [ CTRL+Numpad0 ]    Sneak Attack
--              [ CTRL+Numpad. ]    Trick Attack
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  WS:         [ Home ]    Exenterator
--              [ End ]    Evisceration
--              [ Delete ]    Rudra's Storm
--              [ WIN+Home ]    Mandalic Stab
--              [ WIN+Delete ]    Aeolian Edge
--
--

-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
--
--  TH Modes:  None                 Will never equip TH gear
--             Tag                  Will equip TH gear sufficient for initial contact with a mob (either melee,
--
--             SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
--             Fulltime - Will keep TH gear equipped fulltime


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
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    state.CP = M(false, "Capacity Points Mode")

    lockstyleset = 2
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT')

    --state.WeaponLock = M(false, 'Weapon Lock')
	--state.AttackMode = M{['description']='Attack', 'Uncapped', 'Capped'}

    send_command('lua l gearinfo')

    send_command('bind ^` gs c cycle treasuremode')
    send_command('bind !` input /ja "Flee" <me>')
    send_command('bind @c gs c toggle CP')
	--send_command('bind @a gs c cycle AttackMode')
	--send_command('bind @w gs c toggle WeaponLock')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind ^numpad/ input /ja "Meditate" <me>')
        send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
        send_command('bind ^numpad- input /ja "Third Eye" <me>')
    end

    send_command('bind Home input /ws "Exenterator" <t>')
    send_command('bind End input /ws "Evisceration" <t>')
    send_command('bind Delete input /ws "Rudra\'s Storm" <t>')
	send_command('bind @Home input /ws "Mandalic Stab" <t>')
    send_command('bind @Delete input /ws "Aeolian Edge" <t>')

    send_command('bind @s input /ja "Sneak Attack" <me>')
    send_command('bind @t input /ja "Trick Attack" <me>')

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
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @c')
    --send_command('unbind @a')
    --send_command('unbind @w')
	send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind Home')
    send_command('unbind End')
    send_command('unbind Delete')
	send_command('unbind @Home')
    send_command('unbind @Delete')
	send_command('unbind @s')
    send_command('unbind @t')

    send_command('lua u gearinfo')

end


-- Define sets and vars used by this job file.
function init_gear_sets()
include('Malothar-Items.lua')
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.TreasureHunter = {
		hands="Plun. Armlets +3", --4
		feet="Skulk. Poulaines +1"} --4

    sets.buff['Sneak Attack'] = {}

    sets.buff['Trick Attack'] = {}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = set_combine(sets.TreasureHunter, {head="Skulker's Bonnet +1"})
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Flee'] = {feet="Pill. Poulaines +3"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = set_combine(sets.TreasureHunter, {body="Skulker's Vest +1"})

    sets.precast.JA['Steal'] = {
        ammo="Barathrum", --3
		neck="Pentalagus Charm", --2
        hands="Pill. Armlets +3", --2
		--legs="Asn. Culottes +1", --5
        feet="Pill. Poulaines +3"}

    sets.precast.JA['Despoil'] = {ammo="Barathrum", legs="Skulk. Culottes +1", feet="Skulk. Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets +3"}
    sets.precast.JA['Feint'] = {legs="Plun. Culottes +3"}
    --sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    --sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    sets.precast.Waltz = {
        ammo="Yamarang",
		neck="Phalaina Locket",
        body="Passion Jacket",
		ring1="Asklepian Ring",
        waist="Gishdubar Sash",
        legs="Dashing Subligar"}

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head="Herculean Helm", --7
		neck="Orunmila's Torque", --5
		ear2="Loquac. Earring", --2
		ear2="Enchntr. Earring +1", --2
        body="Taeon Tabard", --9
        hands="Leyline Gloves", --8
		ring1="Rahab Ring", --2
		ring2="Prolix Ring", --2
		back=thf_fc_jse_back, --10
        legs="Rawhide Trousers"} --5

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck="Magoraga Beads",
        body="Passion Jacket",
        ring2="Lebeche Ring"})

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        head="Pill. Bonnet +3",
		neck="Fotia Gorget",
        ear1="Sherida Earring",
		ear2="Moonshade Earring",
        body="Plunderer's Vest +3",
        hands="Meg. Gloves +2",
		ring1="Regal Ring",
		ring2="Epaminondas's Ring",
        waist="Fotia Belt",
        legs="Lustr. Subligar +1",
        feet="Lustra. Leggings +1"} -- default set

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="C. Palug Stone",
		ear2="Telos Earring",
        legs="Meg. Chausses +2"})

    sets.precast.WS.Critical = {
		ammo="Yetshila +1",
		head="Pill. Bonnet +3",
		neck="Asn. Gorget +2",
        ear1="Sherida Earring",
		ear2="Moonshade Earring",
        body="Plunderer's Vest +3",
        hands="Meg. Gloves +2",
		ring1="Ilabrat Ring",
        ring2="Epaminondas's Ring",
		back=thf_dex_wsd_jse_back,
        waist="Artful Belt +1",
        legs="Lustr. Subligar +1",
        feet="Lustra. Leggings +1"}
		
    --[[sets.precast.WS.Critical.Uncapped = set_combine(sets.precast.WS.Critical,{
        ring2="Regal Ring",
        waist="Grunfeld Rope",
        legs="Plun. Culottes +3"})]]--

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        ammo="Seeth. Bomblet +1",
		head="Plun. Bonnet +3",
		hands="Mummu Wrists +2",
		ring1="Ilabrat Ring",
		back=thf_agi_da_jse_back,
		legs="Meg. Chausses +2",
		feet="Plun. Poulaines +3"})

    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
	--[[sets.precast.WS['Exenterator'].Unpacced	= set_combine(sets.precast.WS['Exenterator'], {
        ear1="Tati Earring +1",
        hands=herculean_ta_hands,})]]--

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        head="Adhemar Bonnet +1",
        hands="Mummu Wrists +2",
		ring1="Begrudging Ring",
        ring2="Mummu Ring",
		back=thf_crit_jse_back,
        legs="Pill. Culottes +3",
        feet="Lustra. Leggings +1"})

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	--[[sets.precast.WS['Evisceration'].Uncapped = set_combine(sets.precast.WS['Evisceration'], {
		hands="Adhemar Wrist. +1",
		ring1="Regal Ring",
		feet="Adhe. Gamashes +1"})]]--

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
        ammo="C. Palug Stone",
		neck="Asn. Gorget +2",
        body=herculean_wsd_body,
		ring2="Ilabrat Ring",
        waist="Artful Belt +1",
		back=thf_dex_wsd_jse_back,
        legs="Plun. Culottes +3",
        feet="Lustra. Leggings +1"})

    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {})
	--[[sets.precast.WS['Rudra\'s Storm'].Uncapped = set_combine(sets.precast.WS['Rudra\'s Storm'], {
		ammo="Seeth. Bomblet +1",
		head="Plun. Bonnet +3",
		body="Plunderer's Vest +3",
		ring1="Regal Ring",
		waist="Grunfeld Rope",
		feet="Plun. Poulaines +3"})]]--

    sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]
    sets.precast.WS['Mandalic Stab'].Acc = sets.precast.WS["Rudra's Storm"].Acc

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        ammo="Seeth. Bomblet +1",
		head=herculean_wsd_head,
		neck="Baetyl Pendant",
		ear2="Friomisi Earring",
        body=herculean_wsd_body,
        hands=herculean_wsd_hands,
		ring2="",
        waist="Eschan Stone",
        legs=herculean_wsd_legs,
        feet=herculean_wsd_feet})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {}

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1",
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
		legs="Meg. Chausses +2",
		feet="Pill. Poulaines +3"}

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        head="Malignance Chapeau", --6/6
		neck="Warder's Charm +1",
		ear1="Sanare Earring",
        body="Malignance Tabard", --9/9
        hands="Malignance Gloves", --5/5
		ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
        legs="Malignance Tights", --7/7
        feet="Malignance Boots"}) --4/4

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Yetshila +1",
        body="Pillager's Vest +3",
        neck="Combatant's Torque",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        back=thf_stp_jse_back,
        waist="Windbuffet Belt +1"})

    sets.idle.Weak = sets.idle.DT


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Pill. Poulaines +3"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",
		neck="Asn. Gorget +2",
		ear1="Sherida Earring", --Dedition Earring
		ear2="Dedition Earring",
		body="Pillager's Vest +3",
		hands="Adhemar Wrist. +1",
		ring1="Epona's Ring", --Epona's Ring
		ring2="Gere Ring", --Gere Ring
		back=thf_stp_jse_back,
		waist="Reiki Yotai",
		legs="Samnuha Tights",
		feet="Plun. Poulaines +3"}

    sets.engaged.LowAcc = set_combine(sets.engaged, {
		ear2="Telos Earring"})

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
		legs="Pill. Culottes +3"})

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
		head="Plun. Bonnet +3",
		ring1="Regal Ring"})

    -- * THF Native DW Trait: 25% DW
    -- * THF Job Points DW Gift: 5% DW

    -- No Magic Haste (74% DW to cap)
	-- 41%
    sets.engaged.DW = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
		neck="Asn. Gorget +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        body="Adhemar Jacket +1", -- 6
        hands="Adhemar Wrist. +1",
		ring1="Epona's Ring",
        ring2="Gere Ring",
        back=thf_dw_jse_back, --10
        waist="Reiki Yotai", --7
        legs="Samnuha Tights",
        feet=taeon_dw_feet} --9

    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {})

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {})

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {})

    -- 15% Magic Haste (67% DW to cap)
	-- 37%
    sets.engaged.DW.LowHaste = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
		neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Suppanomimi", --5
        body="Adhemar Jacket +1", -- 6
        hands="Adhemar Wrist. +1",
		ring1="Epona's Ring",
        ring2="Gere Ring",
        back=thf_dw_jse_back, --10
        waist="Reiki Yotai", --7
        legs="Samnuha Tights",
        feet=taeon_dw_feet} --9

    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {})

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {})

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {})

    -- 30% Magic Haste (56% DW to cap)
	-- 26%
    sets.engaged.DW.MidHaste = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
		neck="Asn. Gorget +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        body="Pillager's Vest +3",
        hands="Adhemar Wrist. +1",
		ring1="Epona's Ring",
        ring2="Gere Ring",
        back=thf_dw_jse_back, --10
        waist="Reiki Yotai", --7
        legs="Samnuha Tights",
        feet="Plun. Poulaines +3"}

    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {})

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {})

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {})

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
		neck="Asn. Gorget +2",
        ear1="Sherida Earring", --4
        ear2="Suppanomimi", --5
        body="Pillager's Vest +3",
        hands="Adhemar Wrist. +1",
		ring1="Epona's Ring",
        ring2="Gere Ring",
        back=thf_dw_jse_back, --10
        waist="Reiki Yotai", --7
        legs="Samnuha Tights",
        feet="Plun. Poulaines +3"} -- 22%

    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {})

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {})

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {})

    -- 45% Magic Haste (36% DW to cap)
	-- 5%
    sets.engaged.DW.MaxHaste = {
        ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",
		neck="Asn. Gorget +2",
		ear1="Sherida Earring",
		ear2="Dedition Earring",
		body="Pillager's Vest +3",
		hands="Adhemar Wrist. +1",
		ring1="Epona's Ring",
		ring2="Gere Ring",
		back=thf_stp_jse_back,
		waist="Reiki Yotai",
		legs="Samnuha Tights",
		feet="Plun. Poulaines +3"}

    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        ear2="Telos Earring"})

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
        legs="Pill. Culottes +3"})

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
        head="Plun. Bonnet +3",
		ring1="Regal Ring"})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        ammo="Staunch Tathlum +1",
		head="Adhemar Bonnet +1",
		neck="Loricate Torque +1",
		ear1="Sherida Earring",
		ear2="Telos Earring",
		body="Pillager's Vest +3",
		hands="Adhemar Wrist. +1",
		ring1="Defending Ring",
		ring2="Gere Ring",
		back=thf_stp_jse_back,
		legs="Samnuha Tights",
		feet="Plun. Poulaines +3"}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    --sets.Reive = {neck="Ygnas's Resolve +1"}
    sets.CP = {back="Mecisto. Mantle"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
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
    if spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
    if spell.type == "WeaponSkill" then
        if state.Buff['Sneak Attack'] == true or state.Buff['Trick Attack'] == true then
            equip(sets.precast.WS.Critical)
        end
    end
	if spell.type == 'WeaponSkill' then
        if spell.english == 'Aeolian Edge' then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
			end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)

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

    if not midaction() then
        handle_equipping_gear(player.status)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    determine_haste_group()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end

function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.TreasureMode.value ~= 'None' then
        msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 6 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 6 and DW_needed <= 22 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 22 and DW_needed <= 26 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 26 and DW_needed <= 37 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 37 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
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


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']

        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            cast_delay(1.1)
            send_command('input /ja "Presto" <me>')
        end
    end
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


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

windower.register_event('zone change', 
    function()
        send_command('gi ugs true')
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 2)
    else
        set_macro_page(1, 2)
    end
end

function set_lockstyle()
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end
