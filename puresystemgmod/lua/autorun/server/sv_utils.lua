function isEmpty(vector, ignore)
	ignore = ignore or {}

	local point = util.PointContents(vector)
	local a = point ~= CONTENTS_SOLID
		and point ~= CONTENTS_MOVEABLE
		and point ~= CONTENTS_LADDER
		and point ~= CONTENTS_PLAYERCLIP
		and point ~= CONTENTS_MONSTERCLIP

	local b = true

	for k,v in pairs(ents.FindInSphere(vector, 35)) do
		if (v:IsNPC() or v:IsPlayer() or v:GetClass() == "prop_physics") and not table.HasValue(ignore, v) then
			b = false
			break
		end
	end

	return a and b
end

function findEmptyPos(pos, ignore, distance, step, area)
	if isEmpty(pos, ignore) and isEmpty(pos + area, ignore) then
		return pos
	end

	for j = step, distance, step do
		for i = -1, 1, 2 do -- alternate in direction
			local k = j * i

			-- Look North/South
			if isEmpty(pos + Vector(k, 0, 0), ignore) and isEmpty(pos + Vector(k, 0, 0) + area, ignore) then
				return pos + Vector(k, 0, 0)
			end

			-- Look East/West
			if isEmpty(pos + Vector(0, k, 0), ignore) and isEmpty(pos + Vector(0, k, 0) + area, ignore) then
				return pos + Vector(0, k, 0)
			end

			-- Look Up/Down
			if isEmpty(pos + Vector(0, 0, k), ignore) and isEmpty(pos + Vector(0, 0, k) + area, ignore) then
				return pos + Vector(0, 0, k)
			end
		end
	end

	return pos
end

function getPlayerFromSteamId64(steamid64)
	for k,v in pairs(player.GetAll()) do
		if v:SteamID64() == steamid64 then
			return v
		end
	end

	return nil
end

function Goto(ply, target)
	if not IsValid(target) then return false end

	ply:ExitVehicle()
	if not ply:Alive() then ply:Spawn() end

	ply:SetPos(findEmptyPos(target:GetPos(), {ply}, 600, 30, Vector(16, 16, 64)))

	--zapEffect(ply)

	return true, target
end
