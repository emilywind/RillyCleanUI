OnPlayerLogin(function()
	-------------------------
	-- Hide Alt Power bars --
	-------------------------
	if (EUIDB.hideAltPower) then
		local altPowerBars = {
			PaladinPowerBarFrame,
			PlayerFrameAlternateManaBar,
			MageArcaneChargesFrame,
			MonkHarmonyBarFrame,
			MonkStaggerBar,
			RuneFrame,
			ComboPointPlayerFrame,
			WarlockPowerFrame,
			TotemFrame,
      EssencePlayerFrame,
		}

		for _, altPowerBar in pairs(altPowerBars) do
			altPowerBar:SetAlpha(0)
			RegisterStateDriver(altPowerBar, "visibility", "hide")
		end
	end

  -------------------
  -- Class Colours --
  -------------------
  TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()
  FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()

  local function setUnitColour(healthbar)
    local unit = healthbar.unit
    healthbar:SetStatusBarDesaturated(1)
    if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
      _, class = UnitClass(unit)
      local color = RAID_CLASS_COLORS[class]
      healthbar:SetStatusBarColor(color.r, color.g, color.b)
    elseif UnitIsPlayer(unit) and (not UnitIsConnected(unit)) then
      healthbar:SetStatusBarColor(0.5, 0.5, 0.5)
    else
      if UnitExists(unit) then
        if (UnitIsTapDenied(unit)) and not UnitPlayerControlled(unit) then
          healthbar:SetStatusBarColor(0.5, 0.5, 0.5)
        elseif (not UnitIsTapDenied(unit)) then
          local reaction = FACTION_BAR_COLORS[UnitReaction(unit, "player")]
          if reaction then
            healthbar:SetStatusBarColor(reaction.r, reaction.g, reaction.b)
          end
        end
      end
    end
  end

  hooksecurefunc("UnitFrameHealthBar_Update", setUnitColour)
  hooksecurefunc("HealthBar_OnValueChanged", setUnitColour)

  hooksecurefunc("PlayerFrame_UpdateStatus", function(self)
    if IsResting() then
      PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide()
    end
  end)

  local function skinTargetHealthbar(self)
    if not self or self:IsForbidden() then return end

    -- Set Textures
    self.healthbar:SetStatusBarTexture(EUIDB.healthBarTex)
    if self.myHealPrediction then
      self.myHealPredictionBar:SetTexture(EUIDB.healthBarTex)
    end
  end

  hooksecurefunc(TargetFrame, "OnEvent", function(self)
    if EUIDB.skinPlayerTargetFrame then
      skinTargetHealthbar(self)
    end

    -- Style Buffs & Debuffs
    for aura, _ in self.auraPools:EnumerateActive() do
      applyAuraSkin(aura)
    end
  end)

  hooksecurefunc(FocusFrame, "OnEvent", function(self)
    if EUIDB.skinPlayerTargetFrame then
      skinTargetHealthbar(self)
    end

    -- Style Buffs & Debuffs
    for aura, _ in self.auraPools:EnumerateActive() do
      applyAuraSkin(aura)
    end
  end)

  if not EUIDB.skinPlayerTargetFrame then return end

  local function skinPlayerFrameBars(self)
    self.healthbar:SetStatusBarTexture(EUIDB.healthBarTex)
    self.healthbar.AnimatedLossBar:SetStatusBarTexture(EUIDB.healthBarTex)

    if self.manabar then
      -- Get Power Color
      local powerColor = PowerBarColor[self.manabar.powerType]

      -- Set Texture
      self.manabar.texture:SetTexture(EUIDB.powerBarTex)
      self.manabar.FeedbackFrame.BarTexture:SetTexture(EUIDB.powerBarTex)

      -- Set Power Color
      if self.manabar.powerType == 0 then
        self.manabar:SetStatusBarColor(0, 0.5, 1)
      else
        self.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
      end
    end
  end

  PlayerFrame:HookScript('OnEvent', skinPlayerFrameBars)

  PetFrame:HookScript('OnEvent', function(self)
    self.healthbar:SetStatusBarTexture(EUIDB.healthBarTex)
  end)

  ------------------
  -- Target Frame --
  ------------------
  hooksecurefunc(TargetFrame, "OnEvent", function(self)
    skinTargetHealthbar(self)

    -- Style Buffs & Debuffs
    for aura, _ in self.auraPools:EnumerateActive() do
      applyAuraSkin(aura)
    end
  end)

  hooksecurefunc(FocusFrame, "OnEvent", function(self)
    -- Set Health Texture
    skinTargetHealthbar(self)

    -- Style Buffs & Debuffs
    for aura, _ in self.auraPools:EnumerateActive() do
      applyAuraSkin(aura)
    end
  end)

  hooksecurefunc(TargetFrameToT, "Update", skinTargetHealthbar)

  hooksecurefunc(FocusFrameToT, "Update", skinTargetHealthbar)

  -----------------
  -- Boss Frames --
  -----------------
  function skinBossFrames(self)
    if not self then return end

    if self.healthbar then
      self.healthbar:SetStatusBarTexture(EUIDB.healthBarTex)
    end

    if self.TargetFrameContent.TargetFrameContentMain.ReputationColor then
      self.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(getFrameColour())
    end
  end

  for i = 1, 5 do
    _G['Boss'..i..'TargetFrame']:HookScript('OnEvent', skinBossFrames)
  end

  ------------------------
  -- Mana and Alt Power --
  ------------------------
  local function skinManaBar(self)
    if not self or not self.powerType then return end

    if self.unit ~= 'player' then
      -- Get Power Color
      local powerColor = PowerBarColor[self.powerType]

      -- Set Texture
      self.texture:SetTexture(EUIDB.powerBarTex)

      -- Set Power Color
      if self.unitFrame and self.unitFrame.manabar then
        if self.powerType == 0 then
          self.unitFrame.manabar:SetStatusBarColor(0, 0.5, 1)
        else
          self.unitFrame.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
        end
      end
    end
  end

  local function skinAlternatePower(self)
    if not self then return end

    local powerColor = PowerBarColor[self.powerType]
    self:SetStatusBarTexture(EUIDB.powerBarTex)
    if self.powerType and self.powerType == 0 then
      self:SetStatusBarColor(0, 0.5, 1)
    elseif self.powerType and self.powerType ~= 0 then
      self:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
    end
  end

  hooksecurefunc("UnitFrameManaBar_Update", skinManaBar)

  AlternatePowerBar:HookScript("OnEvent", skinAlternatePower)
end)
