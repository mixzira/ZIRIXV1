vRP.prepare("vRP/money_init_user","INSERT IGNORE INTO vrp_user_moneys(user_id,wallet,bank) VALUES(@user_id,@wallet,@bank)")
vRP.prepare("vRP/get_money","SELECT wallet,bank FROM vrp_user_moneys WHERE user_id = @user_id")
vRP.prepare("vRP/set_money","UPDATE vrp_user_moneys SET wallet = @wallet, bank = @bank WHERE user_id = @user_id")

function vRP.getMoney(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		return tmp.wallet or 0
	else
		return 0
	end
end

function vRP.setMoney(user_id,value)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.wallet = value
	end
end

function vRP.tryPayment(user_id,amount)
	if amount >= 0 then
		local money = vRP.getMoney(user_id)
		if amount >= 0 and money >= amount then
			vRP.setMoney(user_id,money-amount)
			return true
		else
			return false
		end
	end
	return false
end

function vRP.giveMoney(user_id,amount)
	if amount >= 0 then
		local money = vRP.getMoney(user_id)
		vRP.setMoney(user_id,money+amount)
	end
end

function vRP.getBankMoney(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		return tmp.bank or 0
	else
		return 0
	end
end

function vRP.setBankMoney(user_id,value)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.bank = value
	end
end

function vRP.giveBankMoney(user_id,amount)
	if amount >= 0 then
		local money = vRP.getBankMoney(user_id)
		vRP.setBankMoney(user_id,money+amount)
	end
end

function vRP.tryWithdraw(user_id,amount)
	local money = vRP.getBankMoney(user_id)
	if amount >= 0 and money >= amount then
		vRP.setBankMoney(user_id,money-amount)
		vRP.giveMoney(user_id,amount)
		return true
	else
		return false
	end
end

function vRP.tryDeposit(user_id,amount)
	if amount >= 0 and vRP.tryPayment(user_id,amount) then
		vRP.giveBankMoney(user_id,amount)
		return true
	else
		return false
	end
end

function vRP.tryFullPayment(user_id,amount)
	if amount >= 0 then
		local money = vRP.getMoney(user_id)
		if money >= amount then
			return vRP.tryPayment(user_id,amount)
		else
			if vRP.tryWithdraw(user_id, amount-money) then
				return vRP.tryPayment(user_id,amount)
			end
		end
	end
	return false
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name)
	vRP.execute("vRP/money_init_user",{ user_id = user_id, wallet = 2000, bank = 18000 })
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		local rows = vRP.query("vRP/get_money",{ user_id = user_id })
		if #rows > 0 then
			tmp.bank = rows[1].bank
			tmp.wallet = rows[1].wallet
		end
	end
end)

RegisterCommand('savedb',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local tmp = vRP.getUserTmpTable(user_id)
		if tmp and tmp.wallet and tmp.bank then
			vRP.execute("vRP/set_money",{ user_id = user_id, wallet = tmp.wallet, bank = tmp.bank })
		end
		TriggerClientEvent("save:database",source)
		TriggerClientEvent("Notify",source,"importante","Você salvou todo o conteúdo temporário de sua database.")
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp and tmp.wallet and tmp.bank then
		vRP.execute("vRP/set_money",{ user_id = user_id, wallet = tmp.wallet, bank = tmp.bank })
	end
end)

AddEventHandler("vRP:save",function()
	for k,v in pairs(vRP.user_tmp_tables) do
		if v.wallet and v.bank then
			vRP.execute("vRP/set_money",{ user_id = k, wallet = v.wallet, bank = v.bank })
		end
	end
end)