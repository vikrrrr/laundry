ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName = "Clean Laundry Cart"
ENT.Author = "vikR"
ENT.Category = "Laundry Job"
ENT.Contact = "none"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "ClothesNumber")
end