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
--              [ ALT+` ]           Magic Burst Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--  Abilities:  [ WIN+F ]          Full Circle
--              [ WIN+B ]          Blaze of Glory
--              [ WIN+E ]          Ecliptic Attrition
--              [ WIN+D ]          Dematerialize
--              [ WIN+L ]          Life Cycle
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ DELETE ]    Exudation
--              [ ALT+Delete ]    Myrkr
--  	        [ END ]    Hexa Strike
--              [ HOME ]    Black Halo
--
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
	geo_timer = ''
    indi_timer = ''
    indi_duration = 315
	entrust_timer = ''
	entrust_duration = 344
	entrust = 0
	newLuopan = 0

    state.Buff.Entrust = buffactive.Entrust or false
    state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false

    state.CP = M(false, "Capacity Points Mode")

    state.Auto = M(true, 'Auto Nuke')
    state.Element = M{['description']='Element','Fire','Blizzard','Aero','Stone','Thunder','Water'}

    degrade_array = {
        ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V'},
        ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V'},
        ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V'},
        ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V'},
        ['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V'},
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
        }

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
	state.ConsMP = M(false, 'MP Coat')

    send_command('bind !` gs c toggle MagicBurst')
	send_command('bind != gs c toggle ConsMP')
	send_command('bind @f input /ja "Full Circle" <me>')
    send_command('bind @b input /ja "Blaze of Glory" <me>')
    send_command('bind @a input /ja "Ecliptic Attrition" <me>')
    send_command('bind @d input /ja "Dematerialize" <me>')
	send_command('bind @l input /ja "Life Cycle" <me>')
	send_command('bind @e input /ja "Entrust" <me>')
    send_command('bind ^insert gs c cycleback Element')
    send_command('bind ^delete gs c cycle Element')
    send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind Delete input /ws "Exudation" <t>')
    send_command('bind !Delete input /ws "Myrkr" <t>')
    send_command('bind End input /ws "Hexa Strike" <t>')
    send_command('bind Home input /ws "Black Halo" <t>')


    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
	send_command('unbind !`')
    send_command('unbind !=')
    send_command('unbind @f')
    send_command('unbind @b')
    send_command('unbind @a')
    send_command('unbind @d')
    send_command('unbind @l')
    send_command('unbind @e')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind @c')
    send_command('unbind @w')
	send_command('unbind Delete')
	send_command('unbind !Delete')
	send_command('unbind End')
	send_command('unbind Home')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
include('Malothar-Items.lua')
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1"}
    sets.precast.JA['Life Cycle'] = {
		main="Idris",
		sub="Culminus",
		head="Bagua Galero +3",
		neck="Sanctity Necklace",
		ear1="Etiolation Earring",
		ear2="Calamitous Earring",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3", -- Regal Cuffs
		back="Moonlight Cape",
		waist="Eschan Stone", -- Gold Moogle Belt
		legs="Geomancy Pants +3",
		feet="Bagua Sandals +3"}


    -- Fast cast sets for spells

    sets.precast.FC = {
    --  /RDM --15
        range="Dunna", --3
        head=merlinic_fc_head, --15
		neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        body="Zendik Robe", --13
        hands=merlinic_fc_hands, --7
		ring1="Kishar Ring", --4
        ring2="Lebeche Ring", --(2)
		back="Perimede Cape", --(4)
        waist="Witful Belt", --3/(3)
        legs="Geomancy Pants +3", --15
        feet=merlinic_fc_feet} -- 11

    sets.precast.FC['Enhancing Magic'] = sets.precast.FC

    sets.precast.FC['Elemental Magic'] = sets.precast.FC

    sets.precast.FC.Cure = sets.precast.FC

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Jhakri Coronal +2",
		neck="Fotia Gorget",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        waist="Fotia Belt",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2"}

    sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {
		ear1="Cessance Earring",
		ear2="Telos Earring",
		ring1={name="Levia. Ring +1", bag="wardrobe3"},
		ring2={name="Levia. Ring +1", bag="wardrobe4"},
		back=geo_mnd_da_jse_back})
		
	sets.precast.WS['Exudation'] = set_combine(sets.precast.WS, {
		neck="Imbodla Necklace",
		ear1="Lifestorm Earring",
		ear2="Telos Earring",
		ring1="Freke Ring",
		ring2={name="Levia. Ring +1", bag="wardrobe4"},
		back=geo_int_wsd_jse_back,
		waist="Latria Sash"})
	
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Realmrazer'],{
		neck="Caro Necklace",
		ring1={name="Levia. Ring +1", bag="wardrobe3"},
		ring2={name="Levia. Ring +1", bag="wardrobe4"},
		waist="Prosilio Belt +1",
		back=geo_mnd_wsd_jse_back})
	
    sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",
		ear1="Tati Earring +1",
		ring1="Begrudging Ring",
		ring2="Ifrit Ring +1",
		back=geo_mnd_da_jse_back,
		waist="Prosilio Belt +1"})
	
    sets.precast.WS['Flash Nova'] = set_combine(sets.midcast['Elemental Magic'],{})
	
	sets.precast.WS['Shattersoul']= set_combine(sets.precast.WS, {
		ear1="Psystorm Earring",
		ear2="Telos Earring",
		ring1="Freke Ring",
		ring2={name="Shiva Ring +1", bag="wardrobe4"},
		back=geo_int_da_jse_back})
	
    sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Barkaro. Earring",
		ring1={name="Shiva Ring +1", bag="wardrobe3"},
		ring2="Archon Ring",
		back=geo_int_wsd_jse_back,
		waist="Yamabuki-no-Obi"})

    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {} -- Haste

   sets.midcast.Geomancy = {
        main="Idris",
        sub="Genmei Shield",
        range="Dunna",
        head=vanya_cmp_head,
		neck="Bagua Charm +2",
        ear1="Magnetic Earring",
        ear2="Calamitous Earring",
        body="Vedic Coat",
        hands="Shrieker's Cuffs",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Lifestream Cape",
        waist="Austerity Belt +1",
        legs=vanya_cmp_legs,
        feet="Medium's Sabots"}

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
        legs="Bagua Pants +3",
        feet="Azimuth Gaiters +1"})

    sets.midcast.Cure = {
        main=gada_cure, --23
		sub="Sors Shield", --3
		head=vanya_cure_head, --10
		neck="Incanter's Torque",
		ear1="Healing Earring",
		ear2="Beatific Earring",
		body="Vanya Robe",
		hands="Vanya Cuffs",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2="Menelaus's Ring",
		back="Tempered Cape +1", --6
		waist="Bishop's Sash",
		legs=vanya_cure_legs,
		feet="Vanya Clogs"} --5

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ear1="Mendi. Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
		waist="Luminary Sash"})

    sets.midcast.Cursna = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        main=gada_enhance,
        sub="Ammurapi Shield",
		head="Befouled Crown",
		neck="Incanter's Torque",
        ear1="Augment. Earring",
        ear2="Andoaa Earring",
        body="Telchine Chas.",
		hands="Ayao's Gages",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
		legs="Shedir Seraweels",
		feet="Regal Pumps +1"}

    sets.midcast.EnhancingDuration = {
        main=gada_enhance,
        sub="Ammurapi Shield",
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches"}

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        body="Telchine Chas."})

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
        waist="Gishdubar Sash",
        back="Grapevine Cape"})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
		ear1="Earthcry Earring",
		legs="Shedir Seraweels",
        waist="Siegel Sash"})	

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        head="Amalric Coif +1",
        waist="Emphatikos Rope",
		legs="Shedir Seraweels"})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect


    sets.midcast.MndEnfeebles = {
        main="Idris",
		sub="Ammurapi Shield",
		ammo="Hydrocera",
		head="Geo. Galero +3",
		neck="Bagua Charm +2",
		ear1="Gwati Earring", --Regal Earring
		ear2="Digni. Earring",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2="Kishar Ring",
		back=geo_mab_jse_back,
		waist="Luminary Sash",
		legs="Geomancy Pants +3",
		feet="Bagua Sandals +3"} -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        ammo="Pemphredo Tathlum",
		ear2="Barkaro. Earring",
		ring2="Freke Ring",
		waist="Porous Rope"}) -- INT/Magic accuracy

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Geo. Galero +3",
		neck="Incanter's Torque",
		ear1="Barkaro. Earring",
		ear2="Digni. Earring",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		ring1="Evanescence Ring",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Perimede Cape",
		waist="Luminary Sash",
		legs="Azimuth Tights +1",
		feet="Geo. Sandals +3"}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Bagua Galero +3",
		neck="Erra Pendant",
		ear1="Hirudinea Earring",
		body=merlinic_aspir_body,
		--hands=merlinic_aspir_hands,
		ring2="Archon Ring",
		back=geo_mab_jse_back,
		waist="Fucho-no-Obi",
		--legs=merlinic_aspir_legs,
		feet=merlinic_aspir_feet})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        main="Idris",
		range="Dunna",
		head="Amalric Coif +1",
		neck="Orunmila's Torque",
		ear1="Barkaro. Earring", -- Regal Earring
		ear2="Enchntr. Earring +1",
		body="Zendik Robe",
		hands="Geo. Mitaines +3",
		ring1="Kishar Ring",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back=geo_mab_jse_back,
		waist="Luminary Sash",
		legs="Geomancy Pants +3",
		feet="Geo. Sandals +3"})

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        main="Idris",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Bagua Galero +3",
		neck="Saevus Pendant +1",
		ear1="Friomisi Earring", -- Regal Earring
		ear2="Barkaro. Earring",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		ring1="Freke Ring",
		ring2={name="Shiva Ring +1", bag="wardrobe4"},
		back=geo_mab_jse_back,
		waist="Refoccilation Stone",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1"}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        neck="Sanctity Necklace",
		ear1="Hermetic Earring",
		feet="Bagua Sandals +3"})

    sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
		neck="Bagua Charm +2",
		ear1="Digni. Earring",
        body="Twilight Cloak",
		hands="Geo. Mitaines +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		waist="Luminary Sash",
		legs="Geomancy Pants +3",
		feet="Geo. Sandals +3"})

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Befouled Crown",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Sanare Earring",
		body="Jhakri Robe +2",
		hands="Bagua Mitaines +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Moonlight Cape",
		waist="Slipor Sash",
		legs="Assid. Pants +1",
		feet="Geo. Sandals +3"}

    sets.idle.DT = set_combine(sets.idle, {
        body="Mallquis Saio +2", --8/8
		ring1="Vocane Ring", --7/7
		ring2="Defending Ring"}) --10/10

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, {
        -- Pet: -DT (37.5% to cap) / Pet: Regen
        main="Idris",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Bagua Galero +3",
		neck="Bagua Charm +2",
		ear1="Etiolation Earring",
		ear2="Genmei Earring",
		body="Mallquis Saio +2",
		hands="Geo. Mitaines +3",
		ring1="Vocane Ring",
		ring2="Defending Ring",
		back=geo_pet_jse_back,
		waist="Slipor Sash",
		legs="Artsieq Hose",
		feet="Bagua Sandals +3"})

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {})

    sets.PetHP = {head="Bagua Galero +3"}

    -- .Indi sets are for when an Indi-spell is active.
    --sets.idle.Indi = set_combine(sets.idle, {})
    --sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    --sets.idle.DT.Indi = set_combine(sets.idle.DT, {})
    --sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {})

    --sets.idle.Town = set_combine(sets.idle, {})

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Geo. Sandals +3"}

    sets.latent_refresh = {waist="Fucho-no-Obi"}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        main="Idris",
		sub="Genmei Shield",
		head="Jhakri Coronal +2",
		neck="Combatant's Torque",
		ear1="Digni. Earring",
		ear2="Telos Earring",
		body="Jhakri Robe +2",
		hands="Gazu Bracelet +1",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		back=geo_haste_jse_back,
		waist="Goading Belt",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"}
		
	sets.engaged.Hybrid = {
		neck="Loricate Torque +1",
		ear1="Cessance Earring",
		body="Onca Suit",
		ring1="Defending Ring",
		ring2="Vocane Ring",
		back=geo_da_jse_cape,
		waist="Ninurta's Sash"}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.magic_burst = {
        head="Ea Hat +1", --7(+7)
		neck="Mizu. Kubikazari", --10
		body="Ea Houppe. +1", --9(+9)
		ring2="Mujin Band", --0(+5)
		legs="Ea Slops +1", --8(+8)
		feet="Jhakri Pigaches +2"} --7

    sets.buff.Doom = {
		neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash"} --10
		
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
	sets.ConsMP = {body="Seidr Cotehardie"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'Geomancy' then
        if spell.name:startswith('Indi') and state.Buff.Entrust and spell.target.type == 'SELF' then
            add_to_chat(002, 'Entrust active - Select a party member!')
            cancel_spell()
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    elseif state.Auto.value == true then
        if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and spellMap ~= 'GeoNuke' then
            refine_various_spells(spell, action, spellMap, eventArgs)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
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
    elseif spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    elseif spell.skill == 'Geomancy' then
        if state.Buff.Entrust and spell.english:startswith('Indi-') then
            equip({main=gada_indi})
			entrust = 1
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
		if spell.english:startswith('Geo') then
            geo_timer = spell.english
			send_command('@timers c "'..geo_timer..'" 600 down spells/00136.png')
		elseif spell.english:startswith('Indi') then
			if entrust == 1 then
				entrust_timer = spell.english
				send_command('@timers c "'..entrust_timer..' ['..spell.target.name..']" '..entrust_duration..' down spells/00136.png')
				entrust = 0
			else
				send_command('@timers d "'..indi_timer..'"')
				indi_timer = spell.english
				send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
			end
        elseif spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english:startswith('Geo-') or spell.english == "Life Cycle" then
            newLuopan = 1
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

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    if gain == false then
        send_command('@timers d "'..geo_timer..'"')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
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
    if pet.isvalid then
        if pet.hpp > 73 then
            if newLuopan == 1 then
                equip(sets.PetHP)
                disable('head')
            end
        elseif pet.hpp <= 73 then
            enable('head')
            newLuopan = 0
        end
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
end

-- Function to display the current relevant user state when doing an update.
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
    if state.Auto.value then
        msg = ' Auto: On |'
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

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'nuke' and not midaction() then
        send_command('@input /ma "' .. state.Element.current .. ' V" <t>')
    end
end

function refine_various_spells(spell, action, spellMap, eventArgs)

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'GeoElem' then
            spell_index = table.find(degrade_array[spell.element],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Aspir') then
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
    set_macro_page(1, 1)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 1')
end
