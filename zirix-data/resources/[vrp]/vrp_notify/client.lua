RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem)
	SendNUIMessage({ css = css, mensagem = mensagem, time = 7000 })
end)

RegisterNetEvent("NotifyAdm")
AddEventHandler("NotifyAdm",function(nomeadm,mensagem)
	SendNUIMessage({ css = "importante", mensagem = "<b>"..mensagem.."</b><br>- "..nomeadm, time = 20000 })
end)

RegisterNetEvent("NotifyAdmCallback")
AddEventHandler("NotifyAdmCallback",function(nomeadm,mensagem)
	SendNUIMessage({ css = "aviso", mensagem = "<b>"..mensagem.."</b><br>- Privada de "..nomeadm, time = 20000 })
end)