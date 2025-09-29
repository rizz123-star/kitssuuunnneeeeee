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
-- 🏃 MOVEMENT TAB
local moveTab = createTab("Movement")

-- Player
local player = game.Players.LocalPlayer

-- ScrollingFrame biar rapi
local moveFrame = Instance.new("ScrollingFrame", moveTab)
moveFrame.Size = UDim2.new(1, -20, 1, -20)
moveFrame.Position = UDim2.new(0,10,0,10)
moveFrame.BackgroundTransparency = 1
moveFrame.ScrollBarThickness = 6
moveFrame.CanvasSize = UDim2.new(0,0,0,0)
moveFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local layout = Instance.new("UIListLayout", moveFrame)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0,8)

-- Fungsi bikin TextBox
local function makeBox(placeholder, default, callback)
    local box = Instance.new("TextBox", moveFrame)
    box.Size = UDim2.new(0,250,0,40)
    box.PlaceholderText = placeholder
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.BackgroundColor3 = Color3.fromRGB(40,40,40)
    box.ClearTextOnFocus = false
    box.BorderSizePixel = 0
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        callback(val or default)
    end)
    return box
end

-- Fungsi bikin Toggle
local function makeToggle(text, callback)
    local btn = Instance.new("TextButton", moveFrame)
    btn.Size = UDim2.new(0,250,0,40)
    btn.Text = "❌ "..text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = (state and "✅ " or "❌ ")..text
        callback(state)
    end)
    return btn
end

-- Ambil Humanoid
local function getHumanoid()
    return player.Character and player.Character:FindFirstChildOfClass("Humanoid")
end

---------------------------------------------------
-- ✨ FITUR FITUR
---------------------------------------------------

-- SPEED
makeBox("🍎 Speed (default 16)", 16, function(val)
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = val end
end)

-- JUMP POWER
makeBox("🍎 Jump Power (default 50)", 50, function(val)
    local hum = getHumanoid()
    if hum then 
        hum.UseJumpPower = true
        hum.JumpPower = val
    end
end)

-- HIP HEIGHT
makeBox("🍎 HipHeight (default 2)", 2, function(val)
    local hum = getHumanoid()
    if hum then hum.HipHeight = val end
end)

-- GRAVITY
makeBox("🌍 Gravity (default 196.2)", 196.2, function(val)
    workspace.Gravity = val
end)

-- INFINITE JUMP
local infjump = false
makeToggle("Infinite Jump", function(on)
    infjump = on
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infjump then
        local hum = getHumanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- FLY
local flying = false
local flySpeed = 50
local bodyVel, bodyGyro
makeBox("🍎 Fly Speed (default 50)", 50, function(val)
    flySpeed = val or 50
end)

makeToggle("Fly", function(on)
    flying = on
    local char = player.Character
    if not char then return end
    if on then
        local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
        if not hrp then return end
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(1e5,1e5,1e5)
        bodyVel.Velocity = Vector3.zero
        bodyVel.Parent = hrp

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e5,1e5,1e5)
        bodyGyro.CFrame = hrp.CFrame
        bodyGyro.Parent = hrp
    else
        if bodyVel then bodyVel:Destroy(); bodyVel = nil end
        if bodyGyro then bodyGyro:Destroy(); bodyGyro = nil end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        local cam = workspace.CurrentCamera
        local dir = Vector3.new(0,0,0)
        local uis = game:GetService("UserInputService")
        if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
        if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end

        if dir.Magnitude > 0 then
            if bodyVel then bodyVel.Velocity = dir.Unit * flySpeed end
        else
            if bodyVel then bodyVel.Velocity = Vector3.new(0,0,0) end
        end
        if bodyGyro then bodyGyro.CFrame = cam.CFrame end
    end
end)

