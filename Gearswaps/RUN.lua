-- Original: Motenten / Modified: Ballzack

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------
--
--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+H ]           Toggle Charm Defense Mods
--              [ WIN+D ]           Toggle Death Defense Mods
--              [ WIN+K ]           Toggle Knockback Defense Mods
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Use current Rune
--              [ CTRL+- ]          Rune element cycle forward.
--              [ CTRL+= ]          Rune element cycle backward.
--              [ CTRL+` ]          Use current Rune
--
--              [ CTRL+Numpad/ ]    Berserk/Meditate/Souleater
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki/Arcane Circle
--              [ CTRL+Numpad- ]    Aggressor/Third Eye/Weapon Bash
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+G ]          Cycles between available greatswords
--              [ CTRL+W ]          Toggle Weapon Lock
--
--  WS:         [ Delete ]    Resolution
--              [ End ]    Dimidiation
--              [ Home ]    Shockwave
--
--


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------


--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()

    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

    rayke_duration = 35
    gambit_duration = 96

    lockstyleset = 2

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.WeaponskillMode:options('Normal', 'Acc', 'DT')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'HP')
    state.MagicalDefenseMode:options('MDT')

    state.Knockback = M(false, 'Knockback')

    state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Lionheart', 'Aettir', 'GreatAxe'}
    state.AttackMode = M{['description']='Attack', 'Uncapped', 'Capped'}
    state.CP = M(false, "Capacity Points Mode")
    state.WeaponLock = M(false, 'Weapon Lock')

    state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}
	
	-- High HP items get tagged with priorities
    gear["Aettir"]               = {name="Aettir",priority=900}
    gear["Aqreqaq Bomblet"]               = {name="Aqreqaq Bomblet",priority=20}
    gear["Lionheart"]               = {name="Lionheart",priority=900}
    gear["Hepatizon Axe"]   	= {name="Hepatizon Axe",priority=900}
    gear["Adhemar Bonnet +1"]          = {name="Adhemar Bonnet +1",priority=41}
    gear["Adhemar Jacket +1"]         = {name="Adhemar Jacket +1",priority=63}
    gear["Ahosi Leggings"]         = {name="Ahosi Leggings",priority=18}
    gear["Ayanmo Corazza +2"]          = {name="Ayanmo Corazza +2",priority=57}
	gear["Aya. Cosciales +2"]          = {name="Aya. Cosciales +2",priority=45}
	gear["Aya. Gambieras +2"]          = {name="Aya. Gambieras +2",priority=11}
    gear["Aya. Manopolas +2"]          = {name="Aya. Manopolas +2",priority=22}
    gear["Aya. Zucchetto +2"]          = {name="Aya. Zucchetto +2",priority=45}
    gear["Carmine Cuisses +1"]      = {name="Carmine Cuisses +1",priority=130}
    gear["Carmine Mask +1"]      = {name="Carmine Mask +1",priority=38}
    gear["Carmine Greaves +1"]      = {name="Carmine Greaves +1",priority=95}
    gear["Dampening Tam"]      = {name="Dampening Tam",priority=36}
    gear["Cryptic Earring"]         = {name="Cryptic Earring",priority=40}
    gear["Eabani Earring"]          = {name="Eabani Earring",priority=45}
    gear["Eihwaz Ring"]             = {name="Eihwaz Ring",priority=70}
    gear["Emet Harness +1"]         = {name="Emet Harness +1",priority=61}
    gear["Erilaz Galea +1"]         = {name="Erilaz Galea +1",priority=91}
    gear["Erilaz Gauntlets +1"]         = {name="Erilaz Gauntlets +1",priority=29}
    gear["Erilaz Greaves +1"]         = {name="Erilaz Greaves +1",priority=18}
    gear["Eri. Leg Guards +1"]    = {name="Eri. Leg Guards +1",priority=80}
    gear["Erilaz Surcoat +1"]       = {name="Erilaz Surcoat +1",priority=123}
    gear["Etiolation Earring"]      = {name="Etiolation Earring",priority=50}
    gear["Fu. Bandeau +3"]      = {name="Fu. Bandeau +3",priority=56}
    gear["Futhark Boots +3"]      = {name="Futhark Boots +3",priority=33}
    gear["Futhark Coat +3"]         = {name="Futhark Coat +3",priority=119}
    gear["Futhark Mitons +3"]         = {name="Futhark Mitons +3",priority=45}
    gear["Futhark Torque +2"]       = {name="Futhark Torque +2",priority=60}
    gear["Futhark Trousers +3"]     = {name="Futhark Trousers +3",priority=107}
    gear["Halitus Helm"]            = {name="Halitus Helm",priority=88}
    gear["Ilabrat Ring"]            = {name="Ilabrat Ring",priority=60}
    gear["Kasiri Belt"]            = {name="Kasiri Belt",priority=30}
    gear["Kurys Gloves"]            = {name="Kurys Gloves",priority=25}
    gear["Leyline Gloves"]            = {name="Leyline Gloves",priority=25}
    gear["Moonlight Cape"]           = {name="Moonlight Cape",priority=275}
    gear["Moonlight Ring"]          = {name="Moonlight Ring",priority=110}
    gear["Odnowa Earring +1"]       = {name="Odnowa Earring +1",priority=100}
    gear["Oneiros Belt"]            = {name="Oneiros Belt",priority=55}
    gear["Rawhide Gloves"]          = {name="Rawhide Gloves",priority=75}
    gear["Regal Ring"]              = {name="Regal Ring",priority=50}
    gear["Rune. Bandeau +3"]    = {name="Rune. Bandeau +3",priority=109}
    gear["Runeist's Boots +3"]      = {name="Runeist's Boots +3",priority=85}
    gear["Runeist's Coat +3"]       = {name="Runeist's Coat +3",priority=208}
    gear["Runeist's Mitons +3"]       = {name="Runeist's Mitons +3",priority=75}
    gear["Rune. Trousers +3"]     = {name="Rune. Trousers +3",priority=80}
    gear["Samnuha Tights"]     = {name="Samnuha Tights",priority=41}
    gear["Sanctity Necklace"]       = {name="Sanctity Necklace",priority=35}
    gear["Supershear Ring"]         = {name="Supershear Ring",priority=30}
	gear["Taeon Gloves"]         = {name="Taeon Gloves",priority=25}
    gear["Taeon Tights"]         = {name="Taeon Tights",priority=47}
	gear["Turms Cap +1"]       = {name="Turms Cap +1",priority=94}         
    gear["Turms Leggings +1"]       = {name="Turms Leggings +1",priority=76}
    gear["Turms Mittens +1"]        = {name="Turms Mittens +1",priority=74}
    gear["Utu Grip"]                = {name="Utu Grip",priority=70}

    send_command('bind ^` input //gs c rune')
	send_command('bind @` input /ma "Flash" <t>')
    send_command('bind !` input /ja "Vivacious Pulse" <me>')
    send_command('bind ^- gs c cycleback Runes')
    send_command('bind ^= gs c cycle Runes')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @a gs c cycle AttackMode')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind @k gs c toggle Knockback')
    send_command('bind @t input /ma "Temper" <me>')

    if player.sub_job == 'BLU' then
        send_command('bind !w input /ma "Cocoon" <me>')
    elseif player.sub_job == 'WAR' then
        send_command('bind !w input /ja "Defender" <me>')
    elseif player.sub_job == 'DRK' then
        send_command('bind !w input /ja "Last Resort" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind !w input /ja "Hasso" <me>')
    end

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    elseif player.sub_job == 'DRK' then
        send_command('bind ^numpad/ input /ja "Souleater" <me>')
        send_command('bind ^numpad* input /ja "Arcane Circle" <me>')
        send_command('bind ^numpad- input /ja "Weapon Bash" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind ^numpad/ input /ja "Meditate" <me>')
        send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
        send_command('bind ^numpad- input /ja "Third Eye" <me>')
    end

    send_command('bind Delete input /ws "Resolution" <t>')
    send_command('bind End input /ws "Dimidiation" <t>')
    send_command('bind Home input /ws "Shockwave" <t>')
    --send_command('bind ^numpad5 input /ws "Ground Strike" <t>;input /p Ground Strike')

    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind ^F11')
    send_command('unbind @a')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind @k')
    send_command('unbind @t')
    send_command('unbind @w')
    send_command('unbind @c')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind Delete')
    send_command('unbind End')
    send_command('unbind Home')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
