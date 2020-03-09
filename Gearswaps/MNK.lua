function get_sets()
	include('Ballzack-Items.lua')
	AccIndex = 1
	AccArray = {"LowACC","MidACC","HighACC","MaxACC"} -- 4 Levels Of Accuracy Sets For TP/WS/Hybrid. First Set Is LowACC. Add More ACC Sets If Needed Then Create Your New ACC Below. --
	IdleIndex = 1
	IdleArray = {"Movement"} -- Default Idle Set Is Movement --
	Armor = 'None'
	Capacity = 'None'
	target_distance = 5 -- Set Default Distance Here --
	select_default_macro_book() -- Change Default Macro Book At The End --
	set_lockstyle()
	
	-- Key Binds --
	send_command('bind Home input /ws "Raging Fists" <t>')
	send_command('bind Delete input /ws "Victory Smite" <t>')
	send_command('bind End input /ws "Shijin Spiral" <t>')
	send_command('bind @c gs c C4') -- Capacity
	send_command('bind F9 gs c C1') -- Accuracy
	send_command('bind ^F9 gs c C2') -- Hybrid
	send_command('bind F10 gs c C7') -- PDT
	send_command('bind F11 gs c C15') -- MDT
	send_command('bind F12 gs c C6') -- Idle
	send_command('bind ^F12 gs c C5') -- Update
	
	function file_unload()
		send_command('unbind Home')
		send_command('unbind Delete')
        send_command('unbind End')
		send_command('unbind @c')
		send_command('unbind F9')
		send_command('unbind ^F9')
		send_command('unbind F10')
		send_command('unbind F11')
		send_command('unbind F12')
		send_command('unbind ^F12')
	end

	sets.Idle = {}
	-- Idle/Town Sets --
	sets.Idle.Movement = {
		ammo="Staunch Tathlum +1",
		head="Dampening Tam",
		neck="Loricate Torque +1",
		ear1="Sanare Earring",
		ear2="Hearty Earring",
		body=HerculeanVestDT,
		hands=HerculeanGlovesPDT,
		ring1="Defending Ring",
		ring2="Vocane Ring",
		back="Moonlight Cape",
		waist="Moonbow Belt",
		legs="Mummu Kecks +2",
		feet="Herald's Gaiters"}

	sets.Capacity = {back="Mecisto. Mantle"}

	--Normal TP Sets --
	sets.TP= {
		ammo="Ginsen",
		head="Adhemar Bonnet +1",
		neck="Moonlight Nodowa",
		ear1="Sherida Earring",
		ear2="Telos Earring",
		body="Ken. Samue",
		hands=adhemar_b_hands,
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back="Sacro Mantle",
		waist="Moonbow Belt",
		legs="Ken. Hakama",
		feet="Ken. Sune-Ate"}
		
	sets.TP.MidACC = set_combine(sets.TP,{})
	sets.TP.HighACC = set_combine(sets.TP.MidACC,{})
	sets.TP.MaxACC = set_combine(sets.TP.HighACC,{})	

	-- (Impetus Up) TP Sets --
	sets.TP.Impetus = sets.TP
	sets.TP.Impetus = sets.TP.MidACC.Impetus
	sets.TP.Impetus = sets.TP.HighACC.Impetus
	sets.TP.Impetus = sets.TP.MaxACC.Impetus

	-- Perfect Counter Set --
	sets.TP.PerfectCounter = {}

	-- PDT/MDT Sets --
	sets.PDT = {}
	sets.MDT = set_combine(sets.PDT,{})

	-- Hybrid/HP Sets --
	sets.TP.Hybrid = set_combine(sets.PDT,{})
	sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{})
	sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})

	-- WS Base Set --
	sets.WS = {}

	-- Victory Smite Sets --
	sets.WS["Victory Smite"] = {
		ammo="Knobkierrie",
		head="Adhemar Bonnet +1",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body="Ken. Samue",
		hands="Ryuo Tekko",
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back="Sacro Mantle",
		waist="Moonbow Belt",
		legs="Ken. Hakama",
		feet="Ken. Sune-Ate"}
		
	sets.WS["Victory Smite"].MidACC = set_combine(sets.WS["Victory Smite"],{})
	sets.WS["Victory Smite"].HighACC = set_combine(sets.WS["Victory Smite"].MidACC,{})
	sets.WS["Victory Smite"].MaxACC = set_combine(sets.WS["Victory Smite"].HighACC,{})

	-- Raging Fists Sets --
	sets.WS["Raging Fists"] = {
		ammo="Knobkierrie",
		head="Lilitu Headpiece",
		neck="Caro Necklace",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body=HerculeanVestTA,
		hands=adhemar_b_hands,
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back="Sacro Mantle",
		waist="Moonbow Belt",
		legs="Hiza. Hizayoroi +2",
		feet=HerculeanBootsWSD}
	
	sets.WS["Raging Fists"].MidACC = set_combine(sets.WS["Raging Fists"],{})
	sets.WS["Raging Fists"].HighACC = set_combine(sets.WS["Raging Fists"].MidACC,{})
	sets.WS["Raging Fists"].MaxACC = set_combine(sets.WS["Raging Fists"].HighACC,{})

	-- Shijin Spiral Sets --
	sets.WS["Shijin Spiral"] = {
		ammo="Knobkierrie",
		head="Ken. Jinpachi",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Mache Earring +1",
		body="Adhemar Jacket +1",
		hands=adhemar_b_hands,
		ring1="Niqmaddu Ring",
		ring2="Ilabrat Ring",
		back="Sacro Mantle",
		waist="Moonbow Belt",
		legs="Ken. Hakama",
		feet="Ken. Sune-Ate"}
	
	sets.WS["Shijin Spiral"].MidACC = set_combine(sets.WS["Shijin Spiral"],{})
	sets.WS["Shijin Spiral"].HighACC = set_combine(sets.WS["Shijin Spiral"].MidACC,{})
	sets.WS["Shijin Spiral"].MaxACC = set_combine(sets.WS["Shijin Spiral"].HighACC,{})

	sets.WS["Ascetic's Fury"] = {
		ammo="Knobkierrie",
		head="Adhemar Bonnet +1",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body="Abnoba Kaftan",
		hands="Ryuo Tekko",
		ring1="Niqmaddu Ring",
		ring2="Begrudging Ring",
		back=SegomoCrit,
		waist="Moonbow Belt",
		legs="Ken. Hakama",
		feet=HerculeanBootsCrit}
	
	-- JA Sets --
	sets.JA = {}
	sets.JA.Focus = {head="Anchor. Crown +1"}
	sets.JA['Formless Strikes'] = {}
	sets.JA['Hundred Fists'] = {legs="Hes. Hose +1"}
	sets.JA.Mantra = {}
	sets.JA.Counterstance = {}
	sets.JA.Dodge = {}
	sets.JA.Chakra = {
		body="Anch. Cyclas +1",
		hands="Hes. Gloves +1"}
	
	sets.Precast = {}
	
	-- Fastcast Set --
	sets.Precast.FastCast = {}
	-- Utsusemi Precast Set --
	sets.Precast.Utsusemi = set_combine(sets.Precast.FastCast,{})

	sets.Midcast = {}
	-- Magic Haste Set --
	sets.Midcast.Haste = set_combine(sets.PDT,{})
