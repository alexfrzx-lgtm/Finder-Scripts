-- SB Server Hop FINAL REAL (2 MIN + ANTI AFK + ANTI DC)

task.wait(2)

---------------- CONFIG ----------------
local HOP_DELAY = 120 -- 2 MINUTOS
local RETRY_DELAY = 5
--------------------------------------

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local PLACE_ID = game.PlaceId
local CURRENT_JOB_ID = game.JobId

--------------------------------------------------
-- 🛡️ ANTI AFK
--------------------------------------------------
player.Idled:Connect(function()
	VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

--------------------------------------------------
-- SOUND
--------------------------------------------------
local alarm = Instance.new("Sound")
alarm.SoundId = "rbxassetid://5476307813"
alarm.Volume = 1.5
alarm.Looped = true
alarm.Parent = player:WaitForChild("PlayerGui")

pcall(function()
	ContentProvider:PreloadAsync({alarm})
end)

local function startAlarm()
	if not alarm.IsPlaying then alarm:Play() end
end

local function stopAlarm()
	if alarm.IsPlaying then alarm:Stop() end
end

--------------------------------------------------
-- UI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local container = Instance.new("Frame", gui)
container.Size = UDim2.new(0, 340, 0, 56)
container.Position = UDim2.new(0.5, -170, 0.08, 0)
container.BackgroundColor3 = Color3.fromRGB(35,35,35)
container.BorderSizePixel = 0
Instance.new("UICorner", container).CornerRadius = UDim.new(0,10)

local stroke = Instance.new("UIStroke", container)
stroke.Color = Color3.fromRGB(120,120,120)
stroke.Thickness = 1
stroke.Transparency = 0.5

local glowIn = TweenService:Create(stroke, TweenInfo.new(1.6), {Transparency = 0.2, Thickness = 2})
local glowOut = TweenService:Create(stroke, TweenInfo.new(1.6), {Transparency = 0.5, Thickness = 1})

local glowRunning = true
task.spawn(function()
	while glowRunning do
		glowIn:Play(); glowIn.Completed:Wait()
		glowOut:Play(); glowOut.Completed:Wait()
	end
end)

local label = Instance.new("TextLabel", container)
label.Size = UDim2.new(1,-16,0,26)
label.Position = UDim2.new(0,8,0,4)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(230,230,230)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 18
label.RichText = true
label.Text = "Server hop in <b>120</b>s"

--------------------------------------------------
-- PROGRESS BAR
--------------------------------------------------
local barBg = Instance.new("Frame", container)
barBg.Size = UDim2.new(1,-16,0,8)
barBg.Position = UDim2.new(0,8,0,38)
barBg.BackgroundColor3 = Color3.fromRGB(55,55,55)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = Color3.fromRGB(80,220,120)
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill)

TweenService:Create(
	barFill,
	TweenInfo.new(HOP_DELAY, Enum.EasingStyle.Linear),
	{Size = UDim2.new(1,0,1,0)}
):Play()

--------------------------------------------------
-- COUNTDOWN
--------------------------------------------------
task.spawn(function()
	local t = HOP_DELAY
	while t > 0 do
		label.Text = "Server hop in <b>"..t.."</b>s"
		task.wait(10)
		t -= 10
	end

	startAlarm()
	label.Text = "Searching for <b>server</b>"
end)

--------------------------------------------------
-- SERVER FETCH
--------------------------------------------------
local triedServers = {}

local function getNextServer()
	local url = "https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?limit=100&sortOrder=Asc"
	local data = HttpService:JSONDecode(game:HttpGet(url))

	for _,server in ipairs(data.data) do
		if server.id ~= CURRENT_JOB_ID
		and not triedServers[server.id]
		and server.playing < server.maxPlayers then
			return server.id
		end
	end
end

--------------------------------------------------
-- TELEPORT (ANTI DC)
--------------------------------------------------
local function hop()
	local serverId = getNextServer()

	if serverId then
		triedServers[serverId] = true
		stopAlarm()
		glowRunning = false
		TeleportService:TeleportToPlaceInstance(PLACE_ID, serverId, player)
	else
		label.Text = "Retrying..."
		task.delay(RETRY_DELAY, hop)
	end
end

TeleportService.TeleportInitFailed:Connect(function()
	startAlarm()
	task.delay(RETRY_DELAY, hop)
end)

task.delay(HOP_DELAY, hop)
