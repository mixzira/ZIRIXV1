local system = {}

RegisterServerEvent("eblips:add")
AddEventHandler("eblips:add", function(person)
	system[person.src] = person
	for k,v in pairs(system) do
		TriggerClientEvent("eblips:updateAll",k,system)
	end
	TriggerClientEvent("eblips:toggle",person.src,true)
end)

RegisterServerEvent("eblips:remove")
AddEventHandler("eblips:remove",function(src)
	system[src] = nil
	for k,v in pairs(system) do
		TriggerClientEvent("eblips:remove",tonumber(k),src)
	end
	TriggerClientEvent("eblips:toggle",src,false)
end)

AddEventHandler("playerDropped",function()
	if system[source] then
		system[source] = nil
	end
end)