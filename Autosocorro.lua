script_name("AutoAssist")
script_author("Quack")
require "lib.moonloader"

-- Configurações
local HP_THRESHOLD    = 40
local ARMOR_THRESHOLD = 40
local KIT_COOLDOWN    = 10
local ARMOR_COOLDOWN  = 10

function main()
    while not isSampAvailable() do wait(100) end
    sampAddChatMessage("[AutoAssist] Script Auto-Socorro ativo.", 0x00FF00)

    local lastKit   = 0
    local lastArmor = 0

    while true do
        wait(500)

        if not isCharDead(PLAYER_PED) then
            local hp    = getCharHealth(PLAYER_PED)
            local armor = getCharArmour(PLAYER_PED)

            -- HP baixo
            if hp <= HP_THRESHOLD and os.clock() - lastKit > KIT_COOLDOWN then
                sampSendChat("/usarkit")
                lastKit = os.clock()
                sampAddChatMessage("[AutoAssist] Kit usado! HP: " .. math.floor(hp), 0xFF4444)
            end

            -- Colete baixo (somente se estiver usando)
            if armor > 0 and armor <= ARMOR_THRESHOLD and os.clock() - lastArmor > ARMOR_COOLDOWN then
                sampSendChat("/colete")
                lastArmor = os.clock()
                sampAddChatMessage("[AutoAssist] Colete recarregado! Armor: " .. math.floor(armor), 0x4444FF)
            end
        end
    end
end
