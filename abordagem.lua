-- loskatchorros
-- https://www.loskatchorros.com.br/
-- server4.loskatchorros.com.br:7777
--QUACK QUACK

script_name("Auto Abordagem")

local cooldown = 5000
local maxDist = 10.0
local resetTime = 300000 -- 5 minutos

local lastCommand = 0
local abordados = {}

function main()
    while not isSampAvailable() do wait(100) end

    sampAddChatMessage("[AutoAbordagem] Ativo", -1)

    while true do
        wait(300) -- verifica players mais rápido

        local px,py,pz = getCharCoordinates(PLAYER_PED)

        for i = 0, 1000 do
            if sampIsPlayerConnected(i) then

                local ok, ped = sampGetCharHandleBySampPlayerId(i)

                if ok then
                    local x,y,z = getCharCoordinates(ped)
                    local dist = getDistanceBetweenCoords3d(px,py,pz,x,y,z)

                    if dist < maxDist then

                        local now = os.clock()*1000

                        if (not abordados[i] or now - abordados[i] > resetTime)
                        and (now - lastCommand > cooldown) then

                            sampSendChat("/abordagem "..i)

                            local name = sampGetPlayerNickname(i)
                            sampAddChatMessage("Abordando "..name.." ("..i..")", -1)

                            abordados[i] = now
                            lastCommand = now
                        end
                    end
                end
            end
        end
    end

end
