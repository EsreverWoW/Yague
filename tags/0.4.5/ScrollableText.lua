-- ***************************************************************************************************************************************************
-- * ScrollableText.lua                                                                                                                              *
-- ***************************************************************************************************************************************************
-- * Text frame that can be scrolled                                                                                                                 *
-- ***************************************************************************************************************************************************
-- * 0.4.4 RC5 / 2012.01.13 / Baanano: Moved to Yague from BiSCal                                                                                    *
-- ***************************************************************************************************************************************************

local addonInfo, Internal = ...
local addonID = addonInfo.identifier
local PublicInterface = _G[addonID]

local MMax = math.max
local UICreateFrame = UI.CreateFrame

function PublicInterface.ScrollableText(name, parent)
	local frame = UICreateFrame("Frame", name, parent)
	
	local scrollBar = UICreateFrame("RiftScrollbar", name .. ".Scrollbar", frame)
	local mask = UICreateFrame("Mask", name .. ".Mask", frame)
	local textFrame = UICreateFrame("Text", name .. ".TextFrame", mask)

	local function ResetPosition()
		local offset = scrollBar:GetPosition()
		textFrame:ClearAll()
		textFrame:SetPoint("TOPLEFT", mask, "TOPLEFT", 0, -offset)
		textFrame:SetPoint("TOPRIGHT", mask, "TOPRIGHT", 0, -offset)
	end
	
	local function ResetSize()
		scrollBar:SetRange(0, MMax(0, textFrame:GetHeight() - mask:GetHeight()))
		ResetPosition()
	end
	
	scrollBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, 0)
	scrollBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", -18, 0)
	
	mask:SetPoint("TOPLEFT", frame, "TOPLEFT")
	mask:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 0)
	
	textFrame:SetWordwrap(true)
	
	function mask.Event:Size()
		ResetSize()
	end
	
	function frame.Event:WheelForward()
		scrollBar:NudgeUp()
	end
	
	function frame.Event:WheelBack()
		scrollBar:NudgeDown()
	end
	
	function scrollBar.Event:ScrollbarChange()
		ResetPosition()
	end
	
	ResetSize()

	
	function frame:GetFont() return textFrame:GetFont() end
	function frame:GetFontColor() return textFrame:GetFontColor() end
	function frame:GetFontSize() return textFrame:GetFontSize() end
	function frame:GetText() return textFrame:GetText() end
	function frame:SetFont(...)
		textFrame:SetFont(...)
		scrollBar:SetPosition(0)
		ResetSize()
	end
	function frame:SetFontColor(...)
		textFrame:SetFontColor(...)
		scrollBar:SetPosition(0)
		ResetSize()
	end
	function frame:SetFontSize(...)
		textFrame:SetFontSize(...)
		scrollBar:SetPosition(0)
		ResetSize()
	end
	function frame:SetText(...)
		textFrame:SetText(...)
		scrollBar:SetPosition(0)
		ResetSize()
	end
	
	return frame
end
