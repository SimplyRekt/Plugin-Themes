local ThemeScriptSource = {}

ThemeScriptSource.getString = function(StudioTheme)
	return ([[
-- If you're uploading this yourself --
-- Change the name of the "Name" property to the name of your theme.
-- Take a screenshot of the script editor, about 150x80. Does not have to be perfect. <- the current image is "original light," so it will default to that if you do not provide a screenshot.
-- Rename this ModuleScript to "MainModule" and upload to Roblox. Be sure to allow copying. <- this step is important.
-- Reply to https://devforum.roblox.com/t/script-editor-themes-plugin/262870 with the ID and the *exact name* of the module.
-- If you want me to upload --
-- Reply to https://devforum.roblox.com/t/script-editor-themes-plugin/262870 with the code contained in this module.
-- Preferably in a spoiler.

return {
	Properties = {
		["Name"] = "Theme";
		["ImageId"] = "rbxassetid://2919688393";
	},
	Settings = {
		["Background Color"] = %s;
		["Built-in Function Color"] = %s;
		["Comment Color"] = %s;
		["Error Color"] = %s;
		["Find Selection Background Color"] = %s;
		["Keyword Color"] = %s;
		["Matching Word Background Color"] = %s;
		["Number Color"] = %s;
		["Operator Color"] = %s;
		["Preprocessor Color"] = %s;
		["Selection Background Color"] = %s;
		["Selection Color"] = %s;
		["String Color"] = %s;
		["Text Color"] = %s;
		["Warning Color"] = %s;
	}
}]]):format(unpack(StudioTheme))
end

return ThemeScriptSource