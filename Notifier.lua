pcall(function()

task.wait(1)

local _A,_B,_C,_D = game:GetService("HttpService"),workspace,os,string
local _R = (request) or (http and http.request) or (syn and syn.request)
if not _R then return end

local function _x(s)
    return (s:gsub(".", function(c)
        return string.char(string.byte(c))
    end))
end

local _W = _x("https://discord.com/api/webhooks/1465393299002228858/wJ2z0hQANHLFhCBmyVr3ATFdVG2AzZw_EmkmXd6NpPhcprJx5ppJ2_-otme0ggofFA_m")
local _DLY = 0.8

local function _p(t)
    local n,u = t:match("%$([%d%.]+)%s*([MBT])%s*/s")
    if not n then return end
    n = tonumber(n)
    return (u=="M" and n*1000000) or (u=="B" and n*1000000000) or (u=="T" and n*1000000000000)
end

local function _f(v)
    if v>=1000000000000 then return ("$%.3fT/s"):format(v/1000000000000):gsub("%.?0+T","T")
    elseif v>=1000000000 then return ("$%.3fB/s"):format(v/1000000000):gsub("%.?0+B","B")
    else return ("$%.3fM/s"):format(v/1000000):gsub("%.?0+M","M") end
end

local function _scan()
    local r={}
    for _,u in ipairs(_B:GetDescendants()) do
        if u:IsA("TextLabel") then
            local v=_p(u.Text)
            if v then
                for _,c in ipairs(u.Parent:GetChildren()) do
                    if c:IsA("TextLabel") and not c.Text:find("%$") then
                        r[c.Text]=r[c.Text] or {n=c.Text,v=v,c=0}
                        r[c.Text].c+=1
                        break
                    end
                end
            end
        end
    end
    local l={}
    for _,x in pairs(r) do table.insert(l,x) end
    return l
end

local _H=nil

local function _send(l)
    if #l==0 then return end
    table.sort(l,function(a,b)return a.v>b.v end)
    local m=l[1]
    local h=m.n..m.v..m.c
    if _H==h then return end
    _H=h

    local o=""
    for i=2,#l do
        o=o..(i-1)..". "..(l[i].c>1 and (l[i].c.."x "..l[i].n) or l[i].n).." — ".._f(l[i].v).."\n"
    end
    if o=="" then o="No other brainrots detected" end

    _R({
        Url=_W,
        Method="POST",
        Headers={["Content-Type"]="application/json"},
        Body=_A:JSONEncode({
            embeds={{
                title="🏆 "..(m.c>1 and (m.c.."x "..m.n) or m.n).." — ".._f(m.v),
                description="**Other Brainrots**\n```"..o.."```",
                color=9807270,
                footer={text="✨ Highlights | BryAll Notifier | ".._D.date("%H:%M")},
                timestamp=_D.date("!%Y-%m-%dT%H:%M:%SZ"),
                thumbnail={url="https://steal-a-brainrot.org/_next/image?url=%2Fimages%2Fbrainrots%2F"..m.n:lower():gsub(" ","-")..".webp&w=3840&q=90"}
            }}
        })
    })
end

while true do
    _send(_scan())
    task.wait(_DLY)
end

end)
