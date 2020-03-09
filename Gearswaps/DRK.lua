-- Original: Motenten / Modified: Ballzack

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------
--
--  Modes:  	[ F9 ]              Cycle Accuracy Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ F10 ]             Emergency -PDT Mode
--			  	[ CTRL+F10  ]       Cycle Magic Accuracy Modes
--              [ F11 ]             Emergency -MDT Mode
--              [ ALT+F11 ]         Toggle Twilight Mode
--              [ F12 ]             Cycle Idle Modes
--              [ CTRL+F12 ]        Update Current Gear / Report Current Status
--              [ WIN+` ]           Cycle Weapon Modes
--              [ WIN+W ]           Toggle Weapon Lock Mode 
--             	[ CTRL+= ]          Toggle Sam Roll Mode 
--
-- Abilities:  	[ ALT+` ]           Weapon Bash
--             	[ CTRL+L ]          Last Resort
--             	[ CTRL+S ]          Souleater
--             	[ CTRL+N ]          Nether Void
--			   	[ CTRL+D ]          Dark Seal
--             	[ CTRL+C ]    	    Consume Mana
--             	[ CTRL+M ]    	    Meditate
--
--  Spells:
--
--  WS:      	[ Delete ]    	  	Insurgency
--              [ End ]    	  	 	Torcleaver
--              [ Home ]    		Cross Reaper
--              [ WIN+C ]    		Catastrophe
--              [ WIN+R ]    		Resolution
--              [ WIN+E ]    		Entropy
--              [ WIN+Q ]    		Quietus
--              [ WIN+S ]    		Spinning Scythe
--              [ WIN+I ]    		Infernal Scythe

