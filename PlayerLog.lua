
local filePlayerLog = './plugins/PlayerLog/PlayerLog.log'
local fileIP = './plugins/PlayerLog/IP.log'
local fileClientId = './plugins/PlayerLog/ClientId.log'

data.openConfig(filePlayerLog)
data.openConfig(fileIP)
data.openConfig(fileClientId)
    
function PlayerLog(pl)
    local A = pl:getDevice()
    local D = A.os
    file.writeLine(filePlayerLog, '[name: ' .. pl.realName .. ', uuid: ' .. pl.uuid .. ', xuid: ' .. pl.xuid .. ', data: ' .. system.getTimeStr() .. ', OS: ' .. D .. ']')
end

function IP(pl)
    local A = pl:getDevice()
    local B = A.ip
    file.writeLine(fileIP, '[name: ' .. pl.realName .. ', ip: ' .. B .. ', data: ' .. system.getTimeStr() .. ']')
   
end


function ClientId(pl)
    local A = pl:getDevice()
    local E = A.clientId
    file.writeLine(fileClientId, '[name: ' .. pl.realName .. ', data: ' .. system.getTimeStr() .. ', clientId: ' .. E .. ']')
    
end

mc.listen("onJoin", function(pl)
    IP(pl)
    ClientId(pl)
    mc.runcmd("scoreboard objectives add old dummy")
    if mc.runcmd('execute @a[name="'..pl.name..'",scores={old=1}] ~ ~ ~ title "'..pl.name..'" title §a') == true then
        pl:tell('§c§aДобро пожаловать на сервер §l§c"'..pl.name..'"', 0)
    else
        mc.runcmd('execute @a[name="'..pl.name..'"] ~ ~ ~ scoreboard players add @s old 0')
        pl:tell("§c§aСпасибо что зашли к нам впервые - §fDiscord: §ediscord.gg/uXvsVWW!", 0)
        PlayerLog(pl)
        mc.runcmd('execute @a[name="'..pl.name..'",scores={old=0}] ~ ~ ~ scoreboard players set "'..pl.name..'" old 1')

    end
end)

print('[\27[92mCRON\27[0m] \27[93mPlayerLog loaded\27[0m')