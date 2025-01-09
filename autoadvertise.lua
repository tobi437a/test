if not game:IsLoaded() then
	game.Loaded:Wait()
end

wait(5)

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local HttpService = game:GetService("HttpService")

localPlayer.OnTeleport:Connect(function(state)
    queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/tobi437a/test/refs/heads/main/autoadvertise.lua'))()")
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

local phrases = {
    "Join gg / 6uUfW6uczr to gamble gems and win big!",
    "Win big rewards at gg / 6uUfW6uczr",
    "Play now at gg / 6uUfW6uczr for gems!",
    "Gamble gems at gg / 6uUfW6uczr and win big!",
    "Win amazing prizes by gambling your gems at gg / 6uUfW6uczr",
    "Multiply your gems at gg / 6uUfW6uczr",
    "Safe and fair gem gambling awaits you at gg / 6uUfW6uczr",
    "Trustworthy gem gambling available at gg / 6uUfW6uczr",
    "Experience secure gem gambling at gg / 6uUfW6uczr"
}

for i = 1, 15 do
    local message = phrases[math.random(1, #phrases)]
    game:GetService('TextChatService').TextChannels.RBXGeneral:SendAsync(message)
    wait(math.random(3, 7))
end

jumpToServer()
