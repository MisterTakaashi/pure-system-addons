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
util.AddNetworkString( "avertgot" )



for k,v in pairs(player.GetAll()) do
    v:SetNWBool("freezed",false)
    v:SetNWBool("jailed",false)
end

local PureLog = "puresystem/log/"..os.date("%Y_%m_%d")..".txt"

local function AJail(ply,ajtime)
  if ply:GetNWBool("jailed") ==  true or not ply:IsValid() then
    return
  end
  local targets = {}
  local pjt = ajtime
  print("ajtime = ".. pjt)
  local jailDist = 70
  table.insert(targets,ply)

  for _,target in pairs(targets) do
    if target:GetNWBool("jailed") == true then return end
    target:ExitVehicle()

    target:SetNWBool("jailed",true)
    target.jailpos = target:GetPos()
    target.jailprops = {}
    target.weapons = {}
    for k,v in pairs(target:GetWeapons()) do
      table.insert(target.weapons,v:GetClass())
    end

    target:StripWeapons()

    local ajailprops = {
      {pos = Vector(0,0,-5), ang = Angle(90,0,0), model = "models/props_building_details/Storefront_Template001a_Bars.mdl"},
      {pos = Vector(0,0,97), ang = Angle(90,0,0), model = "models/props_building_details/Storefront_Template001a_Bars.mdl"},
      {pos = Vector(21,31,46), ang = Angle(0,90,0), model = "models/props_building_details/Storefront_Template001a_Bars.mdl"},
      {pos = Vector(21,-31,46), ang = Angle(0,90,0), model = "models/props_building_details/Storefront_Template001a_Bars.mdl"},
      {pos = Vector(-21,31,46), ang = Angle(0,90,0), model = "models/props_building_details/Storefront_Template001a_Bars.mdl"},
      {pos = Vector(-21,-31,46), ang = Angle(0,90,0), model = "models/props_building_details/Storefront_Template001a_Bars.mdl"},
      {pos = Vector(-52,0,46), ang = Angle(0,0,0), model = "models/props_building_details/Storefront_Template001a_Bars.mdl"},
      {pos = Vector(52,0,46), ang = Angle(0,0,0), model = "models/props_building_details/Storefront_Template001a_Bars.mdl"}
    }

    for k,v in pairs(ajailprops) do
        local ajailprop = ents.Create("purejail")
        ajailprop:SetPos(target:GetPos() + v.pos)
        ajailprop:SetAngles(v.ang)
        ajailprop:SetModel(v.model)
        ajailprop:Spawn()
        ajailprop:Activate()
        ajailprop.target = target
        ajailprop.targetPos = target.jailpos
        target.jailprops[ajailprop] = true
      end

      if pjt > 0 then
        timer.Create("Ajtime"..target:UserID(), pjt, 1, function()
          if ply:GetNWBool("jailed") == false then return end
          ply:SetNWBool("jailed",false)
          print("Tu est relache de prison")
          timer.Remove("Ajail_check" ..ply:UserID())
          for k, v in pairs(target.jailprops) do
            if not IsValid(k) then continue end
            k:Remove()
          end
          for k,v in pairs(target.weapons) do
            ply:Give(v)
          end
        end)


        timer.Create("Ajail_check" ..target:UserID() ,1,0,function()
          if not IsValid(ply) or ply:GetNWBool("jailed") == false  then
            timer.Remove("Ajail_check" ..ply:UserID() )
            return
          end
          if target:GetPos():DistToSqr(target.jailpos) > jailDist then
            target:SetPos(target.jailpos)
          end
        end)
      end
end
end

hook.Add("PlayerSpawn","PureJailSC",function(ply)
  if ply:GetNWBool("jailed") == true then
  end
end)

