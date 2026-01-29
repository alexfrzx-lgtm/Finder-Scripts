---------------- CONFIG ----------------
-- WEBHOOKS
local WEBHOOK_30M = "https://discord.com/api/webhooks/1465393299002228858/wJ2z0hQANHLFhCBmyVr3ATFdVG2AzZw_EmkmXd6NpPhcprJx5ppJ2_-otme0ggofFA_m"
local WEBHOOK_100M = "https://discord.com/api/webhooks/1466281358664929434/pLh23bjJAw7OSi6VeeYwY0uq09Es8zpGIqR4lI7JaLzWrOxKuVJtMShh4ly1LZuMgpgt"
local WEBHOOK_SHOWCASE = "https://discord.com/api/webhooks/1466366115876835372/0oNv0nzzK9FfO0a_NnmuyoT_SRVPbQt_rDpjUoFGPgB5k2QnGeFLMrveop5tzqLuAbIc"

-- MINIMOS
local MIN_PRODUCTION_30M = 33_500_000
local MIN_PRODUCTION_100M = 100_000_000

-- 🔔 PINGS (TODO CONFIGURABLE)
local ROLE_ID = "1466283703083995361"
local PING_ROLE_AT = 455_000_000      -- ping role en webhook 2
local PING_HERE_AT = 550_000_000      -- ping @here en showcase

local SCAN_DELAY = 0.5

--------------------------------------

local HttpService = game:GetService("HttpService")

local http_request =
    (request) or
    (http and http.request) or
    (syn and syn.request)

if not http_request then return end

