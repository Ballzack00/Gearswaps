-- Original: Motenten / Modified: Ballzack

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Cycle SongMode
--
--  Songs:      [ ALT+` ]           Chocobo Mazurka
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ End ]    			Mordant Rime
--  WS:         [ @End ]    		Gust Slash
--              [ Home ]    		Evisceration
--              [ @Home ]    		Wasp Sting
--              [ Delete ]    		Rudra's Storm
--              [ @Delete ]    		Aeolian Edge
--
--

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    SongMode may take one of three values: None, Placeholder, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle SongMode
    gs c set SongMode Placeholder
    
    The Placeholder state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a placeholder Daurdabla song:
    /console gs c set SongMode Placeholder
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    lockstyleset = 3
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva')

    state.LullabyMode = M{['description']='Lullaby Instrument', 'Horn', 'Harp'}

    state.Carol = M{['description']='Carol', 
        'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
        'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
        'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
        }

    state.Threnody = M{['description']='Threnody',
        'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
        'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
        }

    state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
        'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
        'Spirited Etude', 'Logical Etude', 'Echanting Etude', 'Bewitching Etude'}

    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")

    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        send_command('lua l gearinfo')
    end
   
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Terpander'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1
    
    send_command('bind ^` gs c cycle SongMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')
    send_command('bind !p input /ja "Pianissimo" <me>')

    send_command('bind ^backspace gs c cycle SongTier')
    send_command('bind ^insert gs c cycleback Etude')
    send_command('bind ^delete gs c cycle Etude')
    send_command('bind ^home gs c cycleback Carol')
    send_command('bind ^end gs c cycle Carol')
    send_command('bind ^pageup gs c cycleback Threnody')
    send_command('bind ^pagedown gs c cycle Threnody')

    send_command('bind @` gs c cycle LullabyMode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')

    send_command('bind End input /ws "Mordant Rime" <t>')
    send_command('bind Home input /ws "Evisceration" <t>')
    send_command('bind Delete input /ws "Rudra\'s Storm" <t>')
    send_command('bind @Delete input /ws "Aeolian Edge" <t>')
    send_command('bind @Home input /ws "Wasp Sting" <t>')
    send_command('bind @End input /ws "Gust Slash" <t>')

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
    send_command('unbind !p')
    send_command('unbind ^backspace')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind @`')
    send_command('unbind @w')
    send_command('unbind @c')
    send_command('unbind End')
    send_command('unbind Home')
    send_command('unbind Delete')
    send_command('unbind @Delete')
    send_command('unbind @Home')
    send_command('unbind @End')

    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        send_command('lua u gearinfo')
    end
end


-- Define sets and vars used by this job file.
function init_gear_sets()
include('Rnic-Items.lua')
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
        main="Kali", --7
		sub="Genmei Shield",
		head="Nahtirah Hat", --10
		neck="Orunmila's Torque", --5
		ear1="Loquac. Earring", --2
		ear2="Enchntr. Earring +1", --2
		body="Inyanga Jubbah +2", --14
		hands="Leyline Gloves", --8
		ring1="Kishar Ring", --4
		ring2="Prolix Ring", --2
		back=brd_fc_jse_back, --10
		waist="Witful Belt", --3/(3)
		legs="Aya. Cosciales +2", --6
		feet=chironic_fc_feet} --7

    sets.precast.FC['Enhancing Magic'] = sets.precast.FC

    sets.precast.FC.Cure = sets.precast.FC

    sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
        head="Fili Calot +1", --0/14
		neck="Loricate Torque +1",
		ear1="Ethereal Earring",
		ear2="Etiolation Earring",
		hands="Gende. Gages +1", --7/5
		ring2="Defending Ring",
		waist="Flume Belt +1",
		feet="Telchine Pigaches"}) --0/13

    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
    sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
       
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range=linos_wsd,
        head="Bihu Roundlet +3",
		neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Bihu Jstcorps. +3",
        hands="Bihu Cuffs +3",
		ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=brd_dex_wsd_jse_back,
        waist="Fotia Belt",
        legs="Bihu Cannions +3",
        feet="Bihu Slippers +3"}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        range=linos_crit,
		head=lustratio_b_head,
		ear2="Brutal Earring",
		body="Ayanmo Corazza +2",
		hands=lustratio_b_hands,
		ring1="Hetairoi Ring",
		ring2="Begrudging Ring",
		back=brd_crit_jse_back,
		legs=lustratio_b_legs,
		feet=lustratio_b_feet})
        
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		range=linos_ws,
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Ayanmo Corazza +2",
		ring1="Petrov Ring",
		back=brd_agi_jse_back,
		legs=telchine_da_legs})

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
        range=linos_chr_wsd,
		neck="Bard's Charm +2",
		ear1="Regal Earring",
		back=brd_chr_wsd_jse_back,
		waist="Grunfeld Rope"})

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
        range=linos_dex_wsd,
		head=lustratio_d_head,
		neck="Bard's Charm +2",
		hands=lustratio_d_hands,
		back=brd_dex_wsd_jse_back,
		waist="Grunfeld Rope",
		legs=lustratio_b_legs,
		feet=lustratio_d_feet})
    
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC
        
    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
    sets.midcast.Carol = {hands="Mousai Gages +1"}
    sets.midcast.Etude = {head="Mousai Turban +1"}
    sets.midcast.HonorMarch = {range="Marsyas", hands="Fili Manchettes +1"}
    sets.midcast.Hymnus = {range="Marsyas"}
    sets.midcast.Lullaby = {body="Fili Hongreline +1", hands="Brioso Cuffs +3", legs="Inyanga Shalwar +2",}
    sets.midcast.Madrigal = {head="Fili Calot +1"}
    --sets.midcast.Mambo = {feet="Mousai Crackows"}
    sets.midcast.March = {hands="Fili Manchettes +1"}
    sets.midcast.Mazurka = {range="Marsyas"}
    --sets.midcast.Minne = {legs="Mousai Seraweels"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
    sets.midcast.Threnody = {body="Mousai Manteel +1"}
    sets.midcast['Adventurer\'s Dirge'] = {hands="Bihu Cuffs +3"}
    sets.midcast['Foe Sirvente'] = {head="Bihu Roundlet +3"}
    sets.midcast['Magic Finale'] = {legs="Fili Rhingrave +1"}
    sets.midcast["Sentinel's Scherzo"] = {range="Marsyas", feet="Fili Cothurnes +1"}

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEnhancing = {
       --main="Carnwenhan",
		main="Kali",
        sub="Genmei Shield",
        range="Gjallarhorn",
        head="Fili Calot +1",
		neck="Mnbw. Whistle +1",
        ear1="Genmei Earring",
        ear2="Etiolation Earring",
        body="Fili Hongreline +1",
        hands="Fili Manchettes +1",
		ring1="Moonlight Ring",
        ring2="Defending Ring",
		back=brd_fc_jse_back,
        waist="Flume Belt +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3"}

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongEnfeeble = {
        --main="Carnwenhan",
		main="Kali",
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +2",
		neck="Mnbw. Whistle +1",
        ear1="Digni. Earring",
        ear2="Enchntr. Earring +1",
        body="Brioso Justau. +2",
        hands="Inyan. Dastanas +2",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back=brd_fc_jse_back,
        waist="Luminary Sash",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3"}

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {hands="Brioso Cuffs +3"})

    -- Placeholder song; minimize duration to make it easy to overwrite.
    sets.midcast.SongPlaceholder = set_combine(sets.midcast.SongEnhancing, {range=info.ExtraSongInstrument})

    -- Other general spells and classes.
    sets.midcast.Cure = {
        main="Daybreak",
		sub="Ammurapi Shield",
		range=linos_cure,
		head="Kaykaus Mitra +1",
		neck="Incanter's Torque",
		ear1="Beatific Earring",
		ear2="Meili Earring",
		body="Kaykaus Bliaut +1",
		hands="Inyan. Dastanas +2",
		ring1="Sirona's Ring",
		ring2="Menelaus's Ring",
		back=brd_cure_jse_back,
		waist="Bishop's Sash",
		legs="Vanya Slops",
		feet="Vanya Clogs"}
        
    sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
		main="Grioavolr",
		sub="Enki Strap",
		range=linos_cmp,
		ear2="Regal Earring",
		hands="Kaykaus Cuffs +1",
		ring2="Jann. Ring",
		legs="Kaykaus Tights +1",
		feet="Kaykaus Boots +1"})
        
    sets.midcast.StatusRemoval = sets.precast.FC
        
    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        main="Prelatic Pole",
		sub="Curatio Grip",
		ammo="Hasty Pinion +1",
		head="Vanya Hood",
		neck="Debilis Medallion",
		ear1="Healing Earring",
		ear2="Beatific Earring",
		body="Vanya Robe",
		hands="Inyan. Dastanas +2",
		ring1="Menelaus's Ring",
		ring2="Haoma's Ring",
		back="Oretan. Cape +1",
		waist="Witful Belt",
		legs="Vanya Slops",
		feet="Vanya Clogs"})
    
    sets.midcast['Enhancing Magic'] = {
        main="Pukulatmuj +1",
		sub="Ammurapi Shield",
		range=linos_cmp,
		head="Telchine Cap",
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Mimir Earring",
		body=telchine_duration_body,
		hands=telchine_duration_hands,
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Fi Follet Cape +1",
		waist="Olympus Sash",
		legs=telchine_duration_legs,
		feet="Telchine Pigaches"}

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget", waist="Siegel Sash"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {waist="Emphatikos Rope"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {}
    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield"})
    
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Kali",
        sub="Genmei Shield",
        range="Gjallarhorn",
        head="Inyanga Tiara +2",
		neck="Loricate Torque +1",
        ear1="Ethereal Earring",
        ear2="Hearty Earring",
        body="Kaykaus Bliaut +1",
        hands="Inyan. Dastanas +2",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Moonlight Cape",
        waist="Flume Belt +1",
        legs="Inyanga Shalwar +2",
        feet="Fili Cothurnes +1"}

    sets.idle.DT = {
        head="Bihu Roundlet +3", --6/0
        body="Bihu Jstcorps. +3", --7/0
        hands="Inyan. Dastanas +2", --0/4
        legs="Bihu Cannions +3", --6/0
        feet="Inyan. Crackows +2", --0/3
        neck="Loricate Torque +1", --6/6
        ear2="Etiolation Earring", --0/3
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring",  --10/10
        back="Moonlight Cape", --6/6
        waist="Flume Belt +1", --4/0
        }

    sets.idle.MEva = {
		head="Inyanga Tiara +2", --0/5
        body="Inyanga Jubbah +2", --0/8
        hands="Inyan. Dastanas +2", --0/4
        legs="Inyanga Shalwar +2", --0/6
        feet="Inyan. Crackows +2", --0/3
        neck="Warder's Charm +1",
        ear2="Etiolation Earring", --0/3
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring",  --10/10
        back="Moonlight Cape", --6/6
        waist="Carrier's Sash",}

    sets.idle.Town = set_combine(sets.idle, {
		body="Mou. Manteel +1",
		hands="Mousai Gages +1",
		legs="Kaykaus Tights +1"})
    
    sets.idle.Weak = sets.idle.DT
    
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Fili Cothurnes +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    sets.engaged = {
        main="Aeneas",
		sub="Genmei Shield",
		range="Linos",
		head="Aya. Zucchetto +2",
		neck="Bard's Charm +2",
		ear1="Telos Earring",
		ear2="Cessance Earring",
		body="Ayanmo Corazza +2", -- Ashera Harness
		hands="Aya. Manopolas +2", -- Volte Mittens
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		back="Intarabus's Cape",
		waist="Windbuffet Belt +1",
		legs="Aya. Cosciales +2", -- Volte Tights
		feet="Aya. Gambieras +2"} -- Volte Spats

    sets.engaged.Acc = set_combine(sets.engaged, {})

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {} -- 26%

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = sets.engaged.DW
    sets.engaged.DW.Acc.LowHaste = sets.engaged.DW.Acc

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = sets.engaged.DW
    sets.engaged.DW.Acc.MidHaste = sets.engaged.DW.Acc

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = sets.engaged.DW
    sets.engaged.DW.Acc.HighHaste = sets.engaged.DW.Acc

    -- 45% Magic Haste (36% DW to cap)
	sets.engaged.DW.MaxHaste = {
        range=linos_tp,
        head="Aya. Zucchetto +2",
		neck="Bard's Charm +2",
        ear1="Telos Earring",
        ear2="Eabani Earring",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
		ring1={name="Chirich Ring +1", bag="wardrobe3/"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        back=brd_stp_jse_back,
        waist="Reiki Yotai",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2"}

    sets.engaged.DW.MaxHaste.Acc = set_combine(sets.engaged.DW, {})

    sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {ear2="Cessance Earring", back=brd_dw_jse_back})
    sets.engaged.DW.Acc.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHaste, {ear2="Cessance Earring", back=brd_dw_jse_back})

    sets.engaged.Aftermath = {}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        ring1={name="Moonlight Ring", bag="wardrobe3"}, --5/5
        ring2={name="Moonlight Ring", bag="wardrobe4"}} --5/5

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.SongDWDuration = {main="Carnwenhan", sub="Kali"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        --[[ Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end]]
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Horn' then
                equip({range="Gjallarhorn"})
            else
                equip({range="Daurdabla"})
            end
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] then
            equip(sets.midcast[generalClass])
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Horn' then
                equip({range="Gjallarhorn"})
            else
                equip({range="Daurdabla"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.CombatForm.current == 'DW' then
            equip(sets.SongDWDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Lullaby') and not spell.interrupted then
        get_lullaby_duration(spell)
    end
end

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

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
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
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'etude' then
        send_command('@input /ma '..state.Etude.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <stnpc>')
    end

    gearinfo(cmdParams, eventArgs)
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    return meleeSet
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
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

    local c_msg = state.CastingMode.value

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
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'SongEnfeebleAcc'
        else
            return 'SongEnfeeble'
        end
    elseif state.SongMode.value == 'Placeholder' then
        return 'SongPlaceholder'
    else
        return 'SongEnhancing'
    end
end


function get_lullaby_duration(spell)
    local self = windower.ffxi.get_player()

    local troubadour = false
    local clarioncall = false
    local soulvoice = false
    local marcato = false
 
    for i,v in pairs(self.buffs) do
        if v == 348 then troubadour = true end
        if v == 499 then clarioncall = true end
        if v == 52 then soulvoice = true end
        if v == 231 then marcato = true end
    end

    local mult = 1
    
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
    if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end

    --JP Duration Gift
    if self.job_points.brd.jp_spent >= 1200 then
        mult = mult + 0.05
    end

    if troubadour then
        mult = mult * 2
    end

    if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then 
        base = 60
    elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then 
        base = 30
    end

    totalDuration = math.floor(mult * base)
        
    -- Job Points Buff
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    if troubadour then 
        totalDuration = totalDuration + self.job_points.brd.lullaby_duration
        -- adding it a second time if Troubadour up
    end

    if clarioncall then
        if troubadour then 
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
        else
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade. 
        end
    end
    
    if marcato and not soulvoice then
        totalDuration = totalDuration + self.job_points.brd.marcato_effect
    end

    -- Create the custom timer
    if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
        send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
    elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
        send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 12 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 12 and DW_needed <= 21 then
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

windower.register_event('zone change', 
    function()
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            send_command('gi ugs true')
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 3)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end