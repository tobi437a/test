if not game:IsLoaded() then
	game.Loaded:Wait()
end

wait(5)

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local HttpService = game:GetService("HttpService")

localPlayer.OnTeleport:Connect(function(state)
    queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()")
end)

local function jumpToServer()
    local sfUrl = "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=%s&limit=%s&excludeFullGames=true"
    local req = request({Url=string.format(sfUrl, 19006211286, "Desc", 100)})
    local body = HttpService:JSONDecode(req.Body)
    local servers = {}

    if body and body.data then
        for i, v in ipairs(body.data) do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) then
                local availableSlots = v.maxPlayers - v.playing
                local minPlayersThreshold = 10

                if availableSlots > 0 and v.playing >= minPlayersThreshold and v.id ~= game.JobId then
                    table.insert(servers, v.id)
                end
            end
        end
    end

    if #servers > 0 then
        local randomServerIndex = math.random(1, #servers)
        local randomServerId = servers[randomServerIndex]

        game:GetService("TeleportService"):TeleportToPlaceInstance(19006211286, randomServerId, localPlayer)
    else
        warn("No available servers found.")
    end
end

for i = 1, 20 do
    game:GetService('TextChatService').TextChannels.RBXGeneral:SendAsync('Join gg / 6uUfW6uczr to gamble Pets Go gems and win big!')
    wait(1)
end

jumpToServer()
