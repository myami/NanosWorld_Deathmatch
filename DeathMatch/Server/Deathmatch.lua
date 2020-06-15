-- Deathmatch class

DeathMatch = {
    Global = {}, -- array of all player in the game
    BlueTeam = {}, -- array of the player in BlueTeam
    RedTeam = {}, -- array of the player in RedTeam
    Spectator = {}, -- Array of people that are spectator
    Score = {}, -- array of score {blueteam,redteam}
    MapData = {} -- Data of the map like spawn point for each team , map name etc.... (will be extract from JSON file)
}


DeathMatch.__index = DeathMatch 
function DeathMatch:New( dimension )
    if DeathMatchGlobal[ dimension ] then return DeathMatchGlobal[ dimension ] end -- if the table exists return it

    local new_instance = {
        dimension = dimension -- whenever we need to need in which dimension it is, we can
    }

    setmetatable( new_instance, DeathMatch )
    DeathMatchGlobal[ dimension ] = new_instance -- save the instance to the global table

    return new_instance
end


-- For load the map
-- DeathMatch:DataExtract( Package:Require ("./Maps/" .. map_name .. ".lua") )

function DeathMatch:DataExtract (data) -- data is the json file to get for example test.json
--Get map name, Waitingarea , respawn point, time , weather , ScoreLimit and save all in MapData
self.MapData = data
end


function DeathMatch:Load ()

    for k,v in pairs(NanosWorld:GetPlayer()) do

        if(v:GetValue("WaitingDeathmatchGame")) then
           local i = table.getn(self.Global) 
            self.Global[i] = v
             --Putting them in the Global array
             v:SetValue("IsInADeathmatchGame", true)
        end
          
    end

    -- split them from the temporary array to the team get the length of the array and divide by 2 half will go on each time and if its unpair the last will go on a random team
    for k,v in pairs(self.Global) do
        if (table.getn(self.Global) % 2 == 0) then 
            -- pair
            local i = table.getn(self.Global) /2
            if (k <= i) then
                local b = table.getn(self.BlueTeam)
                self.BlueTeam[b] = v
            else
                local r = table.getn(self.RedTeam)
                self.BlueTeam[r] = v
            end

        else
          -- not pair
          -- add a bot or remove a player or don't launch the deathmatch    
        end
           
    end


    local SpawnBlue = {} 
    local SpawnRed = {} 

    for k,v in pairs(self.MapData.RespawnPoint) do
        if(v.team == 0)then
           local i = table.getn(self.SpawnBlue)
           SpawnBlue[i] = v
        else
            local i = table.getn(self.SpawnRed)
            SpawnRed[i] = v
        end
    end

    if(table.getn(self.SpawnBlue) ~= table.getn(self.BlueTeam)) then
        -- not enough spawnpoint for the blue team
    end

    if(table.getn(self.SpawnRed) ~= table.getn(self.RedTeam)) then
        -- not enough spawnpoint for the red team
    end

    for k,v in pairs(self.BlueTeam) do
   -- spawn them on a respawn point ( and in the correct dimension when it will be implemented)
    v.SetLocation (self.SpawnBlue[k].pos) 
    v.SetRotation (self.SpawnBlue[k].rot) 
    local d = v:GetValue("Data")
    d.Team = 0
    v:SetValue("Data",d)
    end

    for k,v in pairs(self.RedTeam) do
   -- spawn them on a respawn point ( and in the correct dimension when it will be implemented)
   v.SetLocation (self.SpawnRed[k].pos) 
   v.SetRotation (self.SpawnRed[k].rot) 
   local d = v:GetValue("Data")
   d.Team = 1
   v:SetValue("Data",d)

    end
   World.SetTime(self.MapData.time.hour,self.MapData.time.minute)
   World.SetWeather(self.MapData.weather)

   for k,v in pairs(self.Global) do
      -- freeze them 
      v:SetMovementEnabled(false)

      -- load UI
      Events:CallRemote("LoadUI",v,self)
      -- Spawn weapon to each (will be replace by a shop later)
      local NewWeapon = Weapon(
    Vector(-900, 185, 215), -- Spawn Location
    Rotator(0, 90, 90),     -- Spawn Rotation
    "NanosWorld/Weapons/Rifles/AK47/SK_AK47", -- Model
    0,                    -- Collision (Normal)
    true,                 -- Gravity Enabled
    30,                   -- Default Ammo in the Clip
    1000,                 -- Default Ammo in the Bag
    30,                   -- Clip Capacity
    30,                   -- Base Damage
    20,                   -- Spread
    1,                    -- Bullet Count (1 for common weapons, > 1 for shotguns)
    30,                   -- Ammo to Reload (Ammo Clip for common weapons, 1 for shotguns)
    20000,                -- Max Bullet Distance
    7500,                 -- Bullet Speed (visual only)
    Color(20, 10000, 0),  -- Bullet Color
    0.5,                  -- Sight's FOV multiplier
    Vector(0, 0, -14.85), -- Sight Location
    Rotator(-1, 0, 0),    -- Sight Rotation
    Vector(26, 0, 8.5),   -- Left Hand Location
    Rotator(0, 60, 90),   -- Left Hand Rotation
    Vector(-10, 0, 0),    -- Right Hand Offset
    1,                    -- Handling Mode (0. SingleHandedWeapon, 1. DoubleHandedWeapon, 2. SingleHandedMelee, 3. DoubleHandedMelee, 4. Throwable, 5. Torch)
    0.15,                 -- Cadence (1 shot at each 0.15seconds)
    true,                 -- Can Hold Use (keep pressing to keep firing, common to automatic weapons)
    false,                -- Need to release to Fire (common to Bows)
    "NanosWorld/Weapons/Common/Effects/ParticlesSystems/Weapons/P_Bullet_Trail_System", -- Bullet Trail Particle
    "NanosWorld/Weapons/Rifles/AK47/PS_AK47_Barrel_Smoke",                              -- Barrel Particle
    "NanosWorld/Weapons/Rifles/AK47/PS_AK47_Shells",                                    -- Shells Particle
    "NanosWorld/Weapons/Common/Audios/A_Rifle_Dry_Cue",                                 -- Weapon's Dry Sound
    "NanosWorld/Weapons/Common/Audios/A_Rifle_Load_Cue",                                -- Weapon's Load Sound
    "NanosWorld/Weapons/Common/Audios/A_Rifle_Unload_Cue",                              -- Weapon's Unload Sound
    "NanosWorld/Weapons/Common/Audios/Rattle/A_AimZoom_Cue",                            -- Weapon's Zooming Sound
    "NanosWorld/Weapons/Common/Audios/Rattle/A_Rattle_Cue",                             -- Weapon's Aiming Sound
    "NanosWorld/Weapons/Common/Audios/A_AK47_Shot_Cue",                                 -- Weapon's Shot Sound
    "NanosWorld/Characters/Common/Animations/Weapons/AM_Mannequin_Reload_Rifle",        -- Character's Reloading Animation
    "NanosWorld/Characters/Common/Animations/Weapons/AM_Mannequin_Sight_Fire",          -- Character's Aiming Animation
    "NanosWorld/Weapons/Rifles/AK47/SM_AK47_Mag_Empty"                                  -- Magazine Mesh
)
      v:PickUp(NewWeapon)
      
      -- Reset to all player the data value and add the ID of the game
      local d = v:GetValue("Data")
      d.Id = self.dimension
      d.Kill = 0 
      d.Death = 0 
      d.KD = Kill/Death
      d.Shooter = d 
      v:SetValue("Data",d)
     end
  
  -- do the countdown before starting and when it is over launch DeathMatch.Start()
  Events:CallRemote("StartTimerStart",v)
  local my_id = Timer.SetTimeout(10000, self.Start())
