---------------- CONFIG ----------------

--Bloqueados
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

-- SERVICES
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local placeId = game.PlaceId
local currentJobId = game.JobId

local triedServers = {}
local attempts = 0

-- UI
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

-- FUNCIONES
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

-- DETECTAR Players.PlayerAdded:Connect(function(plr) if blockedPlayers[plr.Name] then text.Text = "Detectado "..plr.Name.." ! Hop inmediato..." forceHop() end end)

-- LOOP NORMAL (HOP CADA 7s)

local HOP_TIME = 7

task.spawn(function()
    while true do
        for i = HOP_TIME,0,-1 do
            bar.Size = UDim2.new(i/HOP_TIME,0,1,0)
            text.Text = "Hop en: "..i.."s (Intentos: "..attempts..")"
            task.wait(1)
        end
        forceHop()
    end
end)

-- WEBHOOKS
local WEBHOOK_50M = "https://discord.com/api/webhooks/1465393299002228858/wJ2z0hQANHLFhCBmyVr3ATFdVG2AzZw_EmkmXd6NpPhcprJx5ppJ2_-otme0ggofFA_m"
local WEBHOOK_SHOWCASE = "https://discord.com/api/webhooks/1472370425123049571/OAlyVoxMrhp4yOP1loAezHF-zkKDWPLDAA29Ko9M2DT7wGHJSTyXj8bImw6vInl4VhoC"

-- MINIMOS
local MIN_PRODUCTION_50M = 50_000_000

-- PINGS
local PING_HERE_AT = 550_000_000

local SCAN_DELAY = 0.1


--------------------------------------

local HttpService = game:GetService("HttpService")

local http_request =
    (request) or
    (http and http.request) or
    (syn and syn.request)

if not http_request then return end

-- IMÁGENES DE BRAINROTS (COMPLETO)

