-- Import Ace3 libraries
local ADDON_NAME, KMBH = ...
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")

-- Create the options table for Krags Main Bar Hider
local options = {
    name = "Krags Main Bar Hider",
    handler = KMBH,
    type = "group",
    args = {
        description = {
            order = 1,
            type = "description",
            name = "This addon hides the main action bar, the stance bar, and other elements.",
        },
        hideBar = {
            order = 2,
            type = "toggle",
            name = "Hide Main Action Bar",
            desc = "Toggle visibility of the main action bar.",
            set = function(info, val)
                KMBH.db.profile.hideBar = val  -- Store the setting in the profile
                ToggleKragsMainBar(val)  -- Function to hide/show the bar
            end,
            get = function(info)
                return KMBH.db.profile.hideBar  -- Retrieve the setting from the profile
            end,
        },
        hideStanceBar = {  -- Toggle for Stance Bar visibility
            order = 3,
            type = "toggle",
            name = "Hide Stance Bar",
            desc = "Toggle visibility of the stance bar.",
            set = function(info, val)
                KMBH.db.profile.hideStanceBar = val  -- Store the setting in the profile
                ToggleStanceBar(val)  -- Function to hide/show the stance bar
            end,
            get = function(info)
                return KMBH.db.profile.hideStanceBar  -- Retrieve the setting from the profile
            end,
        },
        hideBagsBar = {  -- Toggle for Bags Bar visibility
            order = 4,
            type = "toggle",
            name = "Hide Bags Bar",
            desc = "Toggle visibility of the Bags Bar.",
            set = function(info, val)
                KMBH.db.profile.hideBagsBar = val  -- Store the setting in the profile
                ToggleBagsBar(val)  -- Function to hide/show the Bags Bar
            end,
            get = function(info)
                return KMBH.db.profile.hideBagsBar  -- Retrieve the setting from the profile
            end,
        },
        hideQuickJoinToastButton = {  -- Toggle for Quick Join Toast Button visibility
            order = 5,
            type = "toggle",
            name = "Hide Quick Join Toast Button",
            desc = "Toggle visibility of the Quick Join Toast Button.",
            set = function(info, val)
                KMBH.db.profile.hideQuickJoinToast = val  -- Store the setting in the profile
                ToggleQuickJoinToastButton(val)  -- Function to hide/show the Toast Button
            end,
            get = function(info)
                return KMBH.db.profile.hideQuickJoinToast  -- Retrieve the setting from the profile
            end,
        },
    },
}

-- Function to initialize the addon and register the options
function KMBH:OnInitialize()
    -- Initialize the saved variables database with defaults
    self.db = AceDB:New("KMBH_DB", {
        profile = {
            hideBar = true,           -- Default state for the action bar
            hideStanceBar = true,     -- Default state for the stance bar
            hideBagsBar = true,       -- Default state for the Bags Bar
            hideQuickJoinToast = true,-- Default state for the Quick Join Toast Button
        },
    }, true)
    
    -- Register the options with AceConfig
    AceConfig:RegisterOptionsTable(ADDON_NAME, options)
    AceConfigDialog:AddToBlizOptions(ADDON_NAME, ADDON_NAME)
end

-- Ensure the addon is initialized
KMBH:OnInitialize()
