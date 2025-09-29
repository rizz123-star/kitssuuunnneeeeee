local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RizzToolsHub"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Developer Label (pojok kiri bawah)
local devLabel = Instance.new("TextLabel", gui)
devLabel.Size = UDim2.new(0,200,0,25)
devLabel.Position = UDim2.new(0,10,1,-30)
devLabel.Text = "👨‍💻 Developer: Rizztzy"
devLabel.TextColor3 = Color3.fromRGB(255,255,255)
devLabel.Font = Enum.Font.GothamBold
devLabel.TextSize = 14
devLabel.BackgroundTransparency = 1
devLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Notifikasi Success (pojok kanan bawah)
local function showSuccess(msg)
    local notif = Instance.new("Frame", gui)
    notif.Size = UDim2.new(0,200,0,40)
    notif.Position = UDim2.new(1,-210,1,-60)
    notif.BackgroundColor3 = Color3.fromRGB(20,20,20)
    notif.BackgroundTransparency = 0.1
    notif.BorderSizePixel = 0
    notif.Active = true

    local corner = Instance.new("UICorner", notif)
    corner.CornerRadius = UDim.new(0,10)

    local lbl = Instance.new("TextLabel", notif)
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Text = "✅ "..(msg or "Success!")
    lbl.TextColor3 = Color3.fromRGB(0,255,100)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 16
    lbl.BackgroundTransparency = 1

    -- Tween animasi muncul & hilang
    local TweenService = game:GetService("TweenService")
    notif.Position = UDim2.new(1,-210,1,50)
    TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(1,-210,1,-60)}):Play()

    task.delay(3,function()
        TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(1,-210,1,50)}):Play()
        task.delay(0.5,function() notif:Destroy() end)
    end)
end

-- Panggil notifikasi sekali setelah exec
showSuccess("Hub Loaded Successfully!")

-- FRAME UTAMA
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 450, 0, 300)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0

-- TITLE BAR
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1,0,0,35)
titleBar.BackgroundColor3 = Color3.fromRGB(40,40,40)
titleBar.BorderSizePixel = 0
titleBar.Active = true

-- JUDUL
local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0,10,0,0)
titleLabel.Text = "🍎 Rizz Tools Hub"
titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.BackgroundTransparency = 1
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- TOMBOL CLOSE
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0,25,0,25)
closeBtn.Position = UDim2.new(1,-30,0.5,-12)
closeBtn.Text = "✖"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)

-- SIDEBAR
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, -35)
sidebar.Position = UDim2.new(0,0,0,35)
sidebar.BackgroundColor3 = Color3.fromRGB(30,30,30)
sidebar.BorderSizePixel = 0

-- CONTENT
local content = Instance.new("Frame", mainFrame)
content.Size = UDim2.new(1, -120, 1, -35)
content.Position = UDim2.new(0, 120, 0, 35)
content.BackgroundTransparency = 1

-- CUSTOM DRAG (biar cuma mainFrame yg gerak)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false

        -- Cek kalau frame keluar layar → balikin ke tengah
        local screenSize = workspace.CurrentCamera.ViewportSize
        local framePos = mainFrame.AbsolutePosition
        local frameSize = mainFrame.AbsoluteSize

        if framePos.X < 0 or framePos.Y < 0 or 
           (framePos.X + frameSize.X) > screenSize.X or 
           (framePos.Y + frameSize.Y) > screenSize.Y then
            
            TweenService:Create(
                mainFrame,
                TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(0.5, -frameSize.X/2, 0.5, -frameSize.Y/2)}
            ):Play()
        end
    end
end)

-- SISTEM TAB
local tabs = {}
local function createTab(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, #tabs * 45 + 10)
    btn.Text = "🍎 "..name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.BorderSizePixel = 0

    local frame = Instance.new("Frame", content)
    frame.Size = UDim2.new(1, -10, 1, -10)
    frame.Position = UDim2.new(0,5,0,5)
    frame.Visible = false
    frame.BackgroundTransparency = 1

    btn.MouseButton1Click:Connect(function()
        for _,t in pairs(tabs) do
            t.frame.Visible = false
        end
        frame.Visible = true
    end)

    table.insert(tabs, {btn = btn, frame = frame})
    return frame
end

-- UTILS: bikin tombol ON/OFF
local function makeToggle(parent, posY, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Position = UDim2.new(0,20,0,posY)
    btn.Text = "🍎 "..text.." [OFF]"
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(150,0,0)
    btn.BorderSizePixel = 0

    local state = false
    local function updateVisual()
        btn.Text = "🍎 "..text..(state and " [ON]" or " [OFF]")
        btn.BackgroundColor3 = state and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0)
    end

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    end)
    btn.MouseLeave:Connect(updateVisual)

    btn.MouseButton1Click:Connect(function()
        state = not state
        updateVisual()
        callback(state)
    end)

    updateVisual()
    return function() return state end