--------------------------------------------------
-- IMÁGENES DE BRAINROTS
--------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--------------------------------------------------
-- IMÁGENES DE BRAINROTS (COMPLETO)
--------------------------------------------------
local BRAINROT_IMAGES = {

-- A
["Arcadopus"] = "https://www.lolga.com/uploads/images/goods/steal-a-brainrot/all-server-arcadopus.png",

-- B
["Bacuru and Egguru"] = "https://static.wikia.nocookie.net/stealabr/images/b/b5/Bacuru_and_Egguru.png",
["Brunito Marsito"] = "https://static.wikia.nocookie.net/stealabr/images/6/60/Brunito_Marsito_byLuiko.png",
["Burrito Bandito"] = "https://static.wikia.nocookie.net/stealabr/images/e/e6/PoTaTo.png",
["Burguro And Fryuro"] = "https://static.wikia.nocookie.net/stealabr/images/6/65/Burguro-And-Fryuro.png",

-- C
["Capitano Moby"] = "https://static.wikia.nocookie.net/stealabr/images/e/ef/Moby.png",
["Celularcini Viciosini"] = "https://media.discordapp.net/attachments/1452514638892634254/1459951125439713303/Celularcini_Viciosini.webp?format=png",
["Cerberus"] = "https://static.wikia.nocookie.net/stealabr/images/4/45/Cerberus.png",
["Chicleteira Bicicleteira"] = "https://static.wikia.nocookie.net/stealabr/images/5/5a/Chicleteira.png",
["Chicleteirina Bicicleteirina"] = "https://static.wikia.nocookie.net/stealabr/images/a/aa/Chicliterita_bicicliterita.png",
["Chicleteira Noelteira"] = "https://static.wikia.nocookie.net/stealabr/images/b/b3/Noel.png",
["Chill Puppy"] = "https://static.wikia.nocookie.net/stealabr/images/3/30/ChillPuppy.png",
["Chillin chili"] = "https://static.wikia.nocookie.net/stealabr/images/e/e0/Chilin.png",
["Chimnino"] = "https://static.wikia.nocookie.net/stealabr/images/c/c5/Chimnino.png",
["Chipso and Queso"] = "https://static.wikia.nocookie.net/stealabr/images/f/f8/Chipsoqueso.png",
["Cookie and Milki"] = "https://static.wikia.nocookie.net/stealabr/images/9/9b/Cooki_and_milki.png",

-- D
["DonkeyTurbo Express"] = "https://static.wikia.nocookie.net/stealabr/images/9/9a/DonkeyturboExpress.png",
["Dragon Canneloni"] = "https://static.wikia.nocookie.net/stealabr/images/3/31/Nah_uh.png",
["Dragon Gingerinni"] = "https://static.wikia.nocookie.net/stealabr/images/3/3a/DragonGingerini.png",

-- E
["Esok Sekolah"] = "https://static.wikia.nocookie.net/stealabr/images/2/2a/EsokSekolah2.png",
["Eviledon"] = "https://static.wikia.nocookie.net/stealabr/images/7/78/Eviledonn.png",

-- F
["Festive 67"] = "https://static.wikia.nocookie.net/stealabr/images/c/c8/TransparentFestive67.png",
["67"] = "https://static.wikia.nocookie.net/stealabr/images/8/83/BOIIIIIII_SIX_SEVEN_%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82.png",
["Fishino Clownino"] = "https://static.wikia.nocookie.net/stealabr/images/d/d6/Fishino_Clownino.png",
["Fragrama and Chocrama"] = "https://static.wikia.nocookie.net/stealabr/images/9/9a/Fragrama_and_Chocrama.png",

-- G
["Garama and Madundung"] = "https://static.wikia.nocookie.net/stealabr/images/e/ee/Garamadundung.png",
["Ginger Gerat"] = "https://static.wikia.nocookie.net/stealabr/images/8/85/GingerGerat.png",
["Goblino Uniciclino"] = "https://static.wikia.nocookie.net/stealabr/images/c/c5/Gobblino_Uniciclino.png",
["Guest 666"] = "https://static.wikia.nocookie.net/stealabr/images/9/99/Guest666t.png",

-- H
["Headless Horseman"] = "https://static.wikia.nocookie.net/stealabr/images/f/ff/Headlesshorseman.png",
["Hydra Dragon Cannelloni"] = "https://static.wikia.nocookie.net/stealabr/images/e/ee/Hydra_Dragon_Cannelloni.png",

-- J
["Jolly jolly Sahur"] = "https://static.wikia.nocookie.net/stealabr/images/f/f1/JollyJollySahur.png",

-- K
["Ketupat Bros"] = "https://static.wikia.nocookie.net/stealabr/images/4/4d/Ketupat_Bros.png",
["Ketupat Kepat"] = "https://static.wikia.nocookie.net/stealabr/images/a/ac/KetupatKepat.png",
["Ketchuru and Musturu"] = "https://static.wikia.nocookie.net/stealabr/images/1/14/Ketchuru.png",

-- L
["La Casa Boo"] = "https://static.wikia.nocookie.net/stealabr/images/d/de/Casa_Booo.png",
["La Extinct Grande"] = "https://static.wikia.nocookie.net/stealabr/images/c/cd/La_Extinct_Grande.png",
["La Ginger Sekohla"] = "https://static.wikia.nocookie.net/stealabr/images/1/14/Esok_Ginger.png",
["La Grande Combinasion"] = "https://static.wikia.nocookie.net/stealabr/images/d/d8/Carti.png",
["La Jolly Grande"] = "https://static.wikia.nocookie.net/stealabr/images/5/5f/La_Chrismas_Grande.png",
["La Secret Combinasion"] = "https://static.wikia.nocookie.net/stealabr/images/f/f2/Lasecretcombinasion.png",
["La Spooky Grande"] = "https://static.wikia.nocookie.net/stealabr/images/5/51/Spooky_Grande.png",
["La Supreme Combinasion"] = "https://static.wikia.nocookie.net/stealabr/images/5/52/SupremeCombinasion.png",
["La Taco Combinasion"] = "https://static.wikia.nocookie.net/stealabr/images/8/84/Latacocombi.png",
["Las Sis"] = "https://cdn.shopify.com/s/files/1/0837/8712/0919/files/Las_Sis_600x600.webp?v=1758288678",
["Lavadorito Spionito"] = "https://static.wikia.nocookie.net/stealabr/images/f/ff/Lavadorito_Spinito.png",
["Los 25"] = "https://static.wikia.nocookie.net/stealabr/images/9/9b/Transparent_Los_25.png",
["Los 67"] = "https://static.wikia.nocookie.net/stealabr/images/d/db/Los-67.png",
["Los Bros"] = "https://static.wikia.nocookie.net/stealabr/images/5/53/BROOOOOOOO.png",
["Los Burritos"] = "https://static.wikia.nocookie.net/stealabr/images/9/97/LosBurritos.png",
["Los Candies"] = "https://static.wikia.nocookie.net/stealabr/images/f/f9/Candy%21.png",
["Los Chicleteiras"] = "https://static.wikia.nocookie.net/stealabr/images/4/4d/Los_ditos.png",
["Los combinasionas"] = "https://static.wikia.nocookie.net/stealabr/images/3/36/Stop_taking_my_chips_im_just_a_baybeh.png",
["Los Hotspotsitos"] = "https://static.wikia.nocookie.net/stealabr/images/6/69/Loshotspotsitos.png",
["Los Jolly Combinasionas"] = "https://static.wikia.nocookie.net/stealabr/images/7/7b/Los_jollycombos.png",
["Los Mobilis"] = "https://static.wikia.nocookie.net/stealabr/images/2/27/Losmobil.png",
["Los nooo My Hotspotsitos"] = "https://cdn.salla.sa/jDznl/003869f6-f451-47df-a720-491c012bfe01-1000x1000-X33W5yduW5d98TIEmdHhWHYgFwI9KCVCrqSIdZaF.png",
["Los Planitos"] = "https://static.wikia.nocookie.net/stealabr/images/8/83/Los_Planitos.png",
["Los Primos"] = "https://static.wikia.nocookie.net/stealabr/images/9/96/LosPrimos.png",
["Los Quesadillas"] = "https://static.wikia.nocookie.net/stealabr/images/9/99/LosQuesadillas.png",
["Los Spaghettis"] = "https://static.wikitide.net/italianbrainrotwiki/c/cb/Los_spaggetis.webp",
["Los Spooky Combinasionas"] = "https://static.wikia.nocookie.net/stealabr/images/8/8a/Lospookycombi.png",
["Los Tacoritas"] = "https://static.wikia.nocookie.net/stealabr/images/4/40/My_kids_will_also_rob_you.png",

-- M
["Mariachi Corazoni"] = "https://static.wikia.nocookie.net/stealabr/images/5/5a/MariachiCora.png",
["Meowl"] = "https://static.wikia.nocookie.net/stealabr/images/b/b8/Clear_background_clear_meowl_image.png",
["Mieteteira Bicicleteira"] = "https://static.wikia.nocookie.net/stealabr/images/8/86/Mieteteira_Bicicleteira.png",
["Money Money Puggy"] = "https://static.wikia.nocookie.net/stealabr/images/0/09/Money_money_puggy.png",
["Money Money Reindeer"] = "https://static.wikia.nocookie.net/stealabr/images/e/ec/MoneyMoneyReindeer.png",

-- N
["Nuclearo Dinossauro"] = "https://static.wikia.nocookie.net/stealabr/images/c/c6/Nuclearo_Dinosauro.png",
["Noo my Candy"] = "https://static.wikia.nocookie.net/stealabr/images/1/12/Noo_my_candy_transparent.png",
["Noo my Present"] = "https://static.wikia.nocookie.net/stealabr/images/3/35/Noo_my_Present.png",
["Naughty Naughty"] = "https://static.wikia.nocookie.net/stealabr/images/1/13/Sought_the_naught.png",


-- O
["Orcaledon"] = "https://static.wikia.nocookie.net/stealabr/images/a/a6/Orcaledon.png",

-- Q
["Quesadilla Vampiro"] = "https://static.wikia.nocookie.net/stealabr/images/0/0e/VampiroQuesa.png", 
["Quesadilla Crocodila"] = "https://static.wikia.nocookie.net/stealabr/images/3/3f/QuesadillaCrocodilla.png",

-- R
["Rang Ring Bus"] = "https://static.wikia.nocookie.net/stealabr/images/2/2b/RingRangBus2.png",
["Reinito Sleighito"] = "https://static.wikia.nocookie.net/stealabr/images/2/27/Reinito.png",

-- S
["Skibidi Toilet"] = "https://static.wikia.nocookie.net/stealabr/images/3/34/Skibidi_toilet.png",
["Spinny Hammy"] = "https://static.wikia.nocookie.net/stealabr/images/7/7d/SpinnyHammy.png",
["Spaghetti Tualetti"] = "https://static.wikia.nocookie.net/stealabr/images/b/b8/Spaghettitualetti.png",
["Spooky and Pumpky"] = "https://static.wikia.nocookie.net/stealabr/images/d/d6/Spookypumpky.png",
["Strawberry Elephant"] = "https://static.wikia.nocookie.net/stealabr/images/5/58/Strawberryelephant.png",
["Swag Soda"] = "https://static.wikia.nocookie.net/stealabr/images/9/9f/Swag_Soda.png",
["Swaggy Bros"] = "https://static.wikia.nocookie.net/stealabr/images/8/85/Swaggy_Bros.png",

-- T
["Tacorita Bicicleta"] = "https://static.wikia.nocookie.net/stealabr/images/0/0f/Gonna_rob_you_twin.png",
["Tang Tang Keletang"] = "https://static.wikia.nocookie.net/stealabr/images/c/ce/TangTangVfx.png",
["Tictac Sahur"] = "https://static.wikia.nocookie.net/stealabr/images/6/6f/Time_moving_slow.png",
["Tralaledon"] = "https://static.wikia.nocookie.net/stealabr/images/7/79/Brr_Brr_Patapem.png",
["Tuff Toucan"] = "https://static.wikia.nocookie.net/stealabr/images/3/3e/TuffToucan.png",

-- W
["W or L"] = "https://static.wikia.nocookie.net/stealabr/images/2/28/Win_Or_Lose.png",
}
-- local BRAINROT_IMAGES = { ... }
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--------------------------------------------------

