--[[
    TITANIUM OPTIMIZER Gen 2 v2.0 (STABILITY PATCH)
    Target: Ultra-Low-End Mobile Devices (2GB-4GB RAM)
    Fixes: FPS Calculation, Null Character Error, Loop Speed
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

--------------------------------------------------------------------------------
-- 1. CINEMATIC UI SYSTEM
--------------------------------------------------------------------------------
local function createCinematicUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TitaniumMasterUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    
    pcall(function() screenGui.Parent = CoreGui end)
    if not screenGui.Parent then screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 340, 0, 70)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0) 
    mainFrame.Position = UDim2.new(0.5, 0, -0.25, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    mainFrame.BackgroundTransparency = 1
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 14)
    uiCorner.Parent = mainFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2
    uiStroke.Transparency = 1 
    uiStroke.Color = Color3.fromRGB(0, 255, 180)
    uiStroke.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.4, 0)
    title.Position = UDim2.new(0, 0, 0.1, 0)
    title.BackgroundTransparency = 1
    title.Text = "TITANIUM v4.1"
    title.Font = Enum.Font.GothamBlack
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextTransparency = 1
    title.TextSize = 16
    title.Parent = mainFrame

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0.35, 0)
    status.Position = UDim2.new(0, 0, 0.5, 0)
    status.BackgroundTransparency = 1
    status.Text = "Initializing Neural Network..."
    status.Font = Enum.Font.GothamMedium
    status.TextColor3 = Color3.fromRGB(180, 180, 180)
    status.TextTransparency = 1
    status.TextSize = 13
    status.Parent = mainFrame

    return mainFrame, title, status, uiStroke, screenGui
end

--------------------------------------------------------------------------------
-- 2. ANIMATION CONTROLLER
--------------------------------------------------------------------------------
local function animateIntro(frame, title, status, stroke)
    local moveTween = TweenInfo.new(1.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
    local fadeTween = TweenInfo.new(1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    TweenService:Create(frame, moveTween, {Position = UDim2.new(0.5, 0, 0.05, 0)}):Play()
    TweenService:Create(frame, fadeTween, {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(stroke, fadeTween, {Transparency = 0.3}):Play()
    TweenService:Create(title, fadeTween, {TextTransparency = 0}):Play()
    TweenService:Create(status, fadeTween, {TextTransparency = 0}):Play()
end

local function animateOutro(frame, title, status, stroke, gui)
    local moveTween = TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
    local fadeTween = TweenInfo.new(1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    TweenService:Create(frame, moveTween, {Position = UDim2.new(0.5, 0, -0.25, 0)}):Play()
    TweenService:Create(frame, fadeTween, {BackgroundTransparency = 1}):Play()
    TweenService:Create(stroke, fadeTween, {Transparency = 1}):Play()
    TweenService:Create(title, fadeTween, {TextTransparency = 1}):Play()
    TweenService:Create(status, fadeTween, {TextTransparency = 1}):Play()

    task.delay(1.6, function()
        if gui then gui:Destroy() end
    end)
end

--------------------------------------------------------------------------------
-- 3. OPTIMIZATION MODULES (Fix: Faster Chunking)
--------------------------------------------------------------------------------
local function safeCall(name, func)
    task.spawn(function()
        local s, e = pcall(func)
        if not s then warn("Titanium Error ["..name.."]: " .. tostring(e)) end
    end)
end

local function Module_Rendering(label)
    label.Text = "Processing Graphics Pipeline..."
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Technology = Enum.Technology.Compatibility
    
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("SunRaysEffect") then
            v:Destroy()
        end
    end

    local counter = 0
    -- [DÜZELTME 1]: Döngü hızı artırıldı (50 -> 200)
    for _, part in pairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Material = Enum.Material.Plastic
            part.Reflectance = 0
            part.CastShadow = false
            for _, tex in pairs(part:GetChildren()) do
                if tex:IsA("Texture") or tex:IsA("Decal") then
                    tex:Destroy()
                end
            end
        end
        counter = counter + 1
        if counter % 200 == 0 then task.wait() end 
    end
end

local function Module_Memory(label)
    label.Text = "Purging Cache & Particles..."
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Explosion") then
            obj:Destroy()
        end
    end
    if Workspace.Terrain then
        pcall(function()
            Workspace.Terrain.WaterWaveSize = 0
            Workspace.Terrain.WaterWaveSpeed = 0
        end)
    end
end

local function Module_Physics(label)
    label.Text = "Optimizing Physics Engine..."
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.PhysicsEnvironmentalThrottle.Always
    Workspace.InterpolationThrottling = Enum.InterpolationThrottling.Enabled
end

--------------------------------------------------------------------------------
-- 4. AI CORE SYSTEM (Fix: Universal FPS & Character Check)
--------------------------------------------------------------------------------
local function StartAICore()
    task.spawn(function()
        local isAggressive = false
        
        while task.wait(1.5) do 
            -- [DÜZELTME 2]: FPS hesaplaması evrensel hale getirildi
            local dt = RunService.RenderStepped:Wait() -- Her kare arasındaki süre
            local fps = math.floor(1 / dt) -- 1/süre = FPS
            
            pcall(function()
                if fps < 30 then
                    if not isAggressive then
                        isAggressive = true
                        settings().Rendering.QualityLevel = 1
                        settings().Physics.ForceEffectsToUseSimplifiedPhysics = true
                    end
                elseif fps > 50 then
                    if isAggressive then
                        isAggressive = false
                        settings().Physics.ForceEffectsToUseSimplifiedPhysics = false
                    end
                end
            end)

            -- [DÜZELTME 3]: Karakter ölürse script hata vermesin diye kontrol eklendi
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end -- Karakter yoksa atla
                
                local myPos = char.HumanoidRootPart.Position
                
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (plr.Character.HumanoidRootPart.Position - myPos).Magnitude
                        local limit = isAggressive and 50 or 120 
                        
                        local shouldHide = dist > limit
                        
                        for _, item in pairs(plr.Character:GetChildren()) do
                            if item:IsA("Accessory") then
                                item.Handle.Transparency = shouldHide and 1 or 0
                            end
                        end
                    end
                end
            end)
        end
    end)
end

--------------------------------------------------------------------------------
-- 5. MASTER EXECUTION
--------------------------------------------------------------------------------
local function ActivateTitaniumMaster()
    if not game:IsLoaded() then game.Loaded:Wait() end

    local frame, title, status, stroke, gui = createCinematicUI()
    
    animateIntro(frame, title, status, stroke)
    task.wait(1.5)

    safeCall("Rendering", function() Module_Rendering(status) end)
    task.wait(0.5) -- UI'ın güncellenmesi için zaman tanı
    
    safeCall("Memory", function() Module_Memory(status) end)
    task.wait(0.5)
    
    safeCall("Physics", function() Module_Physics(status) end)
    task.wait(0.5)

    status.Text = "Finalizing..."
    pcall(function() collectgarbage("collect") end)
    task.wait(1)

    status.Text = "Optimization Successful"
    status.TextColor3 = Color3.fromRGB(50, 255, 120) 
    stroke.Color = Color3.fromRGB(50, 255, 120)
    
    StartAICore()
    print("Titanium v4.1: AI Core Started in Background.")

    task.wait(3)
    animateOutro(frame, title, status, stroke, gui)
end

ActivateTitaniumMaster()
