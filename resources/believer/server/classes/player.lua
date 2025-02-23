local SetTimeout = SetTimeout
local GetPlayerPed = GetPlayerPed
local DoesEntityExist = DoesEntityExist
local GetEntityCoords = GetEntityCoords
local GetEntityHeading = GetEntityHeading

function CreateExtendedPlayer(playerId, identifier, accounts, weight, job, name, coords, uniqueId, is_dead, first_connection, metadata)
	local targetOverrides = Config.PlayerFunctionOverride and Core.PlayerFunctionOverrides[Config.PlayerFunctionOverride] or {}
	
	local self = {}
	
	self.uniqueId = uniqueId
	self.accounts = accounts
	self.coords = coords
	self.group = "user"
	self.identifier = identifier
	self.job = job
	self.name = name
	self.playerId = playerId
	self.source = playerId
	self.variables = {}
	self.weight = weight
	self.maxWeight = Config.MaxWeight
	self.metadata = metadata
	self.license = 'license:'..identifier
	self.is_dead = is_dead
	self.vip = vip or 1
	self.first_connection = first_connection

	ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.license, self.group))
	
	local stateBag = Player(self.source).state
	stateBag:set("identifier", self.identifier, true)
	stateBag:set("license", self.license, true)
	stateBag:set("job", self.job, true)
	stateBag:set("group", self.group, true)
	stateBag:set("name", self.name, true)
	stateBag:set("metadata", self.metadata, true)

	function self.triggerEvent(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end

	function self.setCoords(coords)
		local Ped = GetPlayerPed(self.source)
		local vector = type(coords) == "vector4" and coords or type(coords) == "vector3" and vector4(coords, 0.0) or
		vec(coords.x, coords.y, coords.z, coords.heading or 0.0)
		SetEntityCoords(Ped, vector.xyz, false, false, false, false)
		SetEntityHeading(Ped, vector.w)
	end

	function self.updateCoords()
		SetTimeout(1000,function()
			local Ped = GetPlayerPed(self.source)
			if DoesEntityExist(Ped) then
				local coords = GetEntityCoords(Ped)
				local distance = #(coords - vector3(self.coords.x, self.coords.y, self.coords.z))
				if distance > 1.5 then
					local heading = GetEntityHeading(Ped)
					self.coords = {
						x = coords.x,
						y = coords.y, 
						z = coords.z, 
						heading = heading or 0.0
					}
				end
			end
			self.updateCoords()
		end)
	end

	function self.getCoords(vector)
		if vector then
			return vector3(self.coords.x, self.coords.y, self.coords.z)
		else
			return self.coords
		end
	end

	function self.kick(reason)
		DropPlayer(self.source, reason)
	end

	function self.setMoney(money)
		money = ESX.Math.Round(money)
		self.setAccountMoney('money', money)
	end

	function self.getMoney()
		return self.getAccount('money').money
	end

	function self.addMoney(money, inventory)
		money = ESX.Math.Round(money)
		self.addAccountMoney('money', money, inventory)
	end

	function self.removeMoney(money, inventory)
		money = ESX.Math.Round(money)
		self.removeAccountMoney('money', money, inventory)
	end

	function self.getIdentifier()
		return self.identifier
	end

	function self.setGroup(newGroup)
		ExecuteCommand(('remove_principal identifier.%s group.%s'):format(self.license, self.group))
		self.group = newGroup
		Player(self.source).state:set("group", self.group, true)
		ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.license, self.group))
	end

	function self.getGroup()
		return self.group
	end

	function self.set(k, v)
		self.variables[k] = v
		Player(self.source).state:set(k, v, true)
	end

	function self.get(k)
		return self.variables[k]
	end

	function self.getAccounts(minimal)
		if not minimal then
			return self.accounts
		end

		local minimalAccounts = {}

		for i=1, #self.accounts do
			minimalAccounts[self.accounts[i].name] = self.accounts[i].money
		end

		return minimalAccounts
	end

	function self.getAccount(account)
		for i=1, #self.accounts do
			if self.accounts[i].name == account then
				return self.accounts[i]
			end
		end
	end

	function self.getJob()
		return self.job
	end

	function self.getName()
		return self.name
	end

	function self.setName(newName)
		self.name = newName
		Player(self.source).state:set("name", self.name, true)
	end

	function self.setAccountMoney(accountName, money, inventory)
		if not tonumber(money) then 
			print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
			return
		end
		if money >= 0 then
			local account = self.getAccount(accountName)

			if account then
				money = account.round and ESX.Math.Round(money) or money
				self.accounts[account.index].money = money

				self.triggerEvent('esx:setAccountMoney', account)
				TriggerEvent('esx:setAccountMoney', self.source, accountName, money)
				if (accountName == "money") then
					exports["believer"]:SetItemQuantity(self.source, accountName, money)
				elseif (accountName == "black_money") then
					exports["believer"]:SetItemQuantity(self.source, accountName, money)
				end
			else 
				print(('[^1ERROR^7] Tried To Set Invalid Account ^5%s^0 For Player ^5%s^0!'):format(accountName, self.playerId))
			end
		else 
			print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
		end
	end

	function self.addAccountMoney(accountName, money, inventory)
		if not tonumber(money) then 
			print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
			return
		end
		if money > 0 then
			local account = self.getAccount(accountName)
			if account then
				money = account.round and ESX.Math.Round(money) or money
				self.accounts[account.index].money += money

				self.triggerEvent('esx:setAccountMoney', account)
				TriggerEvent('esx:addAccountMoney', self.source, accountName, money)
				if (accountName == "money") then
					exports["believer"]:AddItem(self.source, accountName, money)
				elseif (accountName == "black_money") then
					exports["believer"]:AddItem(self.source, accountName, money)
				end
			else 
				print(('[^1ERROR^7] Tried To Set Add To Invalid Account ^5%s^0 For Player ^5%s^0!'):format(accountName, self.playerId))
			end
		else 
			print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
		end
	end

	function self.removeAccountMoney(accountName, money, inventory)
		if not tonumber(money) then 
			print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
			return
		end
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				money = account.round and ESX.Math.Round(money) or money
				self.accounts[account.index].money -= money

				self.triggerEvent('esx:setAccountMoney', account)
				TriggerEvent('esx:removeAccountMoney', self.source, accountName, money)
				if (inventory) then
					if (accountName == "money") then
						exports["believer"]:RemoveItemBy(self.source, money, {
							name = accountName,
						})
					elseif (accountName == "black_money") then
						exports["believer"]:RemoveItemBy(self.source, money, {
							name = accountName,
						})
					end
				end
			else 
				print(('[^1ERROR^7] Tried To Set Add To Invalid Account ^5%s^0 For Player ^5%s^0!'):format(accountName, self.playerId))
			end
		else 
			print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
		end
	end

	function self.getInventoryItem(name, slot)
		if (not slot) then
			local inventoryItem = exports["believer"]:GetItemBy(self.source, {
				name = name,
			})
			return inventoryItem
		else
			local slotItem = exports["believer"]:GetItemBy(self.source, {
				name = name,
				slot = slot
			})
			return slotItem
		end
	end

	function self.addInventoryItem(name, count, metadata, slot)
		exports["believer"]:AddItem(self.source, name, count, metadata)
	end

	function self.removeInventoryItem(name, count, metadata, slot)
		exports["believer"]:RemoveItemBy(self.source, count, {
			name = name,
		})
	end

	function self.setInventoryItem(name, count, metadata)
		local item = self.getInventoryItem(name)

		if item and count >= 0 then
			count = ESX.Math.Round(count)

			if count > item.count then
				self.addInventoryItem(item.name, count - item.count)
			else
				self.removeInventoryItem(item.name, item.count - count)
			end
		end
	end

	function self.getWeight()
		return self.weight
	end

	function self.getMaxWeight()
		return self.maxWeight
	end

	function self.canCarryItem(name, count, metadata)
        local boolean = exports["believer"]:CanCarryItem(self.source, name, count)
		return boolean
	end

	function self.setMaxWeight(newWeight)
		self.maxWeight = newWeight
		self.triggerEvent('esx:setMaxWeight', self.maxWeight)
	end

	function self.setJob(job, grade)
		grade = tostring(grade)

		if ESX.DoesJobExist(job, grade) then
			local actualJob = self.job.name
			if (actualJob) then
				local actualJob = string.upper(string.sub(actualJob, 1, 1))..string.sub(actualJob, 2, #actualJob)

				if (GM[actualJob]) then
					if (GM[actualJob].registeredZones) then
						for zoneType, _ in pairs(GM[actualJob].registeredZones) do
							for zoneId, _ in pairs(GM[actualJob].registeredZones[zoneType]) do
								GM[actualJob].registeredZones[zoneType][zoneId]:allowedPlayer(self.source, false)
							end
						end
					end

					if (GM[actualJob].registeredBlips) then
						for blipType, _ in pairs(GM[actualJob].registeredBlips) do
							for blipId, _ in pairs(GM[actualJob].registeredBlips[blipType]) do
								GM[actualJob].registeredBlips[blipType][blipId]:allowedPlayer(self.source, false)
							end
						end
					end
				end
			end

			local newJob = job
			if (newJob) then
				local newJob = string.upper(string.sub(newJob, 1, 1))..string.sub(newJob, 2, #newJob)

				if (GM[newJob]) then
					if (GM[newJob].registeredZones) then
						for zoneType, _ in pairs(GM[newJob].registeredZones) do
							for zoneId, _ in pairs(GM[newJob].registeredZones[zoneType]) do
								GM[newJob].registeredZones[zoneType][zoneId]:allowedPlayer(self.source, true)
							end
						end
					end

					if (GM[newJob].registeredBlips) then
						for blipType, _ in pairs(GM[newJob].registeredBlips) do
							for blipId, _ in pairs(GM[newJob].registeredBlips[blipType]) do
								GM[newJob].registeredBlips[blipType][blipId]:allowedPlayer(self.source, true)
							end
						end
					end
				end
			end

			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

			self.job.id    = jobObject.id
			self.job.name  = jobObject.name
			self.job.label = jobObject.label

			self.job.grade        = tonumber(grade)
			self.job.grade_name   = gradeObject.name
			self.job.grade_label  = gradeObject.label
			self.job.grade_salary = gradeObject.salary

			TriggerEvent('esx:setJob', self.source, self.job)
			self.triggerEvent('esx:setJob', self.job)
			Player(self.source).state:set("job", self.job, true)
		else
			print(('[believer] [^3WARNING^7] Ignoring invalid ^5.setJob()^7 usage for ID: ^5%s^7, Job: ^5%s^7'):format(self.source, job))
		end
	end

	function self.showNotification(msg, options)
		self.triggerEvent('esx:showNotification', msg, options)
	end

	function self.showInventoryNotification(type, msg)
		self.triggerEvent("Inventory:SEND_NOTIFICATION", {
			event = "SEND_NOTIFICATION",
			type = type,
			message = msg
		})
	end

	function self.showHelpNotification(msg, thisFrame, beep, duration)
		self.triggerEvent('esx:showHelpNotification', msg, thisFrame, beep, duration)
	end

	function self.getMeta(index, subIndex)
		if index then

			if type(index) ~= "string" then
				return print("[^1ERROR^7] xPlayer.getMeta ^5index^7 should be ^5string^7!")
			end

			if self.metadata[index] then

				if subIndex and type(self.metadata[index]) == "table" then
					local _type = type(subIndex)

					if _type == "string" then
						if self.metadata[index][subIndex] then
							return self.metadata[index][subIndex]
						end
						return
					end

					if _type == "table" then
						local returnValues = {}
						for i = 1, #subIndex do
							if self.metadata[index][subIndex[i]] then
								returnValues[subIndex[i]] = self.metadata[index][subIndex[i]]
							else
								print(("[^1ERROR^7] xPlayer.getMeta ^5%s^7 not esxist on ^5%s^7!"):format(subIndex[i], index))
							end
						end

						return returnValues
					end

				end

				return self.metadata[index]
			else
				return print(("[^1ERROR^7] xPlayer.getMeta ^5%s^7 not exist!"):format(index))
			end

		end

		return self.metadata
	end

	function self.setMeta(index, value, subValue)
		if not index then
			return print("[^1ERROR^7] xPlayer.setMeta ^5index^7 is Missing!")
		end

		if type(index) ~= "string" then
			return print("[^1ERROR^7] xPlayer.setMeta ^5index^7 should be ^5string^7!")
		end

		if not value then
			return print(("[^1ERROR^7] xPlayer.setMeta ^5%s^7 is Missing!"):format(value))
		end

		local _type = type(value)

		if not subValue then

			if _type ~= "number" and _type ~= "string" and _type ~= "table" then
				return print(("[^1ERROR^7] xPlayer.setMeta ^5%s^7 should be ^5number^7 or ^5string^7 or ^5table^7!"):format(value))
			end

			self.metadata[index] = value
		else

			if _type ~= "string" then
				return print(("[^1ERROR^7] xPlayer.setMeta ^5value^7 should be ^5string^7 as a subIndex!"):format(value))
			end

			self.metadata[index][value] = subValue
		end


		self.triggerEvent('esx:updatePlayerData', 'metadata', self.metadata)
		Player(self.source).state:set('metadata', self.metadata, true)
	end

	function self.clearMeta(index)
		if not index then
			return print(("[^1ERROR^7] xPlayer.clearMeta ^5%s^7 is Missing!"):format(index))
		end

		if type(index) == 'table' then
			for _, val in pairs(index) do
				self.clearMeta(val)
			end

			return
		end

		if not self.metadata[index] then
			return print(("[^1ERROR^7] xPlayer.clearMeta ^5%s^7 not exist!"):format(index))
		end

		self.metadata[index] = nil
		self.triggerEvent('esx:updatePlayerData', 'metadata', self.metadata)
		Player(self.source).state:set('metadata', self.metadata, true)
	end

	function self.setArmour(armour)
		SetPedArmour(GetPlayerPed(self.source), armour)
	end

	function self.getNickName()
		return GetPlayerName(self.source)
	end

	function self.ban(reason, expiration, author)
		if (not reason or not expiration or type(expiration) ~= "number") then
			return
		end

		local playerIdentifier = self.getIdentifier()
		if (not playerIdentifier) then
			return
		end


		local currentBan = {
			reason = reason,
			expiration = expiration,
			author = author
		}
	
		GM.Connecting:ban(playerIdentifier, currentBan)
	end

	function self.kick(reason, author)
		local kick = {
			reason = reason,
			date = os.date("%d/%m/%Y %H:%M:%S"),
			admin = author,
		}
	
		MySQL.insert('INSERT INTO user_sanctions (identifier, type, data) VALUES (?, ?, ?)', {self.identifier, "Kick", json.encode(kick)}, function()
			DropPlayer(self.source, "Vous avez été kick de BlueStark !\n"..reason)
		end)
	end

	function self.onPosition(position, radius)
		local isOnPos = true
		if (#(self.getCoords(true)-position) > radius) then
			isOnPos = false
		end
		return isOnPos
	end

	function self.savePosition(savePosition)
		if (savePosition == true) then
			self.position = nil
		else
			self.position = GetEntityCoords(self.getPed())
		end
	end

	function self.getUniqueId()
		return self.uniqueId
	end

	function self.getDead()
		return self.is_dead
	end

	function self.setDead(boolean)
		self.is_dead = boolean
	end

	function self.getFirstConnection()
		return self.first_connection
	end

	function self.getVip()
		return self.vip
	end

	function self.getPed()
		return GetPlayerPed(self.source)
	end

	function self.getPedArmor()
		return GetPedArmour(self.getPed())
	end

	function self.getPedMaxArmor()
		return GetPlayerMaxArmour(self.source)
	end

	function self.setPedArmor(armor)
		SetPedArmour(self.getPed(), armor)
	end

	for fnName,fn in pairs(targetOverrides) do
		self[fnName] = fn(self)
	end

	return self
end
