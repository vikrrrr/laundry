include("shared.lua")

local colWhite = Color(255, 255, 255)

function ENT:Draw()
    self:DrawModel()

    local ang = self:GetAngles()

    cam.Start3D2D(self:LocalToWorld(self:OBBCenter()) + (ang:Up() * 5) + (ang:Right() * 25), ang + Angle(0, 0, 90), 0.25)
        draw.SimpleText(string.format(LaundryConfig.PhraseDirtyClothes, self:GetClothesNumber()), "DermaLarge", 0, 0, colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end