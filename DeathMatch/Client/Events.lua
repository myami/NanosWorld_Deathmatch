Client:on("MouseUp", function(KeyName, MouseX, MouseY)

end)

Client:on("MouseDown", function(KeyName, MouseX, MouseY)

end)

Client:on("Console", function(Text)

Events:CallRemote("ClientCommand",GetLocalPlayer(), Text)

end)

Events:on("LoadUI", function(Player,Deathmatch)
    -- Generate and set the score to 0 
    -- Generate the leaderboard with everyone at 0
    -- Generate the endgame timer that is frozen until the game start
end)

Events:on("StartTimerStart", function(Player)
    -- Start the 10 sec timer
end) 

Events:on("StartTimerEndGame", function(Player,MaxTime)
    -- Start the end of the game timer
end) 

Events:on("UpdateScore", function(Player,Score)
    -- Score[0] == blue team 
    -- Score[1] == red team
    -- update the UI with the new score
end) 