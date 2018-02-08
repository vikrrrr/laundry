AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:SpawnFunction(ply, tr, cn)
	local ang = ply:GetAngles()
	local ent = ents.Create(cn)
	ent:SetPos(tr.HitPos + tr.HitNormal + Vector(0,0,60))
	ent:SetAngles(Angle(0, ang.y, 0) - Angle(0, 90, 0))
	ent:Spawn()

	return ent
end

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_cart001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(act, cal)
	if not self.ClothTable then return end
	if not (#self.ClothTable > 0) then return end
	if not cal:IsValid() then return end

	cal:addMoney(#self.ClothTable * LaundryConfig.MoneyPerCloth)

	local phrase = string.gsub(LaundryConfig.PhraseNotifyText, "<clothes>", tostring(#self.ClothTable))
	phrase = string.gsub(phrase, "<money>", tostring(#self.ClothTable * LaundryConfig.MoneyPerCloth) .. GAMEMODE.Config.currency)

	DarkRP.notify(cal, 0, 7, phrase)
	
	for _, ent in pairs(self.ClothTable) do
		ent:Remove()
	end
end

function ENT:Think()
	local pos = self:LocalToWorld(self:OBBCenter())
	local ang = self:GetAngles()
	local entnum = 0
	self.ClothTable = { }

	for _, ent in pairs(ents.FindInSphere(pos + (ang:Forward() * 20), 20)) do
		if ent:GetClass() == "cloth" and not table.HasValue(self.ClothTable, ent) then
			if ent:GetClean() then
				table.insert(self.ClothTable, ent)
			end
		end
	end

	for _, ent in pairs(ents.FindInSphere(pos - (ang:Forward() * 20), 20)) do
		if ent:GetClass() == "cloth" then
			if ent:GetClean() and not table.HasValue(self.ClothTable, ent) then
				table.insert(self.ClothTable, ent)
			end
		end
	end

	for _, ent in pairs(self.ClothTable) do
		entnum = entnum + 1
	end

	self:SetClothesNumber(entnum)

	self:NextThink(CurTime() + 0.1)
	return true
end
