
Package:Require ("./Events.lua")
Package:Require ("./Deathmatch.lua")
Package:Require ("./Commands.lua")

Package:on("Load", function()
    print("Load package: " .. Package:GetName())
  end)



DeathmatchGlobal = {} -- Save all the different Deathmatch Game going 