net.Receive( "averto", function( len, ply )
    if !(table.HasValue(PURE.authgrp, ply:GetUserGroup())) then return end
    addAverto( ply, net.ReadEntity(), net.ReadString() ,net.ReadInt( 4 ),net.ReadBool(),net.ReadBool(),net.ReadInt(8) )
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

 function addAverto(admin, target, detail, sev, rp, ajail, ajtime)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end
    //print( admin:Nick().." vient de mettre un avertissement à "..target:Nick()..". Détails : "..detail)

    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    net.Start("avertgot")
      net.WriteString(admin:Nick())
      net.WriteString(detail)
    net.Send(target)

    if ajail == true then
      AJail(target,ajtime)
    end

    local params = {}
    params["port"] = PURE.port
    params["pseudo"] = target:Nick()
    params["steamid"] = target:SteamID()
    params["steamid64"] = target:SteamID64()
    params["admin_pseudo"] = admin:Nick()
    params["admin_steamid"] = admin:SteamID()
    params["admin_steamid64"] = admin:SteamID64()
    params["raison"] = detail
    print("Severite: " .. tostring(sev))
    params["severite"] = tostring(sev)
    params["relatifrp"] = tostring(rp)

    http.Post( "http://puresystem.fr/api/rest/avertissement.php", params,
    function( body, len, headers, code )
		local retourTable = util.JSONToTable(body)
        if retourTable["error"] == false then
			print("[PS] Avertissement envoyé au serveur !")
			for k, ply in pairs( player.GetAll() ) do
				ply:ChatPrint("[PS] " .. admin:Nick().." vient de mettre un avertissement de sévérité ".. tostring(sev) .." à "..target:Nick()..". Raison : "..detail)
			end
			getNewreput(target)
        else
            admin:ChatPrint( retourTable["error"] )
		end
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
    file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..target:Name().." avec le SteamID : "..target:SteamID().." a recu un Avertissement par : "..admin:Nick())
end

function addKickto(admin, target, raison, sev, rp)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end
    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    local params = {}
    params["port"] = PURE.port
    params["pseudo"] = target:Nick()
    params["steamid"] = target:SteamID()
    params["steamid64"] = target:SteamID64()
    params["admin_pseudo"] = admin:Nick()
    params["admin_steamid"] = admin:SteamID()
    params["admin_steamid64"] = admin:SteamID64()
    params["raison"] = raison
    params["severite"] = tostring(sev)
    params["relatifrp"] = tostring(rp)

    http.Post( "http://puresystem.fr/api/rest/kick.php", params,
    function( body, len, headers, code )
		local retourTable = util.JSONToTable(body)
        if retourTable["error"] == false then
			print("[PS] Kick envoyé au serveur !")
			for k, ply in pairs( player.GetAll() ) do
				ply:ChatPrint("[PS] " .. admin:Nick().." vient kicker "..target:Nick()..". Raison : "..raison)
			end
			file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..target:Name().." avec le SteamID : "..target:SteamID().." a ete Kick du serveur par : "..admin:Nick())
			target:Kick("Kick par administrateur\nRaison: " .. raison)
        else
            admin:ChatPrint( retourTable["error"] )
		end
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
end

function addBanto(admin, target, raison, sev, temp, rp)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end
    //print( admin:Nick().." abat le marteau du ban sur "..target:Nick().." de sévérité "..sev.." pour la raison : "..raison..". Pour une durée de : "..temp.." minutes" )
    --ply:Ban(temp)
    --ply:Kick("Vous avez été banni : "..temp.." minutes pour la raison : "..raison)
    temp = temp * 60

    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    local params = {}
    params["port"] = PURE.port
    params["pseudo"] = target:Nick()
    params["steamid"] = target:SteamID()
    params["steamid64"] = target:SteamID64()
    params["admin_pseudo"] = admin:Nick()
    params["admin_steamid"] = admin:SteamID()
    params["admin_steamid64"] = admin:SteamID64()
    params["raison"] = raison
    params["severite"] = tostring(sev)
    params["duree"] = tostring(temp)
    params["relatifrp"] = tostring(rp)

    http.Post( "http://puresystem.fr/api/rest/ban.php", params,
    function( body, len, headers, code )
		local retourTable = util.JSONToTable(body)
        if retourTable["error"] == false then
			print("[PS] Kick envoyé au serveur !")
			for k, ply in pairs( player.GetAll() ) do
				if temp != 0 then
					ply:ChatPrint("[PS] " .. admin:Nick().." vient de bannir "..target:Nick().." pour ".. (temp / 60) .." minute(s). Raison : "..raison)
				else
					ply:ChatPrint("[PS] " .. admin:Nick().." vient de bannir "..target:Nick().." de facon permanente. Raison : "..raison)
				end
			end
			target:Kick("Banni par administrateur\nDurée: " .. (temp / 60) .. " minutes\nRaison: " .. raison)
        else
            admin:ChatPrint( retourTable["error"] )
		end
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
    file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..target:Name().." avec le SteamID : "..target:SteamID().." a ete Banni du serveur par : "..admin:Nick())
end

function addBantoSteamID(admin, steamid, raison, sev, temp, rp)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end
    temp = temp * 60

    if (tostring(rp) == "true") then rp = 1 else rp = 0 end

    print("Je demande la page: \n\nhttp://puresystem.fr/api/rest/ban.php?port="..PURE.port.."&steamid64=".. steamid .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."&raison=".. raison .."&severite=".. sev .."&duree=".. temp .."&relatifrp=".. tostring(rp) .."")

    local params = {}
    params["port"] = PURE.port
    params["steamid64"] = steamid
    params["admin_pseudo"] = admin:Nick()
    params["admin_steamid"] = admin:SteamID()
    params["admin_steamid64"] = admin:SteamID64()
    params["raison"] = raison
    params["severite"] = tostring(sev)
    params["duree"] = tostring(temp)
    params["relatifrp"] = tostring(rp)

    http.Post( "http://puresystem.fr/api/rest/ban.php", params,
    function( body, len, headers, code )
		local retourTable = util.JSONToTable(body)
        if retourTable["error"] == false then
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

			for k,v in pairs(player.GetAll()) do
				if (v:SteamID() == steamid) then
					v:Kick("Kick par administrateur\nRaison: " .. raison)
				end
			end

			file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..steamid.." a ete Banni du serveur par : "..admin:Nick())
        else
            admin:ChatPrint( retourTable["error"] )
		end
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
end

function addAFKick(admin,target,raison)
    if !(table.HasValue(PURE.authgrp, admin:GetUserGroup())) then return end

    local params = {}
    params["port"] = PURE.port
    params["pseudo"] = target:Nick()
    params["steamid"] = target:SteamID()
    params["steamid64"] = target:SteamID64()
    params["admin_pseudo"] = admin:Nick()
    params["admin_steamid"] = admin:SteamID()
    params["admin_steamid64"] = admin:SteamID64()

    http.Post( "http://puresystem.fr/api/rest/afkick.php?port="..PURE.port.."&pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64() .."&admin_pseudo=".. admin:Nick() .."&admin_steamid=".. admin:SteamID() .."&admin_steamid64=".. admin:SteamID64() .."", params,
    function( body, len, headers, code )
		local retourTable = util.JSONToTable(body)
        if retourTable["error"] == false then
			target:Kick("Kick par administrateur\nRaison : "..raison)
            file.Append(PureLog,"\n".. os.date().."\tLe joueur : "..target:Name().." avec SteamID : "..target:SteamID().." a ete kick du serveur par : "..admin:Nick())
        else
            admin:ChatPrint( retourTable["error"] )
		end
    end,
    function( error )
        print("[PS] Impossible de contacter le serveur Pure System...")
    end
    );
end

function getNewreput(target)
    local params = {}
    params["port"] = PURE.port
    params["pseudo"] = target:Nick()
    params["steamid"] = target:SteamID()
    params["steamid64"] = target:SteamID64()

    http.Post( "http://puresystem.fr/api/rest/getinfospost.php?port="..PURE.port.."&pseudo=".. target:Nick() .."&steamid=".. target:SteamID() .."&steamid64=".. target:SteamID64(), params,
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
