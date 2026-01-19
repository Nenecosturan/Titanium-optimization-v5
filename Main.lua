--[[
    🚀 TITANIUM v5.5 GOD-MOBILE (Ultimate Edition)
    - Full Optimization Suite
    - Optimized for Arceus X Neo
]]

local Settings = {
    OptimizeRendering = true,
    ClearTextures = true,
    ClearEffects = true,
    SmartGlass = true,
    RamClean = true,
    NetworkFix = true,
    AntiHeat = true,
    ViewDistance = 450
}

-- Servisler
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer

--------------------------------------------------------------------------------
-- [1] PROFESSIONAL CHARACTER CACHE (FPS Dostu Karakter Koruması)
--------------------------------------------------------------------------------
local CharacterCache = {} 
local function UpdateCache()
    table.clear(CharacterCache)
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then CharacterCache[player.Character] = true end
    end
end
Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(UpdateCache) end)
Players.PlayerRemoving:Connect(UpdateCache)
UpdateCache()

local function IsCritical(part)
    if not part then return true end
    if LocalPlayer.Character and part:IsDescendantOf(LocalPlayer.Character) then return true end
    local model = part:FindFirstAncestorOfClass("Model")
    if model and CharacterCache[model] then return true end
    if part:FindFirstAncestorWhichIsA("Tool") then return true end
    return false
end

--------------------------------------------------------------------------------
-- [2] SMART OPTIMIZATION ENGINE (Görsel ve Fizik)
--------------------------------------------------------------------------------
local function SuperOptimize(v)
    pcall(function()
        if IsCritical(v) then return end 

        if v:IsA("BasePart") then
            v.CastShadow = false
            if Settings.OptimizeRendering then
                -- [SMART GLASS SİSTEMİ]
                if Settings.SmartGlass and (v.Material == Enum.Material.Glass or v.Transparency > 0.1) then
                    v.Material = Enum.Material.Glass
                else
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                end
            end
            -- [CPU SAVER]
            if v.CanTouch and not v.Parent:FindFirstChild("Humanoid") then
                v.CanTouch = false
            end
        elseif v:IsA("Decal") or v:IsA("Texture") then
            if Settings.ClearTextures then v.Transparency = 1 end
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
            if Settings.ClearEffects then v.Enabled = false end
        elseif v:IsA("Shirt") or v:IsA("Pants") then
            if Settings.ClearTextures then v.ShirtTemplate = "" v.PantsTemplate = "" end
        end
    end)
end

--------------------------------------------------------------------------------
-- [3] MASTER NETWORK & ENGINE FIX
--------------------------------------------------------------------------------
task.spawn(function()
    pcall(function()
        settings().Network.IncomingReplicationLag = 0
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Always
        sethiddenproperty(Workspace, "PhysicsSimulationRate", Enum.PhysicsSimulationRate.Fixed30)
        sethiddenproperty(Lighting, "Technology", Enum.Technology.Voxel)
    end)
end)

--------------------------------------------------------------------------------
-- [4] AGGRESSIVE RAM CLEANER (Mobil Isınma Karşıtı)
--------------------------------------------------------------------------------
if Settings.RamClean then
    task.spawn(function()
        local lastPos = Vector3.new(0,0,0)
        while true do
            task.wait(60)
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local currentPos = char.HumanoidRootPart.Position
                if (currentPos - lastPos).Magnitude > 100 then
                    lastPos = currentPos
                    collectgarbage("collect")
                end
            end
        end
    end)
end

--------------------------------------------------------------------------------
-- [5] BOOT & INITIALIZE
--------------------------------------------------------------------------------
task.spawn(function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Atmosphere") then v:Destroy() end
    end
    
    local all = Workspace:GetDescendants()
    for i = 1, #all do
        SuperOptimize(all[i])
        if i % 1000 == 0 then task.wait() end 
    end
end)

Workspace.DescendantAdded:Connect(function(v)
    task.defer(function() SuperOptimize(v) end)
end)

--------------------------------------------------------------------------------
-- [6] ACAYİP GÜZEL BİLDİRİM (Zoom & Fade)
--------------------------------------------------------------------------------
local function FinalNotify()
    local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local f = Instance.new("Frame", sg)
    f.Size = UDim2.new(0,0,0,0)
    f.Position = UDim2.new(0.5,0,0.3,0)
    f.AnchorPoint = Vector2.new(0.5,0.5)
    f.BackgroundColor3 = Color3.fromRGB(15,15,15)
    f.BackgroundTransparency = 0.1
    local c = Instance.new("UICorner", f) c.CornerRadius = UDim.new(0,20)
    local s = Instance.new("UIStroke", f) s.Color = Color3.fromRGB(0, 255, 150) s.Thickness = 3
    
    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1,0,1,0)
    t.Text = "TITANIUM v5.5: GOD MODE 🚀"
    t.TextColor3 = Color3.fromRGB(0, 255, 150)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.TextTransparency = 1

    f:TweenSize(UDim2.new(0,300,0,70), "Out", "Back", 0.6, true)
    task.wait(0.3)
    game:GetService("TweenService"):Create(t, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    
    task.delay(4, function()
        game:GetService("TweenService"):Create(t, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        f:TweenSize(UDim2.new(0,0,0,0), "In", "Back", 0.6, true)
        task.wait(0.6)
        sg:Destroy()
    end)
end

FinalNotify()
warn("🔥 TITANIUM v5.5: ALL SYSTEMS GO")
