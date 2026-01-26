pcall(function()

task.wait(1)

local _A,_B,_C,_D,_E = game,game:GetService("HttpService"),game:GetService("TeleportService"),os,string
local _P = game.Players.LocalPlayer

local function _d(s)
    return (s:gsub(".", function(c)
        return string.char(string.byte(c))
    end))
end

local _API = _d("https://games.roblox.com/v1/games/")
local _PID = game.PlaceId

local function _g()
    local r = _B:JSONDecode(game:HttpGet(_API.._PID.."/servers/Public?sortOrder=Asc&limit=100"))
    local t = {}

    for _,s in pairs(r.data or {}) do
        if type(s)=="table" and s.playing < s.maxPlayers then
            table.insert(t, s.id)
        end
    end

    return t
end

local function _h()
    local s = _g()
    if #s == 0 then return end
    _C:TeleportToPlaceInstance(_PID, s[math.random(#s)], _P)
end

while true do
    _h()
    task.wait(5)
end

end)