end

---------------------------------------------------
-- INFO TAB
local infoTab = createTab("Info")

local infoFrame = Instance.new("Frame", infoTab)
infoFrame.Size = UDim2.new(0, 450, 0, 300)
infoFrame.Position = UDim2.new(0,20,0,20)
infoFrame.BackgroundTransparency = 1

local horizLayout = Instance.new("UIListLayout", infoFrame)
horizLayout.FillDirection = Enum.FillDirection.Horizontal
horizLayout.SortOrder = Enum.SortOrder.LayoutOrder
horizLayout.Padding = UDim.new(0,10)

-- Avatar
local avatarImg = Instance.new("ImageLabel", infoFrame)
avatarImg.Size = UDim2.new(0,100,0,100)
avatarImg.BackgroundColor3 = Color3.fromRGB(40,40,40)
avatarImg.BorderSizePixel = 0
avatarImg.ScaleType = Enum.ScaleType.Crop

local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size100x100
local thumb, _ = game.Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
avatarImg.Image = thumb

-- Text Info
local textFrame = Instance.new("Frame", infoFrame)
textFrame.Size = UDim2.new(1, -120, 1, 0)
textFrame.BackgroundTransparency = 1

local vLayout = Instance.new("UIListLayout", textFrame)
vLayout.FillDirection = Enum.FillDirection.Vertical
vLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
vLayout.SortOrder = Enum.SortOrder.LayoutOrder
vLayout.Padding = UDim.new(0,4)

local function makeInfoLabel(text)
    local lbl = Instance.new("TextLabel", textFrame)
    lbl.Size = UDim2.new(1, -10, 0, 20)
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    return lbl
end

local usernameLabel = makeInfoLabel("Username: "..player.Name)
local displayLabel  = makeInfoLabel("Display Name: "..player.DisplayName)
local useridLabel   = makeInfoLabel("UserId: "..player.UserId)
local gameLabel     = makeInfoLabel("Game: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
local onlineLabel   = makeInfoLabel("Status: Online ✅")
local statsLabel    = makeInfoLabel("Health: 100 | WalkSpeed: 16 | JumpPower: 50")
local fpsLabel      = makeInfoLabel("FPS: 0")
local pingLabel     = makeInfoLabel("Ping: 0 ms")
local timerLabel    = makeInfoLabel("Session: 0s")
local deviceLabel   = makeInfoLabel("Device: ...")

local startTime = tick()
local RunService = game:GetService("RunService")
local stats = game:GetService("Stats")

local UserInputService = game:GetService("UserInputService")
local device = "PC"
if UserInputService.TouchEnabled then device = "Mobile"
elseif UserInputService.GamepadEnabled then device = "Console" end
deviceLabel.Text = "Device: "..device

RunService.RenderStepped:Connect(function()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        statsLabel.Text = "Health: "..math.floor(hum.Health).."/"..hum.MaxHealth..
                          " | WalkSpeed: "..hum.WalkSpeed..
                          " | JumpPower: "..hum.JumpPower
    end
    fpsLabel.Text = "FPS: "..math.floor(1/RunService.RenderStepped:Wait())
    pingLabel.Text = "Ping: "..math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()).." ms"
    local elapsed = tick() - startTime
    timerLabel.Text = string.format("Session: %02dm %02ds", math.floor(elapsed/60), math.floor(elapsed%60))
end)

---------------------------------------------------
-- MAIN TAB
local mainTab = createTab("Main")

