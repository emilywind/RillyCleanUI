SQUARE_TEXTURE = "Interface\\BUTTONS\\WHITE8X8"
TOOLTIP_BORDER = "Interface\\Tooltips\\UI-Tooltip-Border"
DEFAULT_FRAME_COLOUR = {
  0.2,
  0.2,
  0.2,
}

AddonDir = "Interface\\AddOns\\EmsUI"
MediaDir = AddonDir.."\\media"
FontsDir = MediaDir.."\\fonts"
TextureDir = MediaDir.."\\textures"

EUI_TEXTURES = {
  buttons = {
    normal = TextureDir.."\\buttons\\button-normal.tga",
    pushed = TextureDir.."\\buttons\\button-pressed.tga",
    checked = TextureDir.."\\buttons\\button-checked.tga",
  },

  roundedBorder = TextureDir.."\\rounded-border.tga",

  healthBar = TextureDir.."\\blizz-inspired.tga",
  powerBar = TextureDir.."\\blizz-inspired.tga",

  classCircles = TextureDir.."\\class\\fabled",

  circleTexture = TextureDir.."\\Portrait-ModelBack.tga",
  portraitModelFront = TextureDir.."\\portrait-modelfront.tga",

  minimap = {
    dungeonDifficulty = TextureDir.."\\minimap\\UI-DungeonDifficulty-Button.tga"
  },

  lfg = {
    portraitRoles = TextureDir.."\\lfgframe\\UI-LFG-ICON-PORTRAITROLES.tga",
    roles = TextureDir.."\\lfgframe\\UI-LFG-ICON-ROLES.tga"
  },
}

CLEAN_UI = "Clean"
BETTER_BLIZZ_UI = "BetterBlizz"

UI_STYLES = {
  BETTER_BLIZZ_UI,
  CLEAN_UI,
}

FABLED_CLASS_CIRCLES_DATA = {
  class = {
		path = [[Interface\AddOns\EmsUI\media\textures\class\]],
		styles = {
			fabled = {
				name = 'Fabled',
				artist = 'Royroyart',
				site = 'https://www.fiverr.com/royyanikhwani',
			},
			fabledrealm = {
				name = 'Fabled Realm',
				artist = 'Handclaw',
				site = 'https://handclaw.artstation.com/',
			},
			fabledpixels = {
				name = 'Fabled Pixels',
				artist = 'Dragumagu',
				site = 'https://www.artstation.com/dragumagu',
			},
		},
    WARRIOR	= {
      texString = '0:128:0:128',
      texCoords = { 0, 0, 0, 0.125, 0.125, 0, 0.125, 0.125 },
    },
    MAGE = {
      texString = '128:256:0:128',
      texCoords = { 0.125, 0, 0.125, 0.125, 0.25, 0, 0.25, 0.125 },
    },
    ROGUE = {
      texString = '256:384:0:128',
      texCoords = { 0.25, 0, 0.25, 0.125, 0.375, 0, 0.375, 0.125 },
    },
      DRUID = {
      texString = '384:512:0:128',
      texCoords = { 0.375, 0, 0.375, 0.125, 0.5, 0, 0.5, 0.125 },
    },
    EVOKER = {
      texString = '512:640:0:128',
      texCoords = { 0.5, 0, 0.5, 0.125, 0.625, 0, 0.625, 0.125 },
    },
    HUNTER = {
      texString = '0:128:128:256',
      texCoords = { 0, 0.125, 0, 0.25, 0.125, 0.125, 0.125, 0.25 },
    },
    SHAMAN = {
      texString = '128:256:128:256',
      texCoords = { 0.125, 0.125, 0.125, 0.25, 0.25, 0.125, 0.25, 0.25 },
    },
    PRIEST = {
      texString = '256:384:128:256',
      texCoords = { 0.25, 0.125, 0.25, 0.25, 0.375, 0.125, 0.375, 0.25 },
    },
    WARLOCK = {
      texString = '384:512:128:256',
      texCoords = { 0.375, 0.125, 0.375, 0.25, 0.5, 0.125, 0.5, 0.25 },
    },
    PALADIN = {
      texString = '0:128:256:384',
      texCoords = { 0, 0.25, 0, 0.375, 0.125, 0.25, 0.125, 0.375 },
    },
    DEATHKNIGHT = {
      texString = '128:256:256:384',
      texCoords = { 0.125, 0.25, 0.125, 0.375, 0.25, 0.25, 0.25, 0.375 },
    },
    MONK = {
      texString = '256:384:256:384',
      texCoords = { 0.25, 0.25, 0.25, 0.375, 0.375, 0.25, 0.375, 0.375 },
    },
    DEMONHUNTER = {
      texString = '384:512:256:384',
      texCoords = { 0.375, 0.25, 0.375, 0.375, 0.5, 0.25, 0.5, 0.375 },
    },
  },
}

