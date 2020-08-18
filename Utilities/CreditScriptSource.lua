return [[
-- If you're uploading this yourself --
-- Replace UserID with your UserId so you get credit for your theme.
-- Rename this ModuleScript to "MainModule" and upload to Roblox. Be sure to allow copying.  <- this step is important.
-- Reply to https://devforum.roblox.com/t/script-editor-themes-plugin/262870 with the ID of the module.
-- If you want me to upload --
-- Reply to https://devforum.roblox.com/t/script-editor-themes-plugin/262870 with the code contained in this module.
-- Preferably in a spoiler.
local Players = game:GetService("Players")
local UserID = 1

local function GetUserInfo(ID)
	local URL, Ready = Players:GetUserThumbnailAsync(ID, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100);
	local Username = Players:GetNameFromUserIdAsync(ID)
	if Ready and Username then
		return {AvatarThumbnailURL = URL, Username = Username}
	end
end

return GetUserInfo(UserID)]]