--------------------------------------------------
-- NORMALIZAR NOMBRES (ANTI BUGS)
--------------------------------------------------
local function normalizeName(name)
    return name
        :lower()
        :gsub("^%s+", "")
        :gsub("%s+$", "")
        :gsub("%s+", " ")
end

local NORMALIZED_IMAGES = {}
for name, url in pairs(BRAINROT_IMAGES) do
    NORMALIZED_IMAGES[normalizeName(name)] = url
end

local function getBrainrotImage(name)
    return NORMALIZED_IMAGES[normalizeName(name)]
end

--------------------------------------------------
-- PRODUCCIÓN
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
-- SCAN (FIX DEFINITIVO PARA x2, x4, x8...)
--------------------------------------------------
local function scan(minProduction)
    local list = {}

    for _,ui in ipairs(workspace:GetDescendants()) do
        if ui:IsA("TextLabel") then
            local value = parseProduction(ui.Text)
            if value and value >= minProduction then

                local parent = ui.Parent

                for _,c in ipairs(parent:GetChildren()) do
                    if c:IsA("TextLabel") and not c.Text:find("%$") then
                        table.insert(list, {
                            name = c.Text,
                            value = value
                        })
                        break
                    end
                end
            end
        end
    end

    return list
end

--------------------------------------------------
-- WEBHOOK
--------------------------------------------------

