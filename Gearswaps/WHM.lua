-- Original: Motenten / Modified: Ballzack

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+R ]           Toggle Regen Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Afflatus Solace
--              [ ALT+` ]           Afflatus Misery
--              [ CTRL+[ ]          Divine Seal
--              [ CTRL+] ]          Divine Caress
--              [ CTRL+` ]          Composure
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+; ]           Penury/Parsimony
--
--  Spells:     [ ALT+O ]           Regen IV
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Black Halo
--              [ CTRL+Numpad8 ]    Hexa Strike
--              [ CTRL+Numpad9 ]    Realmrazer
--              [ CTRL+Numpad1 ]    Flash Nova
--              [ CTRL+Numpad0 ]    Mystic Boon
--
--
--


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                    Dark Arts
--                                          ----------                  ---------
--                gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar addendum       Addendum: White             Addendum: Black


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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
	

    lockstyleset = 1

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva')

    state.BarElement = M{['description']='BarElement', 'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra'}
    state.BoostSpell = M{['description']='BoostSpell', 'Boost-STR', 'Boost-INT', 'Boost-AGI', 'Boost-VIT', 'Boost-DEX', 'Boost-MND', 'Boost-CHR'}

    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")

    send_command('bind ^` input /ja "Divine Seal" <me>')
    send_command('bind !` input /ja Devotion')
    send_command('bind ^d input /ja "Divine Caress" <me>')
    send_command('bind ^s input /ja Sacrosanctity <me>')
    send_command('bind ^a input /ja Asylum <me>')
    send_command('bind ^insert gs c cycleback BoostSpell')
    send_command('bind ^delete gs c cycle BoostSpell')
    send_command('bind ^home gs c cycleback BarElement')
    send_command('bind ^end gs c cycle BarElement')
    send_command('bind ^pageup gs c cycleback BarStatus')
    send_command('bind ^pagedown gs c cycle BarStatus')
    send_command('bind ^c gs c toggle CP')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind @w gs c toggle WeaponLock')
	
	send_command('bind @p input /ma Poisona')
    send_command('bind ^p input /ma Paralyna')
    send_command('bind @b input /ma Blindna')
    send_command('bind @s input /ma Silena')
    send_command('bind ^s input /ma Stona')
    send_command('bind @v input /ma Viruna')
    send_command('bind @c input /ma Cursna')
    send_command('bind @e input /ma Erase')
    send_command('bind !e input /ma Esuna <me>')
    send_command('bind !s input /ma Sacrifice')

    send_command('bind Home input /ws "Flash Nova" <t>')
	send_command('bind Delete input /ws "Mystic Boon" <t>')
	send_command('bind End input /ws "Realmrazer" <t>')
	send_command('bind @Delete input /ws "Black Halo" <t>')
	send_command('bind @End input /ws "Hexa Strike" <t>')

    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^d')
    send_command('unbind ^s')
    send_command('unbind ^a')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind ^c')
    send_command('unbind @r')
    send_command('unbind @w')
	send_command('unbind ^p')
    send_command('unbind @p')
    send_command('unbind @b')
    send_command('unbind @s')
    send_command('unbind ^s')
    send_command('unbind @v')
    send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind !e')
    send_command('unbind !s')
	send_command('unbind Home')
	send_command('unbind Delete')
    send_command('unbind End')
	send_command('unbind @Delete')
    send_command('unbind @End')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
