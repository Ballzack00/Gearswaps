-- Original: Motenten / Modified: Ballzack

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+H ]           Cycle Helix Mode
--              [ WIN+R ]           Cycle Regen Mode
--              [ WIN+S ]           Toggle Storm Surge
--
--  Abilities:  [ CTRL+` ]          Immanence
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+[ ]          Rapture/Ebullience
--              [ CTRL+] ]          Altruism/Focalization
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+] ]           Perpetuance
--              [ ALT+; ]           Penury/Parsimony
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ DELETE ]    Myrkr
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
--              gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar power          Rapture                     Ebullience
--              gs c scholar duration       Perpetuance
--              gs c scholar accuracy       Altruism                    Focalization
--              gs c scholar enmity         Tranquility                 Equanimity
--              gs c scholar skillchain                                 Immanence
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
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    state.HelixMode = M{['description']='Helix Mode', 'Potency', 'Duration'}
    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
    state.CP = M(false, "Capacity Points Mode")

    update_active_strategems()

    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II'}
        }

    lockstyleset = 2

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant', 'Occult')
    state.IdleMode:options('Normal', 'DT', 'Vagary', 'Refresh')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.StormSurge = M(false, 'Stormsurge')
	state.ConsMP = M(false, 'MP Coat')


    send_command('bind ^` input /ja Immanence <me>')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind != gs c toggle ConsMP')
    --send_command('bind ^- gs c scholar light')
    --send_command('bind ^= gs c scholar dark')
    --send_command('bind ^[ gs c scholar power')
    --send_command('bind ^] gs c scholar accuracy')
    --send_command('bind ^; gs c scholar speed')
    --send_command('bind !w input /ma "Aspir II" <t>')
    --send_command('bind !o input /ma "Regen V" <stpc>')
    --send_command('bind ![ gs c scholar aoe')
    --send_command('bind !] gs c scholar duration')
    --send_command('bind !; gs c scholar cost')
	
	send_command('bind @p input /ma Poisona')
    send_command('bind ^p input /ma Paralyna')
    send_command('bind @b input /ma Blindna')
    send_command('bind @s input /ma Silena')
    send_command('bind ^s input /ma Stona')
    send_command('bind @v input /ma Viruna')
    send_command('bind @c input /ma Cursna')
    send_command('bind @e input /ma Erase')
	
    send_command('bind !c gs c toggle CP')
    send_command('bind @h gs c cycle HelixMode')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind !s gs c toggle StormSurge')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind Delete input /Myrkr')

    select_default_macro_book()
    set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !=')
    --send_command('unbind ^-')
    --send_command('unbind ^=')
    --send_command('unbind ^[')
    --send_command('unbind ^]')
    --send_command('unbind ^;')
    --send_command('unbind !w')
    --send_command('unbind !o')
    --send_command('unbind ![')
    --send_command('unbind !]')
    --send_command('unbind !;')
	send_command('unbind @p')
    send_command('unbind ^p')
    send_command('unbind @b')
    send_command('unbind @s')
    send_command('unbind ^s')
    send_command('unbind @v')
    send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind !c')
    send_command('unbind @h')
    send_command('unbind @g')
    send_command('unbind !s')
    send_command('unbind @w')
    send_command('unbind Delete')
end