-- NOCLIP
local noclip = false
makeToggle("Noclip", function(on)
    noclip = on
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

---------------------------------------------------
-- 🟢 AIMBOT (ditambahkan ke dalam moveFrame)
---------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local camera = workspace.CurrentCamera
local localPlayer = Players.LocalPlayer

local aimbotEnabled = false
local aimbotMode = "nearest" -- "nearest" or "manual"
local selectedTarget = nil
local aimSmoothing = 0.25
local aiming = false

-- Aimbot header
local aTitle = Instance.new("TextLabel", moveFrame)
aTitle.Size = UDim2.new(0,250,0,20)
aTitle.BackgroundTransparency = 1
aTitle.Text = "— Aimbot —"
aTitle.Font = Enum.Font.GothamBold
aTitle.TextSize = 13
aTitle.TextColor3 = Color3.fromRGB(220,220,220)

-- Enable toggle (uses existing style)
makeToggle("Aimbot", function(on)
    aimbotEnabled = on
    if not on then
        aiming = false
        if camera and camera.CameraType == Enum.CameraType.Scriptable then
            camera.CameraType = Enum.CameraType.Custom
        end
    end
end)

-- Aim smoothing box (re-uses makeBox)
makeBox("🎯 Aim Smoothing (0-1)", aimSmoothing, function(val)
    aimSmoothing = math.clamp(tonumber(val) or 0.25, 0, 1)
end)

-- Mode buttons (Nearest / Select)
local modeHolder = Instance.new("Frame", moveFrame)
modeHolder.Size = UDim2.new(0,250,0,36)
modeHolder.BackgroundTransparency = 1

local modeNearest = Instance.new("TextButton", modeHolder)
modeNearest.Size = UDim2.new(0.48, -4, 1, 0)
modeNearest.Position = UDim2.new(0,0,0,0)
modeNearest.Text = "Nearest"
modeNearest.Font = Enum.Font.Gotham
modeNearest.TextSize = 13
modeNearest.BackgroundColor3 = Color3.fromRGB(65,65,65)
modeNearest.BorderSizePixel = 0
Instance.new("UICorner", modeNearest).CornerRadius = UDim.new(0,6)

local modeSelect = Instance.new("TextButton", modeHolder)
modeSelect.Size = UDim2.new(0.48, -4, 1, 0)
modeSelect.Position = UDim2.new(0.52, 0, 0, 0)
modeSelect.Text = "Select"
modeSelect.Font = Enum.Font.Gotham
modeSelect.TextSize = 13
modeSelect.BackgroundColor3 = Color3.fromRGB(65,65,65)
modeSelect.BorderSizePixel = 0
Instance.new("UICorner", modeSelect).CornerRadius = UDim.new(0,6)

modeNearest.MouseButton1Click:Connect(function()
    aimbotMode = "nearest"
    selectedTarget = nil
end)

-- Select list placed inside moveFrame (tidak buat ScreenGui baru)
local selectFrame = Instance.new("Frame", moveFrame)
selectFrame.Size = UDim2.new(0,250,0,200)
selectFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
selectFrame.Visible = false
selectFrame.BorderSizePixel = 0
Instance.new("UICorner", selectFrame).CornerRadius = UDim.new(0,6)

local sfTitle = Instance.new("TextLabel", selectFrame)
sfTitle.Size = UDim2.new(1,0,0,24)
sfTitle.BackgroundTransparency = 1
sfTitle.Text = "Select Target"
sfTitle.Font = Enum.Font.GothamBold
sfTitle.TextSize = 13
sfTitle.TextColor3 = Color3.fromRGB(220,220,220)

local playerList = Instance.new("ScrollingFrame", selectFrame)
playerList.Size = UDim2.new(1, -10, 1, -34)
playerList.Position = UDim2.new(0,5,0,30)
playerList.BackgroundTransparency = 1
playerList.ScrollBarThickness = 6
playerList.CanvasSize = UDim2.new(0,0,0,0)
playerList.AutomaticCanvasSize = Enum.AutomaticSize.Y
local plLayout = Instance.new("UIListLayout", playerList)
plLayout.Padding = UDim.new(0,6)

local closeSelect = Instance.new("TextButton", selectFrame)
closeSelect.Size = UDim2.new(0.6,0,0,28)
closeSelect.Position = UDim2.new(0.2,0,1,-32)
closeSelect.Text = "Cancel"
closeSelect.Font = Enum.Font.GothamBold
closeSelect.TextSize = 13
Instance.new("UICorner", closeSelect).CornerRadius = UDim.new(0,6)
closeSelect.MouseButton1Click:Connect(function()
    selectFrame.Visible = false
end)

-- Cancel target button
makeToggle("Cancel Target", function(on)
    if on then
        selectedTarget = nil
        aimbotMode = "nearest"
        selectFrame.Visible = false
        -- turn toggle back off immediately (so button behaves like a press)
        -- find the last Toggle button and reset its text (cheap hack)
        -- better: could return the toggle object from makeToggle, but keeping simple
        -- We will just wait a frame and reset toggles' visuals:
        task.defer(function()
            for _,v in pairs(moveFrame:GetChildren()) do
                if v:IsA("TextButton") and v.Text:match("Cancel Target") then
                    v.Text = "❌ Cancel Target"
                end
            end
        end)
    end
end)

-- Populate player list
local function refreshPlayerList()
    for _,c in pairs(playerList:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _,pl in ipairs(Players:GetPlayers()) do
        if pl ~= localPlayer then
            local ok = Instance.new("TextButton", playerList)
            ok.Size = UDim2.new(1, -10, 0, 30)
            ok.Position = UDim2.new(0,5,0,0)
            ok.Text = pl.Name
            ok.Font = Enum.Font.Gotham
            ok.TextSize = 13
            ok.BackgroundColor3 = Color3.fromRGB(45,45,45)
            ok.BorderSizePixel = 0
            Instance.new("UICorner", ok).CornerRadius = UDim.new(0,6)
            ok.MouseButton1Click:Connect(function()
                selectedTarget = pl
                aimbotMode = "manual"
                selectFrame.Visible = false
            end)
        end
    end
end

modeSelect.MouseButton1Click:Connect(function()
    refreshPlayerList()
    selectFrame.Visible = true
end)

-- helper: find closest player
local function getClosestPlayer()
    local closest = nil
    local closestDist = math.huge
    local myChar = localPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, pl in pairs(Players:GetPlayers()) do
        if pl ~= localPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
            local hum = pl.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local targetRoot = pl.Character:FindFirstChild("HumanoidRootPart")
                local dist = (targetRoot.Position - myRoot.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = pl
                end
            end
        end
    end
    return closest
end

-- Main aim loop (uses BindToRenderStep for smoothness)
RunService:BindToRenderStep("AimbotRender", Enum.RenderPriority.Camera.Value + 1, function(dt)
    if not aimbotEnabled then
        if aiming then
            aiming = false
            if camera and camera.CameraType == Enum.CameraType.Scriptable then
                camera.CameraType = Enum.CameraType.Custom
            end
        end
        return
    end

    local target = nil
    if aimbotMode == "nearest" then
        target = getClosestPlayer()
    else
        target = selectedTarget
        if target and (not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") or (target.Character:FindFirstChildOfClass("Humanoid") and target.Character:FindFirstChildOfClass("Humanoid").Health <= 0)) then
            target = nil
            selectedTarget = nil
            aimbotMode = "nearest"
        end
    end

    if target and target.Character then
        local targetPart = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
        if targetPart then
            if camera.CameraType ~= Enum.CameraType.Scriptable then
                camera.CameraType = Enum.CameraType.Scriptable
            end
            aiming = true
            local myPos = camera.CFrame.Position
            local desired = CFrame.new(myPos, targetPart.Position)
            local lerpAlpha = math.clamp(1 - aimSmoothing, 0.01, 1)
            camera.CFrame = camera.CFrame:Lerp(desired, lerpAlpha)
        end
    else
        if aiming then
            aiming = false
            if camera and camera.CameraType == Enum.CameraType.Scriptable then
                camera.CameraType = Enum.CameraType.Custom
            end
        end
    end
end)

-- Hotkeys: B toggle aimbot, N cancel target
UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.B then
            aimbotEnabled = not aimbotEnabled
            -- update visual text of Aimbot toggle (best-effort)
            for _,v in pairs(moveFrame:GetChildren()) do
                if v:IsA("TextButton") and v.Text:match("Aimbot") then
                    v.Text = (aimbotEnabled and "✅ " or "❌ ").."Aimbot"
                end
            end
        elseif input.KeyCode == Enum.KeyCode.N then
            selectedTarget = nil
            aimbotMode = "nearest"
            selectFrame.Visible = false
        end
    end
end)

-- Refresh player list when players join/leave
Players.PlayerAdded:Connect(function() refreshPlayerList() end)
Players.PlayerRemoving:Connect(function() refreshPlayerList() end)

-- Initial refresh
refreshPlayerList()
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