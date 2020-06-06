Player:on("Spawn", function(new_player)
    -- Spawns a Character at position X = 0, Y = 0, Z = 0 with default's constructor parameters
    local new_character = Character(Vector(0, 0, 0))
    -- Possess the new Character
    new_player:Possess(new_character)

    new_player:SetValue("IsInADeathmatchGame", false)
    new_player:SetValue("WaitingDeathmatchGame", false)
    new_player:SetValue("IsSpectator", false)
    data = {}
    data.Id = 0 --Deathmatch game id
    data.Team = 0 --Blue = 0 and red = 1 for example
    data.Kill = 0 --Number of player he kill
    data.Death = 0 -- Number of time he died
    data.KD = Kill/Death
    
    new_player:SetValue("Data", Data)
end)

-- Called when Player unpossess a Character (when Players disconnect, they will trigger UnPossess event)
Player:on("UnPossess", function(player, character, isPlayerDisconnecting)
    -- If Player is disconnecting from the server, destroys it's Character
    if (isPlayerDisconnecting) then
            character:Destroy()
    end
end)



Character:on("Death", function(self)
    if (self:GetValue("IsInADeathmatchGame")) then
        --Check you're team and give a point to the other team
    end
end)

Character:on("Respawn", function(self)
    if (self:GetValue("IsInADeathmatchGame")) then
        -- respawn at a random spawn point from is team
    end
end)

