script_name("AutoAssist")
script_author("Quack")

require "lib.moonloader"

function main()
    while not isSampAvailable() do wait(100) end

    sampAddChatMessage("[AutoAssist] Script Auto-Socorro.", -1)

    local lastKit = 0
    local lastArmor = 0
    local lastRepair = 0

    while true do
        wait(500)

        local hp = getCharHealth(PLAYER_PED)
        local armor = getCharArmour(PLAYER_PED)

        -- HP baixo
        if hp <= 40 and os.clock() - lastKit > 10 then
            sampSendChat("/usarkit")
            lastKit = os.clock()
        end

        -- Colete baixo (somente se estiver usando)
        if armor > 0 and armor <= 40 and os.clock() - lastArmor > 10 then
            sampSendChat("/colete")
            lastArmor = os.clock()
        end

        -- Carro
        if isCharInAnyCar(PLAYER_PED) then
            local car = storeCarCharIsInNoSave(PLAYER_PED)
            local carhp = getCarHealth(car)

            if carhp <= 500 and os.clock() - lastRepair > 15 then
                sampSendChat("/reparar")
                lastRepair = os.clock()
            end
        end
    end
end