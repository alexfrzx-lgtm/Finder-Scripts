task.wait(5)

---------------- CONFIG ----------------
local WEBHOOK_URL = "https://discord.com/api/webhooks/1465393299002228858/wJ2z0hQANHLFhCBmyVr3ATFdVG2AzZw_EmkmXd6NpPhcprJx5ppJ2_-otme0ggofFA_m"
local SCAN_DELAY = 0.3
--------------------------------------

local HttpService = game:GetService("HttpService")

local http_request =
    (request) or
    (http and http.request) or
    (syn and syn.request)

if not http_request then return end

--------------------------------------------------
-- 🔧 PRODUCCIÓN
--------------------------------------------------
local function parseProduction(text)
    local n, u = text:match("%$([%d%.]+)%s*([MBT])%s*/s")
    if not n then return end
    n = tonumber(n)
    if u == "M" then return n * 1e6 end
    if u == "B" then return n * 1e9 end
    if u == "T" then return n * 1e12 end
end

local function format(v)
    if v >= 1e12 then
        return string.format("$%.3fT/s", v/1e12):gsub("%.?0+T","T")
    elseif v >= 1e9 then
        return string.format("$%.3fB/s", v/1e9):gsub("%.?0+B","B")
    else
        return string.format("$%.3fM/s", v/1e6):gsub("%.?0+M","M")
    end
end

--------------------------------------------------
-- 🔍 SCAN
--------------------------------------------------
local function scan()
    local found = {}

    for _,ui in ipairs(workspace:GetDescendants()) do
        if ui:IsA("TextLabel") then
            local value = parseProduction(ui.Text)
            if value then
                local parent = ui.Parent
                local nameLabel

                for _,c in ipairs(parent:GetChildren()) do
                    if c:IsA("TextLabel") and not c.Text:find("%$") then
                        nameLabel = c
                        break
                    end
                end

                if nameLabel then
                    if not found[nameLabel.Text] then
                        found[nameLabel.Text] = {
                            name = nameLabel.Text,
                            value = value,
                            count = 1
                        }
                    else
                        found[nameLabel.Text].count += 1
                    end
                end
            end
        end
    end

    local list = {}
    for _,v in pairs(found) do
        table.insert(list, v)
    end

    return list
end

--------------------------------------------------
-- 📤 WEBHOOK
--------------------------------------------------
local lastHash

local function send(list)
    if #list == 0 then return end

    table.sort(list, function(a,b)
        return a.value > b.value
    end)

    local main = list[1]

    local function displayName(b)
        if b.count > 1 then
            return b.count.."x "..b.name
        else
            return b.name
        end
    end

    local others = ""
    for i = 2, #list do
        others = others .. (i-1)..". "..displayName(list[i]).." — "..format(list[i].value).."\n"
    end

    if others == "" then
        others = "_No other brainrots detected_"
    end

    local hash = main.name .. main.value .. main.count .. others
    if lastHash == hash then return end
    lastHash = hash

    local timeNow = os.date("%H:%M")

    http_request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            embeds = {{
                title = "🏆 "..displayName(main).." — "..format(main.value),
                description =
                    "**Other Brainrots**\n```text\n"..others.."\n```",
                color = 9807270,
                thumbnail = {
                    url = "https://steal-a-brainrot.org/_next/image?url=%2Fimages%2Fbrainrots%2F"
                        .. main.name:lower():gsub(" ","-") .. ".webp&w=3840&q=90"
                },
                fields = {
                    {
                        name = "**Server ID**",
                        value = "😂",
                        inline = false
                    }
                },
                footer = {
                    text = "✨ Showcase | Bryall Notifier | "..timeNow
                }
            }}
        })
    })
end

--------------------------------------------------
-- 🔁 LOOP
--------------------------------------------------
while true do
    send(scan())
    task.wait(SCAN_DELAY)
end
