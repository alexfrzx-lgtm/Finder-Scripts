pcall(function()
    local req = request or http_request or syn.request
    if not req then return end

    local url = "https://raw.githubusercontent.com/alexfrzx-lgtm/Finder-Scripts/main/Notifier.lua"
    local res = req({ Url = url, Method = "GET" })

    if res and res.Body then
        loadstring(res.Body)()
    end
end)
