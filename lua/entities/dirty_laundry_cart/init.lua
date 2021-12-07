AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:SpawnFunction(ply, tr, cn)
	local ang = ply:GetAngles()
	local ent = ents.Create(cn)
	ent:SetPos(tr.HitPos + tr.HitNormal + Vector(0,0,40))
	ent:SetAngles(Angle(0, ang.y, 0) - Angle(0, 90, 0))
	ent:Spawn()

	return ent
end

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_basket001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	timer.Create("AddClothTimer"..self:EntIndex(), LaundryConfig.DirtyClothDelay, 0, function()
		if self:GetClothesNumber() >= LaundryConfig.DirtyCartMaxCloth then return end
		self:SetClothesNumber(self:GetClothesNumber() + 1) 
	end )
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(act, cal)
	if self:GetClothesNumber() <= 0 then return end

	local pos = self:LocalToWorld(self:OBBCenter())
	local ang = self:GetAngles()

	local cloth = ents.Create("cloth")
	if not cloth:IsValid() then return end
	cloth:SetPos(pos + (ang:Up() * 30))
	cloth:SetAngles(self:GetAngles())
	if math.random(1, 4) == 4 then
		cloth:SetClothType(2)
	else
		cloth:SetClothType(1)
	end
	cloth:SetClean(false)
	cloth:Spawn()

	self:SetClothesNumber(self:GetClothesNumber() - 1)
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	if timer.Exists("AddClothTimer"..self:EntIndex()) then
		timer.Remove("AddClothTimer"..self:EntIndex())
	end
end