local BRAINROT_IMAGES = {

-- A
["Arcadopus"] = "https://www.lolga.com/uploads/images/goods/steal-a-brainrot/all-server-arcadopus.png",
["Mi Gatito"] = "https://static.wikia.nocookie.net/stealabr/images/5/50/AyMiGatito.png",

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
["Cooki and Milki"] = "https://static.wikia.nocookie.net/stealabr/images/9/9b/Cooki_and_milki.png",
["Cupid Cupid Sahur"] = "https://static.wikia.nocookie.net/stealabr/images/8/89/Cupid_Cupid_Sahur.png",
["Cupid Hotspot"] = "https://static.wikia.nocookie.net/stealabr/images/1/1f/Pot_Cupid.png",
["Chicleteira Cupideira"] = "https://static.wikia.nocookie.net/stealabr/images/6/6f/Chicleteira_Cupideira.png",

-- D
["DonkeyTurbo Express"] = "https://static.wikia.nocookie.net/stealabr/images/9/9a/DonkeyturboExpress.png",
["Dragon Cannelloni"] = "https://static.wikia.nocookie.net/stealabr/images/3/31/Nah_uh.png",
["Dragon Gingerini"] = "https://static.wikia.nocookie.net/stealabr/images/3/3a/DragonGingerini.png",

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
["Gobblino Uniciclino"] = "https://static.wikia.nocookie.net/stealabr/images/c/c5/Gobblino_Uniciclino.png",
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
["La Ginger Sekolah"] = "https://static.wikia.nocookie.net/stealabr/images/1/14/Esok_Ginger.png",
["La Grande Combinasion"] = "https://static.wikia.nocookie.net/stealabr/images/d/d8/Carti.png",
["La Jolly Grande"] = "https://static.wikia.nocookie.net/stealabr/images/5/5f/La_Chrismas_Grande.png",
["La Secret Combinasion"] = "https://static.wikia.nocookie.net/stealabr/images/f/f2/Lasecretcombinasion.png",
["La Spooky Grande"] = "https://static.wikia.nocookie.net/stealabr/images/5/51/Spooky_Grande.png",
["La Supreme Combinasion"] = "https://static.wikia.nocookie.net/stealabr/images/5/52/SupremeCombinasion.png",
["La Taco Combinasion"] = "https://static.wikia.nocookie.net/stealabr/images/8/84/Latacocombi.png",
["Las Sis"] = "https://cdn.shopify.com/s/files/1/0837/8712/0919/files/Las_Sis_600x600.webp?v=1758288678",
["Lavadorito Spinito"] = "https://static.wikia.nocookie.net/stealabr/images/f/ff/Lavadorito_Spinito.png",
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
["Los Puggies"] = "https://static.wikia.nocookie.net/stealabr/images/c/c8/LosPuggies2.png",
["Los Mi Gatitos"] = "https://static.wikia.nocookie.net/stealabr/images/a/af/Los_ay_Gattitos.png",
["Lovin Rose"] = "https://static.wikia.nocookie.net/stealabr/images/a/ab/LovinRose.png",
["Love Love Bear"] = "https://static.wikia.nocookie.net/stealabr/images/b/bf/Love_Love_Bear.png",
["La Romantic Grande"] = "https://static.wikia.nocookie.net/stealabr/images/d/d2/LaRomanricGrande_LeakBySammy.png",

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
["Noo my Heart"] = "https://static.wikia.nocookie.net/stealabr/images/7/75/NooMyLoveheart.png",


-- O
["Orcaledon"] = "https://static.wikia.nocookie.net/stealabr/images/a/a6/Orcaledon.png",

-- P
["Popcuru and Fizzuru"] = "https://static.wikia.nocookie.net/stealabr/images/a/a9/Popuru_and_Fizzuru.png",

-- Q
["Quesadilla Vampiro"] = "https://static.wikia.nocookie.net/stealabr/images/0/0e/VampiroQuesa.png", 
["Quesadilla Crocodila"] = "https://static.wikia.nocookie.net/stealabr/images/3/3f/QuesadillaCrocodilla.png",

-- R
["Rang Ring Bus"] = "https://static.wikia.nocookie.net/stealabr/images/2/2b/RingRangBus2.png",
["Reinito Sleighito"] = "https://static.wikia.nocookie.net/stealabr/images/2/27/Reinito.png",
["Rosetti Tualetti"] = "https://static.wikia.nocookie.net/stealabr/images/f/f8/Rossetti_Tualetti.png",
["Rosey and Teddy"] = "https://static.wikia.nocookie.net/stealabr/images/9/9b/Rosey_and_Teddy.png",

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

-- Prioridad lista
local PRIORITY = {
["Strawberry Elephant"] = 1,
["Meowl"] = 2,
["Skibidi Toilet"] = 3,
["Headless Horseman"] = 4,
["La Supreme Combinasion"] = 5,
["Dragon Gingerini"] = 6,
["Dragon Cannelloni"] = 7,
["Hydra Dragon Cannelloni"] = 8,
["Cerberus"] = 9,
["Ketupat Bros"] = 10,
["Burguro And Fryuro"] = 11,
["Rosey and Teddy"] = 12,
["Popcuru and Fizzuru"] = 13,
["Capitano Moby"] = 14,
["Cooki and Milki"] = 15,
["Reinito Sleighito"] = 16,
["Love Love Bear"] = 17,
["Ginger Gerat"] = 18,
["La Casa Boo"] = 19,
["Fragrama and Chocrama"] = 20,
["Spooky and Pumpky"] = 21,
["La Secret Combinasion"] = 22,
["Los Spaghettis"] = 23,
["La Ginger Sekolah"] = 24,
["Festive 67"] = 25,
["Garama and Madundung"] = 26,
["Jolly jolly Sahur"] = 27,
["Lavadorito Spinito"] = 28,
["Ketchuru and Musturu"] = 29,
["Rosetti Tualetti"] = 30,
["Orcaledon"] = 31,
["Spaghetti Tualetti"] = 32,
["Tictac Sahur"] = 33,
["Ketupat Kepat"] = 34,
["Tang Tang Keletang"] = 35,
["Lovin Rose"] = 36,
["La Taco Combinasion"] = 37,
["Swaggy Bros"] = 38,
["Los Tacoritas"] = 39,
["La Romantic Grande"] = 40, -- CORREGIDO
["Los Primos"] = 41,
["W or L"] = 42,
["Tralaledon"] = 43,
["Eviledon"] = 44,
["Los Puggies"] = 45,
["Gobblino Uniciclino"] = 46,
["La Jolly Grande"] = 47,
["Esok Sekolah"] = 48,
["Chillin chili"] = 49,
["Chipso and Queso"] = 50,
["Money Money Reindeer"] = 51,
["Los Bros"] = 52,
["La Spooky Grande"] = 53,
["Tuff Toucan"] = 54,
["Bacuru and Egguru"] = 55,
["Mieteteira Bicicleteira"] = 56,
["La Extinct Grande"] = 57,
["Celularcini Viciosini"] = 58,
["Money Money Puggy"] = 59,
["Los 67"] = 60,
["Los Candies"] = 61,
["Los Spooky Combinasionas"] = 62,
["Los Jolly Combinasionas"] = 63,
["Los Mobilis"] = 64,
["Los Hotspotsitos"] = 65,
["Las Sis"] = 66,
["Los Planitos"] = 67,
["Chicleteira Cupideira"] = 68,
["Fishino Clownino"] = 69,
["Tacorita Bicicleta"] = 70,
["Spinny Hammy"] = 71,
["Nuclearo Dinossauro"] = 72,
["Los combinasionas"] = 73,
["Chicleteira Noelteira"] = 74,
["Chimnino"] = 75,
["Noo my Heart"] = 76,
["Swag Soda"] = 77,
["Mariachi Corazoni"] = 78,
["La Grande Combinasion"] = 79,
["Los 25"] = 80,
["Los Burritos"] = 81,
["67"] = 82,
["DonkeyTurbo Express"] = 83,
["Los Chicleteiras"] = 84,
["Guest 666"] = 85,
["Los Mi Gatitos"] = 86,
["Rang Ring Bus"] = 87,
["Noo my Present"] = 89,
["Los nooo My Hotspotsitos"] = 90,
["Noo my Candy"] = 91,
["Arcadopus"] = 92,
["Los Quesadillas"] = 93,
["Burrito Bandito"] = 94,
["Chill Puppy"] = 95,
["Chicleteirina Bicicleteirina"] = 96,
["Chicleteira Bicicleteira"] = 97,
["Brunito Marsito"] = 98,
["Cupid Hotspot"] = 99,
["Quesadilla Vampiro"] = 100,
["Ho Ho Ho Sahur"] = 101,
["Mi Gatito"] = 102,
["Cupid Cupid Sahur"] = 103,
["Quesadilla Crocodila"] = 104,
["Naughty Naughty"] = 105,
}

-- NORMALIZAR NOMBRES (ANTI BUGS)

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

-- PRODUCCIÓN

local function parseProduction(text)
    local n, u = text:match("%$([%d%.]+)%s*([MBT])%s*/s")
    if not n then return end
    n = tonumber(n)
    if u == "M" then return n * 1e6 end
    if u == "B" then return n * 1e9 end
    if u == "T" then return n * 1e12 end
end

local function formatMoney(v)
    local s = tostring(math.floor(v))
    local formatted = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    if formatted:sub(1,1) == "," then
        formatted = formatted:sub(2)
    end
    return "$" .. formatted .. "/s"
end

-- SCAN (FIX DEFINITIVO PARA x2, x4, x8...)

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

-- WEBHOOK

local notified50M = {}
local notifiedShowcase = {}

local function send(list, webhook, pingRole, lastHashRef)
    if #list == 0 then return end

    -- ORDENAR POR PRIORITY
table.sort(list, function(a,b)
    local pa = PRIORITY[a.name] or math.huge
    local pb = PRIORITY[b.name] or math.huge
    if pa == pb then
        return a.value > b.value -- si tienen la misma prioridad, elegir el que más genera
    else
        return pa < pb -- prioridad más alta (número más bajo) primero
    end
end)

-- ahora main será el que tiene la PRIORITY más alta
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

-- AGRUPAR OTHER BRAINROTS (x2, x3, x4...)

    local grouped = {}

-- CONTAR brainrots por nombre
for i = 1, #list do
    local v = list[i]
    local key = v.name

    grouped[key] = grouped[key] or {
        name = v.name,
        value = v.value,
        count = 0
    }
    grouped[key].count += 1
end

local others = ""
local hasOthers = false

-- ordenar por valor (mayor a menor)
local ordered = {}
for _,v in pairs(grouped) do
    table.insert(ordered, v)
end

table.sort(ordered, function(a,b)

    local pa = PRIORITY[a.name] or math.huge
    local pb = PRIORITY[b.name] or math.huge

    if pa == pb then
        return a.value > b.value
    else
        return pa < pb
    end
end)

-- construir texto FINAL (SIN LISTA)
for _,v in ipairs(ordered) do
    hasOthers = true

    others = others
        .. v.count .. "x " .. v.name .. "\n"
        .. "— " .. formatMoney(v.value) .. "\n"
end

-- JOIN INFO

    local jobId = game.JobId
    local placeId = game.PlaceId

    local joinLink =
        "https://chillihub1.github.io/chillihub-joiner/?placeId="
        .. placeId ..
        "&gameInstanceId=" .. jobId

-- EMBED

local embed = {
    title = "**" .. main.name .. "**",
    color = 2829618,
    description = "**— " .. formatMoney(main.value) .. "**\n\n",
    footer = {
        text = "BryAll Notifier "
    },
    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
}


-- Producción

embed.description = "**(" .. formatMoney(main.value) .. ")**\n\n"

-- SERVER ID

embed.description = embed.description ..
    "**Server ID**\n```" .. jobId .. "```\n"

-- JOIN SERVER

embed.description = embed.description ..
    "**Join Server**\n[CLICK TO JOIN](" .. joinLink .. ")\n\n"

-- OTHER BRAINROTS

if hasOthers then
    embed.description = embed.description ..
        "**Other Brainrots**\n```" .. others .. "```\n\n"
end

-- THUMBNAIL

local img = getBrainrotImage(main.name)
if img then
    embed.thumbnail = { url = img }
end

-- ENVIAR WEBHOOK (CON O SIN PING)

local content = nil

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

-- SHOWCASE (COPIA DE LA 50M)
if webhook == WEBHOOK_50M then
    local showcaseEmbed = HttpService:JSONDecode(HttpService:JSONEncode(embed))

    -- QUITAR COMPLETAMENTE SERVER ID Y JOIN SERVER
    if showcaseEmbed.description then
        showcaseEmbed.description = showcaseEmbed.description
            :gsub("%*%*Server ID%*%*.-```.-```%s*", "")
            :gsub("%*%*Join Server%*%*.-%b()%s*", "")
    end

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

end -- cierre function send


local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OnlineGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Crear TextLabel centrado
local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 200, 0, 50)
label.Position = UDim2.new(0.5, -100, 0.5, -25)
label.BackgroundTransparency = 1
label.Text = "Online"
label.TextColor3 = Color3.fromRGB(0, 255, 0)
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Parent = screenGui

-- Ahora ejecutamos el loop en paralelo para que la GUI no se bloquee

task.spawn(function()
    while true do
        send(scan(MIN_PRODUCTION_50M), WEBHOOK_50M, false, notified50M)
        task.wait(SCAN_DELAY)
    end
end)
