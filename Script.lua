local Toolbar = plugin:CreateToolbar("Script Editor Themes")
local ToolbarButton = Toolbar:CreateButton("View Themes", "View themes to select", "rbxassetid://3037837976")
local Mouse = plugin:GetMouse()

local GUI = script.ScriptEditorThemesUI
for _,gui in next, game.CoreGui:GetChildren() do if gui.Name == "ScriptEditorThemesUI" then gui:Destroy() end end
--if game.CoreGui:FindFirstChild("ScriptEditorThemesUI") then game.CoreGui:FindFirstChild("ScriptEditorThemesUI"):Destroy() end
GUI.Parent = game.CoreGui

ToolbarButton.Click:Connect(function()
	GUI.Enabled = not GUI.Enabled
end)

local function ChangeTheme(Name, SettingsTable)
	if not type(SettingsTable) == "table" then
		warn'Theme module does not contain a table.'
	else
		for setting, color in next, SettingsTable do
			if settings().Studio[setting] then
				settings().Studio[setting] = color
			end
		end
		print('Successfully changed theme to '..Name..'!')
	end
end

local function GetStudioTheme()
	local Settings = {
		"Color3.new("..(tostring(settings().Studio["Background Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Built-in Function Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Comment Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Error Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Find Selection Background Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Keyword Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Matching Word Background Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Number Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Operator Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Preprocessor Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Selection Background Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Selection Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["String Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Text Color"]))..")";
		"Color3.new("..(tostring(settings().Studio["Warning Color"]))..")";
	}
	return Settings
end

local function doRipple(button, buttonPos)
	if button:IsA("GuiButton") then
		local ripple = GUI.Back.Utilities.Ripple:Clone()
		ripple.ImageColor3 = Color3.new(button.BackgroundColor3.r*.25, button.BackgroundColor3.g*.25, button.BackgroundColor3.b*.25)
		ripple.Visible = true
		ripple.Position = buttonPos
		ripple.Parent = button
		ripple:TweenSize(UDim2.new(0, 250, 0, 250), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, .55, true)
		for i = 2, 10, .5 do ripple.ImageTransparency = i/10 wait() end
		ripple:Destroy()
	end
end

local function scaleCanvasSize(frame)
	local gridLayout = frame:FindFirstChild("UIGridLayout", true)
	if gridLayout then
		frame.CanvasSize = UDim2.new(0, 0, 0, math.ceil(gridLayout.AbsoluteContentSize.Y)+40)
	else
		warn('No GridLayout found in '..frame.Name)
	end
end

--[[
	GUI Handler
	8/21/19 11:19pm
	By: Misdo aka SimplyRekt
--]]
local GuiColors = {
	LightMain = Color3.fromRGB(236, 240, 241),
	DarkMain = Color3.fromRGB(44, 62, 80),
	On = Color3.fromRGB(0, 85, 0),
	Off = Color3.fromRGB(85, 0, 0)
}
local CurrentlyViewing = "Themes"
local TopbarButtons = GUI.Back.TopbarButtons
local Selected = TopbarButtons.Selected
local DarkOn = plugin:GetSetting("Dark")

local Themes = GUI.Back.Themes
local Utilities = GUI.Back.Utilities
local Credits = GUI.Back.Credits

local Positions = {
	Themes = UDim2.new(.15, 0, 0, -10);
	Utilities = UDim2.new(.5, 0, 0, -10);
	Credits = UDim2.new(.85, 0, 0, -10)
}

if plugin:GetSetting("Dark") then
	GUI.Back.BackgroundColor3 = GuiColors.DarkMain
	for _,v in next, TopbarButtons:GetChildren() do if v:IsA("TextButton") then v.BackgroundColor3 = GuiColors.DarkMain v.TextColor3 = GuiColors.LightMain elseif v:IsA("Frame") then v.BackgroundColor3 = GuiColors.LightMain end end
	for _,v in next, Themes.Back.Container:GetChildren() do if v:IsA("Frame") then v.ThemeName.TextColor3 = GuiColors.LightMain end end
	for _,v in next, Credits.Back.Container:GetChildren() do if v:IsA("Frame") then v.CreditedName.TextColor3 = GuiColors.LightMain v.Info.TextColor3 = GuiColors.LightMain end end
	Themes.Back.ScrollBarImageColor3 = GuiColors.LightMain
	Credits.Back.ScrollBarImageColor3 = GuiColors.LightMain
	GUI.Back.Utilities.Back.DarkTheme.BackgroundColor3 = GuiColors.On
	GUI.Back.Utilities.Back.DarkTheme.Text = "Dark: On"
end

local ThemeScriptSource = Utilities.ThemeScriptSource
local UtilityFunctions = {
	["DarkTheme"] = function()
		DarkOn = not DarkOn
		plugin:SetSetting("Dark", DarkOn)
		if DarkOn then
			GUI.Back.BackgroundColor3 = GuiColors.DarkMain
			for _,v in next, TopbarButtons:GetChildren() do if v:IsA("TextButton") then v.BackgroundColor3 = GuiColors.DarkMain v.TextColor3 = GuiColors.LightMain elseif v:IsA("Frame") then v.BackgroundColor3 = GuiColors.LightMain end end
			for _,v in next, Themes.Back.Container:GetChildren() do if v:IsA("Frame") or v:IsA("ScrollingFrame") then v.ThemeName.TextColor3 = GuiColors.LightMain end end
			for _,v in next, Credits.Back.Container:GetChildren() do if v:IsA("Frame") or v:IsA("ScrollingFrame") then v.CreditedName.TextColor3 = GuiColors.LightMain v.Info.TextColor3 = GuiColors.LightMain end end
			Themes.Back.ScrollBarImageColor3 = GuiColors.LightMain
			Credits.Back.ScrollBarImageColor3 = GuiColors.LightMain
			GUI.Back.Utilities.Back.DarkTheme.BackgroundColor3 = GuiColors.On
			GUI.Back.Utilities.Back.DarkTheme.Text = "Dark: On"
		elseif not DarkOn then
			GUI.Back.BackgroundColor3 = GuiColors.LightMain
			for _,v in next, TopbarButtons:GetChildren() do if v:IsA("TextButton") then v.BackgroundColor3 = GuiColors.LightMain v.TextColor3 = GuiColors.DarkMain elseif v:IsA("Frame") then v.BackgroundColor3 = GuiColors.DarkMain end end
			for _,v in next, Themes.Back.Container:GetChildren() do if v:IsA("Frame") or v:IsA("ScrollingFrame") then v.ThemeName.TextColor3 = GuiColors.DarkMain end end
			for _,v in next, Credits.Back.Container:GetChildren() do if v:IsA("Frame") or v:IsA("ScrollingFrame") then v.CreditedName.TextColor3 = GuiColors.DarkMain v.Info.TextColor3 = GuiColors.DarkMain end end
			Themes.Back.ScrollBarImageColor3 = GuiColors.DarkMain
			Credits.Back.ScrollBarImageColor3 = GuiColors.DarkMain
			GUI.Back.Utilities.Back.DarkTheme.BackgroundColor3 = GuiColors.Off
			GUI.Back.Utilities.Back.DarkTheme.Text = "Dark: Off"
		end
	end,
	["ThemeData"] = function()
		local ThemeScript = Instance.new("ModuleScript")
		local CreditScript = Instance.new("ModuleScript")
		local StudioTheme = GetStudioTheme()
		ThemeScript.Source = require(Utilities.ThemeScriptSource).getString(GetStudioTheme())
		CreditScript.Source = require(Utilities.CreditScriptSource)
		ThemeScript.Name = "README"
		CreditScript.Name = "README"
		ThemeScript.Parent = game:GetService("ReplicatedStorage")
		CreditScript.Parent = game:GetService("ReplicatedStorage")
		print("ModuleScripts parented to 'ReplicatedStorage'. Very important, please read.")
	end
}

for i,v in next, TopbarButtons:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Down:Connect(function()
			if GUI.Back:FindFirstChild(v.Name) then
				local mousePos = Vector2.new(Mouse.X, Mouse.Y) - v.AbsolutePosition
				GUI.Back[CurrentlyViewing].Back.Visible = false
				spawn(function() doRipple(v, UDim2.new(0, mousePos.X, 0, mousePos.Y)) end)
				Selected:TweenPosition(Positions[v.Name], "InOut", "Sine", .25, true)
				GUI.Back[v.Name].Back.Visible = true
				CurrentlyViewing = v.Name
			else
				print("Cannot find "..v.Name.." in 'Back'")
			end
		end)
	end
end

local themeModules = Themes.ThemeModules
for _,t in next, themeModules:GetChildren() do
	if t:IsA("ModuleScript") then
		local Success, Info = pcall(require, t)
		if Success then
			local Info = require(t);
			local Frame = Themes.Back.Container["Template"]:Clone()
			Frame.Name = Info["Properties"].Name
			Frame.ThemeName.Text = Info["Properties"].Name
			Frame.Preview.Image = Info["Properties"].ImageId
			Frame.Parent = Themes.Back.Container
		else
			warn(Info)
		end
		
	elseif t:IsA("IntValue") then
		local Success, Info = pcall(require, t.Value)
		if Success then
			local Frame = Themes.Back.Container["Template"]:Clone()
			Frame.Name = Info["Properties"].Name
			Frame.ThemeName.Text = Info["Properties"].Name
			Frame.Preview.Image = Info["Properties"].ImageId
			Frame.Parent = Themes.Back.Container
		else
			warn(Info)
		end
	end
end
Themes.Back.Container["Template"]:Destroy()
scaleCanvasSize(Themes.Back)

local creditModules = Credits.CreditModules
local creditsBack = Credits.Back
for _,c in next, creditModules:GetChildren() do
	if c:IsA("ModuleScript") then
		--print(c.Name)
		local Success, Return = pcall(require, c)
		--print( (Success and "Got " or "Did not get ") .. c.Name)
		if Success then
			local Frame = creditsBack.Container["Template"]:Clone()
			Frame.Name = c.Name
			Frame.CreditedName.Text = Return[2]
			Frame.Info.Text = c.Name
			Frame.Avatar.Image = Return[1]
			Frame.Parent = creditsBack.Container
		else
			warn(Return)
		end
	elseif c:IsA("IntValue") then
		local Success, Return = pcall(require, c.Value)
		if Success then
			local Frame = creditsBack.Container["Template"]:Clone()
			Frame.Name = c.Name
			Frame.CreditedName.Text = Return[2]
			Frame.Info.Text = c.Name
			Frame.Avatar.Image = Return[1]
			Frame.Parent = creditsBack.Container
		else
			warn(Return)
		end
	end
end
creditsBack.Container.Template:Destroy()
scaleCanvasSize(Credits.Back)

local themeFrames = Themes.Back.Container:GetChildren()
for _,f in next, themeFrames do
	local ImageButton = f:FindFirstChildWhichIsA("ImageButton")
	if ImageButton then
		ImageButton.MouseButton1Down:Connect(function()
			if themeModules[f.Name] then
				local ThemeModule = require(themeModules[f.Name])
				ChangeTheme(ThemeModule.Properties.Name, ThemeModule.Settings)
			else
				warn("\""..f.Name.."\" module not found")
			end
		end)
	end
end

local Utility = Utilities.Back:GetChildren()
for _,s in next, Utility do
	if s:IsA("TextButton") then
		s.MouseButton1Down:Connect(function()
			local mousePos = Vector2.new(Mouse.X, Mouse.Y) - s.AbsolutePosition
			spawn(function() doRipple(s, UDim2.new(0, mousePos.X, 0, mousePos.Y)) end)
			UtilityFunctions[s.Name]()
		end)
	end
end

Themes.Back.Container.ChildAdded:Connect(function()
	scaleCanvasSize(Themes.Back)
end)

Credits.Back.Container.ChildAdded:Connect(function()
	scaleCanvasSize(Credits.Back)
end)
