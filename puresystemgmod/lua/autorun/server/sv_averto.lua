util.AddNetworkString( "averto" )
util.AddNetworkString( "kickto" )
util.AddNetworkString( "banto" )

net.Receive( "averto", function( len, ply )
    addAverto( ply, net.ReadEntity(), net.ReadString() ,net.ReadInt( 4 ),net.ReadBool() )
end )

net.Receive( "kickto", function( len, ply )
    addKickto( ply, net.ReadEntity(), net.ReadString(), net.ReadInt( 4 ),net.ReadBool() )
end)

net.Receive( "banto", function( len, ply )
    addBanto( ply, net.ReadEntity(), net.ReadString(), net.ReadInt( 4 ), net.ReadFloat(),net.ReadBool() )
end)

function addAverto(admin, target, detail, sev, rp)
    //print( admin:Nick().." vient de mettre un avertissement à "..target:Nick()..". Détails : "..detail)
    for k, ply in pairs( player.GetAll() ) do
    	ply:ChatPrint("[PS] " .. admin:Nick().." vient de mettre un avertissement de sévérité ".. tostring(sev) .." à "..target:Nick()..". Raison : "..detail)
    end

    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    http.Fetch( "http://puresystem.fr/api/rest/avertissement.php?pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64() .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."&raison=".. detail .."&severite=".. sev .."&relatifrp=".. tostring(rp) .."",
    function( body, len, headers, code )
        print("[PS] Avertissement envoyé au serveur !")
        getNewreput(target)
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
end

function addKickto(admin, target, raison, sev, rp)
    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    http.Fetch( "http://puresystem.fr/api/rest/kick.php?pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64() .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."&raison=".. raison .."&severite=".. sev .."&relatifrp=".. tostring(rp) .."",
    function( body, len, headers, code )
        print("[PS] Kick envoyé au serveur !")
        for k, ply in pairs( player.GetAll() ) do
        	ply:ChatPrint("[PS] " .. admin:Nick().." vient kicker "..target:Nick()..". Raison : "..raison)
        end
        target:Kick("Kick par administrateur\nRaison: " .. raison)
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
end

function addBanto(admin, target, raison, sev, temp, rp)
    //print( admin:Nick().." abat le marteau du ban sur "..target:Nick().." de sévérité "..sev.." pour la raison : "..raison..". Pour une durée de : "..temp.." minutes" )
    --ply:Ban(temp)
    --ply:Kick("Vous avez été banni : "..temp.." minutes pour la raison : "..raison)
    temp = temp * 60

    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    http.Fetch( "http://puresystem.fr/api/rest/ban.php?pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64() .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."&raison=".. raison .."&severite=".. sev .."&duree=".. temp .."&relatifrp=".. tostring(rp) .."",
    function( body, len, headers, code )
        print("[PS] Kick envoyé au serveur !")
        for k, ply in pairs( player.GetAll() ) do
        	ply:ChatPrint("[PS] " .. admin:Nick().." vient de bannir "..target:Nick().." pour ".. (temp / 60) .." minute(s). Raison : "..raison)
        end
        target:Kick("Banni par administrateur\nDurée: " .. (temp / 60) .. " minutes\nRaison: " .. raison)
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
end

function getNewreput(target)
    http.Fetch( "http://puresystem.fr/api/rest/getinfos.php?pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64(),
    function( body, len, headers, code )
        TheReturnedHTML = body
        local retourTable = util.JSONToTable(TheReturnedHTML)

        target:ChatPrint("[PS] Réputation: " .. retourTable["reputation"])
        target:ChatPrint("[PS] Réputation RolePlay: " .. retourTable["reputationrp"])

        target:SetNWInt('reputation',retourTable["reputation"])
        target:SetNWInt('reputationrp',retourTable["reputationrp"])
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
end
