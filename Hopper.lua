task.wait(2)

---------------- CONFIG ----------------
local HOP_DELAY = 35      -- 🔥 5 MINUTOS
local RETRY_DELAY = 3
local COUNT_STEP = 30      -- actualiza cada 30s
--------------------------------------

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local PLACE_ID = game.PlaceId
local CURRENT_JOB_ID = game.JobId

--------------------------------------------------
-- 🛡️ ANTI AFK (INPUT)
--------------------------------------------------
player.Idled:Connect(function()
	VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

--------------------------------------------------
-- 🚶‍♂️ ANTI AFK (MOVE EVERY 60s)
--------------------------------------------------
task.spawn(function()
	while true do
		task.wait(60)
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame *= CFrame.new(0,0,-1)
		end
	end
end)

--------------------------------------------------
-- 🔊 SOUND
--------------------------------------------------
local alarm = Instance.new("Sound", player.PlayerGui)
alarm.SoundId = "rbxassetid://5476307813"
alarm.Volume = 1.2
alarm.Looped = true

local function startAlarm()
	if not alarm.IsPlaying then alarm:Play() end
end

local function stopAlarm()
	if alarm.IsPlaying then alarm:Stop() end
end

--------------------------------------------------
-- 🖥️ UI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,350,0,60)
frame.Position = UDim2.new(0.5,-175,0.08,0)
frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- 🔘 GREY NEON GLOW
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(180,180,180)
stroke.Thickness = 2
stroke.Transparency = 0.2

task.spawn(function()
	while true do
		TweenService:Create(stroke, TweenInfo.new(0.8), {Transparency = 0}):Play()
		task.wait(0.8)
		TweenService:Create(stroke, TweenInfo.new(0.8), {Transparency = 0.4}):Play()
		task.wait(0.8)
	end
end)

--------------------------------------------------
-- TEXT
--------------------------------------------------
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1,-16,0,28)
label.Position = UDim2.new(0,8,0,4)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(240,240,240)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 18
label.RichText = true
label.Text = "Server Hopping ⚡️"

--------------------------------------------------
-- BAR
--------------------------------------------------
local barBg = Instance.new("Frame", frame)
barBg.Size = UDim2.new(1,-16,0,8)
barBg.Position = UDim2.new(0,8,0,40)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = Color3.fromRGB(0,255,120) -- verde normal
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill)

--------------------------------------------------
-- BAR BLINK (ONLY AT END)
--------------------------------------------------
local blinkRunning = false
local COLOR_GREEN = Color3.fromRGB(0,255,120)
local COLOR_RED   = Color3.fromRGB(255,60,60)

local function startBlink()
	if blinkRunning then return end
	blinkRunning = true
	task.spawn(function()
		while blinkRunning do
			TweenService:Create(barFill, TweenInfo.new(0.6), {BackgroundColor3 = COLOR_RED}):Play()
			task.wait(0.6)
			TweenService:Create(barFill, TweenInfo.new(0.6), {BackgroundColor3 = COLOR_GREEN}):Play()
			task.wait(0.6)
		end
	end)
end

--------------------------------------------------
-- FADE TEXT
--------------------------------------------------
local function fadeText(text)
	label.TextTransparency = 1
	label.Text = text
	TweenService:Create(label,TweenInfo.new(0.4),{TextTransparency=0}):Play()
end

--------------------------------------------------
-- SERVER FETCH
--------------------------------------------------
local tried = {}

local function findServer()
	local ok, data = pcall(function()
		return HttpService:JSONDecode(
			game:HttpGet("https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?limit=100")
		)
	end)

	if not ok or not data or not data.data then return nil end

	for _,s in ipairs(data.data) do
		if s.id ~= CURRENT_JOB_ID and not tried[s.id] and s.playing < s.maxPlayers then
			return s.id
		end
	end

	return nil
end

--------------------------------------------------
-- SEARCH & HOP
--------------------------------------------------
local attempts = 0

local function searchAndHop()
	startAlarm()
	startBlink()

	while true do
		attempts += 1
		fadeText("Searching server <b>("..attempts..")</b>")

		local id = findServer()
		if id then
			tried[id] = true
			stopAlarm()
			fadeText("Joining server ⚡️")
			task.wait(0.8)
			TeleportService:TeleportToPlaceInstance(PLACE_ID, id, player)
			return
		end

		task.wait(RETRY_DELAY)

		if attempts >= 15 then
			fadeText("Forcing new server ⚡️")
			TeleportService:Teleport(PLACE_ID, player)
			return
		end
	end
end

--------------------------------------------------
-- BAR TIMER (5 MIN)
--------------------------------------------------
TweenService:Create(
	barFill,
	TweenInfo.new(HOP_DELAY, Enum.EasingStyle.Linear),
	{Size = UDim2.new(1,0,1,0)}
):Play()

for t = HOP_DELAY, 0, -COUNT_STEP do
	fadeText("Server Hopping ⚡️ <b>("..math.floor(t/60).."m "..(t%60).."s)</b>")
	task.wait(COUNT_STEP)
end

searchAndHop()