end

function pretarget(spell,action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	elseif spell.english == 'Impetus' and buffactive.Impetus then -- Change Impetus To Focus When Impetus Is On --
		cancel_spell()
		send_command('Focus')
	elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
		cancel_spell()
		send_command('Aggressor')
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
			if spell.type == "WeaponSkill" and player.tp > 2500 then
				equipSet = set_combine(equipSet,{ear2="Ishvara Earring"})
            end
			equip(equipSet)
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	elseif spell.action_type == 'Magic' then
		if spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ni' then
				if buffactive['Copy Image (3)'] then
					cancel_spell()
					add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
					return
				else
					equip(sets.Precast.Utsusemi)
				end
			else
				equip(sets.Precast.Utsusemi)
			end
		else
			equip(sets.Precast.FastCast)
		end
	elseif spell.type == "Waltz" then
		refine_waltz(spell,action)
		equip(sets.Waltz)
	elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		cast_delay(0.2)
		send_command('cancel Sneak')
	end
	if Capacity == 'Capacity' then
		equip(sets.Capacity)
	end
	if Warp == 'Warp' then
		equip(sets.Warp)
	end
end

function midcast(spell,action)
	if spell.action_type == 'Magic' then
		if spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
				send_command('@wait 1.7;cancel Copy Image*')
			end
			equip(sets.Midcast.Haste)
		elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equip(sets.Midcast.Haste)
		else
			equip(sets.Midcast.Haste)
		end
	end
end

function aftercast(spell,action)
	if not spell.interrupted then
		if spell.type == "WeaponSkill" then
			send_command('wait 0.2;gs c TP')
		elseif spell.english == "Impetus" then -- Impetus Timer --
			timer_impetus()
		elseif spell.english == "Mantra" then -- Mantra Timer/Countdown --
			timer_mantra()
			send_command('wait 170;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;input /echo '..spell.name..': [OFF]')
		end
	end
	status_change(player.status)
end

function status_change(new,old)
	if Armor == 'PDT' then
		equip(sets.PDT)
	elseif Armor == 'MDT' then
		equip(sets.MDT)
	elseif new == 'Engaged' then
		equipSet = sets.TP
		if Armor == 'Hybrid' and equipSet["Hybrid"] then
			equipSet = equipSet["Hybrid"]
		end
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
		if buffactive.Impetus and equipSet["Impetus"] then
			equipSet = equipSet["Impetus"]
		end
		if buffactive['Perfect Counter'] then
			equipSet = set_combine(equipSet,sets.TP.PerfectCounter)
		end
		equip(equipSet)
	else
		equipSet = sets.Idle
		if equipSet[IdleArray[IdleIndex]] then
			equipSet = equipSet[IdleArray[IdleIndex]]
		end
		equip(equipSet)
	end
	if Capacity == 'Capacity' then
		equip(sets.Capacity)
	end
	if Warp == 'Warp' then
		equip(sets.Warp)
	end
end

function buff_change(buff,gain,buff_table)
    buff = string.lower(buff)
	if buff_table['id'] == 272 and player.equipment.main == 'Godhands' then -- Godhands AM3 Timer/Countdown --
        if gain then
            send_command('timers create "Aeonic Aftermath: Lv.3" 180 down')
        else
            send_command('timers delete "Aeonic Aftermath: Lv.3"')
            add_to_chat(123,'Godhands AM3: [OFF]')
        end
    elseif buff_table['id'] == 271 and player.equipment.main == 'Godhands' then -- Godhands AM2 Timer/Countdown --
        if gain then
            send_command('timers create "Aeonic Aftermath: Lv.2" 180 down')
        else
            send_command('timers delete "Aeonic Aftermath: Lv.2"')
            add_to_chat(123,'Godhands AM2: [OFF]')
        end
	elseif buff == 'impetus' and not gain then
		send_command('timers delete "Impetus"')
		add_to_chat(123,'Impetus: [OFF]')
	elseif buff == 'mantra' and not gain then
		send_command('timers delete "Mantra"')
	elseif buff == "inner strength" then -- Inner Strength Timer --
		if gain then
			send_command('timers create "Inner Strength" 30 down')
		else
			send_command('timers delete "Inner Strength"')
			add_to_chat(123,'Inner Strength: [OFF]')
		end
	elseif buff == 'aggressor' and not gain then
		add_to_chat(123,'Aggressor: [OFF]')
	elseif buff == "perfect defense" then -- PD Timer --
		if gain then
			send_command('timers create "Perfect Defense" 57 down')
		else
			send_command('timers delete "Perfect Defense"')
			add_to_chat(123,'PD: [OFF]')
		end
	end
	if not midaction() then
		status_change(player.status)
	end
end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
	if command == 'C1' then -- Accuracy Toggle --
		AccIndex = (AccIndex % #AccArray) + 1
		add_to_chat(158,'Accuracy Level: ' .. AccArray[AccIndex])
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
	elseif command == 'C4' then -- Capacity Toggle --
		if Capacity == 'Capacity' then
			Capacity = 'None'
			add_to_chat(123,'Capacity Set: [Unlocked]')
		else
			Capacity = 'Capacity'
			add_to_chat(158,'Capacity Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C6' then -- Idle Toggle --
		IdleIndex = (IdleIndex % #IdleArray) + 1
		add_to_chat(158,'Idle Set: ' .. IdleArray[IdleIndex])
		status_change(player.status)
	elseif command == 'TP' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	end
end

function timer_impetus()
	local duration = 180
	send_command('timers create "Impetus" '..tostring(duration)..' down')
end

function timer_mantra()
	local duration = 180
	send_command('timers create "Mantra" '..tostring(duration)..' down')
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
	if player.sub_job == 'WAR' then
		set_macro_page(1, 2)
	else
		set_macro_page(1, 2)
	end
end

function set_lockstyle()
	send_command('wait 4; input /lockstyleset 16')
end