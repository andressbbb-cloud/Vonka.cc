local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/andressbbb-cloud/Vonka.cc/refs/heads/main/Vonka.cc.lua"))()

local Window = Library:Window({
    Name = "Vonka.cc",
    Size = UDim2.new(0, 600, 0, 600),
    FadeSpeed = 0.25
})

local Watermark = Library:Watermark("Vonka.cc ~ " .. os.date("%b %d %Y") .. " ~ " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
local KeybindList = Library:KeybindList()

Watermark:SetVisibility(false)
KeybindList:SetVisibility(false)

local AimbotSubtab = LegitTab:SubPage({Name = "Aimbot", Columns = 2})
local LegitTab = Window:Page({Name = "Legit", Columns = 2, Subtabs = true})
local AimbotSubtab = LegitTab:SubPage({Name = "Aimbot", Columns = 2})
local SilentAimSubtab = LegitTab:SubPage({Name = "Silent Aim", Columns = 2})
local TriggerBotSubtab = LegitTab:SubPage({Name = "TriggerBot", Columns = 2})
local VisualTab = Window:Page({Name = "Visual", Columns = 2, Subtabs = false})
local PlayersTab = Window:Page({Name = "Players", Columns = 2, Subtabs = false})
local SettingsTab = Window:Page({Name = "Settings", Columns = 2, Subtabs = false})

do -- Settings Tab
    local SettingsSection = SettingsTab:Section({Name = "Settings", Side = 2})
    local ConfigsSection = SettingsTab:Section({Name = "Profiles", Side = 1})

    for Index, Value in Library.Theme do
        SettingsSection:Label({Name = Index, Alignment = "Left"}):Colorpicker({ Name = Index, Default = Value, Flag = "Theme"..Index, Callback = function(Color)
            Library.Theme[Index] = Color
            Library:ChangeTheme(Index, Color)
        end})
    end

    SettingsSection:Label({Name = "Menu Keybind", Alignment = "Left"}):Keybind({Name = "Menu Keybind", Flag = "Menu Keybind", Default = Enum.KeyCode.RightControl, Mode = "Toggle", Callback = function(Value)
        Library.MenuKeybind = Library.Flags["Menu Keybind"].Key
    end})

    SettingsSection:Toggle({Name = "Watermark", Flag = "Watermark", Default = false, Callback = function(Value)
        Watermark:SetVisibility(Value)
    end})

    SettingsSection:Toggle({Name = "Keybind List", Flag = "Keybind List", Default = false, Callback = function(Value)
        KeybindList:SetVisibility(Value)
    end})

    SettingsSection:Dropdown({Name = "Tweening Style", Flag = "Tweening Style", Default = "Exponential", Items = {"Linear", "Sine", "Quad", "Cubic", "Quart", "Quint", "Exponential", "Circular", "Back", "Elastic", "Bounce"}, Callback = function(Value)
        Library.Tween.Style = Enum.EasingStyle[Value]
    end})

    SettingsSection:Dropdown({Name = "Tweening Direction", Flag = "Tweening Direction", Default = "Out", Items = {"In", "Out", "InOut"}, Callback = function(Value)
        Library.Tween.Direction = Enum.EasingDirection[Value]
    end})

    SettingsSection:Slider({Name = "Tweening Time", Min = 0, Max = 5, Default = 0.25, Decimals = 0.01, Flag = "Tweening Time", Callback = function(Value)
        Library.Tween.Time = Value
    end})

    SettingsSection:Button({Name = "Notification test", Callback = function()
        Library:Notification("This is a notification This is a notification This is a notification This is a notification", 5, Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
    end})

    SettingsSection:Button({Name = "Unload library", Callback = function()
        Library:Unload()
    end})

    local ConfigName
    local ConfigSelected

    local ConfigsListbox = ConfigsSection:Listbox({Items = { }, Name = "Configs", Flag = "Configs List", Callback = function(Value)
        ConfigSelected = Value
    end})

    ConfigsSection:Textbox({Name = "Config Name", Placeholder = ". .", Flag = "Config Name", Callback = function(Value)
        ConfigName = Value
    end})

    ConfigsSection:Button({Name = "Create Config", Callback = function()
        if not isfile(Library.Folders.Configs .. "/" .. ConfigName .. ".json") then
            writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
            Library:RefreshConfigsList(ConfigsListbox)
        else
            Library:Notification("Config '" .. ConfigName .. ".json' already exists", 3, Color3.FromR(255, 0, 0))
            return
        end
    end})

    ConfigsSection:Button({Name = "Load Config", Callback = function()
        if ConfigSelected then
            Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. ConfigSelected))
        end
        Library:Thread(function()
            task.wait(0.1)
            for Index, Value in Library.Theme do
                Library.Theme[Index] = Library.Flags["Theme"..Index].Color
                Library:ChangeTheme(Index, Library.Flags["Theme"..Index].Color)
            end
        end)
    end})

    ConfigsSection:Button({Name = "Delete Config", Callback = function()
        if ConfigSelected then
            Library:DeleteConfig(ConfigSelected)
            Library:RefreshConfigsList(ConfigsListbox)
        end
    end})

    ConfigsSection:Button({Name = "Save Config", Callback = function()
        if ConfigSelected then
            Library:SaveConfig(ConfigSelected)
        end
    end})

    ConfigsSection:Button({Name = "Refresh Configs", Callback = function()
        Library:RefreshConfigsList(ConfigsListbox)
    end})

    Library:RefreshConfigsList(ConfigsListbox)
end