-- NOCLIP
local noclip = false
makeToggle(mainTab,20,"No Clip",function(on) noclip=on end)
game:GetService("RunService").Stepped:Connect(function()
    if noclip and player.Character then
        for _,v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- GOD MODE
local godMode = false
makeToggle(mainTab,70,"God Mode",function(on) godMode=on end)
game:GetService("RunService").Stepped:Connect(function()
    if godMode and player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = hum.MaxHealth end
    end
end)

-- FLY
local flying = false
local flySpeed = 60
local bodyVel, bodyGyro
makeToggle(mainTab,120,"Fly",function(on)
    flying = on
    local char = player.Character
    if not char then return end
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if on then
        hum.PlatformStand = true
        bodyVel = Instance.new("BodyVelocity", root)
        bodyVel.MaxForce = Vector3.new(1e5,1e5,1e5)
        bodyVel.Velocity = Vector3.new()
        bodyGyro = Instance.new("BodyGyro", root)
        bodyGyro.MaxTorque = Vector3.new(1e5,1e5,1e5)
        bodyGyro.P = 1e4
    else
        if bodyVel then bodyVel:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        hum.PlatformStand = false
    end
end)
game:GetService("RunService").RenderStepped:Connect(function()
    if flying and player.Character and bodyVel and bodyGyro then
        local root = player.Character.HumanoidRootPart
        local camCF = workspace.CurrentCamera.CFrame
        bodyGyro.CFrame = camCF
        local dir = camCF.LookVector
        bodyVel.Velocity = dir * flySpeed
    end
end)

---------------------------------------------------
-- TELEPORT TAB
local teleportTab = createTab("Teleport")

local scroll = Instance.new("ScrollingFrame", teleportTab)
scroll.Size = UDim2.new(0,220,0,200)
scroll.Position = UDim2.new(0,20,0,20)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarThickness = 6
scroll.BackgroundColor3 = Color3.fromRGB(30,30,30)
scroll.BorderSizePixel = 0

local function createPlayerBtn(plr)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Text = "🍎 " .. plr.Name
    btn.Parent = scroll
    btn.BorderSizePixel = 0

    btn.MouseButton1Click:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local myChar = player.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                myChar.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(2,1,2)
            end
        end
    end)

    return btn
end

local function refreshPlayers()
    scroll:ClearAllChildren()
    local y = 0
    for _,plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player then
            local btn = createPlayerBtn(plr)
            btn.Position = UDim2.new(0,5,0,y)
            y = y + 35
        end
    end
    scroll.CanvasSize = UDim2.new(0,0,0,y)
end

refreshPlayers()
game.Players.PlayerAdded:Connect(refreshPlayers)
game.Players.PlayerRemoving:Connect(refreshPlayers)

-- Movement + Aimbot UI (LocalScript)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Helper: Ambil Humanoid
local function getHumanoid(p)
    p = p or player
    if p and p.Character then
        return p.Character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

-- MAIN CONTAINER (asumsi ScreenGui sudah ada; bila belum, buat)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MovementAimbotGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.AnchorPoint = Vector2.new(0,0)
mainFrame.Position = UDim2.new(0.02,0,0.1,0)
mainFrame.Size = UDim2.new(0,280,0,420)
mainFrame.BackgroundTransparency = 1

-- Tab style container
local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(1,0,1,0)
container.BackgroundTransparency = 0.15
container.BackgroundColor3 = Color3.fromRGB(18,18,18)
container.BorderSizePixel = 0
Instance.new("UICorner", container).CornerRadius = UDim.new(0,8)
container.ClipsDescendants = false

local title = Instance.new("TextLabel", container)
title.Size = UDim2.new(1,0,0,28)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "🏃 Movement & 🎯 Aimbot"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Padding = Instance.new("UIPadding", title)
title.Padding.PaddingLeft = UDim.new(0,8)

-- Scrolling frame untuk layout
local moveFrame = Instance.new("ScrollingFrame", container)
moveFrame.Size = UDim2.new(1, -20, 1, -38)
moveFrame.Position = UDim2.new(0,10,0,34)
moveFrame.BackgroundTransparency = 1
moveFrame.ScrollBarThickness = 6
moveFrame.CanvasSize = UDim2.new(0,0,0,0)
moveFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
moveFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local layout = Instance.new("UIListLayout", moveFrame)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0,8)

-- Utility: create holder
local function createHolder()
    local holder = Instance.new("Frame", moveFrame)
    holder.Size = UDim2.new(0, 260, 0, 44)
    holder.BackgroundColor3 = Color3.fromRGB(40,40,40)
    holder.BorderSizePixel = 0
    holder.ClipsDescendants = false
    holder.ZIndex = 2
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0,6)
    return holder
end

