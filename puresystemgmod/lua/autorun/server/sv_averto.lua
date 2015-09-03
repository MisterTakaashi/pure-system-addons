AddCSLuaFile()
include("autorun/pure_config.lua")
util.AddNetworkString( "averto" )
util.AddNetworkString( "kickto" )
util.AddNetworkString( "banto" )
util.AddNetworkString( "bantosteamid" )
util.AddNetworkString( "afkick" )
util.AddNetworkString( "rcgu" )
util.AddNetworkString( "freezetk" )
util.AddNetworkString( "unfreezetk" )
util.AddNetworkString( "sunfrezz" )

for k,v in pairs(player.GetAll()) do
    v:SetNWBool("freezed",false)
end

local PureLog = "puresystem/log/"..os.date("%Y_%m_%d")..".txt"

net.Receive( "averto", function( len, ply )
    if !(table.HasValue(PURE.authgrp, ply:GetUserGroup())) then return end
    addAverto( ply, net.ReadEntity(), net.ReadString() ,net.ReadInt( 4 ),net.ReadBool() )
end )

net.Receive( "kickto", function( len, ply )
    if !(table.HasValue(PURE.authgrp, ply:GetUserGroup())) then return end
    addKickto( ply, net.ReadEntity(), net.ReadString(), net.ReadInt( 4 ),net.ReadBool() )
end)

net.Receive( "banto", function( len, ply )
    if !(table.HasValue(PURE.authgrp, ply:GetUserGroup())) then return end
    addBanto( ply, net.ReadEntity(), net.ReadString(), net.ReadInt( 4 ), net.ReadFloat(),net.ReadBool() )
end)

net.Receive( "bantosteamid", function( len, ply )
    if !(table.HasValue(PURE.authgrp, ply:GetUserGroup())) then return end
    addBantoSteamID( ply, net.ReadString(), net.ReadString(), net.ReadInt( 4 ), net.ReadFloat(),net.ReadBool() )
end)

net.Receive( "afkick", function(len, ply)
    if !(table.HasValue(PURE.authgrp, ply:GetUserGroup())) then return end
    addAFKick(ply, net.ReadEntity(),net.ReadString())
end)

net.Receive( "rcgu", function(len, ply)
    ply:Kick("Vous n'avez pas accepte les CGU")
    file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..ply:Name().." avec le SteamID : "..ply:SteamID().." n'a pas accepte les conditions generales d'utilisation et a ete Kick")
end)

net.Receive( "freezetk", function(len,ply)
    if !(table.HasValue(PURE.authgrp, ply:GetUserGroup())) then return end
    targ = net.ReadEntity()
    targ:Freeze(true)
    targ:ChatPrint("Une sanction va tomber ! Vous êtes freeze !")
    targ:SetNWBool("frezzed",true)
end)

net.Receive( "unfreezetk", function(len,ply)
    if !(table.HasValue(PURE.authgrp, ply:GetUserGroup())) then return end
    targ = net.ReadEntity()
    targ:Freeze(false)
    targ:ChatPrint("Vous avez été unfreeze !")
    targ:SetNWBool("frezzed",false)
end)

net.Receive( "sunfrezz", function()
    for k,v in pairs(player.GetAll()) do
        if v:GetNWBool( "frezzed" ) == true then
            v:SetNWBool( "frezzed", false )
            v:Freeze(false)
            v:ChatPrint("Vous avez été unfreeze")
        end
    end
end)


local function addAverto(admin, target, detail, sev, rp)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end
    //print( admin:Nick().." vient de mettre un avertissement à "..target:Nick()..". Détails : "..detail)
    for k, ply in pairs( player.GetAll() ) do
        ply:ChatPrint("[PS] " .. admin:Nick().." vient de mettre un avertissement de sévérité ".. tostring(sev) .." à "..target:Nick()..". Raison : "..detail)
    end

    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    http.Fetch( "http://puresystem.fr/api/rest/avertissement.php?port= "..PURE.port.."&pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64() .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."&raison=".. detail .."&severite=".. sev .."&relatifrp=".. tostring(rp) .."",
    function( body, len, headers, code )
        print("[PS] Avertissement envoyé au serveur !")
        getNewreput(target)
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
    file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..target:Name().." avec le SteamID : "..target:SteamID().." a recu un Avertissement par : "..admin:Nick())
