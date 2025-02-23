ESX = exports['believer']:getSharedObject()

RegisterServerEvent('bluestark_bank:Deposit')
AddEventHandler('bluestark_bank:Deposit', function(amount)
	local playerSrc = source
	if (not playerSrc) then return end

	local playerSelected = ESX.GetPlayerFromId(playerSrc)
	if (not playerSelected) then return end

    amount = tonumber(amount)

	if amount == nil or amount <= 0 or amount > playerSelected.getMoney() then
		playerSelected.showNotification("~r~Montant invalide.")
		return
	end

	playerSelected.removeMoney(amount)
	playerSelected.addAccountMoney('bank', tonumber(amount), true)
	playerSelected.showNotification("Vous avez déposé un montant de ~b~"..tonumber(amount).."$.")
end)


RegisterServerEvent('bluestark_bank:Withdraw')
AddEventHandler('bluestark_bank:Withdraw', function(amount)
	local playerSrc = source
	if (not playerSrc) then return end

	local playerSelected = ESX.GetPlayerFromId(playerSrc)
	if (not playerSelected) then return end

	amount = tonumber(amount)

	if (amount == 0 or amount == nil) then
		playerSelected.showNotification("~r~Montant invalide.")
		return
	end

	local playerBankBalance = playerSelected.getAccount('bank').money


	if amount > playerBankBalance then
		playerSelected.showNotification("~r~Vous n'avez pas assez d'argent en banque.")
		return
	end

	playerSelected.removeAccountMoney('bank', amount, true)
	playerSelected.addAccountMoney("money", amount, true)
	playerSelected.showNotification("Vous avez retiré un montant de ~b~"..tonumber(amount).."$.")
end) 