-- makeAdjuster (plus/minus)
local function makeAdjuster(title, default, step, applyFunc)
    local holder = createHolder()
    local label = Instance.new("TextLabel", holder)
    label.Size = UDim2.new(0.55, -10, 1, 0)
    label.Position = UDim2.new(0.05,0,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local minus = Instance.new("TextButton", holder)
    minus.Size = UDim2.new(0,44,0,30)
    minus.Position = UDim2.new(0.6,0,0.1,0)
    minus.Text = "—"
    minus.AutoButtonColor = true
    minus.Font = Enum.Font.GothamBold
    minus.TextSize = 18
    minus.TextColor3 = Color3.fromRGB(255,255,255)
    minus.BackgroundColor3 = Color3.fromRGB(60,60,60)
    minus.BorderSizePixel = 0
    minus.ZIndex = 3
    Instance.new("UICorner", minus).CornerRadius = UDim.new(0,6)

    local plus = Instance.new("TextButton", holder)
    plus.Size = UDim2.new(0,44,0,30)
    plus.Position = UDim2.new(0.8,0,0.1,0)
    plus.Text = "+"
    plus.AutoButtonColor = true
    plus.Font = Enum.Font.GothamBold
    plus.TextSize = 18
    plus.TextColor3 = Color3.fromRGB(255,255,255)
    plus.BackgroundColor3 = Color3.fromRGB(60,60,60)
    plus.BorderSizePixel = 0
    plus.ZIndex = 3
    Instance.new("UICorner", plus).CornerRadius = UDim.new(0,6)

    -- ensure click not blocked
    holder.Active = false
    minus.Active = true
    plus.Active = true

    local value = default
    local function updateLabel()
        label.Text = title..": "..tostring(value)
        pcall(function() applyFunc(value) end)
    end

    minus.MouseButton1Click:Connect(function()
        value = value - step
        updateLabel()
    end)
    plus.MouseButton1Click:Connect(function()
        value = value + step
        updateLabel()
    end)

    updateLabel()
    return holder
end

-- makeToggle
local function makeToggle(text, default, callback)
    local btn = Instance.new("TextButton", moveFrame)
    btn.Size = UDim2.new(0,260,0,44)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    btn.AutoButtonColor = true
    btn.ZIndex = 3
    btn.Active = true

    local state = default or false
    btn.Text = (state and "✅ " or "❌ ")..text

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = (state and "✅ " or "❌ ")..text
        pcall(function() callback(state) end)
    end)
    -- ensure initial callback
    pcall(function() callback(state) end)
    return btn
end

-- ========== Movement Controls ==========
local lastWalkSpeed = 16
makeAdjuster("🍎 Speed", 16, 1, function(val)
    lastWalkSpeed = val
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = tonumber(val) or 16
    end
end)

local lastJumpPower = 50
makeAdjuster("🍎 Jump Power", 50, 5, function(val)
    lastJumpPower = val
    local hum = getHumanoid()
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = tonumber(val) or 50
    end
end)

