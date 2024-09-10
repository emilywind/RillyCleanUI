----------------------------------
-- Buffs/Debuffs on Unit Frames --
----------------------------------
function applyAuraSkin(aura)
  if aura.border and aura.Border then
    aura.Border:SetAlpha(1)
    aura.border:SetVertexColor(aura.Border:GetVertexColor())
    aura.Border:SetAlpha(0)
  end

  if aura.euiClean then return end

  --icon
  local icon = aura.Icon

  --border
  local border = aura:CreateTexture(aura.border, "OVERLAY")
  border:SetTexture(EUI_TEXTURES.auraBorder)

  if aura.Border then
    border:SetVertexColor(aura.Border:GetVertexColor())
    aura.Border:SetAlpha(0)
  else
    border:SetVertexColor(0,0,0)
  end

  border:ClearAllPoints()
  border:SetAllPoints(aura)
  aura.border = border

  aura.euiClean = true
end
