AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

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
    if (LaundryConfig.BlackOrWhiteList and LaundryConfig.Teams[team.GetName(cal:Team())]) or (not LaundryConfig.BlackOrWhiteList and not LaundryConfig.Teams[team.GetName(cal:Team())]) then
        DarkRP.notify(cal, 1, 5, LaundryConfig.PhraseCantInteract)
        return
    end
    
	if self:GetClothesNumber() <= 0 then return end

	local pos = self:LocalToWorld(self:OBBCenter())
	local ang = self:GetAngles()

	local cloth = ents.Create("cloth")
	if not cloth:IsValid() then return end
	cloth:SetPos(pos + (ang:Up() * 30))
	cloth:SetAngles(self:GetAngles())
	cloth:SetClothType(math.random(1, 4) == 4 and 2 or 1)
	cloth:SetClean(false)
	cloth:Spawn()

	self:SetClothesNumber(self:GetClothesNumber() - 1)
end

function ENT:OnRemove()
	if timer.Exists("AddClothTimer"..self:EntIndex()) then
		timer.Remove("AddClothTimer"..self:EntIndex())
	end
end