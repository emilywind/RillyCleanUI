OnPlayerLogin(function()
  if ( not C_AddOns.IsAddOnLoaded('BigDebuffs') ) then return end

  -- Nameplates
  hooksecurefunc(BigDebuffs, 'NAME_PLATE_UNIT_ADDED', function(self, _, unit)
    local namePlate = C_NamePlate.GetNamePlateForUnit(unit)
    if (namePlate:IsForbidden()) then return end

    local bdbFrame = namePlate.UnitFrame
    local bdbNameplate = bdbFrame.BigDebuffs

    if (bdbNameplate) then
      applyEuiBackdrop(bdbNameplate)
    end
  end)
end)