local notified30M = {}
local notified100M = {}
local notifiedShowcase = {}

local function send(list, webhook, pingRole, lastHashRef)
    if #list == 0 then return end

    -- ordenar por el que más genera
    table.sort(list, function(a,b)
        return a.value > b.value
    end)

    local main = list[1]
    local hash =
    normalizeName(main.name)
    .. "|"
    .. tostring(math.floor(main.value))
    .. "|"
    .. game.JobId

    if not lastHashRef then lastHashRef = {} end
if lastHashRef[hash] then return end
lastHashRef[hash] = true

--------------------------------------------------
    -- AGRUPAR OTHER BRAINROTS (x2, x3, x4...)
--------------------------------------------------
    local grouped = {}

    for i = 2, #list do
        local v = list[i]
        local key = v.name -- 🔥 FIX: agrupar SOLO por nombre

        grouped[key] = grouped[key] or {
            name = v.name,
            value = v.value,
            count = 0
        }
        grouped[key].count += 1
    end

    local others = ""
    local index = 1
    local hasOthers = false

    -- ORDENAR OTHER BRAINROTS DE MAYOR A MENOR
local ordered = {}
for _,v in pairs(grouped) do
    table.insert(ordered, v)
end

table.sort(ordered, function(a, b)
    return a.value > b.value
end)

