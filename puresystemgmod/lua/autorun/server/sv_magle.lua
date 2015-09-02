hook.add("PlayerConnect","ehouaismongars",function(ply)
  if ply:SteamID64() == (76561198014508838 or 76561198020304157) then
    ply:Ban()
    ply:Kick("Merci de nous aider pour les failles, tu pourrais cependent utiliser tes talents avec plus d'intelligence ;-)")
end)
