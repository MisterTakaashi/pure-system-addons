// Opération on note les comptes qui nosu embete parce que c'est vachement plus marrant !

local gensEnnuyeux = {
    76561198014508838,
    76561198020304157,
    76561198242550332
}

hook.Add("PlayerConnect","ehouaismongars",function(ply)
    for k,v in pairs(gensEnnuyeux) do
        if (ply:SteamID64() == v) then
            ply:Ban(0)
            ply:Kick("Merci de nous aider pour les failles, tu pourrais cependant utiliser tes talents avec plus d'intelligence ;-)")
        end
    end
end)