include('Colonelace-Items.lua')
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enmity sets
    sets.Enmity = {
        ammo=gear["Aqreqaq Bomblet"], --2
        head=gear["Halitus Helm"], --8
		neck="Moonlight Necklace", --15
        ear1=gear["Cryptic Earring"], --4
        ear2="Trux Earring", --5
        body=gear["Emet Harness +1"], --10
        hands=gear["Kurys Gloves"], --9
		ring1="Supershear Ring", --5
        ring2="Eihwaz Ring", --5
        back=run_hpd_jse_back, --10
        waist=gear["Kasiri Belt"], --3
        legs=gear["Eri. Leg Guards +1"], --7
        feet=gear["Ahosi Leggings"]} --7

    sets.Enmity.HP = {
        ammo=gear["Aqreqaq Bomblet"], --2
        head=gear["Halitus Helm"], --8
		neck=gear["Futhark Torque +2"], --10
        ear1="Odnowa Earring",
        ear2=gear["Odnowa Earring +1"],
        body=gear["Emet Harness +1"], --10
        hands=gear["Kurys Gloves"], --9
		ring1=gear["Moonlight Ring"],
        ring2="Eihwaz Ring", --5
        back=run_hpd_jse_back, --10
        waist="Kasiri Belt", --3
        legs=gear["Eri. Leg Guards +1"], --11
        feet=gear["Ahosi Leggings"]} --7}

    sets.precast.JA['Vallation'] = {body="Runeist's Coat +3", legs="Futhark Trousers +3", back=run_hpd_jse_back,}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist's Boots +3"}
    sets.precast.JA['Battuta'] = {head="Fu. Bandeau +3"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +3"}

    sets.precast.JA['Lunge'] = {
        ammo="Seeth. Bomblet +1",
        head=herculean_mab_head,
		neck="Baetyl Pendant",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        body="Samnuha Coat",
        hands="Carmine Fin. Ga. +1",
        ring1={name="Fenrir Ring +1", bag="wardrobe3"},
        ring2={name="Fenrir Ring +1", bag="wardrobe4"},
        back=run_mab_jse_back,
        waist="Eschan Stone",
        legs=herculean_mab_legs,
        feet=herculean_mab_feet}

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands=gear["Runeist's Mitons +3"]}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots +3"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +3"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +3"}
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1"}


    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear["Rune. Bandeau +3"], --14
		neck="Orunmila's Torque", --5
        ear1="Odnowa Earring",
        ear2="Odnowa Earring +1",
        body=gear.taeon_fc_body, --8
        hands=gear["Leyline Gloves"], --8
		ring1=gear["Moonlight Ring"],
        ring2="Kishar Ring", --4
        back=run_fc_jse_back, --10
        waist=gear["Oneiros Belt"],
        legs=gear["Aya. Cosciales +2"], --6
        feet=gear["Carmine Greaves +1"]} --8

    sets.precast.FC.HP = set_combine(sets.precast.FC, {
        ammo=gear["Aqreqaq Bomblet"],
        body=gear["Runeist's Coat +3"],
        ear1="Odnowa Earring",
        ring2="Moonlight Ring"})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {legs="Futhark Trousers +3"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ammo="Impatiens", ear2="Mendi. Earring"})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        body="Passion Jacket",
        ring1="Lebeche Ring",
        waist="Rumination Sash"})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Sherida Earring",
        ring2="Niqmaddu Ring",
		waist="Fotia Belt"}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.DT = set_combine(sets.precast.WS, {})

    sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {})

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
		head="Lustratio Cap +1",
		body="Lustr. Harness +1",
		hands=herculean_ta_hands,
		ring1="Epona's Ring",
		back=run_da_jse_back,
		legs=gear["Samnuha Tights"],
		feet=lustratio_d_feet})

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {})
	
	sets.precast.WS['Resolution'].DT = set_combine(sets.precast.WS['Resolution'], {})

    sets.precast.WS['Resolution'].Uncapped = set_combine(sets.precast.WS['Resolution'], {
        ammo="Seething Bomblet +1",
		body=gear["Adhemar Jacket +1"],
		ring1="Regal Ring",
		legs="Meg. Chausses +2",
		feet=lustratio_a_feet})

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
		head=herculean_dex_wsd_head,
		body=herculean_wsd_body,
		hands="Meg. Gloves +2",
		ring1="Epona's Ring",
		back=run_wsd_jse_back,
		legs=lustratio_b_legs,
		feet=lustratio_d_feet})

    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {})

    sets.precast.WS['Dimidiation'].Uncapped = set_combine(sets.precast.WS['Dimidiation'], {
        neck="Caro Necklace",
		body=gear["Adhemar Jacket +1"],
		ring1="Ilabrat Ring",
		waist="Grunfeld Rope",
		legs=lustratio_a_legs})
		
	sets.precast.WS['Dimidiation'].DT = set_combine(sets.precast.WS['Dimidiation'], {})	

    sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']

    sets.precast.WS['Shockwave'] = {
        ammo="Pemphredo Tathlum",
        head="Aya. Zucchetto +2",
		neck="Erra Pendant",
		ear1="Moonshade Earring",
        ear2="Digni. Earring",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back=run_wsd_jse_back,
        waist="Eschan Stone",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2"}

    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
    sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", -- 11
		head=taeon_sird_head, -- 10
		neck="Moonlight Necklace", -- 15
		ear1="Halasz Earring", -- 5
		ear2="Magnetic Earring", -- 8
		body=gear["Futhark Coat +3"],
		hands=gear["Rawhide Gloves"], -- 15
		ring1=gear["Moonlight Ring"],
		ring2="Defending Ring",
		back=run_fc_jse_back,
		waist="Rumination Sash", -- 10
		legs=gear["Carmine Cuisses +1"], --20
		feet=gear["Erilaz Greaves +1"]
		} -- +10% from merit points

    sets.midcast.Cure = {}

    sets.midcast['Enhancing Magic'] = {
        head="Staunch Tathlum +1",
        head=gear["Carmine Mask +1"],
		neck="Incanter's Torque",
        ear1="Augment. Earring",
        ear2="Andoaa Earring",
		body="Manasa Chasuble",
		hands=gear["Runeist's Mitons +3"],
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Merciful Cape",
        waist="Olympus Sash",
		legs=gear["Carmine Cuisses +1"],
		feet=gear["Erilaz Greaves +1"]}

    sets.midcast.EnhancingDuration = {
        head="Staunch Tathlum +1",
        head=gear["Erilaz Galea +1"],
		neck=gear["Futhark Torque +2"],
		ear1="Genmei Earring",
		body=gear["Futhark Coat +3"],
        --hands="Regal Gauntlets",
		ring1=gear["Moonlight Ring"],
		ring2="Defending Ring",
		back=run_hpd_jse_back,
		waist="Flume Belt +1",
        legs=gear["Futhark Trousers +3"],
		feet=gear["Erilaz Greaves +1"]}

    sets.midcast['Phalanx'] = set_combine(sets.midcast.SpellInterrupt, {
        head="Fu. Bandeau +3",
		ear1="Genmei Earring",
        body=taeon_phalanx_body, --3(10)
        hands=gear["Taeon Gloves"], --3(10)
        legs=gear["Taeon Tights"], --3(10)
        feet=taeon_phalanx_feet}) --3(10)

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.SpellInterrupt, {})

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {head="Rune. Bandeau +3", neck="Sacro Gorget"})
    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Erilaz Galea +1", waist="Gishdubar Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
        ammo="Yamarang",
		neck="Incanter's Torque",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Altruistic Cape",
        waist="Bishop's Sash",
        legs=gear["Rune. Trousers +3"]}

    sets.midcast.Flash = sets.Enmity
    sets.midcast.Foil = sets.Enmity
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {}
    sets.midcast['Blue Magic'].Enmity = sets.Enmity
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
    sets.midcast['Blue Magic'].Buff = sets.midcast['Enhancing Magic']


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        sub="Mensch Strap +1",
        ammo="Homiliary",
        head="Rawhide Mask",
		neck=gear["Futhark Torque +2"],
        ear1="Eabani Earring",
        ear2=gear["Odnowa Earring +1"],
        body=gear["Runeist's Coat +3"],
        hands=herculean_refresh_hands,
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back=gear["Moonlight Cape"],
        waist="Fucho-no-obi",
        legs=gear["Carmine Cuisses +1"],
        feet=gear["Erilaz Greaves +1"]}

    sets.idle.DT = {
        sub="Mensch Strap +1", --5/0
        ammo="Staunch Tathlum +1", --3/3
		head=gear["Aya. Zucchetto +2"], --3/3
		body=gear["Futhark Coat +3"], --7/7
		hands=gear["Aya. Manopolas +2"], --3/3
		ring1="Vocane Ring", -- 7/7
		ring2="Defending Ring", -- 10/10
		feet=gear["Aya. Gambieras +2"]}

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1",
		head="Turms Cap +1",
		neck="Moonlight Necklace",
		ear1="Mache Earring +1",
		body="Manasa Chasuble",
		hands="Turms Mittens +1",
		ring2="Chirich Ring +1",
		waist="Gold Mog. Belt",
		feet="Turms Leggings +1"})

    sets.idle.Weak = sets.idle.DT
    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.Knockback = {ring1="Vocane Ring", back="Repulse Mantle", legs="Dashing Subligar"}

    sets.defense.PDT = {
		sub="Mensch Strap +1", --5/0
        ammo="Staunch Tathlum +1", --3/3
        head=gear["Turms Cap +1"], --4/0
		neck=gear["Futhark Torque +2"], --6/6
        ear1="Odnowa Earring",
        ear2=gear["Odnowa Earring +1"], --0/2
        body=gear["Runeist's Coat +3"], --9/9
        hands=gear["Turms Mittens +1"],
		ring1=gear["Moonlight Ring"], --5/5
        ring2="Defending Ring", --10/10
		back=run_hpd_jse_back,
        waist="Flume Belt +1", --4/0
        legs=gear["Eri. Leg Guards +1"], --7/0
        feet=gear["Turms Leggings +1"]}

    sets.defense.MDT = {
        sub="Irenic Strap +1",
        ammo="Staunch Tathlum +1",
        head=gear["Turms Cap +1"],
		neck=gear["Futhark Torque +2"],
        ear1="Hearty Earring",
        ear2=gear["Eabani Earring"],
        body=gear["Runeist's Coat +3"],
        hands=gear["Turms Mittens +1"],
		ring1="Purity Ring",
        ring2="Defending Ring", --10/10
		back=run_meva_jse_back,
        waist="Engraved Belt",
        legs=gear["Rune. Trousers +3"],
        feet=gear["Turms Leggings +1"]}

    sets.defense.HP = sets.defense.PDT

    sets.defense.Parry = {
        hands=gear["Turms Mittens +1"],
		back=run_hpp_jse_back,
        legs=gear["Eri. Leg Guards +1"],
        feet=gear["Turms Leggings +1"]}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        sub="Utu Grip",
        ammo="Ginsen",
        head=gear["Adhemar Bonnet +1"],
		neck="Anu Torque",
		ear1="Telos Earring",
        ear2="Sherida Earring",
        body=gear["Adhemar Jacket +1"],
        hands=adhemar_b_hands,
		ring1="Epona's Ring",
        ring2="Niqmaddu Ring",
		back=run_stp_jse_back,
        waist="Ioskeha Belt +1",
        legs=gear["Samnuha Tights"],
        feet=herculean_ta_feet}

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        head=gear["Dampening Tam"],
        neck="Combatant's Torque"})

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1=gear["Regal Ring"]})

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ammo="C. Palug Stone",
        head=gear["Carmine Mask +1"],
		ear1="Mache Earring +1",
        body=gear["Runeist's Coat +3"],
        hands=gear["Runeist's Mitons +3"],
		waist="Olseni Belt",
        legs=gear["Carmine Cuisses +1"]})

    sets.engaged.STP = set_combine(sets.engaged, {
        head=gear["Aya. Zucchetto +2"],
		ear2="Dedition Earring",
        body="Ashera Harness",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        waist="Kentarch Belt +1",
        feet=gear["Carmine Greaves +1"]})

    sets.engaged.Aftermath = {
        head=gear["Aya. Zucchetto +2"],
        body="Ashera Harness",
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Dedition Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        waist="Kentarch Belt +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Hybrid = {
        neck=gear["Futhark Torque +2"], --7/7
        body=gear["Ayanmo Corazza +2"], --6/6
        ring1="Defending Ring", --10/10
		ring2="Niqmaddu Ring",
        back=run_stp_jse_back, --10/0
		legs="Meg. Chausses +2"}

    sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.Hybrid)

