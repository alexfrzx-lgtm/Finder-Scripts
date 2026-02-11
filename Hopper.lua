--// CONFIG
local blockedPlayers = {
["NoahFri3ndlyultra241"]=true,
["Ethan_Vortex70"]=true,
["FoxRainbowbubble"]=true,
["Ch0c0t0astr0ck3t"]=true,
["moon_TURBO9816"]=true,
["EllaFriendly2893"]=true,
["Lilypurple6709"]=true,
["AlexFrost150"]=true,
["Chl0e_R0CKET4167"]=true,
["greensnow7865"]=true,
["Jumb0Pink82"]=true,
["Sammoonzippy"]=true,
["rock3t_Sports2814"]=true,
["EthanFriendly1587"]=true,
["Olivermicro7790"]=true,
["M3gashadow1174"]=true,
["Windsilverfox3966"]=true,
["astr0Hyper41"]=true,
["SophieWaverobotic"]=true,
["Megapeppermint80"]=true,
["SunnySportslucky5187"]=true,
["Storm_ultra2557"]=true,
["tiny_TOAST4438"]=true,
["Chloe_Pepper34"]=true,
["EthanDogcool4882"]=true,
["DogultraPink"]=true,
["Al3xGr33nfuzzy"]=true,
["Sophiebubble1448"]=true,
["Biglucky7267"]=true,
["m00n_Otter70"]=true,
["robot_Banana3244"]=true,
["redspeedy7188"]=true,
["JackNinjaunicorn6590"]=true,
["BearGalaxy6118"]=true,
["pepperAstr08801"]=true,
["BenMarble91"]=true,
["Miafrostcandy"]=true,
["goldflamered2913"]=true,
["Miamegaf0rest4370"]=true,
["mega_Green11"]=true,
["bunnyWindStar707613"]=true,
["jumb0candysunny"]=true,
["fox_rain186"]=true,
["EthanChoco7600"]=true,
["Mega_ocean9408"]=true,
["hyp3rcom3t2129"]=true,
["Sophieastro2116"]=true,
["happykoalaChoco"]=true,
["ninja0tter476596"]=true,
["pixelFrost215613"]=true,
["LilySnowywolf"]=true,
["spark_micro1746"]=true,
["StormWavesuper"]=true,
["SophieCandy4784"]=true,
["SammegaPixel"]=true,
["Wolf_las3r1891"]=true,
["Alexstarbird47"]=true,
["cloudsunny2274"]=true,
}

--// SERVICES
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local placeId = game.PlaceId
local currentJobId = game.JobId

local triedServers = {}
local attempts = 0

--// UI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local background = Instance.new("Frame", screenGui)
background.Size = UDim2.new(1,0,0,25)
background.BackgroundColor3 = Color3.fromRGB(25,25,25)
background.BorderSizePixel = 0

local bar = Instance.new("Frame", background)
bar.Size = UDim2.new(1,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(0,200,255)
bar.BorderSizePixel = 0

local text = Instance.new("TextLabel", background)
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.TextColor3 = Color3.new(1,1,1)
text.TextScaled = true
text.Font = Enum.Font.SourceSansBold

--// FUNCIONES
local function hasBlockedPlayer()
    for _, plr in pairs(Players:GetPlayers()) do
        if blockedPlayers[plr.Name] then
            return plr.Name
        end
    end
    return nil
end

local function findServer()
    local cursor = ""
    while true do
        local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..cursor
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)
        if success and result and result.data then
            for _, server in pairs(result.data) do
                if server.playing < server.maxPlayers
                and server.id ~= currentJobId
                and not triedServers[server.id] then
                    triedServers[server.id] = true
                    return server.id
                end
            end
            if result.nextPageCursor then
                cursor = result.nextPageCursor
            else
                break
            end
        else
            break
        end
    end
    return nil
end

local function forceHop()
    local serverId
    repeat
        attempts += 1
        text.Text = "Forzando hop... (Intentos: "..attempts..")"
        serverId = findServer()
        task.wait(1)
    until serverId
    TeleportService:TeleportToPlaceInstance(placeId, serverId, player)
    triedServers = {}
end

--// DETECTAR BLOQUEADOS EN TIEMPO REAL
Players.PlayerAdded:Connect(function(plr)
    if blockedPlayers[plr.Name] then
        text.Text = "Detectado "..plr.Name.." ! Hop inmediato..."
        forceHop()
    end
end)

--// LOOP ULTRA-TURBO: chequea bloqueados existentes y hace hop
task.spawn(function()
    while true do
        local blocked = hasBlockedPlayer()
        if blocked then
            text.Text = "Detectado "..blocked.." ! Hop inmediato..."
            forceHop()
        end
        task.wait(0.5) -- chequeo cada medio segundo
    end
end)

--// LOOP NORMAL (opcional barra de hop)
local HOP_TIME = 60
while true do
    for i = HOP_TIME,0,-1 do
        bar.Size = UDim2.new(i/HOP_TIME,0,1,0)
        text.Text = "Hop en: "..i.."s (Intentos: "..attempts..")"
        task.wait(1)
    end
    forceHop()
end
