AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

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
    local numCloth = #self.ClothTable

	if not self.ClothTable or numCloth < 1 or not cal:IsValid() then return end

    local reward = numCloth * LaundryConfig.MoneyPerCloth

	cal:addMoney(reward)

	DarkRP.notify(cal, 0, 7, string.format(LaundryConfig.PhraseNotifyText, DarkRP.formatMoney(reward), numCloth))
	
	for _, ent in pairs(self.ClothTable) do
		ent:Remove()
	end
end

function ENT:Think()
	local ang = self:GetAngles()

	self.ClothTable = {}

	for _, ent in pairs(ents.FindInSphere(self:LocalToWorld(self:OBBCenter()) + (ang:Forward() * 20), 20)) do
		if ent:GetClass() == "cloth" and ent:GetClean() and not table.HasValue(self.ClothTable, ent) then
			table.insert(self.ClothTable, ent)
		end
	end

	self:SetClothesNumber(#self.ClothTable)

	self:NextThink(CurTime() + 1)
	return true
end