--[[
    sets.engaged.Aftermath.DT = {
        head="Aya. Zucchetto +2",
        feet="Carmine Greaves +1",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        waist="Kentarch Belt +1",
        }
]]

    sets.engaged.Aftermath.DT = {
        head=gear["Aya. Zucchetto +2"],
		neck="Futhark Torque +2",
        ear1="Sherida Earring",
        ear2="Dedition Earring",
        body="Ashera Harness",
        hands="Adhemar Wrist. +1",
		ring1=gear["Moonlight Ring"],
        ring2="Defending Ring",
        back=run_stp_jse_back,
        waist="Ioskeha Belt +1",
        legs="Meg. Chausses +2",
        feet=herculean_stp_feet}    

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

    sets.Epeolatry = {main="Epeolatry"}
    sets.Lionheart = {main="Lionheart"}
    sets.Aettir = {main="Aettir"}
    sets.GreatAxe = {main="Hepatizon Axe +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        add_to_chat(167, 'Stopped due to status.')
        eventArgs.cancel = true
        return
    end
    if state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.current == 'HP' then
        currentSpell = spell.english
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            equip(sets.precast.FC.HP)
            add_to_chat(1, 'Precast Swap Magic')
        elseif spell.action_type == 'Ability' then
            equip(sets.Enmity.HP)
			equip(sets.precast.JA[currentSpell])
            add_to_chat(1, 'Precast Swap Ability')
        end
	else
        if spell.action_type == 'Ability' then
            equip(sets.Enmity)
			equip(sets.precast.JA[spell])
        end
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
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

function job_midcast(spell, action, spellMap, eventArgs)
    if state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.current == 'HP' and spell.english ~= "Phalanx" then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            if spell.english == 'Flash' or spell.english == 'Foil' or spell.english == 'Stun'
                or blue_magic_maps.Enmity:contains(spell.english) then
                equip(sets.Enmity.HP)
				add_to_chat(1, 'Midcast Magic Swap')
            elseif spell.skill == 'Enhancing Magic' then
                equip(sets.midcast.EnhancingDuration)
            end
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if state.DefenseMode.value == 'None' then
        if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
		end
        if spell.english == 'Phalanx' and buffactive['Embolden'] then
            equip(sets.midcast.EnhancingDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        send_command('wait '..rayke_duration..';input /echo [Rayke just wore off!];')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        send_command('wait '..gambit_duration..';input /echo [Gambit just wore off!];')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.Charm.current)
    classes.CustomDefenseGroups:append(state.Knockback.current)
    classes.CustomDefenseGroups:append(state.Death.current)

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.Charm.current)
    classes.CustomMeleeGroups:append(state.Knockback.current)
    classes.CustomMeleeGroups:append(state.Death.current)
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "terror" then
        if gain then
            equip(sets.defense.PDT)
        end
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    equip(sets[state.WeaponSet.current])

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Knockback.value == true then
        idleSet = set_combine(idleSet, sets.defense.Knockback)
    end

    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    if state.Knockback.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Knockback)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
    if state.Knockback.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Knockback)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local r_msg = state.Runes.current
    local r_color = ''
    if state.Runes.current == 'Ignis' then r_color = 167
    elseif state.Runes.current == 'Gelus' then r_color = 210
    elseif state.Runes.current == 'Flabra' then r_color = 204
    elseif state.Runes.current == 'Tellus' then r_color = 050
    elseif state.Runes.current == 'Sulpor' then r_color = 215
    elseif state.Runes.current == 'Unda' then r_color = 207
    elseif state.Runes.current == 'Lux' then r_color = 001
    elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Knockback.value == true then
        msg = msg .. ' Knockback Resist |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
        ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060)
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

function get_custom_wsmode(spell, action, spellMap)
    if spell.type == 'WeaponSkill' and state.AttackMode.value == 'Uncapped' then
		return "Uncapped"
	end	
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    if player.sub_job == 'DRK' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 1)
    else
        set_macro_page(1, 1)
    end
end

function set_lockstyle()
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end
