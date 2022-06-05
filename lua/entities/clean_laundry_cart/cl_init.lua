include("shared.lua")

local colWhite = Color(255, 255, 255)
local superAngle = Angle(0, 0, 90)

function ENT:Draw()
    self:DrawModel()

	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 500 ^ 2 then return end

    local ang = self:GetAngles()

    cam.Start3D2D(self:LocalToWorld(self:OBBCenter()) + (ang:Up() * 5) + (ang:Right() * 21), ang + superAngle, 0.25)
        draw.SimpleText(string.format(LaundryConfig.PhraseCleanClothes, self:GetClothesNumber()), "DermaLarge", 0, 0, colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end