end

local function addKickto(admin, target, raison, sev, rp)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end
    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    http.Fetch( "http://puresystem.fr/api/rest/kick.php?port="..PURE.port.."&pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64() .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."&raison=".. raison .."&severite=".. sev .."&relatifrp=".. tostring(rp) .."",
    function( body, len, headers, code )
        print("[PS] Kick envoyé au serveur !")
        for k, ply in pairs( player.GetAll() ) do
            ply:ChatPrint("[PS] " .. admin:Nick().." vient kicker "..target:Nick()..". Raison : "..raison)
        end
        file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..target:Name().." avec le SteamID : "..target:SteamID().." a ete Kick du serveur par : "..admin:Nick())
        target:Kick("Kick par administrateur\nRaison: " .. raison)
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
end

local function addBanto(admin, target, raison, sev, temp, rp)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end
    //print( admin:Nick().." abat le marteau du ban sur "..target:Nick().." de sévérité "..sev.." pour la raison : "..raison..". Pour une durée de : "..temp.." minutes" )
    --ply:Ban(temp)
    --ply:Kick("Vous avez été banni : "..temp.." minutes pour la raison : "..raison)
    temp = temp * 60

    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    http.Fetch( "http://puresystem.fr/api/rest/ban.php?port="..PURE.port.."&pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64() .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."&raison=".. raison .."&severite=".. sev .."&duree=".. temp .."&relatifrp=".. tostring(rp) .."",
    function( body, len, headers, code )
        print("[PS] Kick envoyé au serveur !")
        for k, ply in pairs( player.GetAll() ) do
            if temp != 0 then
                ply:ChatPrint("[PS] " .. admin:Nick().." vient de bannir "..target:Nick().." pour ".. (temp / 60) .." minute(s). Raison : "..raison)
            else
                ply:ChatPrint("[PS] " .. admin:Nick().." vient de bannir "..target:Nick().." de facon permanente. Raison : "..raison)
            end
        end
        target:Kick("Banni par administrateur\nDurée: " .. (temp / 60) .. " minutes\nRaison: " .. raison)

    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
    file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..target:Name().." avec le SteamID : "..target:SteamID().." a ete Banni du serveur par : "..admin:Nick())
end

local function addBantoSteamID(admin, steamid, raison, sev, temp, rp)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end
    temp = temp * 60

    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    print("Je demande la page: \n\nhttp://puresystem.fr/api/rest/ban.php?port="..PURE.port.."&steamid64=".. steamid .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."&raison=".. raison .."&severite=".. sev .."&duree=".. temp .."&relatifrp=".. tostring(rp) .."")

    http.Fetch( "http://puresystem.fr/api/rest/ban.php?port="..PURE.port.."&steamid64=".. steamid .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."&raison=".. raison .."&severite=".. sev .."&duree=".. temp .."&relatifrp=".. tostring(rp) .."",
    function( body, len, headers, code )
        print("[PS] Kick envoyé au serveur !")
        for k, ply in pairs( player.GetAll() ) do
            if (ply:SteamID() == steamid) then
                ply:Kick("Banni par administrateur\nDurée: " .. (temp / 60) .. " minutes\nRaison: " .. raison)
            end

            if temp != 0 then
                ply:ChatPrint("[PS] " .. admin:Nick().." vient de bannir "..steamid.." pour ".. (temp / 60) .." minute(s). Raison : "..raison)
            else
                ply:ChatPrint("[PS] " .. admin:Nick().." vient de bannir "..steamid.." de facon permanente. Raison : "..raison)
            end
        end
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );

    for k,v in pairs(player.GetAll()) do
        if (v:SteamID() == steamid) then
            v:Kick("Kick par administrateur\nRaison: " .. raison)
        end
    end

    file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..steamid.." a ete Banni du serveur par : "..admin:Nick())
end

local function addAFKick(admin,target,raison)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end
    target:Kick("Kick par administrateur\nRaison : "..raison)
    file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..target:Name().." avec SteamID : "..target:SteamID().." a ete kick du serveur par : "..admin:Nick())
end

local function getNewreput(target)
    http.Fetch( "http://puresystem.fr/api/rest/getinfos.php?port="..PURE.port.."&pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64(),
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
