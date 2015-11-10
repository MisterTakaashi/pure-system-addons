ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "purejail"
ENT.Author = "PureSystem"
ENT.Spawnable = false

function ENT:CanTool()
    return false
end

function ENT:PhysgunPickup(ply)
    return false
end