-- Infinite jump toggle
local infjump = false
makeToggle("Infinite Jump", false, function(on)
    infjump = on
end)
UserInputService.JumpRequest:Connect(function()
    if infjump then
        local hum = getHumanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ========== Aimbot System ==========
local aimbotEnabled = false
local aimbotMode = "nearest" -- "nearest" or "manual"
local selectedTarget = nil -- Player object
local aimSmoothing = 0.25 -- 0..1 (bigger => slower smoothing)
local aimFOV = 120 -- optional, not used for strict selection but can be extended

-- UI for aimbot controls
local aimbotTitle = Instance.new("TextLabel", moveFrame)
aimbotTitle.Size = UDim2.new(0,260,0,24)
aimbotTitle.BackgroundTransparency = 1
aimbotTitle.Text = "— Aimbot —"
aimbotTitle.Font = Enum.Font.GothamBold
aimbotTitle.TextColor3 = Color3.fromRGB(200,200,200)
aimbotTitle.TextSize = 13

-- Toggle aimbot
makeToggle("Enable Aimbot", false, function(on)
    aimbotEnabled = on
    if not on then
        -- clear selection but keep mode
        -- restore camera if changed by code
        if camera and camera.CameraType == Enum.CameraType.Scriptable then
            camera.CameraType = Enum.CameraType.Custom
        end
    end
end)

-- Mode selector (two small buttons)
local modeHolder = createHolder()
modeHolder.Size = UDim2.new(0,260,0,44)
local modeLabel = Instance.new("TextLabel", modeHolder)
modeLabel.Size = UDim2.new(0.55, -10, 1, 0)
modeLabel.Position = UDim2.new(0.05,0,0,0)
modeLabel.BackgroundTransparency = 1
modeLabel.Font = Enum.Font.Gotham
modeLabel.TextSize = 14
modeLabel.TextColor3 = Color3.fromRGB(255,255,255)
modeLabel.TextXAlignment = Enum.TextXAlignment.Left
modeLabel.Text = "Mode: Nearest"

local btnNearest = Instance.new("TextButton", modeHolder)
btnNearest.Size = UDim2.new(0,88,0,30)
btnNearest.Position = UDim2.new(0.55,4,0.1,0)
btnNearest.Text = "Nearest"
btnNearest.Font = Enum.Font.GothamBold
btnNearest.TextSize = 13
btnNearest.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", btnNearest).CornerRadius = UDim.new(0,6)
btnNearest.AutoButtonColor = true

local btnManual = Instance.new("TextButton", modeHolder)
btnManual.Size = UDim2.new(0,88,0,30)
btnManual.Position = UDim2.new(0.78,-10,0.1,0)
btnManual.Text = "Select"
btnManual.Font = Enum.Font.GothamBold
btnManual.TextSize = 13
btnManual.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", btnManual).CornerRadius = UDim.new(0,6)
btnManual.AutoButtonColor = true

btnNearest.MouseButton1Click:Connect(function()
    aimbotMode = "nearest"
    modeLabel.Text = "Mode: Nearest"
    selectedTarget = nil
end)

-- Popup select UI
local selectPopup = Instance.new("Frame", screenGui)
selectPopup.Size = UDim2.new(0,300,0,260)
selectPopup.Position = UDim2.new(0.5,-150,0.5,-130)
selectPopup.Visible = false
selectPopup.BackgroundColor3 = Color3.fromRGB(20,20,20)
selectPopup.BorderSizePixel = 0
Instance.new("UICorner", selectPopup).CornerRadius = UDim.new(0,8)
selectPopup.ZIndex = 50

local spTitle = Instance.new("TextLabel", selectPopup)
spTitle.Size = UDim2.new(1,0,0,30)
spTitle.Position = UDim2.new(0,0,0,0)
spTitle.BackgroundTransparency = 1
spTitle.Text = "Select Player (click to choose)"
spTitle.Font = Enum.Font.GothamBold
spTitle.TextSize = 14
spTitle.TextColor3 = Color3.fromRGB(255,255,255)

local spList = Instance.new("ScrollingFrame", selectPopup)
spList.Size = UDim2.new(1,-10,1,-70)
spList.Position = UDim2.new(0,5,0,35)
spList.BackgroundTransparency = 1
spList.ScrollBarThickness = 6
spList.CanvasSize = UDim2.new(0,0,0,0)
spList.AutomaticCanvasSize = Enum.AutomaticSize.Y

local spLayout = Instance.new("UIListLayout", spList)
spLayout.SortOrder = Enum.SortOrder.LayoutOrder
spLayout.Padding = UDim.new(0,6)

local cancelSelectBtn = Instance.new("TextButton", selectPopup)
cancelSelectBtn.Size = UDim2.new(0,120,0,30)
cancelSelectBtn.Position = UDim2.new(0.5,-60,1,-34)
cancelSelectBtn.Text = "Cancel"
cancelSelectBtn.Font = Enum.Font.GothamBold
cancelSelectBtn.TextSize = 14
cancelSelectBtn.AutoButtonColor = true
Instance.new("UICorner", cancelSelectBtn).CornerRadius = UDim.new(0,6)

local function refreshPlayerList()
    -- clear
    for _,child in pairs(spList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for i,p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local btn = Instance.new("TextButton", spList)
            btn.Size = UDim2.new(1,-10,0,34)
            btn.Position = UDim2.new(0,5,0,0)
            btn.Text = p.Name
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.AutoButtonColor = true
            btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
            btn.BorderSizePixel = 0
            btn.ZIndex = 51
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
            btn.MouseButton1Click:Connect(function()
                selectedTarget = p
                aimbotMode = "manual"
                modeLabel.Text = "Mode: Manual ("..p.Name..")"
                selectPopup.Visible = false
            end)
        end
    end
end

btnManual.MouseButton1Click:Connect(function()
    refreshPlayerList()
    selectPopup.Visible = true
end)

cancelSelectBtn.MouseButton1Click:Connect(function()
    selectPopup.Visible = false
end)

-- Cancel target button (clear selection)
local cancelHolder = createHolder()
cancelHolder.Size = UDim2.new(0,260,0,36)
local cancelBtn = Instance.new("TextButton", cancelHolder)
cancelBtn.Size = UDim2.new(1, -12, 1, 0)
cancelBtn.Position = UDim2.new(0,6,0,0)
cancelBtn.Text = "Cancel Target"
cancelBtn.Font = Enum.Font.GothamBold
cancelBtn.TextSize = 14
cancelBtn.AutoButtonColor = true
Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0,6)
cancelBtn.MouseButton1Click:Connect(function()
    selectedTarget = nil
    if aimbotMode == "manual" then
        modeLabel.Text = "Mode: Manual (none)"
    end
end)

-- Aim smoothing adjuster
makeAdjuster("Aim Smoothing (0-1)", 0.25, 0.05, function(val)
    aimSmoothing = math.clamp(tonumber(val) or 0.25, 0, 1)
end)

-- ================= Aim logic =================
local prevCameraType = camera.CameraType
local function getClosestPlayer()
    local closest = nil
    local closestDist = math.huge
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    for _, pl in pairs(Players:GetPlayers()) do
        if pl ~= player and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and getHumanoid(pl) and getHumanoid(pl).Health > 0 then
            local targetRoot = pl.Character:FindFirstChild("HumanoidRootPart")
            local dist = (targetRoot.Position - myRoot.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = pl
            end
        end
    end
    return closest
end

local aiming = false
RunService:BindToRenderStep("AimbotAimStep", Enum.RenderPriority.Camera.Value + 1, function(dt)
    if not aimbotEnabled then
        if aiming then
            aiming = false
            -- restore camera
            if camera and camera.CameraType == Enum.CameraType.Scriptable then
                camera.CameraType = Enum.CameraType.Custom
            end
        end
        return
    end

    -- determine target
    local target = nil
    if aimbotMode == "nearest" then
        target = getClosestPlayer()
    elseif aimbotMode == "manual" then
        target = selectedTarget
        if target and (not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") or (getHumanoid(target) and getHumanoid(target).Health <= 0)) then
            -- dead or invalid
            target = nil
            selectedTarget = nil
            if aimbotMode == "manual" then
                modeLabel.Text = "Mode: Manual (none)"
            end
        end
    end

    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        aiming = true
        -- set camera to scriptable to control smoothly
        if camera.CameraType ~= Enum.CameraType.Scriptable then
            camera.CameraType = Enum.CameraType.Scriptable
        end

        local myPos = camera.CFrame.Position
        local targetPart = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
        if not targetPart then return end
        local targetPos = targetPart.Position

        -- compute lookAt CFrame while keeping camera position
        local desired = CFrame.new(myPos, targetPos)

        -- lerp current camera CFrame to desired
        local newCFrame = camera.CFrame:Lerp(desired, math.clamp(1 - aimSmoothing, 0.01, 1))
        camera.CFrame = newCFrame
    else
        -- no target
        if aiming then
            aiming = false
            if camera and camera.CameraType == Enum.CameraType.Scriptable then
                camera.CameraType = Enum.CameraType.Custom
            end
        end
    end
end)

-- cleanup on character respawn: reapply movement defaults
Players.LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.5)
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = lastWalkSpeed or 16
        hum.UseJumpPower = true
        hum.JumpPower = lastJumpPower or 50
    end
end)

-- Optional: Hotkey to toggle aimbot (press 'B')
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.B then
            aimbotEnabled = not aimbotEnabled
            -- update toggle button label (search for Enable Aimbot)
            for _,v in pairs(moveFrame:GetChildren()) do
                if v:IsA("TextButton") and v.Text:match("Aimbot") then
                    v.Text = (aimbotEnabled and "✅ " or "❌ ").."Enable Aimbot"
                end
            end
        end
        if input.KeyCode == Enum.KeyCode.N then
            -- quick cancel
            selectedTarget = nil
            aimbotMode = "nearest"
            modeLabel.Text = "Mode: Nearest"
        end
    end
end)

