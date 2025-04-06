local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("ZONE_CHANGED")
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")

local function ApplyVisibilitySetting()
    C_Timer.After(0.1, function()
        ToggleKragsMainBar(KragsMainBarDB.hideBar)
        ToggleStanceBar(KragsMainBarDB.hideStanceBar)
        ToggleBagsBar(KragsMainBarDB.hideBagsBar)
        ToggleQuickJoinToastButton(KragsMainBarDB.hideQuickJoinToast)
    end)
end

f:SetScript("OnEvent", function()
    if not KragsMainBarDB then
        KragsMainBarDB = { 
            hideBar = true, 
            hideStanceBar = true, 
            hideBagsBar = true,  -- Default setting for BagsBar
            hideQuickJoinToast = true  -- Default setting for QuickJoinToastButton
        }
    end
    ApplyVisibilitySetting()
end)

-- Toggle visibility of the main action bar
function ToggleKragsMainBar(shouldHide)
    KragsMainBarDB.hideBar = shouldHide
    if shouldHide then
        MainMenuBar:Hide()
    else
        MainMenuBar:Show()
    end
end

-- Toggle visibility of the stance bar
function ToggleStanceBar(shouldHide)
    if StanceBar then
        KragsMainBarDB.hideStanceBar = shouldHide
        if shouldHide then
            StanceBar:Hide()
        else
            StanceBar:Show()
        end
    end
end

-- Toggle visibility of the BagsBar (hides all bag buttons)
function ToggleBagsBar(shouldHide)
    local bagsBar = _G["BagsBar"]
    if bagsBar then
        KragsMainBarDB.hideBagsBar = shouldHide
        if shouldHide then
            BagsBar:Hide()
        else
            BagsBar:Show()
        end
    end
end

-- Hide QuickJoinToastButton and disable it
function ToggleQuickJoinToastButton(shouldHide)
    if QuickJoinToastButton then
        KragsMainBarDB.hideQuickJoinToast = shouldHide
        if shouldHide then
            QuickJoinToastButton:Hide()
            QuickJoinToastButton:UnregisterAllEvents()
            QuickJoinToastButton:SetScript("OnShow", nil)
        else
            QuickJoinToastButton:Show()
            QuickJoinToastButton:RegisterAllEvents()
        end
    end
end

-- Slash command to toggle the main action bar
SLASH_KRAGSMAINBAR1 = "/hidebar"
SlashCmdList["KRAGSMAINBAR"] = function()
    local newState = not KragsMainBarDB.hideBar
    ToggleKragsMainBar(newState)
    if newState then
        print("Main action bar hidden.")
    else
        print("Main action bar shown.")
    end
end

-- Slash command to toggle the stance bar
SLASH_KRAGSSTANCEBAR1 = "/hidestance"
SlashCmdList["KRAGSSTANCEBAR"] = function()
    local newState = not KragsMainBarDB.hideStanceBar
    ToggleStanceBar(newState)
    if newState then
        print("Stance bar hidden.")
    else
        print("Stance bar shown.")
    end
end

-- Slash command to toggle the bags bar
SLASH_KRAGSBAGS1 = "/hidebags"
SlashCmdList["KRAGSBAGS"] = function()
    local newState = not KragsMainBarDB.hideBagsBar
    ToggleBagsBar(newState)
    if newState then
        print("Bags bar hidden.")
    else
        print("Bags bar shown.")
    end
end

-- Slash command to toggle the Quick Join Toast Button
SLASH_KRAGSTOAST1 = "/hidetoast"
SlashCmdList["KRAGSTOAST"] = function()
    local newState = not KragsMainBarDB.hideQuickJoinToast
    ToggleQuickJoinToastButton(newState)
    if newState then
        print("Quick Join Toast Button hidden.")
    else
        print("Quick Join Toast Button shown.")
    end
end
