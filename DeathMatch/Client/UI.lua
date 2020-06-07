BlueTeamScore = 0
RedTeamScore = 0
Time = 0


text = "Blue Team : ".. BlueTeamScore .. " || Red Team : " .. RedTeamScore -- Score on the middle top of the screen

-- if time > 60 show it in min otherwise in sec ??? 
textTimer = Time .." sec remaining" -- Time in the bottom left ? 

-- Need to do a leaderboard with all player name , Kill,Death,KDratio, and ping


locationScore = Vector2D(250, 250) -- Screen space position to render the text.

locationTimer = Vector2D(123, 321)


fontType = 0 -- Roboto
fontSize = 32 -- Size of the font
textColor = Color(1, 0, 0, 1) -- Color to render the text.
kerning = 0 -- Horizontal spacing adjustment to modify the spacing between each letter.
shadowColor = Color(1, 1, 1, 1) -- Color to render the shadow of the text.
shadowOffset = Vector2D(1, 1) -- Pixel offset relative to the screen space position to render the shadow of the text.
bCenterX = false -- If true, then interpret the screen space position X coordinate as the center of the rendered text.
bCenterY = false -- If true, then interpret the screen space position Y coordinate as the center of the rendered text.
bOutlined = false -- If true, then the text should be rendered with an outline.
outlineColor = Color(1, 1, 1, 1) -- Color to render the outline for the text.

Render.AddText(0, text, locationScore, fontType, fontSize, textColor, kerning, bCenterX, bCenterY, bEnableShadow, shadowOffset, shadowColor, bOutlined, outlineColor)


Render.AddText(0, textTimer, locationTimer, fontType, fontSize, textColor, kerning, bCenterX, bCenterY, bEnableShadow, shadowOffset, shadowColor, bOutlined, outlineColor)