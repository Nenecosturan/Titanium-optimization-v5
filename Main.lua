--[[
    TITANIUM OPTIMIZER GEN 2
    Target: Ultra-Low-End Mobile Devices (2GB-4GB RAM)
    Author: Senior Roblox Optimization Engineer
    Language: Luau
    Version: 2.0 (God-Tier Edition)
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--------------------------------------------------------------------------------
-- 1. UI SYSTEM (Görsel Geri Bildirim)
--------------------------------------------------------------------------------
local function createStatusUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TitaniumOptimizerUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    
    -- Güvenlik: Eğer exploit ile çalıştırılıyorsa CoreGui, değilse PlayerGui
    pcall(function()
        screenGui.Parent = CoreGui
    end)
    if not screenGui.Parent then
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "StatusFrame"
    mainFrame.Size = UDim2.new(0, 300, 0, 80)
    mainFrame.Position = UDim2.new(0.5, -150, 0.2, 0) -- Ekranın üst ortası
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.Parent = screenGui

    -- Yuvarlatılmış Kenarlar
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 20)
    uiCorner.Parent = mainFrame

    -- Parlama Efekti (Stroke)
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 3
    uiStroke.Transparency = 0.5
    uiStroke.Parent = mainFrame

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 1, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextSize = 18
    statusLabel.TextWrapped = true
    statusLabel.Parent = mainFrame

    return mainFrame, statusLabel, uiStroke, screenGui
end

--------------------------------------------------------------------------------
-- 2. OPTIMIZATION MODULES
--------------------------------------------------------------------------------

-- Modül: Bellek ve Partikül Temizliği
local function optimizeMemory()
    -- Gereksiz efektleri temizle
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Explosion") then
            obj:Destroy()
        end
    end
    
    -- Terrain Suyunu Dondur
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end
end

-- Modül: Render ve GPU (Grafik)
local function optimizeRendering()
    settings().Rendering.QualityLevel = 1 -- En düşük kaliteye zorla
    
    -- Işıklandırmayı Çökert (Basitleştir)
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 2
    Lighting.Technology = Enum.Technology.Compatibility
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0

    -- Post-Process Efektlerini Sil
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("Sky") or effect:IsA("SunRaysEffect") then
            effect:Destroy()
        end
    end

    -- Materyal ve Doku Temizliği (Toplu İşlem)
    -- Not: FPS düşmemesi için 'task.wait' ile chunking yapıyoruz.
    local counter = 0
    for _, part in pairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Material = Enum.Material.Plastic
            part.Reflectance = 0
            part.CastShadow = false
            -- Dokuları sil
            for _, child in pairs(part:GetChildren()) do
                if child:IsA("Texture") or child:IsA("Decal") then
                    child:Destroy()
                end
            end
        elseif part:IsA("MeshPart") then
            part.RenderFidelity = Enum.RenderFidelity.Performance
            part.Material = Enum.Material.Plastic
            part.CastShadow = false
        end
        
        counter = counter + 1
        if counter % 500 == 0 then task.wait() end -- Donmayı engelle
    end
end

-- Modül: CPU ve Fizik
local function optimizePhysics()
    -- Fizik Hesaplamalarını Kısıtla
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.PhysicsEnvironmentalThrottle.Always
    settings().Physics.AllowSleep = true
    Workspace.InterpolationThrottling = Enum.InterpolationThrottling.Enabled

    -- Çarpışma ve Dokunma Olaylarını Kapat (Sadece Dekorasyonlar İçin)
    -- Dikkat: Bu kısım oyunun mekaniklerini bozabilir, bu yüzden sadece MeshPart'lara uyguluyoruz.
    local counter = 0
    for _, part in pairs(Workspace:GetDescendants()) do
        if part:IsA("MeshPart") and part.CanCollide == false then
            -- Zaten çarpışması kapalıysa dokunma eventlerini de kapat (CPU tasarrufu)
            part.CanTouch = false
            part.CanQuery = false
        end
        counter = counter + 1
        if counter % 500 == 0 then task.wait() end
    end
end

-- Modül: Ağ ve Ping (Lag Reducer)
local function optimizeNetwork()
    -- Uzaktaki oyuncuların aksesuarlarını gizle (Rendering yükünü azaltır)
    task.spawn(function()
        while task.wait(3) do
            pcall(function()
                if not LocalPlayer.Character then return end
                local myPos = LocalPlayer.Character.PrimaryPart.Position
                
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (plr.Character.HumanoidRootPart.Position - myPos).Magnitude
                        
                        -- Eğer 50 studdan uzaksa aksesuarları gizle
                        for _, acc in pairs(plr.Character:GetChildren()) do
                            if acc:IsA("Accessory") or acc:IsA("Shirt") or acc:IsA("Pants") then
                                if dist > 50 then
                                    if acc:IsA("Accessory") then acc.Handle.Transparency = 1 end
                                else
                                    if acc:IsA("Accessory") then acc.Handle.Transparency = 0 end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
    
    -- Simulation Radius (Exploit yetkisi gerektirebilir, pcall içine alındı)
    pcall(function()
        settings().Physics.ForceEffectsToUseSimplifiedPhysics = true
        LocalPlayer.SimulationRadius = 0 -- Sadece kendi karakterini hesapla
    end)
end

--------------------------------------------------------------------------------
-- 3. MAIN EXECUTION (Güvenli Başlatma)
--------------------------------------------------------------------------------

local function ActivateTitanium()
    local frame, label, stroke, gui = createStatusUI()
    
    -- Başlangıç durumu
    label.Text = "Titanium Optimizer Gen 2 Initializing..."
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    stroke.Color = Color3.fromRGB(255, 255, 255)

    task.wait(1)

    -- Optimizasyon İşlemi
    local success, err = pcall(function()
        optimizeMemory()
        optimizeRendering()
        optimizePhysics()
        optimizeNetwork()
        
        -- Çöp Toplayıcıyı Manuel Çalıştır (RAM Temizliği)
        local gcSuccess, gcResult = pcall(function() 
            repeat task.wait() until game:IsLoaded()
            collectgarbage("collect") 
        end)
    end)

    -- Sonuç Bildirimi
    if success then
        -- BAŞARILI DURUMU
        label.Text = "Device optimized by Titanium Optimizer"
        label.TextColor3 = Color3.fromRGB(0, 255, 100) -- Parlak Yeşil
        stroke.Color = Color3.fromRGB(0, 255, 100) -- Yeşil Parlama
        
        -- Yanıp sönme efekti (Tween yerine basit döngü CPU dostudur)
        task.spawn(function()
            local t = 0
            while t < 5 do
                stroke.Transparency = 0.2
                task.wait(0.1)
                stroke.Transparency = 0.6
                task.wait(0.1)
                t = t + 0.2
            end
            gui:Destroy() -- 5 saniye sonra arayüzü sil
        end)
        
        print("Titanium Optimizer Gen 2: Successful.")
    else
        -- BAŞARISIZ DURUMU
        label.Text = "Optimization Failed"
        label.TextColor3 = Color3.fromRGB(255, 50, 50) -- Kırmızı
        stroke.Color = Color3.fromRGB(255, 50, 50) -- Kırmızı Parlama
        warn("Titanium Optimizer Error: " .. tostring(err))
        
        task.wait(5)
        gui:Destroy()
    end
end

-- Scripti Başlat
if not game:IsLoaded() then
    game.Loaded:Wait()
end
ActivateTitanium()