include('Rolanddeschain-Items.lua')
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells

    sets.precast.FC = {
    --    /SCH --3
	--    /RDM --15
		ammo="Impatiens",
		head="Nahtirah Hat", -- 10%
		neck="Cleric's Torque +2", -- 7%
		ear1="Enchntr. Earring +1", -- 2%
		ear2="Loquac. Earring", -- 2%
		body="Inyanga Jubbah +2", -- 14%
		hands="Fanatic Gloves", -- 7%
		ring1="Kishar Ring", -- 4%
		ring2="Lebeche Ring",
		back=whm_fc_jse_back, -- 10%
		waist="Witful Belt", -- 3%
		legs="Pinga Pants +1", -- 13%
		feet=chironic_fc_feet} -- 7%

    sets.precast.FC['Enhancing Magic'] = sets.precast.FC

    sets.precast.FC['Healing Magic'] = sets.precast.FC

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
        head="Piety Cap +3", --13
		ear1="Nourish. Earring +1", --4
        ear2="Mendi. Earring", --5
		back="Perimede Cape"}) --(4)

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

    -- Precast sets to enhance JAs
    --sets.precast.JA.Benediction = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Amar Cluster",
        head="Piety Cap +3",
		neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Brutal Earring",
		body="Ayanmo Corazza +2",
		hands="Piety Mitts +3",
		waist="Fotia Belt",
        legs="Piety Pantaln. +3",
		feet="Piety Duckbills +3"}

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        neck="Caro Necklace",
		ear2="Telos Earring",
		ring1="Rufescent Ring",
		ring2={name="Levia. Ring +1", bag="wardrobe4"},
		waist="Prosilio Belt +1",
		back=whm_wsd_jse_back})
		
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {
		ear2="Telos Earring",
		ring1="Rufescent Ring",
		ring2={name="Levia. Ring +1", bag="wardrobe4"},
		back=whm_da_jse_back})
		
	sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",
		ear2="Telos Earring",
		ring1="Rufescent Ring",
		ring2={name="Levia. Ring +1", bag="wardrobe4"},
		waist="Prosilio Belt +1",
		back=whm_wsd_jse_back})	

    sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
		ear2="Telos Earring",
		ring1="Ilabrat Ring",
		ring2="Begrudging Ring",
		back=whm_crit_jse_back})

    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {})

    -- Midcast Sets --

    sets.midcast.FC = {
        head="Aya. Zucchetto +2", --(6%)
		neck="Orunmila's Torque", -- 5%
		ear1="Enchntr. Earring +1", -- 2%
		ear2="Loquac. Earring", -- 2%
        body="Ayanmo Corazza +2", --(4%)
        hands="Aya. Manopolas +2", --(4%)
		ring1="Kishar Ring", -- 4%
		ring1="Prolix Ring", -- 2%
		back=whm_fc_jse_back, -- 10%
		waist="Witful Belt", -- 3%
        legs="Aya. Cosciales +2", --(9%)
        feet="Theo. Duckbills +3"} --(3%) Haste

    sets.midcast.ConserveMP = {
        main="Sucellus",
        sub="Thuellaic Ecu +1",
		ammo="Pemphredo Tathlum",
        head="Vanya Hood",
		ear1="Magnetic Earring",
        ear2="Calamitous Earring",
        body="Vedic Coat",
        --hands="Shrieker's Cuffs",
		back="Fi Follet Cape +1",
        waist="Austerity Belt +1",
        --legs="Vanya Slops",
        feet="Kaykaus Boots +1"}
		
    -- Cure Sets --
    sets.midcast.CureSolace = {
        main="Raetic Rod +1", --22(+10)
        sub="Sors Shield", --3/(-5)
        ammo="Esper Stone +1",
        head="Kaykaus Mitra +1", --11(+2)/(-6)
		neck="Incanter's Torque",
        ear1="Glorious Earring", -- (+2)/(-5)
        ear2="Novia Earring", 
        body="Ebers Bliaud +1",
        hands="Theophany Mitts +3", --(+4)/(-7)
		ring1="Kuchekula Ring", --0/(-7)
        ring2="Lebeche Ring", --3/(-5)
        back=whm_cure_jse_back,
        waist="Austerity Belt +1",
        legs="Ebers Pant. +1",
        feet="Kaykaus Boots +1"} --17(+2)/(0)

    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
        waist="Hachirin-no-Obi"})

    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {body="Theo. Briault +3"}) --0(+6)/(-6)

    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
        waist="Hachirin-no-Obi"})

    sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {body="Kaykaus Bliaut +1"}) --6(+4)/(0)

    sets.midcast.CuragaWeather = set_combine(sets.midcast.CuragaNormal, {
		back="Twilight Cape",
        waist="Hachirin-no-Obi"})

    --sets.midcast.CureMelee = sets.midcast.CureSolace

    sets.midcast.StatusRemoval = {
        main="Yagrush",
        sub="Chanter's Shield",
		ammo="Incantor Stone",
        head="Nahtirah Hat",
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
        body="Inyanga Jubbah +2",
        hands="Fanatic Gloves",
		ring1="Kishar Ring",
		ring2="Lebeche Ring",
		back=whm_fc_jse_back,
		waist="Witful Belt",
		legs="Pinga Pants +1",
		feet=chironic_fc_feet}

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
		head="Kaykaus Mitra +1",
		neck="Debilis Medallion", --15
		ear1="Beatific Earring",
		ear2="Healing Earring",
        body="Ebers Bliaud +1",
        hands="Fanatic Gloves", --15
		ring1="Menelaus's Ring", --20
        ring2="Haoma's Ring", --15
		back=whm_fc_jse_back, --25
        waist="Bishop's Sash",
        legs="Th. Pant. +3", --21
        feet="Vanya Clogs"}) --5

    sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque +2"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        head="Befouled Crown",
		neck="Incanter's Torque",
        ear1="Augment. Earring",
        ear2="Andoaa Earring",
        body="Telchine Chas.",
        hands="Inyan. Dastanas +2",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Perimede Cape",
        waist="Olympus Sash",
        legs="Piety Pantaln. +3",
        feet="Theo. Duckbills +3"}

    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",
		ammo="Impatiens",
        head="Telchine Cap",
		neck="Incanter's Torque",
        ear1="Loquac. Earring",
        ear2="Andoaa Earring",
        body=telchine_enhancing_body,
        hands="Telchine Gloves",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Perimede Cape",
        waist="Olympus Sash",
        legs=telchine_enhancing_legs,
        feet="Theo. Duckbills +3"}

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head="Inyanga Tiara +2",
        body="Piety Briault +3",
        hands=telchine_regen_hands,
        legs=telchine_regen_legs,
		feet=telchine_regen_feet})

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
        hands="Ebers Mitts +1",
        legs="Th. Pant. +3" })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {waist="Gishdubar Sash"})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
		ear1="Earthcry Earring",
        waist="Siegel Sash",
		legs="Haven Hose"})

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
		head="Chironic Hat",
        waist="Emphatikos Rope"})

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {feet="Ebers Duckbills +1"})

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        main="Beneficus",
		head="Ebers Cap +1",
		body="Ebers Bliaud +1",
		hands="Ebers Mitts +1",
		legs="Piety Pantaln. +3",
		feet="Ebers Duckbills +1"})

    sets.midcast.BoostStat = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast.Protect = set_combine(sets.midcast.ConserveMP, sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect
    sets.midcast.ShellraV = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
        main="Maxentius",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Theophany Cap +3",
		neck="Incanter's Torque",
        ear1="Digni. Earring",
        ear2="Regal Earring",
        body="Theo. Briault +3",
        hands="Piety Mitts +3",
		ring1="Kishar Ring",
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back=whm_fc_jse_back,
        waist="Refoccilation Stone",
        legs="Th. Pant. +3",
		feet=chironic_macc_feet}

    sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], {
        main="Maxentius",
        sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head=chironic_macc_head,
		neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Friomisi Earring",
		body="Chironic Doublet",
		hands=chironic_macc_hands,
		ring1={name="Shiva Ring +1", bag="wardrobe3"},
		ring2={name="Shiva Ring +1", bag="wardrobe4"},
		back="",
		waist="Refoccilation Stone",
		legs="Chironic Hose",
		feet=chironic_macc_feet})

    sets.midcast.Holy = sets.midcast.Banish

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Theophany Cap +3",
		neck="Erra Pendant",
        ear1="Digni. Earring",
        ear2="Regal Earring",
        body="Chironic Doublet",
        hands="Inyan. Dastanas +2",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back=whm_fc_jse_back,
        waist="Eschan Stone",
        legs="Th. Pant. +3",
        feet="Medium's Sabots"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Theophany Cap +3",
		neck="Erra Pendant",
		ear1="Digni. Earring",
		ear2="Regal Earring",
		body="Theo. Briault +3",
		hands="Kaykaus Cuffs +1",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2="Kishar Ring",
		back=whm_fc_jse_back,
		waist="Luminary Sash",
		legs="Th. Pant. +3",
		feet="Theo. Duckbills +3"}

    sets.midcast.IntEnfeebles = sets.midcast.MndEnfeebles

    sets.midcast.Impact = {
        main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
        head=empty,
		neck="Sanctity Necklace",
        body="Twilight Cloak",
        hands="Kaykaus Cuffs +1",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back=whm_fc_jse_back,
		waist="Luminary Sash",
        legs="Th. Pant. +3",
        feet="Theo. Duckbills +3"}

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC


    -- Sets to return to when not performing an action.

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Loricate Torque +1",
		ear1="Sanare Earring",
		ear2="Eabani Earring",
		body="Piety Briault +3",
		hands=chironic_refresh_hands,
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Moonlight Cape",
		waist="Slipor Sash",
		legs="Assid. Pants +1",
		feet="Herald's Gaiters"}

    sets.idle.DT = set_combine(sets.idle, {
		main="Terra's Staff",
		sub="Enki Strap",
		ammo="Staunch Tathlum +1",
		ring1="Vocane Ring",
		ring2="Defending Ring"})

    sets.idle.MEva = set_combine(sets.idle.DT, {
        head="Inyanga Tiara +2",
		body="Pinga Tunic +1",
		hands="Inyan. Dastanas +2",
		ring1="Inyanga Ring",
		back=whm_cure_jse_back,
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2"})


    sets.idle.Town = set_combine(sets.idle, {
        main="Yagrush",
        sub="Ammurapi Shield",
        head="Kaykaus Mitra +1",
		neck="Cleric's Torque +2",
        ear1="Glorious Earring",
        ear2="Regal Earring",
        body="Pinga Tunic +1",
        hands="Kaykaus Cuffs +1",
        legs="Pinga Pants +1"})

    sets.idle.Weak = sets.idle.DT

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        main="Yagrush",
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		neck="Combatant's Torque",
		ear1="Cessance Earring",
		ear2="Telos Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		ring1="Petrov Ring",
		ring2="Ilabrat Ring",
		back=whm_stp_jse_back,
		waist="Windbuffet Belt +1",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1", back="Mending Cape"}
    sets.buff['Devotion'] = {head="Piety Cap +3"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash"} --10

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
    if spellMap == "Holy" and state.Buff['Afflatus Solace'] then
		equip({feet="Piety Duckbills +3"})
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
	if spellMap == 'Banish' and state.Buff['Afflatus Misery'] then
		equip({legs="Piety Pantaln. +3"})
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Repose" then
            send_command('@timers c "Repose ['..spell.target.name..']" 90 down spells/00098.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
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

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'boostspell' then
        send_command('@input /ma '..state.BoostSpell.value..' <me>')
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
--      if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
--          return "CureMelee"
        if default_spell_map == 'Cure' then
            if buffactive['Afflatus Solace'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
                end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureWeather"
                else
                    return "CureNormal"
                end
            end
        elseif default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "CuragaNormal"
            end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