function get_sets()
	include('Ballzack-Items.lua')
	AccIndex = 1
	AccArray = {"LowACC","MidACC","HighACC"} -- 3 Levels Of Accuracy Sets For TP/WS/Hybrid/Stun. First Set Is LowACC. 
	MaccIndex = 1
	MaccArray = {"Potency","Resist","Duration"} 
	WeaponIndex = 1
	WeaponArray = {"Anguta","Apocalypse","Liberator","Redemption","Caladbolg","Ragnarok","Lycurgos"}
	IdleIndex = 1
	IdleArray = {"Movement","Refresh","Regain"} -- Default Idle Set Is Movement --
	Armor = 'None'
	Twilight = 'None'
	TreasureHunter = 'None'
	Samurai_Roll = 'OFF' -- Set Default SAM Roll ON or OFF Here --
	Lock_Main = 'OFF'
	target_distance = 5 -- Set Default Distance Here --
	select_default_macro_book() -- Change Default Macro Book At The End --
	RandomLockstyleGenerator = 'true'
	
	-- List of Equipment Sets created for Random Lockstyle Generator
    -- (If you want to have the same Lockstyle every time, reduce the list to a single Equipset #)
    random_lockstyle_list = {1,2}
	
	-- Random Lockstyle generator.
    if RandomLockstyleGenerator == 'true' then
        local randomLockstyle = random_lockstyle_list[math.random(1, #random_lockstyle_list)]
        send_command('@wait 4;input /lockstyleset '.. randomLockstyle)
    end

	-- Key Binds --
	
	send_command('bind Delete input /ws "Insurgency" <t>')
	send_command('bind End input /ws "Torcleaver" <t>')
	send_command('bind Home input /ws "Cross Reaper" <t>')
	send_command('bind @c input /ws "Catastrophe" <t>')
	send_command('bind @r input /ws "Resolution" <t>')
	send_command('bind @e input /ws "Entropy" <t>')
	send_command('bind @s input /ws "Spinning Scythe" <t>')
	send_command('bind @q input /ws "Quietus" <t>')
	send_command('bind @i input /ws "Infernal Scythe" <t>')
	send_command('bind F9 gs c C1')-- Accuracy
	send_command('bind ^F9 gs c C2') -- Hybrid
	send_command('bind !F9 gs c C4') -- Volte
	send_command('bind F10 gs c C7')-- PDT
	send_command('bind ^F10 gs c C14')-- Macc Cycle
	send_command('bind F11 gs c C15')-- MDT
	send_command('bind ^F11 gs c C3')-- Twilight
	send_command('bind F12 gs c C6')-- Idle
	send_command('bind ^F12 gs c C5')-- Update
	send_command('bind !` input /ja "Weapon Bash" <t>')
	send_command('bind @` gs c C17')-- Cycle Weapons
	send_command('bind @w gs c C18') -- Weapon Lock
	send_command('bind ^` input /ma Stun <t>; wait 0.5; input /p Stun (スタン) <t>')
	send_command('bind ^= gs c C11')-- Sam Roll
	send_command('bind != gs c C12')-- TH Toggle
	
	function file_unload()
		send_command('unbind End')
		send_command('unbind Delete')
        send_command('unbind Home')
		send_command('unbind @c')
		send_command('unbind @r')
		send_command('unbind @e')
		send_command('unbind @s')
		send_command('unbind @q')
		send_command('unbind @i')
		send_command('unbind F9')
		send_command('unbind ^F9')
		send_command('unbind !F9')
		send_command('unbind F10')
		send_command('unbind ^F10')
		send_command('unbind F11')
		send_command('unbind ^F11')
		send_command('unbind F12')
		send_command('unbind ^F12')
		send_command('unbind !`')
		send_command('unbind @`')
		send_command('unbind @w')
		send_command('unbind ^`')
		send_command('unbind ^=')
		send_command('unbind !=')
	end
	
	sets.Idle = {			
		ammo="Staunch Tathlum +1",
        head="Volte Salade",
		neck="Loricate Torque +1",
		ear1="Sanare Earring",
		ear2="Hearty Earring",
		body="Sacro Breastplate",
		hands="Ratri Gadlings +1",
		ring1="Defending Ring",
		ring2={name="Moonlight Ring", bag="wardrobe4"},
		back="Moonlight Cape",
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Volte Sollerets"}

	-- Movement Sets --
	sets.Idle.Movement = set_combine(sets.Idle,{legs="Carmine Cuisses +1"})
	sets.Idle.Movement.Anguta = set_combine(sets.Idle.Movement,{main="Anguta"})
	sets.Idle.Movement.Liberator = set_combine(sets.Idle.Movement,{main="Liberator"})
	sets.Idle.Movement.Apocalypse = set_combine(sets.Idle.Movement,{main="Apocalypse"})
	sets.Idle.Movement.Redemption = set_combine(sets.Idle.Movement,{main="Redemption"})
	sets.Idle.Movement.Caladbolg = set_combine(sets.Idle.Movement,{main="Caladbolg"})
	sets.Idle.Movement.Ragnarok = set_combine(sets.Idle.Movement,{main="Ragnarok"})
	sets.Idle.Movement.Lycurgos = set_combine(sets.Idle.Movement,{main="Lycurgos"})

	-- Refresh Sets --
	sets.Idle.Refresh = set_combine(sets.Idle,{
		head=empty,
		neck="Vim Torque +1",
		body="Lugra Cloak +1",
		hands="Ogier's Gauntlets",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		feet="Ogier's Leggings"})
	sets.Idle.Refresh.Anguta = set_combine(sets.Idle.Refresh,{main="Anguta"})
	sets.Idle.Refresh.Liberator = set_combine(sets.Idle.Refresh,{main="Liberator"})
	sets.Idle.Refresh.Apocalypse = set_combine(sets.Idle.Refresh,{main="Apocalypse"})
	sets.Idle.Refresh.Redemption = set_combine(sets.Idle.Refresh,{main="Redemption"})
	sets.Idle.Refresh.Caladbolg = set_combine(sets.Idle.Refresh,{main="Caladbolg"})
	sets.Idle.Refresh.Ragnarok = set_combine(sets.Idle.Refresh,{main="Ragnarok"})
	sets.Idle.Refresh.Lycurgos = set_combine(sets.Idle.Refresh,{main="Lycurgos"})

	-- Regain Sets --
	sets.Idle.Regain = set_combine(sets.Idle,{head="Ratri Sallet +1"})
	sets.Idle.Regain.Anguta = set_combine(sets.Idle.Regain,{main="Anguta"})
	sets.Idle.Regain.Liberator = set_combine(sets.Idle.Regain,{main="Liberator"})
	sets.Idle.Regain.Apocalypse = set_combine(sets.Idle.Regain,{main="Apocalypse"})
	sets.Idle.Regain.Redemption = set_combine(sets.Idle.Regain,{main="Redemption"})
	sets.Idle.Regain.Caladbolg = set_combine(sets.Idle.Regain,{main="Caladbolg"})
	sets.Idle.Regain.Ragnarok = set_combine(sets.Idle.Regain,{main="Ragnarok"})
	sets.Idle.Regain.Lycurgos = set_combine(sets.Idle.Regain,{main="Lycurgos"})

	sets.Twilight = set_combine(sets.Idle.Regen,{head="Twilight Helm",body="Twilight Mail"})

	-- JA Sets --
	sets.JA = {}
    sets.JA['Arcane Circle'] = {feet="Ig. Sollerets +3"}
    sets.JA['Nether Void'] = {legs="Heath. Flanchard +1"}
    sets.JA['Souleater'] = {head="Ig. Burgonet +3"}
    sets.JA['Weapon Bash'] = {hands="Ig. Gauntlets +3"}
    sets.JA['Last Resort'] = {back="Ankou's Mantle"}
    sets.JA['Dark Seal'] = {head="Fall. Burgeonet +3"}
    sets.JA['Blood Weapon'] = {body="Fall. Cuirass +3"}

	sets.Precast = {}
	-- Fastcast Set --
	sets.Precast.FastCast = {
		ammo="Sapience Orb",
		head="Carmine Mask +1",
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
		body=odyssean_fc_body,
		hands="Leyline Gloves",
		ring1="Kishar Ring",
		ring2="Prolix Ring",
		back=drk_fc_jse_back,
		waist="Tempus Fugit",
		legs="Eschite Cuisses",
		feet=odyssean_fc_feet}
		
	-- Precast Dark Magic --
	sets.Precast['Dark Magic'] = sets.Precast.FastCast

	-- Midcast Base Set --
	sets.Midcast = {}
	
	-- Magic Haste Set --
	sets.Midcast.Haste = sets.PDT

	-- Dark Magic Set --
	sets.Midcast['Dark Magic'] = {
		ammo="Pemphredo Tathlum",
        head="Ig. Burgonet +3",
		neck="Erra Pendant",
		ear1="Dark Earring",
		ear2="Digni. Earring",
		body="Carm. Sc. Mail +1",
		hands="Fall. Fin. Gaunt. +3",
		ring1="Evanescence Ring",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Niht Mantle",
		waist="Casso Sash",
		legs="Eschite Cuisses",
		feet="Rat. Sollerets +1"}
	
	-- Absorb Set --
    sets.Midcast.Absorb = set_combine(sets.Midcast['Dark Magic'],{
		ear1="Gwati Earring",
		hands="Pavor Gauntlets",
        ring1="Kishar Ring",
		back="Chuparrosa Mantle"})
		
	sets.Midcast.Absorb.Resist = set_combine(sets.Midcast.Absorb,{
		head="Carmine Mask +1",
		hands="Fall. Fin. Gaunt. +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back=drk_mab_jse_back,
		waist="Eschan Stone",
		legs="Fall. Flanchard +3",
		feet="Ig. Sollerets +3"})
		
	sets.Midcast.Absorb.Duration = set_combine(sets.Midcast.Absorb,{
		hands="Black Gadlings", 
		legs="Black Cuisses"})
			
	-- Absorb-TP Set --
    sets.Midcast['Absorb-TP'] = set_combine(sets.Midcast.Absorb,{hands="Heath. Gauntlets +1"})

	-- Stun Sets --
	sets.Midcast.Stun = set_combine(sets.Midcast['Dark Magic'],{
		head="Carmine Mask +1",
		ear1="Gwati Earring",
		hands="Flam. Manopolas +2",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back=drk_mab_jse_back,
		waist="Eschan Stone",
		legs="Ratri Cuisses +1",
		feet="Ig. Sollerets +3"})
		
	sets.Midcast.Stun.Resist = set_combine(sets.Midcast.Stun,{})
	sets.Midcast.Stun.Duration = set_combine(sets.Midcast.Stun,{feet="Rat. Sollerets +1"})

	-- Endark Set --
	sets.Midcast['Endark II'] = set_combine(sets.Midcast['Dark Magic'],{
		ammo="Sapience Orb",
		ear2="Loquac. Earring"})
		
	-- Elemental Magic Set --
	sets.Midcast['Elemental Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Jumalik Helm",
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body="Fall. Cuirass +3",
		hands="Fall. Fin. Gaunt. +3",
		ring1={name="Shiva Ring +1", bag="wardrobe3"},
		ring2={name="Shiva Ring +1", bag="wardrobe4"},
		back=drk_mab_jse_back,
		waist="Eschan Stone",
		legs="Eschite Cuisses",
		feet="Ig. Sollerets +3"}	

	-- Enfeebling Magic Set --
	sets.Midcast['Enfeebling Magic'] = set_combine(sets.Midcast['Elemental Magic'],{
		head="Carmine Mask +1",
		neck="Erra Pendant",
		ear1="Gwati Earring",
		ear2="Digni. Earring",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		legs="Ratri Cuisses +1"})

	-- Dread Spikes Set --
	sets.Midcast['Dread Spikes'] = {
		ammo="Egoist's Tathlum",
		head="Ratri Sallet +1",
		neck="Dualism Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
		body="Heath. Cuirass +1",
		hands="Rat. Gadlings +1",
		ring1={name="Moonlight Ring", bag="wardrobe3"},
		ring2={name="Moonlight Ring", bag="wardrobe4"},
		back="Moonlight Cape",
		waist="Gold Mog. Belt",
		legs="Ratri Cuisses +1",
		feet="Rat. Sollerets +1"}
		
	sets.Midcast.Drain = set_combine(sets.Midcast['Dark Magic'],{
		head="Pixie Hairpin +1",
		ear1="Hirudinea Earring",
        waist="Austerity Belt +1"}) 

	sets.Midcast.Aspir = set_combine(sets.Midcast.Drain, {})
	
		-- TP Base Set --
	sets.TP = {}
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------- ANGUTA SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------		

	-- Anguta TP Sets --
	sets.TP.Anguta = {main="Anguta",}
	sets.TP.Anguta.MidACC = set_combine(sets.TP.Anguta,{})
	sets.TP.Anguta.HighACC = set_combine(sets.TP.Anguta.MidACC,{})

	-- Anguta(High Haste) TP Sets --
	sets.TP.Anguta.HighHaste = set_combine(sets.TP.Anguta,{})
	sets.TP.Anguta.MidACC.HighHaste = set_combine(sets.TP.Anguta.MidACC,{})
	sets.TP.Anguta.HighACC.HighHaste = set_combine(sets.TP.Anguta.HighACC,{})

	-- Anguta(SAM Roll) TP Sets --
	sets.TP.Anguta.STP = set_combine(sets.TP.Anguta,{})
	sets.TP.Anguta.MidACC.STP = set_combine(sets.TP.Anguta.MidACC,{})
	sets.TP.Anguta.HighACC.STP = set_combine(sets.TP.Anguta.HighACC,{})

	-- Anguta(High Haste + SAM Roll) TP Sets --
	sets.TP.Anguta.HighHaste.STP = set_combine(sets.TP.Anguta.STP,{})
	sets.TP.Anguta.MidACC.HighHaste.STP = set_combine(sets.TP.Anguta.MidACC.STP,{})
	sets.TP.Anguta.HighACC.HighHaste.STP = set_combine(sets.TP.Anguta.HighACC.STP,{})

	----------------- /sam sets -----------------------------
	
	-- Anguta /SAM TP Sets --
	sets.TP.Anguta.SAM = {
		main="Anguta",
		ammo="Aurgelmir Orb",
		head="Flamma Zucchetto +2",
		neck="Abyssal Beads +2",
		ear1="Dedition Earring",
		ear2="Cessance Earring",
		body=valorous_qa_body,
		hands="Sulev. Gauntlets +2",
		ring1="Flamma Ring",
		ring2="Niqmaddu Ring",
		back=drk_acc_jse_back,
		waist="Ioskeha Belt +1",
		legs="Ig. Flanchard +3",
		feet=valorous_stp_feet}
		
	sets.TP.Anguta.SAM.MidACC = set_combine(sets.TP.Anguta.SAM,{})
	
	sets.TP.Anguta.SAM.HighACC = set_combine(sets.TP.Anguta.SAM.MidACC,{
		ear1="Telos Earring",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1",
		ring1={name="Chirich Ring +1", bag="wardrobe3"}})

	-- Anguta(High Haste) /SAM TP Sets --
	sets.TP.Anguta.SAM.HighHaste = set_combine(sets.TP.Anguta.SAM,{waist="Windbuffet Belt +1",})
	
	sets.TP.Anguta.SAM.MidACC.HighHaste = set_combine(sets.TP.Anguta.SAM.HighHaste,{})
		
	sets.TP.Anguta.SAM.HighACC.HighHaste = set_combine(sets.TP.Anguta.SAM.MidACC.HighHaste,{
		ear1="Telos Earring",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1",
		ring1={name="Chirich Ring +1", bag="wardrobe3"}})

	-- Anguta(SAM Roll) /SAM TP Sets --
	sets.TP.Anguta.SAM.STP = set_combine(sets.TP.Anguta.SAM,{
		ear2="Telos Earring",
		body=valorous_stp_body,
		hands="Acro Gauntlets",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		back=drk_acc_jse_back,
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2"})
		
	sets.TP.Anguta.SAM.MidACC.STP = set_combine(sets.TP.Anguta.SAM.STP,{})
	
	sets.TP.Anguta.SAM.HighACC.STP = set_combine(sets.TP.Anguta.SAM.MidACC.STP,{})

	-- Anguta(High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Anguta.SAM.HighHaste.STP = set_combine(sets.TP.Anguta.SAM.STP,{waist="Windbuffet Belt +1"})
	
	sets.TP.Anguta.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Anguta.SAM.HighHaste.STP,{})
	
	sets.TP.Anguta.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Anguta.SAM.MidACC.HighHaste.STP,{})
	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------- APOCALYPSE SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	

	-- Apocalypse(AM Down) TP Sets --
	sets.TP.Apocalypse = {} 
	sets.TP.Apocalypse.MidACC = set_combine(sets.TP.Apocalypse,{})
	sets.TP.Apocalypse.HighACC = set_combine(sets.TP.Apocalypse.MidACC,{})

	-- Apocalypse(AM Down: High Haste) TP Sets --
	sets.TP.Apocalypse.HighHaste = set_combine(sets.TP.Apocalypse,{waist="Windbuffet Belt +1"})
	sets.TP.Apocalypse.MidACC.HighHaste = set_combine(sets.TP.Apocalypse.MidACC,{})
	sets.TP.Apocalypse.HighACC.HighHaste = set_combine(sets.TP.Apocalypse.HighACC,{})
	
	-- Apocalypse(AM Down: SAM Roll) TP Sets --
	sets.TP.Apocalypse.STP = set_combine(sets.TP.Apocalypse,{})
	sets.TP.Apocalypse.MidACC.STP = set_combine(sets.TP.Apocalypse.MidACC,{})
	sets.TP.Apocalypse.HighACC.STP = set_combine(sets.TP.Apocalypse.HighACC,{})
	
	-- Apocalypse(AM Down: High Haste + SAM Roll) TP Sets --
	sets.TP.Apocalypse.HighHaste.STP = set_combine(sets.TP.Apocalypse.STP,{waist="Windbuffet Belt +1"})
	sets.TP.Apocalypse.MidACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.MidACC.STP,{})
	sets.TP.Apocalypse.HighACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.HighACC.STP,{})
	
	-- Apocalypse(AM Up) TP Sets --
	sets.TP.Apocalypse.AM = set_combine(sets.TP.Apocalypse,{waist="Windbuffet Belt +1"})
	sets.TP.Apocalypse.MidACC.AM = set_combine(sets.TP.Apocalypse.MidACC,{})
	sets.TP.Apocalypse.HighACC.AM = set_combine(sets.TP.Apocalypse.HighACC,{})

	-- Apocalypse(AM Up: High Haste) TP Sets --
	sets.TP.Apocalypse.AM.HighHaste = set_combine(sets.TP.Apocalypse.AM,{waist="Windbuffet Belt +1"})
	sets.TP.Apocalypse.MidACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.MidACC.AM,{})
	sets.TP.Apocalypse.HighACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.HighACC.AM,{})

	-- Apocalypse(AM Up: SAM Roll) TP Sets --
	sets.TP.Apocalypse.AM.STP = set_combine(sets.TP.Apocalypse.AM,{})
	sets.TP.Apocalypse.MidACC.AM.STP = set_combine(sets.TP.Apocalypse.MidACC.AM,{})
	sets.TP.Apocalypse.HighACC.AM.STP = set_combine(sets.TP.Apocalypse.HighACC.AM,{})

	-- Apocalypse(AM Up: High Haste + SAM Roll) TP Sets --
	sets.TP.Apocalypse.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.AM.STP,{waist="Windbuffet Belt +1"})
	sets.TP.Apocalypse.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.MidACC.AM.STP,{})
	sets.TP.Apocalypse.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.HighACC.AM.STP,{})

	------------ /sam sets --------------------------------
	
	-- Apocalypse(AM Down) /SAM TP Sets --
	sets.TP.Apocalypse.SAM = {
		main="Apocalypse",
		ammo="Focal Orb",
		head="Flam. Zucchetto +2",
		neck="Abyssal Beads +2",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body=valorous_qa_body,
		hands=valorous_qa_hands,
		ring1="Petrov Ring",
		ring2="Niqmaddu Ring",
		back=drk_da_jse_back,
		waist="Ioskeha Belt +1",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2"} 
		
	sets.TP.Apocalypse.SAM.MidACC = set_combine(sets.TP.Apocalypse.SAM,{
		hands="Sulev. Gauntlets +2",
		ring1="Flamma Ring",
		ear2="Telos Earring"})
		
	sets.TP.Apocalypse.SAM.HighACC = set_combine(sets.TP.Apocalypse.SAM.MidACC,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1"})

	-- Apocalypse(AM Down: High Haste) /SAM TP Sets --
	sets.TP.Apocalypse.SAM.HighHaste = set_combine(sets.TP.Apocalypse.SAM,{waist="Windbuffet Belt +1",})
	
	sets.TP.Apocalypse.SAM.MidACC.HighHaste = set_combine(sets.TP.Apocalypse.SAM.HighHaste,{
		hands="Sulev. Gauntlets +2",
		ring1="Flamma Ring",
		ear2="Telos Earring"})
		
	sets.TP.Apocalypse.SAM.HighACC.HighHaste = set_combine(sets.TP.Apocalypse.SAM.MidACC.HighHaste,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1"})

	-- Apocalypse(AM Down: SAM Roll) /SAM TP Sets --
	sets.TP.Apocalypse.SAM.STP = set_combine(sets.TP.Apocalypse.SAM,{
		ring1="Hetairoi Ring",
		feet=valorous_qa_feet})
		
	sets.TP.Apocalypse.SAM.MidACC.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC,{
		hands="Sulev. Gauntlets +2",
		ear2="Telos Earring"})
	
	sets.TP.Apocalypse.SAM.HighACC.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC,{})
	
	-- Apocalypse(AM Down: High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Apocalypse.SAM.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.STP,{waist="Windbuffet Belt +1"})
	
	sets.TP.Apocalypse.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.HighHaste.STP,{
		hands="Sulev. Gauntlets +2",
		ear2="Telos Earring"})
		
	sets.TP.Apocalypse.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.HighHaste.STP,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1"})
	
	-- Apocalypse(AM Up) /SAM TP Sets --
	sets.TP.Apocalypse.SAM.AM = set_combine(sets.TP.Apocalypse.SAM,{})
	sets.TP.Apocalypse.SAM.MidACC.AM = set_combine(sets.TP.Apocalypse.SAM.MidACC,{})
	sets.TP.Apocalypse.SAM.HighACC.AM = set_combine(sets.TP.Apocalypse.SAM.HighACC,{})

	-- Apocalypse(AM Up: High Haste) /SAM TP Sets --
	sets.TP.Apocalypse.SAM.AM.HighHaste = set_combine(sets.TP.Apocalypse.SAM.HighHaste,{waist="Windbuffet Belt +1"})
	
	sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.SAM.AM.HighHaste,{
		hands="Sulev. Gauntlets +2",
		ring1="Flamma Ring",
		ear2="Telos Earring"})
		
	sets.TP.Apocalypse.SAM.HighACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1"})

	-- Apocalypse(AM Up: SAM Roll) /SAM TP Sets --
	sets.TP.Apocalypse.SAM.AM.STP = set_combine(sets.TP.Apocalypse.SAM.STP,{})
	sets.TP.Apocalypse.SAM.MidACC.AM.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.STP,{})
	sets.TP.Apocalypse.SAM.HighACC.AM.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC.STP,{})

	-- Apocalypse(AM Up: High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Apocalypse.SAM.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.HighHaste.STP,{waist="Windbuffet Belt +1"})
	
	sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.AM.HighHaste.STP,{
		hands="Sulev. Gauntlets +2",
		ear2="Telos Earring"})
		
	sets.TP.Apocalypse.SAM.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste.STP,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1"})

