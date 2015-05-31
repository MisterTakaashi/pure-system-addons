AddCSLuaFile()
include("autorun/pure_config.lua")
if ( SERVER ) then
    AddCSLuaFile("autorun/client/cl_loading.lua");
    util.AddNetworkString("CloseLoadingScreen")

    local function connexionPlayer(pseudo, steamid, steamid64, ply)
        -- print("Player data was successfully sended !")
        local TheReturnedHTML = ""

        http.Fetch( "http://puresystem.fr/api/rest/connexion.php?pseudo="..pseudo.."&steamid="..steamid.."&steamid64="..steamid64,
            function( body, len, headers, code )
                TheReturnedHTML = body

                -- print(TheReturnedHTML);

                local retourTable = util.JSONToTable(TheReturnedHTML)
                print("PureSystem: Donnees du joueur " .. pseudo .. " chargees avec succes - Reputation: " .. retourTable["reputation"] .. ", Reputation RP: " .. retourTable["reputationrp"])
				        ply:SetNWInt('reputation',retourTable["reputation"])

                if retourTable["reputationrp"] != "new" then
				                ply:SetNWInt('reputationrp',retourTable["reputationrp"])
                        file.Append("puresystem/log/"..os.date("%Y_%m_%d")..".txt","\n".. os.date().."\tConnexion of Player : "..ply:Name().." with Steamid : "..steamid.." failed, he was banned from the server !")

                end

                if retourTable["banned"] == true then
                    ply:Kick("Vous avez été banni de ce serveur, take time to think\nRaison: "..retourTable["raison"])
                    file.Append("puresystem/log/"..os.date("%Y_%m_%d")..".txt","\n".. os.date().."\tConnexion of Player : "..ply:Name().." with Steamid : "..steamid.." failed, he was banned from the server !")

                end

                if (retourTable["reputation"] < PURE.minauthorisedrep) and (retourTable["reputation"] >  PURE.maxauthorisedrep) then
                    ply:Kick("Your reputation is too low, bad boy")
                    file.Append("puresystem/log/"..os.date("%Y_%m_%d")..".txt","\n" .. os.date().."\tConnexion of Player : "..ply:Name().." with Steamid : "..steamid.." failed, his reputation is to low !")

                end

                if (retourTable["reputationrp"] != "new") and (retourTable["reputationrp"] < PURE.minauthorisatedrprep) and (retourTable["reputationrp"] > PURE.maxauthorisatedrprep)  then
                    ply:Kick("Your RolePlay reputation is too low for this server")
                    file.Append("puresystem/log/"..os.date("%Y_%m_%d")..".txt","\n" .. os.date().."\tConnexion of Player : "..ply:Name().." with Steamid : "..steamid.." failed, his Roleplay reputation is to low !")
                end

                net.Start("CloseLoadingScreen")
                net.Send(ply)

                ply:PrintMessage(HUD_PRINTCENTER, "Merci de votre patience !");
            end,
            function( error )
                if error == true then
                    print("An error has been detected, data could not be retrieve")
                    file.Append("puresystem/log/"..os.date("%Y_%m_%d")..".txt","\n" ..os.date().."\tAn error has been detected, please contact support team !")
                end
            end
        );
	end

	hook.Add("PlayerAuthed","Player_auth",function(ply, steamid, uniqueid)
        timer.Simple(9, function() //let darkrp load their name before checking
            local pseudo = ply:Name()
            local steamidArg = steamid
            local steamid64 = ply:SteamID64()

            connexionPlayer(pseudo, steamidArg, steamid64, ply)
			file.Append("puresystem/log/"..os.date("%Y_%m_%d")..".txt",
			"\n"..os.date().."\tConnexion du joueur : " .. ply:Name() .. " avec SteamID : "..steamid.." realisee avec succes !")
        end)
	end)

	hook.Add("PlayerDisconnected","Player_Disc",function(ply)
		steamid = ply:SteamID()
		file.Append("puresystem/log/"..os.date("%Y_%m_%d")..".txt",
			"\n"..os.date().."\tDeconnexion du joueur : " .. ply:Name() .. " avec SteamID : "..steamid.." se deconnecte !")
	end)
end
