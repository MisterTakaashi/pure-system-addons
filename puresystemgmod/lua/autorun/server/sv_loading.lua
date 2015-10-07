util.AddNetworkString("Discon")

net.Receive("Discon",function(len,ply)
	ply:Kick("Vous vous êtes deconnecté du serveur")
end)
