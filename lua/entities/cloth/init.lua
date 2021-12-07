AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:SpawnFunction(ply, tr, cn)
	local ent = ents.Create(cn)
	ent:SetPos(tr.HitPos + tr.HitNormal)
    ent:SetClothType(math.random(1, 4) == 4 and 2 or 1)
	ent:SetClean(false)
	ent:Spawn()

	return ent
end

local colOrange = Color(255,125,0)
local colBlue = Color(0,50,255)

function ENT:Initialize()
	self:SetModel("models/props_junk/garbage_newspaper001a.mdl")
    self:SetMaterial(self:GetClean() and "models/debug/debugwhite" or "models/props_pipes/GutterMetal01a")
    self:SetColor(self:GetClothType() == 1 and colOrange or colBlue)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end