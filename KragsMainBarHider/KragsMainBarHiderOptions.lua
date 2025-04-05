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
            name = "This addon hides the main action bar and the stance bar.",
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
        hideStanceBar = {  -- New toggle for Stance Bar visibility
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
    },
}

-- Function to initialize the addon and register the options
function KMBH:OnInitialize()
    -- Initialize the saved variables database with defaults for 'hideBar' and 'hideStanceBar'
    self.db = AceDB:New("KMBH_DB", {
        profile = {
            hideBar = true,        -- Default state for the action bar
            hideStanceBar = true,  -- Default state for the stance bar
        },
    }, true)
    
    -- Register the options with AceConfig
    AceConfig:RegisterOptionsTable(ADDON_NAME, options)
    AceConfigDialog:AddToBlizOptions(ADDON_NAME, ADDON_NAME)
end

-- Ensure the addon is initialized
KMBH:OnInitialize()