-- Small UX: close popup when clicking outside
selectPopup.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- do nothing; user selects via buttons
    end
end)

-- Ensure initial player list updated when players join/leave
Players.PlayerAdded:Connect(function() refreshPlayerList() end)
Players.PlayerRemoving:Connect(function() refreshPlayerList() end)

-- Initially refresh
refreshPlayerList()

-- End of script
---------------------------------------------------
-- 🛠️ MISC TAB
local miscTab = createTab("Misc")

-- 📜 Scrolling Frame
local miscFrame = Instance.new("ScrollingFrame", miscTab)
miscFrame.Size = UDim2.new(1, -20, 1, -20)
miscFrame.Position = UDim2.new(0,10,0,10)
miscFrame.BackgroundTransparency = 1
miscFrame.ScrollBarThickness = 6
miscFrame.CanvasSize = UDim2.new(0,0,0,0) 
miscFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Layout otomatis
local layout = Instance.new("UIListLayout", miscFrame)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0,8)

---------------------------------------------------
-- 📌 Fungsi UI Helper
local function makeButton(text, callback)
    local btn = Instance.new("TextButton", miscFrame)
    btn.Size = UDim2.new(0,250,0,40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    -- Efek hover
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    end)

    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    return btn
end

local function makeLabel(text)
    local lbl = Instance.new("TextLabel", miscFrame)
    lbl.Size = UDim2.new(0,300,0,30)
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(200,200,200)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

