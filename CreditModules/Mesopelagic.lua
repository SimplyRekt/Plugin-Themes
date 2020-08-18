local Players = game:GetService("Players")
local UserID = 120385818;

local function GetUserInfo(ID)
	local URL, Ready = Players:GetUserThumbnailAsync(ID, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100);
	local Username = Players:GetNameFromUserIdAsync(ID)
	if Ready and Username then
		return {URL, Username}
	elseif not Ready and Username then
		return {"rbxassetid://8167273", Username}
	elseif Ready and not Username then
		return {Ready, "UNKNOWN (error)"}
	elseif not Ready and not Username then
		return {"rbxassetid://8167273", "UNKNOWN (error)"}
	end
end

return GetUserInfo(UserID)