-- [[ TITANIUM ANIMATED BOOTSTRAPPER v2.0 ]] --
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local function showNotify(msg, color)
    -- Varsa eski GUI'yi temizle
    local existing = CoreGui:FindFirstChild("TitaniumNotify")
    if existing then existing:Destroy() end

    -- Ekran GUI Oluşturma
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TitaniumNotify"
    screenGui.Parent = CoreGui
    screenGui.DisplayOrder = 100 -- Diğer UI'ların üstünde görünmesi için
    
    -- Ana Panel (Kutu)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 0, 0, 0) -- Başlangıç boyutu (Zoom efekti için)
    mainFrame.Position = UDim2.new(0.5, 0, 0.3, 0) -- Ekranın %30'luk üst kısmı (Mobil uyumlu)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    -- Köşe Yumuşatma (UICorner)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 18) -- Gözle görülür şık yumuşaklık
    corner.Parent = mainFrame

    -- Kenarlık Parlaması (UIStroke)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2.5
    stroke.Color = color
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Transparency = 0.3
    stroke.Parent = mainFrame

    -- Yazı Etiketi
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = color
    textLabel.Text = msg
    textLabel.TextSize = 17
    textLabel.Font = Enum.Font.GothamBold -- Daha modern bir font
    textLabel.Parent = mainFrame

    -- ANIMASYONLAR (TweenService)
    local openInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local closeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)

    local zoomIn = TweenService:Create(mainFrame, openInfo, {Size = UDim2.new(0, 300, 0, 65)})
    local zoomOut = TweenService:Create(mainFrame, closeInfo, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})

    -- Oynat
    zoomIn:Play()
    
    -- 4 saniye sonra kapanış (Animasyonla birlikte)
    task.delay(4, function()
        if mainFrame then
            zoomOut:Play()
            zoomOut.Completed:Connect(function()
                screenGui:Destroy()
            end)
        end
    end)
end

-- SCRIPT ÇALIŞTIRMA (RAW LINK KULLANIMI)
local raw_url = "https://raw.githubusercontent.com/Nenecosturan/Titanium-FPS-Booster-v.2/refs/heads/main/Main.lua"

local success, result = pcall(function()
    -- game:HttpGet ile Raw linkten kod çekilir ve loadstring ile çalıştırılır
    return loadstring(game:HttpGet(raw_url))()
end)

if success then
    -- Başarılıysa yeşil bildirim
    showNotify("Your device is now optimized", Color3.fromRGB(85, 255, 127))
else
    -- Hata varsa kırmızı bildirim
    showNotify("Optimization failed", Color3.fromRGB(255, 80, 80))
    warn("Titanium Error Log: " .. tostring(result))
end
