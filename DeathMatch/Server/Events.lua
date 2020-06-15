Player:on("Spawn", function(new_player)
    -- Spawns a Character at position X = 0, Y = 0, Z = 0 with default's constructor parameters
    local new_character = Character(Vector(0, 0, 0))
    -- Possess the new Character
    new_player:Possess(new_character)

    new_player:SetValue("IsInADeathmatchGame", false)
    new_player:SetValue("WaitingDeathmatchGame", false)
    new_player:SetValue("IsSpectator", false)
    local data = {}
    data.Id = 0 --Deathmatch game id
    data.Team = 0 --Blue = 0 and red = 1 for example
    data.Kill = 0 --Number of player he kill
    data.Death = 0 -- Number of time he died
    data.KD = Kill/Death
    data.Shooter = new_player 
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
      local  D = self:GetValue("Data")
        D.Death =  D.Death + 1
                  -- Find the good deathmatch game in DeathmatchGlobal with the ID that is the index of the instance in DeathmatchGlobal
        local Game = DeathmatchGlobal[D.Id] 
        
        self:SetValue("Data", D)
        if(D.Team == 0) then
         Game.Score[1] =  Game.Score[1] + 1
          -- Add 1 point to the red team  
        end
        if(D.Team == 1) then
         Game.Score[0] =  Game.Score[0] + 1
          -- Add 1 point to the blue team  
          Game:UpdateUI() -- update the score UI 
        end
        -- Take the last guy that shoot on the player and give him the kill
        local Shoot = D.Shooter:GetValue("Data")
        Shoot.Kill = Shoot.Kill + 1
        D.Shooter:SetValue("Data", Shoot)
        Game:UpdateLeaderboard()

        --Send to all the client the new data to update the leaderboard
        
    end
end)

Character:on("Respawn", function(self)
    if (self:GetValue("IsInADeathmatchGame")) then
        -- respawn at a random spawn point from is team
    end
end)

Character:on("TakeDamage", function(self, damage, type, bone, FromDirection, Instigator)
    if (self:GetValue("IsInADeathmatchGame")) then
        -- Save the shooter
       local D = self:GetValue("Data")
        D.Shooter = Instigator
        self:SetValue("Data", D)
    end
end)

Events:on("ClientCommand", function(Player, Text)
    if (Text == "JoinDeathmatch" or Text == "JD") then
        JoinDeathmatch(Player)
    end
end)