for _,v in ipairs(ordered) do
    hasOthers = true

    local label = v.name
    if v.count > 1 then
        label = "x"..v.count.." "..label
    end

    others = others
        .. index .. ". " .. label .. "\n"
        .. "— " .. format(v.value) .. "\n"

    index += 1
end

    --------------------------------------------------
    -- JOIN INFO
--------------------------------------------------
    local jobId = game.JobId
    local placeId = game.PlaceId

    local joinLink =
        "https://chillihub1.github.io/chillihub-joiner/?placeId="
        .. placeId ..
        "&gameInstanceId=" .. jobId

    --------------------------------------------------
-- EMBED
--------------------------------------------------
local embed = {
    color = 1317145,
    footer = { text = "✨ Highlights | BryAll Notifier" },
    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
}

-- Título (mejor brainrot)
embed.title = "💎 **" .. main.name .. "**"

-- Producción
embed.description = "**— " .. format(main.value) .. "**\n\n"

--------------------------------------------------
-- SERVER ID
--------------------------------------------------
embed.description = embed.description ..
    "**Server ID**\n```" .. jobId .. "```\n"

--------------------------------------------------
-- JOIN SERVER
--------------------------------------------------
embed.description = embed.description ..
    "**Join Server**\n[CLICK TO JOIN](" .. joinLink .. ")\n\n"

--------------------------------------------------
-- OTHER BRAINROTS
--------------------------------------------------
if hasOthers then
    embed.description = embed.description ..
        "**Other Brainrots**\n```" .. others .. "```\n\n"
end

--------------------------------------------------
-- THUMBNAIL
--------------------------------------------------
local img = getBrainrotImage(main.name)
if img then
    embed.thumbnail = { url = img }
end

--------------------------------------------------
-- ENVIAR WEBHOOK (CON O SIN PING)
--------------------------------------------------
local content = nil
if webhook == WEBHOOK_100M and main.value >= PING_ROLE_AT then
    content = "<@&" .. ROLE_ID .. ">"
end

-- enviar a la webhook principal
http_request({
    Url = webhook,
    Method = "POST",
    Headers = { ["Content-Type"] = "application/json" },
    Body = HttpService:JSONEncode({
        content = content,
        embeds = { embed }
    })
})

-- 🔥 SHOWCASE (COPIA DE LA 100M)
if webhook == WEBHOOK_100M then
    local showcaseEmbed = table.clone(embed)

    -- SOLO SERVER ID TROLL 😂 (sin join, sin jobid)
    showcaseEmbed.description = showcaseEmbed.description
        :gsub("%*%*Server ID%*%*.-\n\n", "**Server ID**\n😂\n\n")
        :gsub("%*%*Join Server%*%*.-\n\n", "")

    local showcaseContent = nil
    if main.value >= PING_HERE_AT then
        showcaseContent = "@here"
    end

    http_request({
        Url = WEBHOOK_SHOWCASE,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode({
            content = showcaseContent,
            embeds = { showcaseEmbed }
        })
    })
end

end -- ✅ CIERRE CORRECTO DE function send

--------------------------------------------------
-- LOOP
--------------------------------------------------
while true do
    send(
        scan(MIN_PRODUCTION_30M),
        WEBHOOK_30M,
        false,
        notified30M
    )

    send(
        scan(MIN_PRODUCTION_100M),
        WEBHOOK_100M,
        true,
        notified100M
    )

    task.wait(SCAN_DELAY)
end
