include("autorun/pure_config.lua")
local PureLog = "puresystem/log/"..os.date("%Y_%m_%d")..".txt"
if ( SERVER ) then
    AddCSLuaFile("autorun/client/cl_loading.lua");
    util.AddNetworkString("EndLoeading")
    util.AddNetworkString("CloseLoadingScreenErr")
    util.AddNetworkString("PConnect")
    util.AddNetworkString("OpenPureLoading")

    local function connexionPlayer(pseudo, steamid, steamid64, ply)
        local TheReturnedHTML = ""
        http.Fetch( "http://puresystem.fr/api/rest/connexion.php?port="..PURE.port.."&pseudo="..pseudo.."&steamid="..steamid.."&steamid64="..steamid64,
            function( body, len, headers, code )
                TheReturnedHTML = body
                local retourTable = util.JSONToTable(TheReturnedHTML)
                print(body)
                if retourTable["error"] != false then
                  print("Le Serveur n'est pas répétorié dans le Pure System. Veuillez prendre contact avec le support : http://puresystem.fr")
                  file.Append("puresystem/log/"..os.date("%Y_%m_%d")..".txt","\n" ..os.date().."\tUne Erreur a ete detectee, contactez le support !")
                  net.Start("EndLoeading")
                    net.WriteString("Error1")
                    net.WriteString(retourTable["error"])
                  net.Send(ply)
                  print(body)
                  return end

                  if retourTable["banned"] == true then
                      ply:Kick("Vous avez été banni de ce serveur, take time to think\nRaison: "..retourTable["raison"])
                      file.Append(PureLog,"\n".. os.date().."\tConnexion du Joueur : "..ply:Name().." avec Steamid : "..steamid.." refusee, il a ete ban du serveur !")
                  end

                print("PureSystem: Donnees du joueur " .. pseudo .. " chargees avec succes - Reputation: " .. retourTable["reputation"] .. ", Reputation RP: " .. retourTable["reputationrp"])
				        ply:SetNWInt('reputation',retourTable["reputation"])

                if retourTable["reputationrp"] != "new" then
				              ply:SetNWInt('reputationrp',retourTable["reputationrp"])
                end



                if (retourTable["reputation"] < PURE.minauthorisedrep) or (retourTable["reputation"] >  PURE.maxauthorisedrep) then
                    ply:Kick("Votre Reputation ne convient pas a ce serveur, elle doit être entre " .. PURE.minauthorisedrep .. " et " .. PURE.maxauthorisedrep)
                    file.Append(PureLog,"\n" .. os.date().."\tConnexion du Joueur : "..ply:Name().." avec Steamid : "..steamid.." refusee, sa reputation ne convenait pas !")
                end

                if (retourTable["reputationrp"] == "new") and (PURE.authorisenewplayers == false) then
                    ply:Kick("Ce serveur n'accepte pas les joueurs n'ayant pas encore de réputation RP")
                    file.Append(PureLog,"\n" .. os.date().."\tConnexion du Joueur : "..ply:Name().." avec Steamid : "..steamid.." refusee, pas encore de Reputation RolePlay !")
                end

                if (retourTable["reputationrp"] != "new") and ((retourTable["reputationrp"] < PURE.minauthorisatedrprep) or (retourTable["reputationrp"] > PURE.maxauthorisatedrprep))  then
                    ply:Kick("Votre Reputation Roleplay ne convient pas a ce serveur, elle doit être entre " .. PURE.minauthorisatedrprep .. " et " .. PURE.maxauthorisatedrprep)
                    file.Append(PureLog,"\n" .. os.date().."\tConnexion du Joueur : "..ply:Name().." avec Steamid : "..steamid.." refusee, sa Reputation Roleplay ne convenait pas !")
                end

                net.Start("EndLoeading")
                  net.WriteInt(retourTable["reputation"],8)
                  if retourTable["reputationrp"] == "new" then
                    net.WriteString("new")
                  else
                    net.WriteString("notnew")
                    net.WriteInt(retourTable["reputationrp"],8)
                  end
                net.Send(ply)
                print(body)
                ply:PrintMessage(HUD_PRINTCENTER, "Merci de votre patience !");
            end,

            function( error )
              print("Un probleme est survenu lors du contact avec l'API PureSysteme, elle est probablement inactive")
              file.Append("puresystem/log/"..os.date("%Y_%m_%d")..".txt","\n" ..os.date().."\tUne Erreur a ete detectee, contactez le support !")
              net.Start("EndLoeading")
                net.WriteString("Error2")
              net.Send(ply)
              print(body)
              ply:ChatPrint("[PS] Votre serveur n'est pas reference sur le Pure Systeme ou une erreur s'est produite")
            end
        );
	end

	net.Receive("PConnect",function(len,ply)
    local pseudo = ply:Name()
    local steamidArg = ply:SteamID()
    local steamid64 = ply:SteamID64()

    connexionPlayer(pseudo, steamidArg, steamid64, ply)
	   file.Append(PureLog,
		   "\n"..os.date().."\tConnexion du joueur : " .. ply:Name() .. " avec SteamID : "..steamidArg.." realisee avec succes !")
	end)

  hook.Add("PlayerInitialSpawn","OpenPureLoading",function(ply)
    net.Start("OpenPureLoading")
    net.Send(ply)
    ply:SetNWInt("St64",ply:SteamID64())
    ply:SetNWInt("timenserv",os.time())
  end)

	hook.Add("PlayerDisconnected","Player_Disc",function(ply)
		steamid = ply:SteamID()
		file.Append(PureLog,
			"\n"..os.date().."\tDeconnexion du joueur : " .. ply:Name() .. " avec SteamID : "..steamid.." se deconnecte !")
	end)
end