-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------- LIBERATOR SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	-- Liberator(AM3 Down) TP Sets --
	sets.TP.Liberator = {}
	sets.TP.Liberator.MidACC = set_combine(sets.TP.Liberator,{})
	sets.TP.Liberator.HighACC = set_combine(sets.TP.Liberator.MidACC,{})

	-- Liberator(AM3 Up) TP Sets --
	sets.TP.Liberator.AM3 = set_combine(sets.TP.Liberator,{})
	sets.TP.Liberator.MidACC.AM3 = set_combine(sets.TP.Liberator.AM3,{})
	sets.TP.Liberator.HighACC.AM3 = set_combine(sets.TP.Liberator.MidACC.AM3,{})

	-- Liberator(AM3 Down: High Haste) TP Sets --
	sets.TP.Liberator.HighHaste = set_combine(sets.TP.Liberator,{})
	sets.TP.Liberator.MidACC.HighHaste = set_combine(sets.TP.Liberator.HighHaste,{})
	sets.TP.Liberator.HighACC.HighHaste = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})

	-- Liberator(AM3 Up: High Haste) TP Sets --
	sets.TP.Liberator.AM3_HighHaste = set_combine(sets.TP.Liberator.AM3,{})
	sets.TP.Liberator.MidACC.AM3_HighHaste = set_combine(sets.TP.Liberator.AM3_HighHaste,{})
	sets.TP.Liberator.HighACC.AM3_HighHaste = set_combine(sets.TP.Liberator.MidACC.AM3_HighHaste,{})

	-- Liberator(AM3 Down: SAM Roll) TP Sets --
	sets.TP.Liberator.STP = set_combine(sets.TP.Liberator,{})
	sets.TP.Liberator.MidACC.STP = set_combine(sets.TP.Liberator.MidACC,{})
	sets.TP.Liberator.HighACC.STP = set_combine(sets.TP.Liberator.HighACC,{})

	-- Liberator(AM3 Up: SAM Roll) TP Sets --
	sets.TP.Liberator.AM3.STP = set_combine(sets.TP.Liberator.AM3,{})
	sets.TP.Liberator.MidACC.AM3.STP = set_combine(sets.TP.Liberator.MidACC.AM3,{})
	sets.TP.Liberator.HighACC.AM3.STP = set_combine(sets.TP.Liberator.HighACC.AM3,{})

	-- Liberator(AM3 Down: High Haste + SAM Roll) TP Sets --
	sets.TP.Liberator.HighHaste.STP = set_combine(sets.TP.Liberator.HighHaste,{})
	sets.TP.Liberator.MidACC.HighHaste.STP = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})
	sets.TP.Liberator.HighACC.HighHaste.STP = set_combine(sets.TP.Liberator.HighACC.HighHaste,{})

	-- Liberator(AM3 Up: High Haste + SAM Roll) TP Sets --
	sets.TP.Liberator.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.HighHaste,{})
	sets.TP.Liberator.MidACC.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})
	sets.TP.Liberator.HighACC.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.HighACC.HighHaste,{})

	---------------------------------- /sam sets --------------------------------------
	
	-- Liberator(AM3 Down) /SAM TP Sets --
	sets.TP.Liberator.SAM = {
		main="Liberator",
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",
		neck="Ganesha's Mala",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body=valorous_qa_body,
		hands=valorous_qa_hands,
		ring1="Hetairoi Ring",
		ring2="Niqmaddu Ring",
		back=drk_acc_jse_back,
		waist="Ioskeha Belt +1",
		legs="Ig. Flanchard +3",
		feet=valorous_qa_feet}
		
	sets.TP.Liberator.SAM.MidACC = set_combine(sets.TP.Liberator.SAM,{
		hands="Sulev. Gauntlets +2"})
	
	sets.TP.Liberator.SAM.HighACC = set_combine(sets.TP.Liberator.SAM.MidACC,{
		neck="Abyssal Beads +2",
		ear1="Mache Earring +1",
		ear2="Telos Earring",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1",
		ring1="Regal Ring",
		feet="Flam. Gambieras +2"})

	-- Liberator(AM3 Up) /SAM TP Sets --
	sets.TP.Liberator.SAM.AM3 = set_combine(sets.TP.Liberator.SAM,{
		ammo="Yetshila +1",
		neck="Abyssal Beads +2",
		ear1="Dedition Earring",
		ear2="Telos Earring",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		back=drk_stp_jse_back,
		waist="Sailfi Belt +1",
		legs="Flamma Dirs +2",
		feet=valorous_stp_feet})
		
	sets.TP.Liberator.SAM.MidACC.AM3 = set_combine(sets.TP.Liberator.SAM.AM3,{
		ear1="Cessance Earring",
		ring1="Flamma Ring"})
	
	sets.TP.Liberator.SAM.HighACC.AM3 = set_combine(sets.TP.Liberator.SAM.MidACC.AM3,{})

	-- Liberator(AM3 Down: High Haste) /SAM TP Sets --
	sets.TP.Liberator.SAM.HighHaste = set_combine(sets.TP.Liberator.SAM,{waist="Windbuffet Belt +1"})
	
	sets.TP.Liberator.SAM.MidACC.HighHaste = set_combine(sets.TP.Liberator.SAM.HighHaste,{
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Liberator.SAM.HighACC.HighHaste = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste,{
		neck="Abyssal Beads +2",
		ear1="Mache Earring +1",
		ear2="Telos Earring",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1",
		ring1="Regal Ring",
		feet="Flam. Gambieras +2"})

	-- Liberator(AM3 Up: High Haste) /SAM TP Sets --
	sets.TP.Liberator.SAM.AM3_HighHaste = set_combine(sets.TP.Liberator.SAM.AM3,{})
	
	sets.TP.Liberator.SAM.MidACC.AM3_HighHaste = set_combine(sets.TP.Liberator.SAM.AM3_HighHaste,{
		ear1="Cessance Earring",
		ring1="Flamma Ring"})
		
	sets.TP.Liberator.SAM.HighACC.AM3_HighHaste = set_combine(sets.TP.Liberator.SAM.MidACC.AM3_HighHaste,{})

	-- Liberator(AM3 Down: SAM Roll) /SAM TP Sets --
	sets.TP.Liberator.SAM.STP = set_combine(sets.TP.Liberator.SAM,{
		ammo="Focal Orb"})		
		
	sets.TP.Liberator.SAM.MidACC.STP = set_combine(sets.TP.Liberator.SAM.STP,{
		ammo="Aurgelmir Orb",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Liberator.SAM.HighACC.STP = set_combine(sets.TP.Liberator.SAM.MidACC.STP,{
		neck="Abyssal Beads +2",
		ear1="Mache Earring +1",
		ear2="Telos Earring",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1",
		ring1="Regal Ring",
		feet="Flam. Gambieras +2"})

	-- Liberator(AM3 Up: SAM Roll) /SAM TP Sets --
	sets.TP.Liberator.SAM.AM3.STP = set_combine(sets.TP.Liberator.SAM.AM3,{})
	sets.TP.Liberator.SAM.MidACC.AM3.STP = set_combine(sets.TP.Liberator.SAM.MidACC.AM3,{})
	sets.TP.Liberator.SAM.HighACC.AM3.STP = set_combine(sets.TP.Liberator.SAM.HighACC.AM3,{})

	-- Liberator(AM3 Down: High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Liberator.SAM.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.STP,{waist="Windbuffet Belt +1"})
	
	sets.TP.Liberator.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighHaste.STP,{
		ammo="Aurgelmir Orb",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Liberator.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste.STP,{
		neck="Abyssal Beads +2",
		ear1="Mache Earring +1",
		ear2="Telos Earring",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1",
		ring1="Regal Ring",
		feet="Flam. Gambieras +2"})

	-- Liberator(AM3 Up: High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Liberator.SAM.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.SAM.AM3.STP ,{})
	sets.TP.Liberator.SAM.MidACC.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.SAM.MidACC.AM3,{})
	sets.TP.Liberator.SAM.HighACC.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighACC.AM3,{})
	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------- Redemption SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	-- Redemption(AM Down) TP Sets --
	sets.TP.Redemption = {} 
	sets.TP.Redemption.MidACC = set_combine(sets.TP.Redemption,{}) 
	sets.TP.Redemption.HighACC = set_combine(sets.TP.Redemption.MidACC,{})
		
	-- Redemption(AM Down: High Haste) TP Sets --
	sets.TP.Redemption.HighHaste = set_combine(sets.TP.Redemption,{waist="Windbuffet Belt +1"})
	sets.TP.Redemption.MidACC.HighHaste = set_combine(sets.TP.Redemption.MidACC,{})
	sets.TP.Redemption.HighACC.HighHaste = set_combine(sets.TP.Redemption.HighACC,{})

	-- Redemption(AM Down: SAM Roll) TP Sets --
	sets.TP.Redemption.STP = set_combine(sets.TP.Redemption,{})
	sets.TP.Redemption.MidACC.STP = set_combine(sets.TP.Redemption.MidACC,{})
	sets.TP.Redemption.HighACC.STP = set_combine(sets.TP.Redemption.HighACC,{})

	-- Redemption(AM Down: High Haste + SAM Roll) TP Sets --
	sets.TP.Redemption.HighHaste.STP = set_combine(sets.TP.Redemption.STP,{waist="Windbuffet Belt +1"})
	sets.TP.Redemption.MidACC.HighHaste.STP = set_combine(sets.TP.Redemption.MidACC.STP,{})
	sets.TP.Redemption.HighACC.HighHaste.STP = set_combine(sets.TP.Redemption.HighACC.STP,{})
	
	-- Redemption(AM Up) TP Sets --
	sets.TP.Redemption.AM = set_combine(sets.TP.Redemption,{})
	sets.TP.Redemption.MidACC.AM = set_combine(sets.TP.Redemption.AM,{}) 
	sets.TP.Redemption.HighACC.AM = set_combine(sets.TP.Redemption.MidACC.AM,{})

	-- Redemption(AM Up: High Haste) TP Sets --
	sets.TP.Redemption.AM.HighHaste = set_combine(sets.TP.Redemption.AM,{waist="Windbuffet Belt +1"})
	sets.TP.Redemption.MidACC.AM.HighHaste = set_combine(sets.TP.Redemption.AM.MidACC,{})
	sets.TP.Redemption.HighACC.AM.HighHaste = set_combine(sets.TP.Redemption.HighACC.AM,{})

	-- Redemption(AM Up: SAM Roll) TP Sets --
	sets.TP.Redemption.AM.STP = set_combine(sets.TP.Redemption.STP,{})
	sets.TP.Redemption.MidACC.AM.STP = set_combine(sets.TP.Redemption.MidACC.AM,{})
	sets.TP.Redemption.HighACC.AM.STP = set_combine(sets.TP.Redemption.HighACC.AM,{})

	-- Redemption(AM Up: High Haste + SAM Roll) TP Sets --
	sets.TP.Redemption.AM.HighHaste.STP = set_combine(sets.TP.Redemption.HighHaste.STP,{waist="Windbuffet Belt +1"})
	sets.TP.Redemption.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Redemption.MidACC.STP,{})
	sets.TP.Redemption.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Redemption.HighACC.STP,{})
	
	
	---------------------------------- /sam sets --------------------------------------

	-- Redemption(AM Down) TP Sets --  /SAM
	sets.TP.Redemption.SAM = {
		main="Redemption",
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",
		neck="Abyssal Beads +2",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body=valorous_qa_body,
		hands=valorous_qa_hands,
		ring1="Flamma Ring",
		ring2="Niqmaddu Ring",
		back=drk_da_jse_back,
		waist="Ioskeha Belt +1",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2"}
		
	sets.TP.Redemption.SAM.MidACC = set_combine(sets.TP.Redemption.SAM,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Redemption.SAM.HighACC = set_combine(sets.TP.Redemption.SAM.MidACC,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Regal Ring"})

	-- Redemption(AM Down: High Haste) TP Sets -- /SAM
	sets.TP.Redemption.SAM.HighHaste = set_combine(sets.TP.Redemption.SAM,{waist="Windbuffet Belt +1"})
	
	sets.TP.Redemption.SAM.MidACC.HighHaste = set_combine(sets.TP.Redemption.SAM.HighHaste,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Redemption.SAM.HighACC.HighHaste = set_combine(sets.TP.Redemption.SAM.MidACC.HighHaste,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Regal Ring"})
	
	-- Redemption(AM Down: SAM Roll) TP Sets -- /SAM
	sets.TP.Redemption.SAM.STP = set_combine(sets.TP.Redemption.SAM,{
		ammo="Yetshila +1",
		ring1="Hetairoi Ring"})
		
	sets.TP.Redemption.SAM.MidACC.STP = set_combine(sets.TP.Redemption.SAM.STP,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2",
		feet=valorous_qa_feet})
		
	sets.TP.Redemption.SAM.HighACC.STP = set_combine(sets.TP.Redemption.SAM.MidACC.STP,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Regal Ring",
		feet="Flam. Gambieras +2"})

	-- Redemption(AM Down: High Haste + SAM Roll) TP Sets -- /SAM
	sets.TP.Redemption.SAM.HighHaste.STP = set_combine(sets.TP.Redemption.SAM.STP,{waist="Windbuffet Belt +1"})
	
	sets.TP.Redemption.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Redemption.SAM.HighHaste.STP,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2",
		feet=valorous_qa_feet})
		
	sets.TP.Redemption.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Redemption.SAM.MidACC.HighHaste.STP,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Regal Ring",
		feet="Flam. Gambieras +2"})
	
	-- Redemption(AM Up) TP Sets -- /SAM
	sets.TP.Redemption.SAM.AM = set_combine(sets.TP.Redemption.SAM,{})		
	sets.TP.Redemption.SAM.MidACC.AM = set_combine(sets.TP.Redemption.SAM.MidACC,{}) 
	sets.TP.Redemption.SAM.HighACC.AM = set_combine(sets.TP.Redemption.SAM.HighACC,{})
	
	-- Redemption(AM Up: High Haste) TP Sets -- /SAM
	sets.TP.Redemption.SAM.AM.HighHaste = set_combine(sets.TP.Redemption.SAM.AM,{waist="Windbuffet Belt +1"})
	sets.TP.Redemption.SAM.MidACC.AM.HighHaste = set_combine(sets.TP.Redemption.SAM.MidACC.HighHaste,{})
	sets.TP.Redemption.SAM.HighACC.AM.HighHaste = set_combine(sets.TP.Redemption.SAM.HighACC.HighHaste,{})

	-- Redemption(AM Up: SAM Roll) TP Sets -- /SAM
	sets.TP.Redemption.SAM.AM.STP = set_combine(sets.TP.Redemption.SAM.STP,{})
	sets.TP.Redemption.SAM.MidACC.AM.STP = set_combine(sets.TP.Redemption.SAM.MidACC.STP,{})
	sets.TP.Redemption.SAM.HighACC.AM.STP = set_combine(sets.TP.Redemption.SAM.HighACC.STP,{})

	-- Redemption(AM Up: High Haste + SAM Roll) TP Sets --
	sets.TP.Redemption.SAM.AM.HighHaste.STP = set_combine(sets.TP.Redemption.SAM.HighHaste.STP,{waist="Windbuffet Belt +1"})
	sets.TP.Redemption.SAM.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Redemption.SAM.MidACC.HighHaste.STP,{})
	sets.TP.Redemption.SAM.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Redemption.SAM.HighACC.HighHaste.STP,{})
	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------- CALADBOLG SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	-- Caladbolg(AM Down) TP Sets --
	sets.TP.Caladbolg = {} 
	sets.TP.Caladbolg.MidACC = set_combine(sets.TP.Caladbolg,{}) 
	sets.TP.Caladbolg.HighACC = set_combine(sets.TP.Caladbolg.MidACC,{})
		
	-- Caladbolg(AM Down: High Haste) TP Sets --
	sets.TP.Caladbolg.HighHaste = set_combine(sets.TP.Caladbolg,{waist="Windbuffet Belt +1"})
	sets.TP.Caladbolg.MidACC.HighHaste = set_combine(sets.TP.Caladbolg.MidACC,{})
	sets.TP.Caladbolg.HighACC.HighHaste = set_combine(sets.TP.Caladbolg.HighACC,{})

	-- Caladbolg(AM Down: SAM Roll) TP Sets --
	sets.TP.Caladbolg.STP = set_combine(sets.TP.Caladbolg,{})
	sets.TP.Caladbolg.MidACC.STP = set_combine(sets.TP.Caladbolg.MidACC,{})
	sets.TP.Caladbolg.HighACC.STP = set_combine(sets.TP.Caladbolg.HighACC,{})

	-- Caladbolg(AM Down: High Haste + SAM Roll) TP Sets --
	sets.TP.Caladbolg.HighHaste.STP = set_combine(sets.TP.Caladbolg.STP,{waist="Windbuffet Belt +1"})
	sets.TP.Caladbolg.MidACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.MidACC.STP,{})
	sets.TP.Caladbolg.HighACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.HighACC.STP,{})
	
	-- Caladbolg(AM Up) TP Sets --
	sets.TP.Caladbolg.AM = set_combine(sets.TP.Caladbolg,{})	
	sets.TP.Caladbolg.MidACC.AM = set_combine(sets.TP.Caladbolg.AM,{}) 
	sets.TP.Caladbolg.HighACC.AM = set_combine(sets.TP.Caladbolg.MidACC.AM,{})

	-- Caladbolg(AM Up: High Haste) TP Sets --
	sets.TP.Caladbolg.AM.HighHaste = set_combine(sets.TP.Caladbolg.AM,{waist="Windbuffet Belt +1"})
	sets.TP.Caladbolg.MidACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.AM.MidACC,{})
	sets.TP.Caladbolg.HighACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.HighACC.AM,{})

	-- Caladbolg(AM Up: SAM Roll) TP Sets --
	sets.TP.Caladbolg.AM.STP = set_combine(sets.TP.Caladbolg.STP,{})
	sets.TP.Caladbolg.MidACC.AM.STP = set_combine(sets.TP.Caladbolg.MidACC.AM,{})
	sets.TP.Caladbolg.HighACC.AM.STP = set_combine(sets.TP.Caladbolg.HighACC.AM,{})

	-- Caladbolg(AM Up: High Haste + SAM Roll) TP Sets --
	sets.TP.Caladbolg.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.HighHaste.STP,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.MidACC.STP,{})
	sets.TP.Caladbolg.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.HighACC.STP,{})
	
	
	---------------------------------- /sam sets --------------------------------------

	-- Caladbolg(AM Down) TP Sets --  /SAM
	sets.TP.Caladbolg.SAM = {
		main="Caladbolg",
		ammo="Aurgelmir Orb",
		head="Flamma Zucchetto +2",
		neck="Abyssal Beads +2",
		ear1="Cessance Earring",
		ear2="Telos Earring",
		body=valorous_qa_body,
		hands="Flam. Manopolas +2",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		ring2="Niqmaddu Ring",
		back=drk_acc_jse_back,
		waist="Ioskeha Belt +1",
		legs=odyssean_stp_legs,
		feet=valorous_stp_feet} 
		
	sets.TP.Caladbolg.SAM.MidACC = set_combine(sets.TP.Caladbolg.SAM,{}) 
			
	sets.TP.Caladbolg.SAM.HighACC = set_combine(sets.TP.Caladbolg.SAM.MidACC,{})

	-- Caladbolg(AM Down: High Haste) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.HighHaste = set_combine(sets.TP.Caladbolg.SAM,{waist="Windbuffet Belt +1"})
	
	sets.TP.Caladbolg.SAM.MidACC.HighHaste = set_combine(sets.TP.Caladbolg.SAM.HighHaste,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Caladbolg.SAM.HighACC.HighHaste = set_combine(sets.TP.Caladbolg.SAM.MidACC.HighHaste,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})
	
	-- Caladbolg(AM Down: SAM Roll) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.STP = set_combine(sets.TP.Caladbolg.SAM,{
		ear1="Dedition Earring",
		ear2="Telos Earring",
		body=valorous_stp_body,
		hands="Flam. Manopolas +2",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		legs=odyssean_stp_legs})
		
	sets.TP.Caladbolg.SAM.MidACC.STP = set_combine(sets.TP.Caladbolg.SAM.STP,{})
	sets.TP.Caladbolg.SAM.HighACC.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.STP,{})

	-- Caladbolg(AM Down: High Haste + SAM Roll) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.STP,{waist="Windbuffet Belt +1"})
	
	sets.TP.Caladbolg.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.HighHaste.STP,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Caladbolg.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.HighHaste.STP,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})
	
	-- Caladbolg(AM Up) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.AM = set_combine(sets.TP.Caladbolg.SAM,{
		ammo="Yetshila +1",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2"})
	
	sets.TP.Caladbolg.SAM.MidACC.AM = set_combine(sets.TP.Caladbolg.SAM.AM,{
		ear2="Telos Earring"})
	
	sets.TP.Caladbolg.SAM.HighACC.AM = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM,{
		ammo="Seething Bomblet +1",
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})
	
	-- Caladbolg(AM Up: High Haste) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.AM.HighHaste = set_combine(sets.TP.Caladbolg.SAM.AM,{waist="Windbuffet Belt +1"})
	
	sets.TP.Caladbolg.SAM.MidACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.SAM.AM.HighHaste,{ear2="Telos Earring"})
	
	sets.TP.Caladbolg.SAM.HighACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM.HighHaste,{
		ammo="Seething Bomblet +1",
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})

	-- Caladbolg(AM Up: SAM Roll) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.AM.STP = set_combine(sets.TP.Caladbolg.SAM.AM,{
		ear1="Dedition Earring",
		ear2="Telos Earring",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		legs=odyssean_stp_legs})
		
	sets.TP.Caladbolg.SAM.MidACC.AM.STP = set_combine(sets.TP.Caladbolg.SAM.AM.STP,{})
	sets.TP.Caladbolg.SAM.HighACC.AM.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM.STP,{})

	-- Caladbolg(AM Up: High Haste + SAM Roll) TP Sets --
	sets.TP.Caladbolg.SAM.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.AM.STP,{waist="Windbuffet Belt +1"})
	sets.TP.Caladbolg.SAM.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.AM.HighHaste.STP,{})
	sets.TP.Caladbolg.SAM.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM.HighHaste.STP,{})
	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------- RAGNAROK SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	

	-- Ragnarok TP Sets --
	sets.TP.Ragnarok = {} 
		
	sets.TP.Ragnarok.MidACC = set_combine(sets.TP.Ragnarok,{}) 
		
	sets.TP.Ragnarok.HighACC = set_combine(sets.TP.Ragnarok.MidACC,{})
		
	-- Ragnarok(High Haste) TP Sets --
	sets.TP.Ragnarok.HighHaste = set_combine(sets.TP.Ragnarok,{waist="Windbuffet Belt +1"})
	sets.TP.Ragnarok.MidACC.HighHaste = set_combine(sets.TP.Ragnarok.HighHaste,{})
	sets.TP.Ragnarok.HighACC.HighHaste = set_combine(sets.TP.Ragnarok.MidACC.HighHaste,{})
	
	-- Ragnarok(SAM Roll) TP Sets --
	sets.TP.Ragnarok.STP = set_combine(sets.TP.Ragnarok,{})
	sets.TP.Ragnarok.MidACC.STP = set_combine(sets.TP.Ragnarok.STP,{})
	sets.TP.Ragnarok.HighACC.STP = set_combine(sets.TP.Ragnarok.MidACC.STP,{})
							
	-- Ragnarok(High Haste + SAM Roll) TP Sets --
	sets.TP.Ragnarok.HighHaste.STP = set_combine(sets.TP.Ragnarok.STP,{waist="Windbuffet Belt +1"})
	sets.TP.Ragnarok.MidACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.MidACC.STP,{})
	sets.TP.Ragnarok.HighACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.HighACC.STP,{})
	
	------------------- /sam sets -----------------------------
	
	-- Ragnarok /SAM TP Sets --
	sets.TP.Ragnarok.SAM = {
		main="Ragnarok",
		ammo="Aurgelmir Orb",
		head="Flamma Zucchetto +2",
		neck="Abyssal Beads +2",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body=valorous_qa_body,
		hands=valorous_qa_hands,
		ring1="Hetairoi Ring",
		ring2="Niqmaddu Ring",
		back=drk_acc_jse_back,
		waist="Ioskeha Belt +1",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2"}
	
	sets.TP.Ragnarok.SAM.MidACC = set_combine(sets.TP.Ragnarok.SAM,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2"}) 
		
	sets.TP.Ragnarok.SAM.HighACC = set_combine(sets.TP.Ragnarok.SAM.MidACC,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})

	-- Ragnarok(High Haste) /SAM TP Sets --
	sets.TP.Ragnarok.SAM.HighHaste = set_combine(sets.TP.Ragnarok.SAM,{waist="Windbuffet Belt +1"})
	
	sets.TP.Ragnarok.SAM.MidACC.HighHaste = set_combine(sets.TP.Ragnarok.SAM.HighHaste,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Ragnarok.SAM.HighACC.HighHaste = set_combine(sets.TP.Ragnarok.SAM.MidACC.HighHaste,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})

	-- Ragnarok(SAM Roll) /SAM TP Sets --
	sets.TP.Ragnarok.SAM.STP = set_combine(sets.TP.Ragnarok.SAM,{
		ear1="Dedition Earring",
		ear2="Telos Earring",
		body=valorous_stp_body,
		hands="Flam. Manopolas +2",
		ring1={name="Chirich Ring +1", bag="wardrobe3"},
		legs=odyssean_stp_legs})
		
	sets.TP.Ragnarok.SAM.MidACC.STP = set_combine(sets.TP.Ragnarok.SAM.STP,{})
	sets.TP.Ragnarok.SAM.HighACC.STP = set_combine(sets.TP.Ragnarok.SAM.MidACC.STP,{})

	-- Ragnarok(High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Ragnarok.SAM.HighHaste.STP = set_combine(sets.TP.Ragnarok.SAM.STP,{waist="Windbuffet Belt +1"})
	
	sets.TP.Ragnarok.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.SAM.HighHaste.STP,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Ragnarok.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.SAM.MidACC.HighHaste.STP,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})
	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------- Lycurgos SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	

	-- Lycurgos TP Sets --
	sets.TP.Lycurgos = {} 
	sets.TP.Lycurgos.MidACC = set_combine(sets.TP.Lycurgos,{}) 	
	sets.TP.Lycurgos.HighACC = set_combine(sets.TP.Lycurgos.MidACC,{})
		
	-- Lycurgos(High Haste) TP Sets --
	sets.TP.Lycurgos.HighHaste = set_combine(sets.TP.Lycurgos,{waist="Windbuffet Belt +1"})
	sets.TP.Lycurgos.MidACC.HighHaste = set_combine(sets.TP.Lycurgos.HighHaste,{})
	sets.TP.Lycurgos.HighACC.HighHaste = set_combine(sets.TP.Lycurgos.MidACC.HighHaste,{})
	
	-- Lycurgos(SAM Roll) TP Sets --
	sets.TP.Lycurgos.STP = set_combine(sets.TP.Lycurgos,{})
	sets.TP.Lycurgos.MidACC.STP = set_combine(sets.TP.Lycurgos.STP,{})
	sets.TP.Lycurgos.HighACC.STP = set_combine(sets.TP.Lycurgos.MidACC.STP,{})
							
	-- Lycurgos(High Haste + SAM Roll) TP Sets --
	sets.TP.Lycurgos.HighHaste.STP = set_combine(sets.TP.Lycurgos.STP,{waist="Windbuffet Belt +1"})
	sets.TP.Lycurgos.MidACC.HighHaste.STP = set_combine(sets.TP.Lycurgos.MidACC.STP,{})
	sets.TP.Lycurgos.HighACC.HighHaste.STP = set_combine(sets.TP.Lycurgos.HighACC.STP,{})
	
	------------------- /sam sets -----------------------------
	
	-- Lycurgos /SAM TP Sets --
	sets.TP.Lycurgos.SAM = {
		main="Lycurgos",
		ammo="Focal Orb",
		head="Flam. Zucchetto +2", 
		neck="Abyssal Beads +2",
		ear1="Cessance Earring",
		ear2="Telos Earring",
		body=valorous_stp_body,
		hands=valorous_qa_hands,
		ring1="Hetairoi Ring",
		ring2="Niqmaddu Ring",
		back=drk_acc_jse_back,
		waist="Ioskeha Belt +1",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2"}
	
	sets.TP.Lycurgos.SAM.MidACC = set_combine(sets.TP.Lycurgos.SAM,{
		ammo="Aurgelmir Orb",
		hands="Sulev. Gauntlets +2"})
	
	sets.TP.Lycurgos.SAM.HighACC = set_combine(sets.TP.Lycurgos.SAM.MidACC,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})

	-- Lycurgos(High Haste) /SAM TP Sets --
	sets.TP.Lycurgos.SAM.HighHaste = set_combine(sets.TP.Lycurgos.SAM,{waist="Windbuffet Belt +1"})
	
	sets.TP.Lycurgos.SAM.MidACC.HighHaste = set_combine(sets.TP.Lycurgos.SAM.HighHaste,{
		ammo="Aurgelmir Orb",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Lycurgos.SAM.HighACC.HighHaste = set_combine(sets.TP.Lycurgos.SAM.MidACC.HighHaste,{
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})

	-- Lycurgos(SAM Roll) /SAM TP Sets --
	sets.TP.Lycurgos.SAM.STP = set_combine(sets.TP.Lycurgos.SAM,{
		ammo="Aurgelmir Orb",
		ear2="Brutal Earring",
		body=valorous_qa_body})
	
	sets.TP.Lycurgos.SAM.MidACC.STP = set_combine(sets.TP.Lycurgos.SAM.MidACC,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2"})
	
	sets.TP.Lycurgos.SAM.HighACC.STP = set_combine(sets.TP.Lycurgos.SAM.HighACC,{
		ammo="Seething Bomblet +1",
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})

	-- Lycurgos(High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Lycurgos.SAM.HighHaste.STP = set_combine(sets.TP.Lycurgos.SAM.STP,{waist="Windbuffet Belt +1"})
	
	sets.TP.Lycurgos.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Lycurgos.SAM.HighHaste.STP,{
		ear2="Telos Earring",
		hands="Sulev. Gauntlets +2"})
		
	sets.TP.Lycurgos.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Lycurgos.SAM.MidACC.HighHaste.STP,{
		ammo="Seething Bomblet +1",
		ear1="Mache Earring +1",
		body="Emicho Haubert +1",
		hands="Emicho Gauntlets +1",
		ring1="Flamma Ring"})	

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

	-- PDT/MDT Sets --
	sets.PDT = {
		head="Sulevia's Mask +2",
		neck="Loricate Torque +1",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ring1="Defending Ring",
		ring2={name="Moonlight Ring", bag="wardrobe4"},
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2"}
		
	sets.MDT = set_combine(sets.PDT,{
		ammo="Staunch Tathlum +1",
		head="Volte Salade",
		neck="Warder's Charm +1",
		ear1="Sanare Earring",
		ear2="Hearty Earring",
		body="Sacro Breastplate",
		hands="Ratri Gadlings +1",
		ring2="Purity Ring",
		back=drk_fc_jse_back,
		waist="Asklepian Belt",
		legs="Ratri Cuisses +1",
		feet="Volte Sollerets"})
							
	--sets.Scarlet = set_combine(sets.PDT,{})

	-- Hybrid Set --
	sets.TP.Hybrid = set_combine(sets.PDT,{
		ammo="Aurgelmir Orb",
		head="Hjarrandi Helm",
		neck="Abyssal Beads +2",
		ear1="Cessance Earring",
		ear2="Telos Earring",
		body="Hjarrandi Breast.",
		hands="Sulev. Gauntlets +2",
		ring1="Moonlight Ring",
		ring2="Moonlight Ring",
		back=drk_acc_jse_back,
		waist="Tempus Fugit",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2"})
		
	sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{})
	sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})
	
	-- Volte Set --
	sets.TP.Volte = set_combine(sets.PDT,{
		ammo="Aurgelmir Orb",
		head="Volte Salade",
		neck="Abyssal Beads +2",
		ear1="Cessance Earring",
		ear2="Telos Earring",
		body="Hjarrandi Breast.", -- Volte Haubert
		hands="Sulev. Gauntlets +2", -- Volte Moufles
		ring1="Moonlight Ring",
		ring2="Moonlight Ring",
		back=drk_acc_jse_back,
		waist="Tempus Fugit",
		legs="Ig. Flanchard +3", -- Volte Brayettes
		feet="Volte Sollerets"})
		
	sets.TP.Volte.MidACC = set_combine(sets.TP.Hybrid,{})
	sets.TP.Volte.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})

	-- WS Base Set --
	sets.WS = {
		ammo="Seething Bomblet +1",
		head="Flam. Zucchetto +2",
		neck="Abyssal Beads +2",
		ear1="Cessance Earring",
		ear2="Moonshade Earring",
		body="Argosy Hauberk +1",
		hands="Argosy Mufflers +1",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		back=drk_da_jse_back,
		waist="Fotia Belt",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2"}
		
	sets.WS.MidACC = set_combine(sets.WS,{ear1="Telos Earring"})
	
    sets.WS.HighACC = set_combine(sets.WS.MidACC,{})

	-- Resolution Sets --
	--Description:	Delivers a fivefold attack. Damage varies with TP.
	--Stat Modifier:	73~85% STR fTP:	0.71875	1.5	2.25
	sets.WS.Resolution = set_combine(sets.WS,{
        ammo="Seething Bomblet +1",
		head="Flam. Zucchetto +2",
		neck="Abyssal Beads +2",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Argosy Hauberk +1",
		hands="Argosy Mufflers +1",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		back=drk_da_jse_back,
		waist="Fotia Belt",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2"})
	
	sets.WS.Resolution.MidACC = set_combine(sets.WS.Resolution,{
		ear1="Cessance Earring"})
	
	sets.WS.Resolution.HighACC = set_combine(sets.WS.Resolution.MidACC,{
		ear1="Telos Earring",
		body="Ignominy Cuirass +3",
		hands="Ig. Gauntlets +3"})
	
	-- Torcleaver Sets --
	-- Description:	Deals triple damage. Damage varies with TP.
	-- Stat Modifier:	80% VIT fTP:	4.75	7.5	10
    sets.WS.Torcleaver = {
		ammo="Knobkierrie",
        head=odyssean_wsd_head,
		neck="Abyssal Beads +2",
		ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Ignominy Cuirass +3",
        hands=odyssean_wsd_hands,
		ring1="Epaminondas's Ring",
		ring2="Niqmaddu Ring",
		back=drk_vit_wsd_jse_back,
		waist="Fotia Belt",
        legs="Fall. Flanchard +3",
        feet="Sulev. Leggings +2"}
		
    sets.WS.Torcleaver.MidACC = set_combine(sets.WS.Torcleaver,{})
    sets.WS.Torcleaver.HighACC = set_combine(sets.WS.Torcleaver.MidACC,{})

	-- Scourge Sets --
	--Relic Aftermath: +5% Critical Hit Rate 15 acc
	--Stat Modifier:	40% STR / 40% VIT	fTP:	3.0
    sets.WS.Scourge = {
		ammo="Knobkierrie",
        head="Fall. Burgeonet +3",
		neck="Abyssal Beads +2",
		ear1="Ishvara Earring",
        ear2="Brutal Earring",
        body="Ignominy Cuirass +3",
        hands=valorous_wsd_hands,
		ring1="Epaminondas's Ring",
		ring2="Niqmaddu Ring",
		back=drk_str_wsd_jse_back,
		waist="Fotia Belt",
        legs="Fall. Flanchard +3",
        feet="Sulev. Leggings +2"}
		
    sets.WS.Scourge.MidACC = set_combine(sets.WS.Scourge,{})
	sets.WS.Scourge.HighACC = set_combine(sets.WS.Scourge.MidACC,{})	
	
	-- Shockwave Sets --
    sets.WS.Shockwave = {
		ammo="Pemphredo Tathlum",
		head="Carmine Mask +1",
		neck="Erra Pendant",
		ear1="Digni. Earring",
		ear2="Gwati Earring",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		ring1="Regal Ring",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back=drk_mab_jse_back,
		waist="Eschan Stone",
		legs="Flamma Dirs +2",
		feet="Ig. Sollerets +3"}

	-- Infernal Sets --	
	sets.WS['Infernal Scythe'] = {
		ammo="Knobkierrie",
		head="Pixie Hairpin +1",
		neck="Fotia Gorget",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body="Fall. Cuirass +3",
		hands="Fall. Fin. Gaunt. +3",
		ring1={name="Shiva Ring +1", bag="wardrobe3"},
		ring2="Archon Ring",
		back=drk_mab_jse_back,
		waist="Fotia Belt",
		legs="Fall. Flanchard +3",
        feet="Ratri Sollerets +1"}	

	-- Catastrophe Sets --
	--Stat Modifier:	40% STR / 40% INT	fTP:	2.75
	--Relic Aftermath: 10% Equipment Haste (+102/1024) AG 10% Ability
	sets.WS.Catastrophe = {
		ammo="Knobkierrie",
        head="Ratri Sallet +1",
		neck="Abyssal Beads +2",
		ear1="Ishvara Earring",
        ear2="Brutal Earring",
        body="Ignominy Cuirass +3",
        hands="Rat. Gadlings +1",
		ring1="Epaminondas's Ring",
		ring2="Niqmaddu Ring",
		back=drk_str_wsd_jse_back,
		waist="Fotia Belt",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1"}
		
	sets.WS.Catastrophe.MidACC = set_combine(sets.WS.Catastrophe,{})
	sets.WS.Catastrophe.HighACC = set_combine(sets.WS.Catastrophe.MidACC,{})

	-- Entropy Sets --
	--Delivers a fourfold attack. Converts some of the damage into MP. Damage varies with TP.
	--Stat Modifier:	73~85% INT fTP:	0.75	1.25	2.0
	sets.WS.Entropy = {
		ammo="Knobkierrie",
		head="Ratri Sallet +1",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		body="Ignominy Cuirass +3",
		hands="Rat. Gadlings +1",
		ring1={name="Shiva Ring +1", bag="wardrobe3"},
		ring2={name="Shiva Ring +1", bag="wardrobe4"},
		back=drk_int_da_jse_back,
		waist="Fotia Belt",
		legs="Fall. Flanchard +3",
		feet="Ratri Sollerets +1"}
		
	sets.WS.Entropy.MidACC = set_combine(sets.WS.Entropy,{})
	sets.WS.Entropy.HighACC = set_combine(sets.WS.Entropy.MidACC,{})
							
	-- CrossReaper Sets --
	--Delivers a two-hit attack. Damage varies with TP.
	--Stat Modifier:	60% STR / 60% MND fTP:	2.0	4.0	7.0
	sets.WS['Cross Reaper'] = {
		ammo="Knobkierrie",
        head="Ratri Sallet +1",
		neck="Abyssal Beads +2",
		ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Ignominy Cuirass +3",
        hands="Rat. Gadlings +1",
		ring1="Epaminondas's Ring",
		ring2="Niqmaddu Ring",
		back=drk_str_wsd_jse_back,
		waist="Fotia Belt",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1"}
		
	sets.WS['Cross Reaper'].MidACC = set_combine(sets.WS['Cross Reaper'],{})
	sets.WS['Cross Reaper'].HighACC = set_combine(sets.WS['Cross Reaper'].MidACC,{})

	-- Spinning Scythe Sets --
	sets.WS['Spinning Scythe'] = {
		ammo="Knobkierrie",
        head="Ratri Sallet +1",
		neck="Abyssal Beads +2",
		ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Ignominy Cuirass +3",
        hands="Rat. Gadlings +1",
		ring1="Epaminondas's Ring",
		ring2="Niqmaddu Ring",
		back=drk_str_wsd_jse_back,
		waist="Fotia Belt",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1"}
		
	sets.WS['Spinning Scythe'].MidACC = set_combine(sets.WS['Spinning Scythe'],{})
	sets.WS['Spinning Scythe'].HighACC = set_combine(sets.WS['Spinning Scythe'].MidACC,{})
	
	-- Insurgency Sets --
	--Delivers a fourfold attack. Damage varies with TP.
	--Stat Modifier:	20% STR / 20% INT fTP:	0.5	3.25	6.0
	sets.WS.Insurgency = {
		ammo="Knobkierrie",
		head="Ratri Sallet +1",
		neck="Abyssal Beads +2",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		body="Ignominy Cuirass +3",
		hands="Rat. Gadlings +1",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		back=drk_str_wsd_jse_back,
		waist="Fotia Belt",
		legs="Ratri Cuisses +1",
		feet="Rat. Sollerets +1"}
		
	sets.WS.Insurgency.MidACC = set_combine(sets.WS.Insurgency,{})
	sets.WS.Insurgency.HighACC = set_combine(sets.WS.Insurgency.MidACC,{})
	
	-- Quietus Sets --
	--Delivers a triple damage attack that ignores target's defense. Amount ignored varies with TP.
	--Stat Modifier:	60% STR / 60% MND Defense ignored:	10%	30%	50% fTP:	3.0
	sets.WS.Quietus = {
		ammo="Knobkierrie",
		head="Ratri Sallet +1",
		neck="Abyssal Beads +2",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		body="Ignominy Cuirass +3",
		hands="Rat. Gadlings +1",
		ring1="Epaminondas's Ring",
		ring2="Niqmaddu Ring",
		back=drk_str_wsd_jse_back,
		waist="Fotia Belt",
		legs="Ratri Cuisses +1",
		feet="Rat. Sollerets +1"}

	sets.WS.Quietus.MidACC = set_combine(sets.WS.Quietus, {})
	sets.WS.Quietus.HighACC = set_combine(sets.WS.Quietus.MidACC, {})
	
	-- Fell Cleave Sets --
	sets.WS['Fell Cleave'] = {
		ammo="Knobkierrie",
		head=odyssean_wsd_head,
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		body="Ignominy Cuirass +3",
		hands=valorous_wsd_hands,
		ring1="Epaminondas's Ring",
		ring2="Niqmaddu Ring",
		back=drk_str_wsd_jse_back,
		waist="Fotia Belt",
		legs="Fall. Flanchard +3",
		feet="Sulev. Leggings +2"}
		
	-- Upheaval Sets --
	sets.WS.Upheaval = {
		ammo="Knobkierrie",
		head="Ratri Sallet +1",
		neck="Fotia gorget",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		body="Ignominy Cuirass +3",
		hands=valorous_wsd_hands,
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		back=drk_vit_wsd_jse_back,
		waist="Fotia Belt",
		legs="Fall. Flanchard +3",
		feet="Sulev. Leggings +2"}
		
	-- Decimation Sets --
	sets.WS.Decimation = {
		ammo="Seething Bomblet +1",
		head="Flam. Zucchetto +2",
		neck="Abyssal Beads +2",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		body="Argosy Hauberk +1",
		hands="Argosy Mufflers +1",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		back=drk_da_jse_back,
		waist="Fotia Belt",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2"}	
		
	-- Souleater WS Set --
    sets.SE_WS = {head="Ig. Burgonet +3"}
	
	sets.MAXDrain = {main="Misanthropy"}
	
	sets.Obi = {waist="Hachirin-no-Obi"}
		
	sets.Protect = {ring2="Sheltered Ring"}
	
	sets.RefreshPotencyRecieved = {waist="Gishdubar Sash"}
	
	sets.TH = {head="Wh. Rarab Cap +1", hands=odyssean_th_hands, waist="Chaac Belt"}
	
	sets.CursnaPotencyRecieved = {
		neck="Nicander's Necklace",
		ring1={name="Eshmun's Ring", bag="wardrobe3"},
		ring2={name="Eshmun's Ring", bag="wardrobe4"},
		waist="Gishdubar Sash",
		legs="Shabti Cuisses +1"}
		
	sets.meva = {
		ammo="Staunch Tathlum +1",
		head="Ratri Sallet +1",
		neck="Warder's Charm +1",
		ear1="Sanare Earring",
		ear2="Eabani Earring",
		body="Ratri Plate +1",
		hands="Rat. Gadlings +1",
		ring1="Vengeful Ring",
		ring2="Purity Ring",
		back=drk_fc_jse_back,
		waist="Asklepian Belt",
		legs="Ratri Cuisses +1",
		feet="Rat. Sollerets +1"}
		
	sets.ResistStun = set_combine(sets.Meva,{
		ammo="Staunch Tathlum +1",
		ear1="Arete del Luna",
		ear2="Arete del Luna +1",
		body="Onca Suit",
		ring1="Icecrack Ring",
		back=drk_meva_jse_back,
		legs="Volte Hose"})	
	
	-- Arcane Circle/Founders Breastplate WS Set --
    --sets.AC_WS = {body="Found. Breastplate"}
	
end

function pretarget(spell,action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
		cancel_spell()
		send_command('Aggressor')
	elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
		cancel_spell()
		send_command('ThirdEye')
	elseif spell.english == "Meditate" and player.tp > 2900 then -- Cancel Meditate If TP Is Above 2900 --
		cancel_spell()
		add_to_chat(123, spell.name .. ' Canceled: ['..player.tp..' TP]')
	elseif spell.type == "WeaponSkill" and spell.target.distance > target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
		cancel_spell()
		add_to_chat(123, spell.name..' Canceled: [Out of Range]')
		return
	end
end

function precast(spell,action)
	if spell.type == "WeaponSkill" then
			equipSet = sets.WS
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if equipSet[AccArray[AccIndex]] then
				equipSet = equipSet[AccArray[AccIndex]]
			end
			if buffactive["Souleater"] then -- Equip Ignominy Burgonet when you have Souleater on --
                equipSet = set_combine(equipSet,sets.SE_WS)
            end
			if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll == 'ON' then
				equipSet = equipSet["STP"]
			end
			if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
				equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
			end
			if player.tp > 2750 or player.equipment.main == 'Anguta' and player.tp > 2500 then
                equipSet = set_combine(equipSet,{ear1="Cessance Earring"}) -- 3000 TP: Equip "Your Choice of Earring"--
            else
				if player.tp > 2900 then
					equipSet = set_combine(equipSet,{ear1="Cessance Earring"})
				end
			end
			equip(equipSet)
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	elseif spell.action_type == 'Magic' then
		if buffactive.silence or spell.target.distance > 16+target_distance then -- Cancel Magic or Ninjutsu If You Are Silenced or Out of Range --
			cancel_spell()
			add_to_chat(123, spell.name..' Canceled: [Silenced or Out of Casting Range]')
			return
		else
			if spell.english == 'Utsusemi: Ni' then
				if buffactive['Copy Image (3)'] then
					cancel_spell()
					add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
					return
				else
					equip(sets.Precast.FastCast)
				end
			elseif sets.Precast[spell.skill] then
				equip(sets.Precast[spell.skill])
			else
				equip(sets.Precast.FastCast)
			end
		end
	end
	if Twilight == 'Twilight' then
		equip(sets.Twilight)
	end
	if TreasureHunter == 'TreasureHunter' then
		equip(sets.TH)
	end
end

function midcast(spell,action)
	equipSet = {}
	if spell.action_type == 'Magic' then
		equipSet = sets.Midcast
		if spell.english:startswith('Absorb') and spell.english ~= "Absorb-TP" then
			equipSet = sets.Midcast.Absorb
			if equipSet[MaccArray[MaccIndex]] then
				equipSet = equipSet[MaccArray[MaccIndex]]
			end
		elseif spell.english:startswith('Drain') or spell.english:startswith('Aspir') or spell.english:startswith('Bio') then
			if world.day == "Darksday" or world.weather_element == "Dark" then -- Equip Hachirin-no-Obi On Darksday or Dark Weather --
				equipSet = set_combine(equipSet,{waist="Hachirin-no-Obi"})
			end
			equipSet = 	sets.Midcast.Drain
		elseif spell.english == "Stoneskin" then
			if buffactive.Stoneskin then
				send_command('@wait 1.7;cancel stoneskin')
			end
			equipSet = equipSet.Stoneskin
		elseif spell.english == "Sneak" then
			if spell.target.name == player.name and buffactive['Sneak'] then
				send_command('cancel sneak')
			end
			equipSet = equipSet.Haste
		elseif spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
				send_command('@wait 1.7;cancel Copy Image*')
			end
			equipSet = equipSet.Haste
		elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equipSet = equipSet.Haste
		else
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if equipSet[MaccArray[MaccIndex]] then
				equipSet = equipSet[MaccArray[MaccIndex]]
			end
			if equipSet[spell.skill] then
				equipSet = equipSet[spell.skill]
			end
			if equipSet[spell.type] then
				equipSet = equipSet[spell.type]
			end
		end
	elseif equipSet[spell.english] then
		equipSet = equipSet[spell.english]
	end
	if buffactive["Dark Seal"] then -- Equip Aug'd Fall. Burgeonet +3 When You Have Dark Seal Up --
        equipSet = set_combine(equipSet,{head="Fall. Burgeonet +3",})
    end
	if buffactive['Dark Seal'] and buffactive['Nether Void'] and S{"Drain II","Drain III"}:contains(spell.english) and player.tp<600 then
		equipSet = set_combine(equipSet,(sets.MAXDrain))
		add_to_chat(100,'WARNING: Misanthropy is on now *****')
	end
	equip(equipSet)
end

function aftercast(spell,action)

		if spell.type == "WeaponSkill" then
			send_command('wait 0.2;gs c TP')
		elseif spell.english == "Arcane Circle" then -- Arcane Circle Countdown --
			send_command('wait 260;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;input /echo '..spell.name..': [OFF]')
		elseif spell.english == "Sleep II" then -- Sleep II Countdown --
			send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Sleep" then -- Sleep Countdown --
			send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		end
		status_change(player.status)
	end
	

function status_change(new,old)
	check_equip_lock()
	if Armor == 'PDT' then
		equip(sets.PDT)
	elseif Armor == 'MDT' then
		equip(sets.MDT)
	--elseif Armor == 'Scarlet' then
		--equip(sets.Scarlet)
	elseif new == 'Engaged' then
		equipSet = sets.TP
		if Armor == 'Hybrid' and equipSet["Hybrid"] then
			equipSet = equipSet["Hybrid"]
		end
		if Armor == 'Volte' and equipSet["Volte"] then
			equipSet = equipSet["Volte"]
		end
		if equipSet[WeaponArray[WeaponIndex]] then
			equipSet = equipSet[WeaponArray[WeaponIndex]]
		end
		if equipSet[player.sub_job] then
			equipSet = equipSet[player.sub_job]
		end
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
	    if buffactive["Aftermath: Lv.3"] and equipSet["AM3"] then
    			if buffactive["Last Resort"] and ((buffactive.Haste and buffactive.March == 2) or (buffactive.Embrava and (buffactive.March == 2 or (buffactive.March and buffactive.Haste) or (buffactive.March and buffactive['Mighty Guard']) or (buffactive['Mighty Guard'] and buffactive.Haste))) or (buffactive[580] and (buffactive.March or buffactive.Haste or buffactive.Embrava or buffactive['Mighty Guard']))) and equipSet["HighHaste"] then
    				equipSet = equipSet["AM3_HighHaste"]
    			else 
    				equipSet = equipSet["AM3"]
    			end
    	end	
		if buffactive.Aftermath and equipSet["AM"] then
			equipSet = equipSet["AM"]
		end
		if buffactive["Last Resort"] and ((buffactive.Haste and buffactive.March == 2) or (buffactive.Embrava and (buffactive.March == 2 or (buffactive.March and buffactive.Haste) or (buffactive.March and buffactive['Mighty Guard']) or (buffactive['Mighty Guard'] and buffactive.Haste))) or (buffactive[580] and (buffactive.March or buffactive.Haste or buffactive.Embrava or buffactive['Mighty Guard']))) and equipSet["HighHaste"] then
			equipSet = equipSet["HighHaste"]
		end
		if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll == 'ON' then
			equipSet = equipSet["STP"]
		end
		equip(equipSet)
	else
		equipSet = sets.Idle
		if equipSet[IdleArray[IdleIndex]] then
			equipSet = equipSet[IdleArray[IdleIndex]]
		end
		if equipSet[WeaponArray[WeaponIndex]] then
			equipSet = equipSet[WeaponArray[WeaponIndex]]
		end
		if equipSet[player.sub_job] then
			equipSet = equipSet[player.sub_job]
		end
		if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
			equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
		end
		equip(equipSet)
	end
	if Twilight == 'Twilight' then
		equip(sets.Twilight)
	end
	if TreasureHunter == 'TreasureHunter' then
		equip(sets.TH)
	end
end

function buff_change(buff,gain)
	buff = string.lower(buff)
	if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
		if gain then
			send_command('timers create "Aftermath: Lv.3" 180 down;wait 150;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 15;input /echo Aftermath: Lv.3 [WEARING OFF IN 15 SEC.];wait 5;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
		else
			send_command('timers delete "Aftermath: Lv.3"')
			add_to_chat(123,'AM3: [OFF]')
		end
	elseif buff == 'weakness' then -- Weakness Timer --
		if gain then
			send_command('timers create "Weakness" 300 up')
		else
			send_command('timers delete "Weakness"')
		end
	end
	if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep & Have 200+ HP --
		equip({neck="Vim's Torque +1"})
	else
		if not midaction() then
			status_change(player.status)
		end
	end
end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
	if command == 'C1' then -- Accuracy Level Toggle --
		AccIndex = (AccIndex % #AccArray) + 1
		status_change(player.status)
		add_to_chat(158,'Accuracy Level: '..AccArray[AccIndex])
	elseif command == 'C17' then -- Main Weapon Toggle --
		WeaponIndex = (WeaponIndex % #WeaponArray) + 1
		add_to_chat(158,'Main Weapon: '..WeaponArray[WeaponIndex])
		status_change(player.status)
	elseif command == 'C18' then -- Lock Main Weapon Toggle --
        if Lock_Main == 'ON' then
			Lock_Main = 'OFF'
			add_to_chat(123,'Main Weapon: [Unlocked]')
        else
            Lock_Main = 'ON'
            add_to_chat(158,'Main Weapon: [Locked]')
        end
		status_change(player.status)	
	elseif command == 'C14' then -- Macc Toggle --
		MaccIndex = (MaccIndex % #MaccArray) + 1
		add_to_chat(158,'Macc Level: '..MaccArray[MaccIndex])
		status_change(player.status)
	elseif command == 'C5' then -- Auto Update Gear Toggle --
		status_change(player.status)
		add_to_chat(158,'Auto Update Gear')
	elseif command == 'C2' then -- Hybrid Toggle --
		if Armor == 'Hybrid' then
			Armor = 'None'
			add_to_chat(123,'Hybrid Set: [Unlocked]')
		else
			Armor = 'Hybrid'
			add_to_chat(158,'Hybrid Set: '..AccArray[AccIndex])
		end
		status_change(player.status)
	elseif command == 'C4' then -- Volte Toggle --
		if Armor == 'Volte' then
			Armor = 'None'
			add_to_chat(123,'Volte Set: [Unlocked]')
		else
			Armor = 'Volte'
			add_to_chat(158,'Volte Set: '..AccArray[AccIndex])
		end
		status_change(player.status)	
	elseif command == 'C7' then -- PDT Toggle --
		if Armor == 'PDT' then
			Armor = 'None'
			add_to_chat(123,'PDT Set: [Unlocked]')
		else
			Armor = 'PDT'
			add_to_chat(158,'PDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C15' then -- MDT Toggle --
		if Armor == 'MDT' then
			Armor = 'None'
			add_to_chat(123,'MDT Set: [Unlocked]')
		else
			Armor = 'MDT'
			add_to_chat(158,'MDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C11' then -- SAM Roll Toggle --
		if Samurai_Roll == 'ON' then
			Samurai_Roll = 'OFF'
			add_to_chat(123,'SAM Roll: [OFF]')
		else
			Samurai_Roll = 'ON'
			add_to_chat(158,'SAM Roll: [ON]')
		end
		status_change(player.status)	
	elseif command == 'C3' then -- Twilight Toggle --
		if Twilight == 'Twilight' then
			Twilight = 'None'
			add_to_chat(123,'Twilight Set: [Unlocked]')
		else
			Twilight = 'Twilight'
			add_to_chat(158,'Twilight Set: [locked]')
		end
		status_change(player.status)
	elseif command == 'C12' then -- Twilight Toggle --
		if TreasureHunter == 'TreasureHunter' then
			TreasureHunter = 'None'
			add_to_chat(123,'TreasureHunter Set: [Unlocked]')
		else
			TreasureHunter = 'TreasureHunter'
			add_to_chat(158,'TreasureHunter Set: [Locked]')
		end
		status_change(player.status)	
	elseif command == 'C8' then -- Distance Toggle --
		if player.target.distance then
			target_distance = math.floor(player.target.distance*10)/10
			add_to_chat(158,'Distance: '..target_distance)
		else
			add_to_chat(123,'No Target Selected')
		end
	elseif command == 'C6' then -- Idle Toggle --
		IdleIndex = (IdleIndex % #IdleArray) + 1
		status_change(player.status)
		add_to_chat(158,'Idle Set: '..IdleArray[IdleIndex])
	elseif command == 'TP' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	end
end

function check_equip_lock() -- Lock Equipment Here --
    if Lock_Main == 'ON' then
		disable('main','sub')
    else
        enable('main','sub')
    end
end

function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end

function set_macro_page(set,book)
	if not tonumber(set) then
		add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
		return
	end
	if set < 1 or set > 10 then
		add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
		return
	end
	
	if book then
		if not tonumber(book) then
			add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
			return
		end
		if book < 1 or book > 20 then
			add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
			return
		end
		send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
	else
		send_command('@input /macro set '..tostring(set))
	end
end

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'SAM' then
		set_macro_page(1, 1)
	else
		set_macro_page(1, 1)
	end
end