end

function DeathMatch:Start ()

for k,v in pairs(self.Global) do
-- unfreeze the player
    v:SetMovementEnabled(true)
   end
-- start the countdown for the end of the game (end game by time or if a time arrive at the score limit)
Events:CallRemote("StartTimerEndGame",v,self.MapData.MaxTime)
end

function DeathMatch:End ()
    --Freeze everyone
    v:SetMovementEnabled(false)
    -- Announce the winner team (and the stats of the game)
    if (self.Score[0] > self.Score[1])then
        --blue team win
    end
    if (self.Score[1] > self.Score[0])then
        --Red team win
    end
    if (self.Score[1] == self.Score[0])then
        --Equality
    end
    for k,v in pairs(self.Global) do
        Events:CallRemote("ShowLeaderboard",v,true)
     end
  
    
    -- wait 10 sec so everyone can see the score and stats
    local my_id = Timer.SetTimeout(10000,self.RemoveAllPlayer())
    -- Remove everyone from the deathmatch lobby and put them in the waitinglobby
   
    -- Destroy this lobby in the global variable index.lua server
end
function DeathMatch:RemoveAllPlayer()
    for k,v in pairs(self.Global) do
        Events:CallRemote("ShowLeaderboard",v,false)
        v:SetValue("IsInADeathmatchGame", false)
        v:SetValue("WaitingDeathmatchGame", true)
        local d = v:GetValue("Data")
        d.Id = 0
        d.Kill = 0 
        d.Death = 0 
        d.KD = Kill/Death
        d.Shooter = d 
        v:SetValue("Data",d)
        -- Lobby position
        v.SetLocation (Vector(0,0,0)) 
        v.SetRotation (Rotation(0,0,0)) 
     end
end
function DeathMatch:UpdateUI ()
    -- loop through every client to update the score
    for k,v in pairs(self.Global) do
        Events:CallRemote("UpdateScore",v,self.Score)
     end
end

function DeathMatch:UpdateLeaderboard ()
    -- loop through every client to update the score
    for k,v in pairs(self.Global) do
        --[[ get this data from each player and update it on the leaderboard 
             d.Kill = 0 
             d.Death = 0 
             d.KD = Kill/Death
        ]]
     end
end

function DeathMatch:CheckVictory ()
    if(self.Score[0] == self.MapData.ScoreLimit or self.Score[1] == self.MapData.ScoreLimit) then
         self.End()
    end
end