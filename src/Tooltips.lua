local function GetDifficultyLevelColor(level)
	level = (level - tt.playerLevel);
	if (level > 4) then
		return "|cffff2020"; -- red
	elseif (level > 2) then
		return "|cffff8040"; -- orange
	elseif (level >= -2) then
		return "|cffffff00"; -- yellow
	elseif (level >= -GetQuestGreenRange()) then
		return "|cff40c040"; -- green
	else
		return "|cff808080"; -- gray
	end
end

local function getUnitHealthColor(unit)
	local r, g, b

	if (UnitIsPlayer(unit)) then
		r, g, b = GetClassColor(select(2,UnitClass(unit)))
	else
		r, g, b = GameTooltip_UnitColor(unit)
		if (g == 0.6) then g = 0.9 end
		if (r==1 and g==1 and b==1) then r, g, b = 0, 0.9, 0.1 end
	end

	return r, g, b
end

local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_LOGIN")
CF:SetScript("OnEvent", function(self, event)
	if IsAddOnLoaded('TinyTooltip') or IsAddOnLoaded('TipTac') then
		return
	end

	-- Tooltips anchored on mouse
	hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
		if (InCombatLockdown() or RCUIDB.tooltipAnchor == 'DEFAULT') then
	    self:SetOwner(parent, "ANCHOR_NONE")
	    self:ClearAllPoints()
	    self:SetPoint(unpack({"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -200, 220}))
		else
			self:SetOwner(parent, RCUIDB.tooltipAnchor)
		end
	end)

	local bar = GameTooltipStatusBar
	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints()
	bar.bg:SetColorTexture(1, 1, 1)
	bar.bg:SetVertexColor(0.2, 0.2, 0.2, 0.8)
	bar.TextString = bar:CreateFontString(nil, "OVERLAY")
	bar.TextString:SetPoint("CENTER")
	setDefaultFont(bar.TextString, 11)
	bar.capNumericDisplay = true
	bar.lockShow = 1

	-- Gametooltip statusbar
	GameTooltipStatusBar:SetStatusBarTexture(RILLY_CLEAN_TEXTURES.statusBar)
	GameTooltipStatusBar:ClearAllPoints()
	GameTooltipStatusBar:SetPoint("LEFT", 3, 0)
	GameTooltipStatusBar:SetPoint("RIGHT", -3, 0)
	GameTooltipStatusBar:SetPoint("BOTTOM", 0, -5)
	GameTooltipStatusBar:SetHeight(10)

	-- Class colours
	hooksecurefunc(GameTooltip, "SetUnit", function()
    local tooltip = GameTooltip
		local _, unit = tooltip:GetUnit()
		if  not unit then return end
		local level = UnitEffectiveLevel(unit)
		local r, g, b = getUnitHealthColor(unit)

		if UnitIsPlayer(unit) then
			local className, class = UnitClass(unit)
			local race = UnitRace(unit)

			if (level < 0) then
				level = "??"
			end

			local text = GameTooltipTextLeft1:GetText()
			GameTooltipTextLeft1:SetFormattedText("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, text:match("|cff\x\x\x\x\x\x(.+)|r") or text)

			local guild, guildRank = GetGuildInfo(unit)
			local PlayerInfoLine = GameTooltipTextLeft2
			if (guild) then
				PlayerInfoLine = GameTooltipTextLeft3
			end
			PlayerInfoLine:SetText(level .. " " .. race .. " " .. className)
		end

		local family = UnitCreatureFamily(unit)
		if (family) then -- UnitIsBattlePetCompanion(unit);
			GameTooltipTextLeft2:SetText(level .. " " .. family)
		end

		GameTooltip:AddLine(' ')
	end)

	GameTooltip:HookScript("OnUpdate", function(tooltip)
		skinNineSlice(GameTooltip.NineSlice)
		GameTooltip.NineSlice:SetCenterColor(0.08,0.08,0.08) -- Simpler and themed BG color
		GameTooltip.NineSlice:SetBorderColor(0,0,0,0)

		local RillyCleanToolTipBorder = _G["RillyCleanToolTipBorder"]

		if (RillyCleanToolTipBorder == nil) then
			RillyCleanToolTipBorder = CreateFrame("Frame", "RillyCleanToolTipBorder", GameTooltip, "BackdropTemplate")
			RillyCleanToolTipBorder:SetFrameLevel(0)
			RillyCleanToolTipBorder:SetFrameStrata("TOOLTIP")
			RillyCleanToolTipBorder:SetPoint("CENTER",0,0)
			RillyCleanToolTipBorder:SetScale(1)

			RillyCleanToolTipBorder.backdropInfo = {
				bgFile = SQUARE_TEXTURE,
				tile = false, tileSize = 0, edgeSize = 0,
				insets = { left = 1, right = 1, top = 1, bottom = 1 }
			}
			RillyCleanToolTipBorder:ApplyBackdrop()
			RillyCleanToolTipBorder:SetBackdropColor(0,0,0,1)
			RillyCleanToolTipBorder:SetBackdropBorderColor(0,0,0,1)
			RillyCleanToolTipBorder:Show()
		end

		RillyCleanToolTipBorder:SetHeight(GameTooltip:GetHeight() - 4)
		RillyCleanToolTipBorder:SetWidth(GameTooltip:GetWidth() - 4)
	end)

	GameTooltipStatusBar:HookScript("OnValueChanged", function(self, hp)
		local unit = "mouseover"
	  local focus = GetMouseFocus()
	  if (focus and focus.unit) then
	      unit = focus.unit
	  end

		local value = UnitHealth(unit)
		local valueMax = UnitHealthMax(unit)
		local percent = math.floor(value / valueMax * 100)

		TextStatusBar_UpdateTextStringWithValues(self, self.TextString, value, 0, valueMax)

	  local r, g, b = getUnitHealthColor(unit)

	  self:SetStatusBarColor(r, g, b)
	end)
end)
