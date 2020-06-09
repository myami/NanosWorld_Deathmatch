Client:on("MouseUp", function(KeyName, MouseX, MouseY)

end)

Client:on("MouseDown", function(KeyName, MouseX, MouseY)

end)

Client:on("Console", function(Text)

Events:CallRemote("ClientCommand",GetLocalPlayer(), Text)

end)