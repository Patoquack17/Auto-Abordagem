--[[
   ____  _   _  ____  ____  _  __  
  / __ \| | | |/ _  |/ ___|| |/ /  
 | |  | | | | | |_| | |    | ' /   
 | |__| | |_| |  _  | |___ | . \   
  \___\_\\___|_| |_|\____||_|\_\  
        ~~ QUACK QUACK ~~          
  loskatchorros.com.br | server4:7777
]]--
script_name('Police Helper')
local sampev = require 'lib.samp.events'
local vkeys  = require 'vkeys'

local cooldown  = 5000
local maxDist   = 15.0
local resetTime = 300000

local lastCommand = 0
local abordados   = {}
local targetIndex = {}
local blacklist   = {} -- { [id] = true }

local actions = {
    { key = 0x31, cmd = '/abordagem',    msg = 'Abordando',          checkAbordado = true  },
    { key = 0x32, cmd = '/algemar',      msg = 'Algemando',          checkAbordado = false },
    { key = 0x33, cmd = '/prender',      msg = 'Prendendo',          checkAbordado = false },
    { key = 0x34, cmd = '/prenderArmas', msg = 'Prendendo armas de', checkAbordado = false },
    { key = 0x35, cmd = '/revistarcarga',msg = 'Revistando carga de',checkAbordado = false },
    { key = 0x36, cmd = '/prendercarga', msg = 'Prendendo carga de', checkAbordado = false },
}

for i = 1, #actions do
    targetIndex[i] = 1
end

function isBlacklisted(id)
    return blacklist[id] == true
end

function getPlayersInRange()
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local found = {}
    for i = 0, sampGetMaxPlayerId(false) do
        if i ~= myId and sampIsPlayerConnected(i) and not isBlacklisted(i) then
            local ok, ped = sampGetCharHandleBySampPlayerId(i)
            if ok then
                local x, y, z = getCharCoordinates(ped)
                local dist = getDistanceBetweenCoords3d(px, py, pz, x, y, z)
                if dist <= maxDist then
                    table.insert(found, { id = i, dist = dist })
                end
            end
        end
    end
    table.sort(found, function(a, b) return a.dist < b.dist end)
    return found
end

function executeAction(action, actionIdx, now)
    if now - lastCommand <= cooldown then return end
    local players = getPlayersInRange()
    if #players == 0 then
        sampAddChatMessage('Nenhum jogador proximo.', -1)
        return
    end
    if targetIndex[actionIdx] > #players then
        targetIndex[actionIdx] = 1
    end

    local id = players[targetIndex[actionIdx]].id
    if not sampIsPlayerConnected(id) then
        targetIndex[actionIdx] = (targetIndex[actionIdx] % #players) + 1
        return
    end

    local name = sampGetPlayerNickname(id)

    if action.checkAbordado then
        if abordados[id] and now - abordados[id] <= resetTime then
            sampAddChatMessage('Jogador ja foi abordado recentemente.', -1)
            targetIndex[actionIdx] = (targetIndex[actionIdx] % #players) + 1
            return
        end
        abordados[id] = now
    end

    sampSendChat(action.cmd .. ' ' .. id)
    sampAddChatMessage(
        '[' .. targetIndex[actionIdx] .. '/' .. #players .. '] ' ..
        action.msg .. ' ' .. name .. ' (' .. id .. ')',
        -1
    )
    lastCommand = now
    targetIndex[actionIdx] = (targetIndex[actionIdx] % #players) + 1
end

function sampev.onPlayerDisconnect(id, reason)
    if blacklist[id] then
        blacklist[id] = nil
    end
    if abordados[id] then
        abordados[id] = nil
    end
end

function main()
    while not isSampAvailable() do wait(100) end
    sampAddChatMessage('[PoliceHelper] 1:Abordagem | 2:Algemar | 3:Prender | 4:PrenderArmas | 5:RevistaCarga | 6:PrenderCarga', -1)
    sampAddChatMessage('[PoliceHelper] /blAdd <id> | /blRemove <id> | /blList | /policehelper', -1)

    sampRegisterChatCommand('policehelper', function()
        sampAddChatMessage('[PoliceHelper] 1:Abordagem | 2:Algemar | 3:Prender | 4:PrenderArmas | 5:RevistaCarga | 6:PrenderCarga', -1)
        sampAddChatMessage('[PoliceHelper] /blAdd <id> | /blRemove <id> | /blList | /policehelper', -1)
    end)

    sampRegisterChatCommand('blAdd', function(args)
        local id = tonumber(args:match('^%s*(%S+)'))
        if not id then
            sampAddChatMessage('[BL] Uso: /blAdd <id>', -1)
            return
        end
        if blacklist[id] then
            local name = sampIsPlayerConnected(id) and sampGetPlayerNickname(id) or '?'
            sampAddChatMessage('[BL] ' .. name .. ' (' .. id .. ') ja esta na blacklist.', -1)
            return
        end
        blacklist[id] = true
        local name = sampIsPlayerConnected(id) and sampGetPlayerNickname(id) or '?'
        sampAddChatMessage('[BL] ' .. name .. ' (' .. id .. ') adicionado.', -1)
    end)

    sampRegisterChatCommand('blRemove', function(args)
        local id = tonumber(args:match('^%s*(%S+)'))
        if not id then
            sampAddChatMessage('[BL] Uso: /blRemove <id>', -1)
            return
        end
        if not blacklist[id] then
            local name = sampIsPlayerConnected(id) and sampGetPlayerNickname(id) or '?'
            sampAddChatMessage('[BL] ' .. name .. ' (' .. id .. ') nao esta na blacklist.', -1)
            return
        end
        local name = sampIsPlayerConnected(id) and sampGetPlayerNickname(id) or '?'
        blacklist[id] = nil
        sampAddChatMessage('[BL] ' .. name .. ' (' .. id .. ') removido.', -1)
    end)

    sampRegisterChatCommand('blList', function()
        local list = {}
        for id in pairs(blacklist) do
            local name = sampIsPlayerConnected(id) and sampGetPlayerNickname(id) or '?'
            table.insert(list, name .. ' (' .. id .. ')')
        end
        if #list == 0 then
            sampAddChatMessage('[BL] Blacklist vazia.', -1)
        else
            sampAddChatMessage('[BL] Blacklist (' .. #list .. '): ' .. table.concat(list, ', '), -1)
        end
    end)

    while true do
        wait(10)
        local now = getGameTimer()
        for i, action in ipairs(actions) do
            if wasKeyPressed(action.key) then
                executeAction(action, i, now)
            end
        end
    end
end