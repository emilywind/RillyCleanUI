-- local RCUI=CreateFrame("Frame") -- Adapted from SUI - customised for RCUI
-- RCUI:RegisterEvent("PLAYER_LOGIN")
-- RCUI:SetScript("OnEvent", function(self, event)
-- 	if not RCUIDB.afkScreen then return end

-- 	local PName = UnitName("player")
-- 	local PLevel = UnitLevel("player")
-- 	local PClassName, PClass = UnitClass("player")
-- 	local PRace = UnitRace("player")
-- 	local PFaction = UnitFactionGroup("player")
-- 	local color = RAID_CLASS_COLORS[PClass]
-- 	local PGuild = " "

-- 	local font = STANDARD_TEXT_FONT
-- 	local blank = [[Interface\AddOns\RCUI\textures\blank.tga]]
-- 	local normTex = [[Interface\AddOns\RCUI\textures\normTex.tga]]

-- 	local function UpdateColor(t)
-- 		if t == template then return end

-- 		if t == "Transparent" then
-- 			local balpha = 1
-- 			if t == "Transparent" then balpha = 0.7 end
-- 			borderr, borderg, borderb = { .125, .125, .125 }
-- 			backdropr, backdropg, backdropb = { .05, .05, .05 }
-- 			backdropa = balpha
-- 		end

-- 		template = t
-- 	end

-- 	local function SetTemplate(f, t, tex)
-- 		if tex then
-- 			texture = normTex
-- 		else
-- 			texture = blank
-- 		end

-- 		UpdateColor(t)

-- 		f.backdropInfo = {
-- 			bgFile = texture,
-- 			edgeFile = blank,
-- 			tile = false, tileSize = 0, edgeSize = 1,
-- 		}
-- 		f:ApplyBackdrop()

-- 		f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
-- 		f:SetBackdropBorderColor(borderr, borderg, borderb)
-- 	end

-- 	local function addapi(object)
-- 		local mt = getmetatable(object).__index
-- 		if not object.SetTemplate then mt.SetTemplate = SetTemplate end
-- 	end

-- 	local handled = {["Frame"] = true}
-- 	local object = CreateFrame("Frame")
-- 	addapi(object)
-- 	addapi(object:CreateTexture())
-- 	addapi(object:CreateFontString())

-- 	object = EnumerateFrames()
-- 	while object do
-- 		if not handled[object:GetObjectType()] then
-- 			addapi(object)
-- 			handled[object:GetObjectType()] = true
-- 		end

-- 		object = EnumerateFrames(object)
-- 	end

-- 	local AFKPanel = CreateFrame( "Frame", "AFKPanel", nil, "BackdropTemplate" )
-- 	AFKPanel:SetPoint( "BOTTOMLEFT", UIParent, "BOTTOMLEFT", -2, -2 )
-- 	AFKPanel:SetPoint( "TOPRIGHT", UIParent, "BOTTOMRIGHT", 2, 150 )
-- 	AFKPanel:SetTemplate("Transparent")
-- 	AFKPanel:Hide()

-- 	local AFKPanelTop = CreateFrame( "Frame", "AFKPanelTop", nil, "BackdropTemplate" )
-- 	AFKPanelTop:SetPoint( "TOPLEFT", UIParent, "TOPLEFT",-2, 2 )
-- 	AFKPanelTop:SetPoint( "BOTTOMRIGHT", UIParent, "TOPRIGHT", 2, -80 )
-- 	AFKPanelTop:SetTemplate("Transparent")
-- 	AFKPanelTop:SetFrameStrata("FULLSCREEN")
-- 	AFKPanelTop:Hide()

-- 	AFKPanelTop.Text = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
-- 	AFKPanelTop.Text:SetPoint( "CENTER", AFKPanelTop, "CENTER", 0, 0 )
-- 	AFKPanelTop.Text:SetFont( font, 40, "OUTLINE" )
-- 	AFKPanelTop.Text:SetText( "AFK" )
-- 	AFKPanelTop.Text:SetTextColor( color.r, color.g, color.b )

-- 	AFKPanelTop.DateText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
-- 	AFKPanelTop.DateText:SetPoint( "BOTTOMRIGHT", AFKPanelTop, "BOTTOMRIGHT", -20, 44 )
-- 	AFKPanelTop.DateText:SetFont( font, 15, "OUTLINE" )

-- 	AFKPanelTop.ClockText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
-- 	AFKPanelTop.ClockText:SetPoint( "BOTTOMRIGHT", AFKPanelTop, "BOTTOMRIGHT", -20, 20 )
-- 	AFKPanelTop.ClockText:SetFont( font, 20, "OUTLINE" )

-- 	AFKPanelTop.PlayerNameText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
-- 	AFKPanelTop.PlayerNameText:SetPoint( "LEFT", AFKPanelTop, "LEFT", 25, 19 )
-- 	AFKPanelTop.PlayerNameText:SetFont( font, 26, "OUTLINE" )
-- 	AFKPanelTop.PlayerNameText:SetText( PName )
-- 	AFKPanelTop.PlayerNameText:SetTextColor( color.r, color.g, color.b )

-- 	AFKPanel.Text = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
-- 	AFKPanel.Text:SetPoint("CENTER", AFKPanel, "CENTER", 0, 0 )
-- 	AFKPanel.Text:SetFont( font, 110, "OUTLINE" )
-- 	AFKPanel.Text:SetText( "|cffb07aebRC|r|cff009cffUI|r" )

-- 	-- Set Up the Player Model
-- 	AFKPanel.playerModel = CreateFrame('PlayerModel', nil, AFKPanel);
-- 	AFKPanel.playerModel:SetSize(800, 1000)
-- 	AFKPanel.playerModel:SetPoint("RIGHT", AFKPanel, "RIGHT", 250, 110 )
-- 	AFKPanel.playerModel:SetUnit('player');
-- 	AFKPanel.playerModel:SetAnimation(0);
-- 	AFKPanel.playerModel:SetRotation(math.rad(-15));
-- 	AFKPanel.playerModel:SetCamDistanceScale(1.8);

-- 	local function getGuildLine()
-- 		local guildstatus = true
-- 		local PGuild;

-- 		if IsInGuild() then
-- 			PGuild = GetGuildInfo('player')

-- 			if (PGuild == nil) then
-- 				PGuild = "..."
-- 			end
-- 		else
-- 			return " "
-- 		end

-- 		return "|cff0394ff" .. PGuild .. "|r"
-- 	end

-- 	AFKPanelTop.GuildText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
-- 	AFKPanelTop.GuildText:SetPoint( "LEFT", AFKPanelTop, "LEFT", 25, -3 )
-- 	AFKPanelTop.GuildText:SetFont( font, 15, "OUTLINE" )

-- 	AFKPanelTop.PlayerInfoText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
-- 	AFKPanelTop.PlayerInfoText:SetPoint( "LEFT", AFKPanelTop, "LEFT", 25, -20 )
-- 	AFKPanelTop.PlayerInfoText:SetFont( font, 15, "OUTLINE" )
-- 	AFKPanelTop.PlayerInfoText:SetText( LEVEL .. " " .. PLevel .. " " .. PRace .. " " .. PClassName )

-- 	local interval = 0
-- 	AFKPanelTop:SetScript( "OnUpdate", function( self, elapsed )
-- 		interval = interval - elapsed
-- 		if( interval <= 0 ) then
-- 			AFKPanelTop.ClockText:SetText( format("%s", date( "%H:%M:%S" ) ) )
-- 			AFKPanelTop.DateText:SetText( format("%s", date( "%d %b" ) ) )
-- 			interval = 0.5
-- 		end
-- 	end )

-- 	local OnEvent = function(self, event, unit)
-- 		if event == "PLAYER_FLAGS_CHANGED" then
-- 			local isArena, isRegistered = C_PvP.IsArena()
-- 			if unit == "player" then
-- 				if UnitIsAFK(unit) and not UnitIsDead(unit) and not InCombatLockdown() and not isArena then
-- 					-- SpinStart()
-- 					AFKPanelTop.GuildText:SetText(getGuildLine())
-- 					AFKPanel:Show()
-- 					AFKPanelTop:Show()
-- 					Minimap:Hide()
-- 				else
-- 					SpinStop()
-- 					AFKPanel:Hide()
-- 					AFKPanelTop:Hide()
-- 					Minimap:Show()
-- 				end
-- 			end
-- 		elseif event == "PLAYER_LEAVING_WORLD" then
-- 			SpinStop()
-- 		elseif event == "PLAYER_DEAD" then
-- 			if UnitIsAFK("player") then
-- 				SpinStop()
-- 				AFKPanel:Hide()
-- 				AFKPanelTop:Hide()
-- 				Minimap:Show()
-- 			end
-- 		end
-- 	end

-- 	AFKPanel:RegisterEvent( "PLAYER_ENTERING_WORLD" )
-- 	AFKPanel:RegisterEvent( "PLAYER_LEAVING_WORLD" )
-- 	AFKPanel:RegisterEvent( "PLAYER_FLAGS_CHANGED" )
-- 	AFKPanel:SetScript( "OnEvent", OnEvent )

-- 	AFKPanel:SetScript( "OnShow", function( self )
-- 		UIParent:SetAlpha(0);
-- 		for i = 1, 40 do
-- 			local raidframe = _G["CompactRaidFrame"..i..""]
-- 			if raidframe == nil then else  raidframe:Hide(); end
-- 			i = i + 1
-- 		end
-- 	end )

-- 	AFKPanel:SetScript( "OnHide", function( self )
-- 		UIFrameFadeOut( UIParent, 0.5, 0, 1 )
-- 		for i = 1, 40 do
-- 			local raidframe = _G["CompactRaidFrame"..i..""]
-- 			if raidframe == nil then else  raidframe:Show(); end
-- 			i = i + 1
-- 		end
-- 	end )

-- 	function SpinStart()
-- 		spinning = true
-- 		MoveViewRightStart( 0.1 )
-- 	end

-- 	function SpinStop()
-- 		if( not spinning ) then return end
-- 		spinning = nil
-- 		MoveViewRightStop()
-- 	end
-- end)
