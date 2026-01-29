-- SB Server Hop FINAL REAL (2 MIN + ANTI AFK + ANTI DC + FIX FREEZE)

task.wait(2)

---------------- CONFIG ----------------
local HOP_DELAY = 180
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
-- SERVER FETCH (FIXED)
--------------------------------------------------
local triedServers = {}
local badServers = {}

local MIN_PLAYERS = 2
local MIN_FREE_SLOTS = 1

local function getNextServer()
	local success, data = pcall(function()
		return HttpService:JSONDecode(
			game:HttpGet("https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?limit=100&sortOrder=Desc")
		)
	end)

	if not success or not data or not data.data then
		return nil
	end

	for _, server in ipairs(data.data) do
		local freeSlots = server.maxPlayers - server.playing
		if server.id ~= CURRENT_JOB_ID
		and not triedServers[server.id]
		and not badServers[server.id]
		and server.playing >= MIN_PLAYERS
		and freeSlots >= MIN_FREE_SLOTS then
			return server.id
		end
	end
end

--------------------------------------------------
-- TELEPORT (ANTI FREEZE)
--------------------------------------------------
local searchingTries = 0

local function hop()
	searchingTries += 1

	local serverId = getNextServer()

	if serverId then
		searchingTries = 0
		triedServers[serverId] = true
		stopAlarm()
		glowRunning = false
		TeleportService:TeleportToPlaceInstance(PLACE_ID, serverId, player)
	else
		label.Text = "Searching server ("..searchingTries..")"
		if searchingTries >= 4 then
			local data = HttpService:JSONDecode(
				game:HttpGet("https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?limit=100")
			)
			for _, server in ipairs(data.data) do
				if server.id ~= CURRENT_JOB_ID then
					TeleportService:TeleportToPlaceInstance(PLACE_ID, server.id, player)
					return
				end
			end
		end
		task.delay(RETRY_DELAY + 5, hop)
	end
end

TeleportService.TeleportInitFailed:Connect(function()
	for id,_ in pairs(triedServers) do
		badServers[id] = true
	end
	startAlarm()
	task.delay(RETRY_DELAY + 5, hop)
end)

task.delay(HOP_DELAY, hop)
