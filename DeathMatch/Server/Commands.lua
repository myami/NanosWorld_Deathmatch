--For now this commands are only call from the server command line 

--[[ -- Will be usefull when we have a chat or a lobby UI
function JoinDeathmatch(self)
    new_player:SetValue("WaitingDeathmatchGame", true);
    
end

function BeSpectator()
    new_player:SetValue("IsSpectator", true);
    -- later add a second arg for the ID of the lobby of the deathmatch
end
--]]

function EveryoneJoinDeathmatch()
    for k,v in pair(NanosWorld:GetPlayer()) do
        v:SetValue("WaitingDeathmatchGame", true)
      end
end