CLASS_PORTRAIT_PACKS = {}
local classInfo = FABLED_CLASS_CIRCLES_DATA.class

for iconStyle, data in next, classInfo.styles do
  CLASS_PORTRAIT_PACKS[format('%s%s', classInfo.path, iconStyle)] = format('%s (by %s)', data.name, data.artist)
end

function getFrameColour()
  if EUIDB.frameColor then
    return unpack(EUIDB.frameColor)
  else
    return unpack(DEFAULT_FRAME_COLOUR)
  end
end

function OnPlayerLogin(callback)
  local frame = CreateFrame("Frame")
  frame:RegisterEvent("PLAYER_LOGIN")
  frame:SetScript("OnEvent", callback)
end

EUI_FONTS = {
  Andika = FontsDir.."\\Andika.ttf",
  Fira = FontsDir.."\\FiraSans.ttf",
  SourceSans = FontsDir.."\\SourceSans3.ttf",
  Marmelad = FontsDir.."\\Marmelad.ttf",
  Bangers = FontsDir.."\\Bangers-Regular.ttf",
}

EUI_DAMAGE_FONT = FontsDir.."\\Bangers-Regular.ttf"

function styleIcon(ic)
  ic:SetTexCoord(0.08, 0.92, 0.08, 0.92)
end

EUI_BACKDROP = {
  edgeFile = TOOLTIP_BORDER,
  tileEdge = true,
  edgeSize = 10,
}

function applyEuiBackdrop(b, frame)
  if (b.euiClean) then return end

  local frame = frame or CreateFrame("Frame", nil, b)

  -- Icon
  local name = b:GetName()
  local icon = b.icon or b.Icon or (name and _G[name.."Icon"]) or b
  styleIcon(icon, b)

  local border
  if EUIDB.uiStyle == "BetterBlizz" then
    border = CreateFrame('Frame', nil, frame, "BackdropTemplate")
    border:SetPoint("TOPLEFT",icon,"TOPLEFT",-2,2)
    border:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,-2)
    border:SetBackdrop(EUI_BACKDROP)
    border:SetBackdropBorderColor(getFrameColour())
  else
    border = frame:CreateTexture()
    border:SetDrawLayer("OVERLAY")
    border:SetTexture(EUI_TEXTURES.roundedBorder)
    border:SetPoint("TOPLEFT", icon, "TOPLEFT", -1, 1)
    border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
    border:SetVertexColor(0.1, 0.1, 0.1)
  end

  b.euiClean = true

  return border
end

function setEuiBorderColor(border, r, g, b)
  if border.SetVertexColor then
    border:SetVertexColor(r, g, b)
  else
    border:SetBackdropBorderColor(r, g, b)
  end
end

function setDefaultFont(textObject, size, outlinestyle)
  if not textObject then return end
  local _, currSize = textObject:GetFont()
  if not size then size = currSize end
  if not outlinestyle then outlinestyle = "THINOUTLINE" end

  textObject:SetFont(EUIDB.font, size, outlinestyle)
end

function skinProgressBar(bar)
  if not bar or (bar and bar.euiClean) then return end

  if bar.BorderMid then
    bar.BorderMid:SetAlpha(0)
    bar.BorderLeft:SetAlpha(0)
    bar.BorderRight:SetAlpha(0)
  end

  bar:SetStatusBarTexture(PlayerCastingBarFrame:GetStatusBarTexture())
  bar:GetStatusBarTexture():SetVertexColor(0.8, 0, 0)

  if bar.BarBG then
    bar.BarBG:Hide()
    bar.BarFrame:Hide()
  end

  -- Border
  local back = bar:CreateTexture(nil, "BACKGROUND")
  back:SetTexture(4505194)
  back:SetAtlas('ui-castingbar-background')
  back:SetPoint("TOPLEFT", bar, "TOPLEFT", -2, 2)
  back:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 2, -2)
  back:SetVertexColor(getFrameColour())

  bar.back = back

  bar.euiClean = true
end
