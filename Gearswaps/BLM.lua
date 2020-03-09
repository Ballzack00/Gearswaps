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
--              [ WIN+D ]           Toggle Death Casting Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Spells:     [ CTRL+` ]          Stun
--              [ ALT+P ]           Shock Spikes
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ Delete ]    Myrkr
--
--


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
  
    state.CP = M(false, "Capacity Points Mode")
	
    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
    }

    lockstyleset = 11

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.CastingMode:options('Normal','Resistant','Occult')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
    state.CP = M(false, "Capacity Points Mode")
	state.ConsMP = M(false, 'AF Body')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder'}
	
	-- High MP items get tagged with priorities
    gear["Amalric Coif +1"]            = {name="Amalric Coif +1",priority=141}
	gear["Amalric Doublet +1"]          = {name="Amalric Doublet +1",priority=153}
	gear["Amalric Slops +1"]         = {name="Amalric Slops +1",priority=185}
	gear["Amalric Nails +1"]         = {name="Amalric Nails +1",priority=106}
	gear["Bane Cape"]      = {name="Bane Cape",priority=90}
	gear["Barkaro. Earring"]      = {name="Barkaro. Earring",priority=25}
	gear["Elis Tome"]       = {name="Elis Tome",priority=30}
	gear["Etiolation Earring"]      = {name="Etiolation Earring",priority=50}
	gear["Gwati Earring"]       = {name="Gwati Earring",priority=10}
	gear["Fucho-no-obi"]       = {name="Fucho-no-obi",priority=30}
	gear["Helios Boots"]       = {name="Helios Boots",priority=14}
	gear["Helios Jacket"]       = {name="Helios Jacket",priority=54}
	gear["Hydrocera"]       = {name="Hydrocera",priority=20}
	gear["Loquac. Earring"]       = {name="Loquac. Earring",priority=30}
	gear["Mall. Chapeau +2"]       = {name="Mall. Chapeau +2",priority=29}
	gear["Mendicant's Earring"]       = {name="Mendicant's Earring",priority=30}
	gear["Mephitas's Ring"]      = {name="Mephitas's Ring",priority=100}
    gear["Mephitas's Ring +1"]      = {name="Mephitas's Ring +1",priority=110}
	gear["Orunmila's Torque"]       = {name="Orunmila's Torque",priority=30}
	gear["Perdition Slops"]       = {name="Perdition Slops",priority=59}
	gear["Pixie Hairpin +1"]       = {name="Pixie Hairpin +1",priority=120}
	gear["Psilomene"]   	= {name="Psilomene",priority=45}
	gear["Psycloth Lappas"]       = {name="Psycloth Lappas",priority=109}
	gear["Sanctity Necklace"]       = {name="Sanctity Necklace",priority=35}
	gear["Spae. Tonban +3"]       = {name="Sanctity Necklace",priority=158}
	gear["Zendik Robe"]       = {name="Zendik Robe",priority=57}

    send_command('bind ^` input /ma Stun <t>')
    send_command('bind !` gs c toggle MagicBurst')
	send_command('bind ^= gs c toggle ConsMP')
    send_command('bind @a input /ma "Aspir III" <t>')
    send_command('bind @d gs c toggle DeathMode')
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind Delete input /Myrkr')
    send_command('bind End input /ws "Gate of Tartarus" <t>')
    send_command('bind Home input /ws "Vidohunir" <t>')

    select_default_macro_book()
    set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind @a')
    send_command('unbind @d')
    send_command('unbind @s')
    send_command('unbind @r')
    send_command('unbind @c')
    send_command('unbind @w')
    send_command('unbind Delete')
    send_command('unbind End')
    send_command('unbind Home')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
include('Ballzack-Items.lua')
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    ---- Precast Sets ----

    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        back=blm_mab_jse_back,
		feet="Wicce Sabots +1"}

    sets.precast.JA.Manafont = {body="Arch. Coat +3"}

    -- Fast cast sets for spells
    sets.precast.FC = {
    --    /RDM --15
        ammo="Sapience Orb", -- 2%
		head=merlinic_fc_head, -- 14%
		neck=gear["Orunmila's Torque"], -- 5%
		ear1=gear["Loquac. Earring"], -- 2%
		ear2="Enchntr. Earring +1", -- 2%
		body=gear["Zendik Robe"], -- 13%
		hands=merlinic_fc_hands, -- 7%
		ring1="Prolix Ring",
		ring2="Kishar Ring", -- 4%
		back="Perimede Cape",
		waist="Witful Belt", -- 3%
		legs=gear["Psycloth Lappas"], -- 7%
		feet=merlinic_fc_feet} --11%

    sets.precast.FC['Enhancing Magic'] = sets.precast.FC

    sets.precast.FC['Elemental Magic'] = sets.precast.FC

    sets.precast.FC.Cure = sets.precast.FC

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2={name="Stikini Ring +1", bag="wardrobe4"}})

    sets.precast.FC.DeathMode = {
        ammo=gear["Psilomene"],
		head=gear["Amalric Coif +1"],
		neck=gear["Orunmila's Torque"],
		ear1=gear["Loquac. Earring"],
		ear2=gear["Etiolation Earring"],
		body=gear["Zendik Robe"],
		hands=helios_fc_hands,
		ring1=gear["Mephitas's Ring"],
		ring2=gear["Mephitas's Ring +1"],
		back=blm_mp_fc_jse_back,
		waist="Witful Belt",
		legs=gear["Psycloth Lappas"],
		feet=gear["Amalric Nails +1"]}

    sets.precast.FC.Impact.DeathMode = set_combine(sets.precast.FC.DeathMode, {
		head=empty, 
		body="Twilight Cloak"})

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
		neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
		ring1="Freke Ring",
		ring2={name="Shiva Ring +1", bag="wardrobe4"},
		back=blm_mab_jse_back,
		waist="Fotia Belt",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Vidohunir'] = {
        ammo="Pemphredo Tathlum",
        head=gear["Pixie Hairpin +1"],
		neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        body=gear["Amalric Doublet +1"],
        hands=amalric_d_hands,
		ring1="Freke Ring",
        ring2="Archon Ring",
        back=blm_mab_jse_back,
        waist="Sacro Cord",
        legs=gear["Amalric Slops +1"],
        feet=gear["Amalric Nails +1"]} -- INT

    sets.precast.WS['Myrkr'] = {
        ammo=gear["Psilomene"],
		head="Kaabnax Hat",
		neck="Dualism Collar +1",
		ear1=gear["Etiolation Earring"],
		ear2="Influx Earring",
		body="Weather. Robe +1",
		hands="Otomi Gloves",
		ring1=gear["Mephitas's Ring"],
		ring2=gear["Mephitas's Ring +1"],
		back=gear["Bane Cape"],
		waist="Shinjutsu-no-Obi +1",
		legs=gear["Amalric Slops +1"],
		feet="Psycloth Boots"} -- Max MP


    ---- Midcast Sets ----

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
        ammo=gear["Hydrocera"],
		head="Vanya Hood",
		neck="Incanter's Torque",
		ear1="Healing Earring",
		ear2="Beatific Earring",
		body="Vanya Robe",
		hands="Telchine Gloves",
		ring1="Menelaus's Ring",
		ring2="Sirona's Ring",
		back="Tempered Cape +1",
		waist="Bishop's Sash",
		legs="Vanya Slops",
		feet="Vanya Clogs"}

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        waist="Luminary Sash"})

    sets.midcast.Cursna = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        main="Gada",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Augment. Earring",
		body="Telchine Chas.",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Perimede Cape",
		waist="Olympus Sash"}

    sets.midcast.EnhancingDuration = {
        main="Gada",
		sub="Ammurapi Shield",
		head="Telchine Cap",
		body="Telchine Chas.",
		hands="Telchine Gloves",
		legs="Telchine Braconi",
		feet="Telchine Pigaches"}

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        body="Telchine Chas."})

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
		head=gear["Amalric Coif +1"],
        waist="Gishdubar Sash"})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash"})

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
        head=gear["Amalric Coif +1"],
        waist="Emphatikos Rope"})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.MndEnfeebles = {
        ammo=gear["Hydrocera"],
		head="Spae. Petasos +3",
		neck="Src. Stole +2",
		ear1="Regal Earring",
		ear2="Digni. Earring",
		body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2="Kishar Ring",
		back=blm_mab_jse_back,
		waist="Luminary Sash",
		legs="Spae. Tonban +3",
		feet="Spae. Sabots +3"} -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        ammo="Pemphredo Tathlum",
		ear2="Barkaro. Earring"}) -- INT/Magic accuracy

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.IntEnfeebles, {feet="Arch. Sabots +3"})
	sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum",
		head="Spae. Petasos +3",
		neck="Erra Pendant",
		ear1="Digni. Earring",
		ear2=gear["Barkaro. Earring"],
		body="Shango Robe",
		hands="Spae. Gloves +3",
		ring1="Evanescence Ring",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back=gear["Bane Cape"],
		waist="Luminary Sash",
		legs="Spae. Tonban +3",
		feet="Wicce Sabots +1"}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head=gear["Pixie Hairpin +1"],
		ear1="Hirudinea Earring",
		hands=merlinic_aspir_hands,
		ring2="Archon Ring",
		back=blm_mab_jse_back,
		waist=gear["Fucho-no-Obi"],
		feet=merlinic_aspir_feet})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		ear1="Regal Earring",
		body="Spaekona's Coat +3",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		back=blm_mab_jse_back,
		feet="Spae. Sabots +3"})

    sets.midcast.Death = {
        ammo=gear["Psilomene"],
		head=gear["Pixie Hairpin +1"],
		neck="Src. Stole +2",
		ear1="Static Earring",
		ear2=gear["Barkaro. Earring"],
		body=gear["Amalric Doublet +1"],
		hands=amalric_a_hands,
		ring1="Archon Ring",
		ring2=gear["Mephitas's Ring +1"],
		back=blm_mp_jse_back,
		waist="Hachirin-no-Obi",
		legs="Ea Slops +1",
		feet=gear["Amalric Nails +1"]}
		
	sets.midcast.Death.Aspir = {
		ammo=gear["Psilomene"],
		head=gear["Pixie Hairpin +1"],
		neck="Src. Stole +2",
		ear1=gear["Etiolation Earring"],
		ear2=gear["Barkaro. Earring"],
		body="Ea Houppe. +1",
		hands=amalric_a_hands,
		ring1="Evanescence Ring",
		ring2=gear["Mephitas's Ring +1"],
		back=blm_mp_jse_back,
		waist=gear["Fucho-no-Obi"],
		legs=gear["Spae. Tonban +3"],
		feet=merlinic_aspir_feet}	
		
    sets.midcast.Death.Occult = set_combine(sets.midcast.Death, {
        ammo="Seraphic Ampulla",
		head=gear["Mall. Chapeau +2"],
		neck="Combatant's Torque",
		ear1="Telos Earring",
		ear2="Dedition Earring",
		body=gear["Helios Jacket"],
		hands=helios_occult_hands,
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		ring2={name="Chirich Ring +1", bag="wardrobe4"},
		back=blm_stp_jse_back,
		waist="Oneiros Rope",
		legs=gear["Perdition Slops"],
		feet=gear["Helios Boots"]})

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum",
		head="Arch. Petasos +3",
		neck="Src. Stole +2",
		ear1="Regal Earring",
		ear2=gear["Barkaro. Earring"],
		body=gear["Amalric Doublet +1"],
		hands=amalric_d_hands,
		ring1="Freke Ring",
		ring2={name="Shiva Ring +1", bag="wardrobe4"},
		back=blm_mab_jse_back,
		waist="Refoccilation Stone",
		legs=gear["Amalric Slops +1"],
		feet="Amalric Nails +1"}
		--feet="Arch. Sabots +3"}

    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        waist="Eschan Stone",
		legs=merlinic_mab_legs,
		feet="Jhakri Pigaches +2"})


    sets.midcast['Elemental Magic'].Occult = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Seraphic Ampulla",
		head=gear["Mall. Chapeau +2"],
		neck="Combatant's Torque",
		ear1="Telos Earring",
		ear2="Dedition Earring",
		body=gear["Helios Jacket"],
		hands=helios_occult_hands,
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		ring2={name="Chirich Ring +1", bag="wardrobe4"},
		back=blm_stp_jse_back,
		waist="Oneiros Rope",
		legs=gear["Perdition Slops"],
		feet=gear["Helios Boots"]})

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak",
		hands="Spae. Gloves +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		waist="Eschan Stone",
		legs="Ea Slops +1",
		feet="Arch. Sabots +3"})

    sets.midcast.Impact.Occult = set_combine(sets.midcast.Impact, {
        ammo="Seraphic Ampulla",
		neck="Combatant's Torque",
		ear1="Telos Earring",
		ear2="Dedition Earring",
		body="Twilight Cloak",
		hands=helios_occult_hands,
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		ring2={name="Chirich Ring +1", bag="wardrobe4"},
		back=blm_stp_jse_back,
		waist="Oneiros Rope",
		legs=gear["Perdition Slops"],
		feet=gear["Helios Boots"]})

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Idle Sets --

    sets.idle = {
        ammo="Staunch Tathlum +1",
		head="Volte Beret",
		neck="Loricate Torque +1",
		ear1="Lugalbanda Earring",
		ear2="Hearty Earring",
		body="Jhakri Robe +2",
		hands=merlinic_dt_hands,
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Moonlight Cape",
		waist="Slipor Sash",
		legs="Assid. Pants +1",
		feet="Herald's Gaiters"}

    sets.idle.DT = set_combine(sets.idle, {
        head=merlinic_dt_head, --3/3
		body="Mallquis Saio +2", --8/8
		ring1="Vocane Ring", --7/7
		ring2="Defending Ring", --10/10
		legs=merlinic_dt_legs, --3/3
		feet="Hag. Sabots +1"})

    sets.idle.ManaWall = {
        back=blm_mab_jse_back, 
		feet="Wicce Sabots +1"}

    sets.idle.DeathMode = {
		ammo=gear["Psilomene"],
		head=gear["Amalric Coif +1"],
		neck="Loricate Torque +1",
		ear1=gear["Etiolation Earring"],
		ear2=gear["Barkaro. Earring"],
		body=gear["Amalric Doublet +1"],
		hands=amalric_a_hands,
		ring1="Defending Ring",
		ring2=gear["Mephitas's Ring +1"],
		back=gear["Bane Cape"],
		waist="Slipor Sash",
		legs=gear["Amalric Slops +1"],
		feet=gear["Amalric Nails +1"]}

    sets.idle.Weak = sets.idle.DT

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    --sets.latent_dt = {ear2="Sorcerer's Earring"}

    sets.magic_burst = {
        head="Ea Hat +1",
		body="Ea Houppe. +1",
		ring2="Mujin Band",
		legs="Ea Slops +1"}

    sets.magic_burst.Resistant = set_combine(sets.magic_burst,{
		hands="Spae. Gloves +3",
		ear1="Friomisi Earring"})

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    sets.engaged = {
        head="Jhakri Coronal +2",
		neck="Combatant's Torque",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
		waist="Windbuffet Belt +1",
		back=blm_stp_jse_back,
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash"} --10

    sets.DarkAffinity = {head="Pixie Hairpin +1",ring2="Archon Ring"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
	sets.ConsMP = {body="Spaekona's Coat +3"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
    if spellMap == 'Aspir' then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            if state.CastingMode.value == "Resistant" then
                equip(sets.midcast.Death.Resistant)
            else
                equip(sets.midcast.Death)
            end
        end
    end
	if spell.action_type == 'Magic' and state.DeathMode.value then
		eventArgs.handled = true	
		if S{"Aspir", "Aspir II", "Aspir III"}:contains(spell.english) then
			equip(sets.midcast.Death.Aspir)	
		end	
	end

    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            --if state.CastingMode.value == "Resistant" then
                --equip(sets.magic_burst.Resistant)
            --else
                equip(sets.magic_burst)
            --end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
		if spell.skill == 'Elemental Magic' and state.ConsMP.value then
			equip(sets.ConsMP)
		end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" or spell.english == "Breakga" then
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
    -- Unlock armor when Mana Wall buff is lost.
    if buff== "Mana Wall" then
        if gain then
            --send_command('gs enable all')
            equip(sets.precast.JA['Mana Wall'])
            --send_command('gs disable all')
        else
            --send_command('gs enable all')
            handle_equipping_gear(player.status)
        end
    end

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

--[[ latent DT set auto equip on HP% change
    --windower.register_event('hpp change', function(new, old)
        --if new<=25 then
            --equip(sets.latent_dt)
        --end
    --end)
--]]


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    --if player.hpp <= 25 then
        --idleSet = set_combine(idleSet, sets.latent_dt)
    --end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end

    return defenseSet
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.DeathMode.value then
        msg = msg .. ' Death: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local aspirs = S{'Aspir','Aspir II','Aspir III'}

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if aspirs:contains(spell.name) then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 2)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
