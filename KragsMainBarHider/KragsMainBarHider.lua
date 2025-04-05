local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")

local function ApplyVisibilitySetting()
    C_Timer.After(0.1, function()
        ToggleKragsMainBar(KragsMainBarDB.hideBar)
        ToggleStanceBar(KragsMainBarDB.hideStanceBar)
    end)
end

f:SetScript("OnEvent", function()
    if not KragsMainBarDB then
        KragsMainBarDB = { hideBar = true, hideStanceBar = true }  -- Add default setting for the stance bar
    end
    ApplyVisibilitySetting()
end)

-- Toggle visibility of the main action bar
function ToggleKragsMainBar(shouldHide)
    if shouldHide then
        MainMenuBar:Hide()
        print("Main action bar hidden.")
    else
        MainMenuBar:Show()
        print("Main action bar shown.")
    end
    KragsMainBarDB.hideBar = shouldHide
end

-- Toggle visibility of the stance bar
function ToggleStanceBar(shouldHide)
    -- Check if StanceBar exists and is not nil
    if StanceBar then
        if shouldHide then
            StanceBar:Hide()
            print("Stance bar hidden.")
        else
            StanceBar:Show()
            print("Stance bar shown.")
        end
        KragsMainBarDB.hideStanceBar = shouldHide
    else
        print("Stance bar is not available for your class.")
    end
end

-- Slash command to toggle the main action bar
SLASH_KRAGSMAINBAR1 = "/hidebar"
SlashCmdList["KRAGSMAINBAR"] = function()
    local newState = not KragsMainBarDB.hideBar
    ToggleKragsMainBar(newState)
end

-- Slash command to toggle the stance bar
SLASH_KRAGSSTANCEBAR1 = "/hidestance"
SlashCmdList["KRAGSSTANCEBAR"] = function()
    local newState = not KragsMainBarDB.hideStanceBar
    ToggleStanceBar(newState)
end