-- Define sets and vars used by this job file.
function init_gear_sets()
include('Rolanddeschain-Items.lua')
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +3"}
    sets.precast.JA['Enlightenment'] = {body="Peda. Gown +3"}
    sets.precast.JA['Sublimation'] = {
        ammo="Psilomene",
		head="Acad. Mortar. +3",
		neck="Dualism Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
		body="Acad. Gown +2",
		hands="Telchine Gloves",
		ring1="Meridian Ring",
		ring2="K'ayres Ring",
		back="Moonlight Cape",
		waist="Gold Mog. Belt",
		legs="Acad. Pants +3",
		feet="Skaoi Boots"}

    -- Fast cast sets for spells
    sets.precast.FC = {
    --    /RDM --15
        --ammo="Sapience Orb", --2
		ammo="Incantor Stone",
        head=merlinic_fc_head, --15
		neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        body="Pinga Tunic +1", --15
        hands="Acad. Bracers +3", --7
		ring1="Kishar Ring", --4
        ring2="Prolix Ring", --2
        back=sch_fc_jse_back, --10
        waist="Witful Belt", --3/(3)
        legs="Pinga Pants +1", --13
        feet="Peda. Loafers +3"} --8

    sets.precast.FC.Grimoire = {head="Peda. M.Board +3", feet="Acad. Loafers +3"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear2="Malignance Earring"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2={name="Stikini Ring +1", bag="wardrobe4"},})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        head="Jhakri Coronal +2",
		neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Telos Earring",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
		ring1="Epaminondas's Ring",
        ring2="Rufescent Ring",
        waist="Fotia Belt",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2"}

    sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		neck="Saevus Pendant +1",
		ear1="Friomisi Earring",
		ear2="Regal Earring",
		body="Peda. Gown +3",
		hands="Jhakri Cuffs +2",
		ring1="Epaminondas's Ring",
		ring2="Archon Ring",
		back=sch_mab_jse_back,
		waist="Hachirin-no-Obi",
		legs="Peda. Pants +3",
		feet="Arbatel Loafers +1"})

    sets.precast.WS['Myrkr'] = {
        ammo="Psilomene",
		head="Kaabnax Hat",
		neck="Dualism Collar +1",
		ear1="Etiolation Earring",
		ear2="Influx Earring",
		body="Weather. Robe +1",
		hands="Otomi Gloves",
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring",
		back=sch_fc_jse_back,
		waist="Shinjutsu-no-Obi +1",
		legs="Amalric Slops +1",
		feet="Psycloth Boots"} -- Max MP


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
        ammo="Esper Stone +1", --0/(-5)
        head="Kaykaus Mitra +1", --11(+2)/(-6)
		neck="Incanter's Torque",
        ear1="Beatific Earring",
        ear2="Magnetic Earring",
        body="Kaykaus Bliaut +1", --(+4)/(-6)
        hands="Kaykaus Cuffs +1", --11(+2)
		ring1="Kuchekula Ring", --0/(-7)
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Tempered Cape +1", --6
        waist="Austerity Belt +1",
        legs="Kaykaus Tights +1", --11(+2)/(-6)
        feet="Kaykaus Boots +1"}

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff", --10
        sub="Achaq Grip", --0/(-4)
        waist="Hachirin-no-Obi"})

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        waist="Luminary Sash"})

    sets.midcast.StatusRemoval = sets.precast.FC

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        main="Gada",
		head="Vanya Hood",
		neck="Debilis Medallion",
        ear1="Beatific Earring",
		ear2="Healing Earring",
		body="Peda. Gown +3",
        hands="Hieros Mittens",
		ring1="Menelaus's Ring",
		ring2="Haoma's Ring",
		back="Oretan. Cape +1",
		waist="Bishop's Sash",
		legs="Acad. Pants +3",
        feet="Vanya Clogs"})

    sets.midcast['Enhancing Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        ammo="Savant's Treatise",
        head="Befouled Crown",
        neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Augment. Earring",
		body=telchine_enhancing_body,
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Perimede Cape",
		waist="Olympus Sash",
		legs=telchine_enhancing_legs,
        feet=telchine_enhancing_feet}

    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",
        head="Telchine Cap",
        body="Peda. Gown +3",
        hands="Telchine Gloves",
        legs=telchine_enhancing_legs,
        feet=telchine_enhancing_feet}

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head="Arbatel Bonnet +1",
        body=telchine_regen_body,
        back="Bookworm's Cape",
		legs=telchine_regen_legs,
		feet=telchine_regen_feet})

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
		back=sch_fc_jse_back})

    sets.midcast.Haste = sets.midcast.EnhancingDuration
	
    sets.midcast.Adloquium = sets.midcast.EnhancingDuration

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
        waist="Gishdubar Sash"})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
		ear2="Earthcry Earring",
        waist="Siegel Sash",
		legs="Shedir Seraweels"})

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
        head="Amalric Coif +1",
        waist="Emphatikos Rope",
		legs="Shedir Seraweels"})

    sets.midcast.Storm = sets.midcast.EnhancingDuration
	
    sets.midcast.Embrava = sets.midcast.EnhancingDuration

    sets.midcast.Stormsurge = set_combine(sets.midcast.Storm, {feet="Peda. Loafers +3"})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        main="Maxentius",
        sub="Ammurapi Shield",
        ammo="Hydrocera",
        head="Acad. Mortar. +3",
		neck="Erra Pendant",
        ear1="Digni. Earring",
        ear2="Regal Earring",
        body="Acad. Gown +2",
        hands="Kaykaus Cuffs +1",
		ring1="Kishar Ring",
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back=sch_mab_jse_back,
        waist="Luminary Sash",
        legs="Chironic Hose",
        feet="Acad. Loafers +3"}

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		ammo="Pemphredo Tathlum",
		ear2="Malignance Earring"})

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Acad. Mortar. +3",
		neck="Erra Pendant",
        ear1="Digni. Earring",
        ear2="Regal Earring",
        body="Acad. Gown +2",
        hands="Acad. Bracers +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Perimede Cape",
        waist="Luminary Sash",
        legs="Peda. Pants +3",
        feet="Acad. Loafers +3"}

    sets.midcast.Kaustra = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		neck="Argute Stole +2",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body=merlinic_burst_body,
		hands="Amalric Gages +1",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back=sch_mab_jse_back,
		waist="Hachirin-no-Obi",
		legs=merlinic_burst_legs,
		feet="Jhakri Pigaches +2"}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        ear2="Hirudinea Earring",
		ring1="Evanescence Ring",
        ring2="Archon Ring",
        waist="Fucho-no-obi",
		legs="Peda. Pants +3",
		feet="Merlinic Crackows"})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		main="Maxentius",
		sub="Ammurapi Shield",
		head="Peda. M.Board +3",
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Regal Earring",
		body="Zendik Robe",
		hands="Acad. Bracers +3",
		ring1="Kishar Ring",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back=sch_mab_jse_back,
		waist="Luminary Sash",
		legs="Acad. Pants +2",
		feet="Acad. Loafers +3"})

    -- Elemental Magic
    sets.midcast['Elemental Magic'] = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Peda. M.Board +3",
		neck="Saevus Pendant +1",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
		ring1={name="Shiva Ring +1", bag="wardrobe3"},
        ring2={name="Shiva Ring +1", bag="wardrobe4"},
        back=sch_mab_jse_back,
        waist="Refoccilation Stone",
        legs="Amalric Slops +1",
        feet="Amalric Nails +1"}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		neck="Sanctity Necklace",
		ear1="Hermetic Earring",
		legs="Peda. Pants +3"})
		
	sets.midcast['Elemental Magic'].Occult = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Seraphic Ampulla",
		head="Mall. Chapeau +2",
		neck="Combatant's Torque",
		ear1="Telos Earring",
		ear2="Dedition Earring",
		body="Helios Jacket",
		hands="Helios Gloves",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		ring2={name="Chirich Ring +1", bag="wardrobe4"},
		back=sch_stp_jse_back,
		waist="Oneiros Rope",
		legs="Perdition Slops",
		feet="Helios Boots"})	

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        main="Akademos",
        sub="Enki Strap",
        head=empty,
		ear1="Digni. Earring",
        body="Twilight Cloak",
		hands="Kaykaus Cuffs +1",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
        legs="Acad. Pants +2",
		feet="Acad. Loafers +3"})
		
	sets.midcast.Impact.Occult = set_combine(sets.midcast.Impact, {
        ammo="Seraphic Ampulla",
		neck="Combatant's Torque",
		ear1="Telos Earring",
		ear2="Dedition Earring",
		body="Twilight Cloak",
		hands="Helios Gloves",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		ring2={name="Chirich Ring +1", bag="wardrobe4"},
		back=sch_stp_jse_back,
		waist="Oneiros Rope",
		legs="Perdition Slops",
		feet="Helios Boots"})	

    sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'],{
        head=merlinic_burst_head,
		neck="Argute Stole +2",
		ring1="Locus Ring",
        ring2="Mujin Band",
        back=sch_mab_jse_back,})

    sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
        head="Pixie Hairpin +1",
        ring1="Archon Ring",
		feet="Jhakri Pigaches +2"})

    sets.midcast.LightHelix = set_combine(sets.midcast.Helix, {})

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Homiliary",
        head="Befouled Crown",
		neck="Loricate Torque +1",
        ear1="Lugalbanda Earring",
        ear2="Sanare Earring",
        body="Jhakri Robe +2",
        hands=chironic_refresh_hands,
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Moonlight Cape",
        waist="Slipor Sash",
        legs="Assiduity Pants +1",
        feet="Herald's Gaiters"}

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
		head=chironic_dt_head,
        body="Mallquis Saio +2", --8/8
        ring1="Vocane Ring", --7/(-1)
        ring2="Defending Ring"}) --10/10

    sets.idle.Vagary = sets.midcast['Elemental Magic']

    sets.idle.Refresh = set_combine(sets.idle,{main="Bolelabunga", sub="Genmei Shield"})

    sets.idle.Weak = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT
    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        feet="Jhakri Pigaches +2",
        neck="Combatant's Torque",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Hetairoi Ring",
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.magic_burst = {
        -- Akademos 10
        head="Peda. M.Board +3", --(4)
		--neck="Argute Stole +2", --10
		neck="Mizu. Kubikazari", --10
        --body=gear.Merl_MB_body, --10
        hands="Amalric Gages +1", --(6)
		ring2="Mujin Band", --(5)
        --legs="Merlinic Shalwar", --2
        --feet="Merlinic Crackows", --11
        }
		
	sets.magic_burst.Resistant = set_combine(sets.magic_burst,{})	

    --sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1", "Lugh's Cape"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

    sets.buff.FullSublimation = {
       head="Acad. Mortar. +3", --4
	   ear1="Savant's Earring", --1
       body="Peda. Gown +3"} --5

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash"} --10

    sets.LightArts = {legs="Acad. Pants +2", feet="Acad. Loafers +3"}
    sets.DarkArts = {body="Acad. Gown +2", feet="Acad. Loafers +3"}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.Bookworm = {back="Bookworm's Cape"}
    sets.CP = {back="Mecisto. Mantle"}
	sets.ConsMP = {body="Seidr Cotehardie"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Aspir' then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then
        equip(sets.precast.FC.Grimoire)
    elseif spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' or spell.english == "Kaustra" then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
            if buffactive['Klimaform'] then
                equip(sets.buff['Klimaform'])
            end
        end
        if spellMap == "Helix" then
            --equip(sets.midcast['Elemental Magic'])
            if spell.english:startswith('Lumino') then
                equip(sets.midcast.LightHelix)
            elseif spell.english:startswith('Nocto') then
                equip(sets.midcast.DarkHelix)
            else
                equip(sets.midcast.Helix)
            end
            if state.HelixMode.value == 'Duration' then
                equip(sets.Bookworm)
            end
        end
    end
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Enfeebling Magic' then
        if spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then
            equip(sets.LightArts)
        elseif spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then
            equip(sets.DarkArts)
        end
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            if state.CastingMode.value == "Resistant" then
                equip(sets.magic_burst.Resistant)
            else
                equip(sets.magic_burst)
            end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
		if spell.skill == 'Elemental Magic' and state.ConsMP.value then
			equip(sets.ConsMP)
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
        if state.Buff.Perpetuance then
            equip(sets.buff['Perpetuance'])
        end
        if spellMap == "Storm" and state.StormSurge.value then
            equip (sets.midcast.Stormsurge)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.FullSublimation)
    end
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

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

    local c_msg = state.CastingMode.value

    local h_msg = state.HelixMode.value
    
    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
	if state.ConsMP.value then
        msg = ' MP Coat: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Helix: ' ..string.char(31,001)..h_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and (spell.element == world.weather_element or spell.element == world.day_element) then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


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
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
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
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 5*33

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spellMap == 'Aspir' then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 2)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