---------------------------------------------------
-- 🔄 Rejoin
makeButton("🔄 Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)

-- 🌐 Join Server by ID
local joinBox = Instance.new("TextBox", miscFrame)
joinBox.Size = UDim2.new(0,250,0,40)
joinBox.PlaceholderText = "Enter Server ID..."
joinBox.Text = ""
joinBox.TextColor3 = Color3.fromRGB(255,255,255)
joinBox.Font = Enum.Font.Gotham
joinBox.TextSize = 14
joinBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
joinBox.BorderSizePixel = 0
Instance.new("UICorner", joinBox).CornerRadius = UDim.new(0,6)

makeButton("🌐 Join Server", function(btn)
    local serverId = joinBox.Text
    if serverId ~= "" then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverId, game.Players.LocalPlayer)
    else
        btn.Text = "⚠️ Invalid ID"
        task.wait(1.5)
        btn.Text = "🌐 Join Server"
    end
end)

---------------------------------------------------
-- 🆔 Server Info
makeLabel("🆔 Server ID: "..game.JobId)

local playerCountLabel = makeLabel("👥 Players in Server: "..#game.Players:GetPlayers())
game:GetService("RunService").RenderStepped:Connect(function()
    playerCountLabel.Text = "👥 Players in Server: "..#game.Players:GetPlayers()
end)

---------------------------------------------------
-- 📋 Copy Player List
makeButton("📋 Copy Player List", function(btn)
    local names = {}
    for _,plr in ipairs(game.Players:GetPlayers()) do
        table.insert(names, plr.Name.." ("..plr.DisplayName..")")
    end
    local text = table.concat(names, ", ")

    if setclipboard then
        setclipboard(text)
    elseif toclipboard then
        toclipboard(text)
    end

    btn.Text = "✅ Copied!"
    task.wait(1.5)
    btn.Text = "📋 Copy Player List"
end)

-- 🔗 Copy Game Link
makeButton("🔗 Copy Game Link", function(btn)
    local link = "https://www.roblox.com/games/"..game.PlaceId.."?jobId="..game.JobId
    if setclipboard then
        setclipboard(link)
    elseif toclipboard then
        toclipboard(link)
    end

    btn.Text = "✅ Link Copied!"
    task.wait(1.5)
    btn.Text = "🔗 Copy Game Link"
end)

-- 🎲 Hop Server
makeButton("🎲 Hop Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)
---------------------------------------------------

-- DEFAULT TAB AKTIF
tabs[1].frame.Visible = true

-- TOMBOL REOPEN
local reopen = Instance.new("ImageButton", gui)
reopen.Size = UDim2.new(0,40,0,40)
reopen.Position = UDim2.new(0,20,0.5,-20)
reopen.Image = "rbxassetid://6034509993"
reopen.BackgroundTransparency = 1
reopen.Visible = false
reopen.Active = true
reopen.Draggable = true

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    reopen.Visible = true
end)
reopen.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    reopen.Visible = false
end)