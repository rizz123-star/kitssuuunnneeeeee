-- 🍎 RIZZ TOOLS HUB FINAL
local uis = game:GetService("UserInputService")
local players = game:GetService("Players")
local plr = players.LocalPlayer

-- GUI HOLDER
local gui = Instance.new("ScreenGui")
gui.Name = "RizzToolsHub"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- 🖼 FRAME UTAMA
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 500, 0, 320)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- 🏷️ TITLE BAR
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 6)
titleBar.Active = true

local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.Text = "🍎 Rizz Tools Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.BackgroundTransparency = 1
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ❌ CLOSE BUTTON
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -35, 0.5, -12)
closeBtn.Text = "✖"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
end)
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- 🔄 REOPEN KEY (RightShift)
uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- 🖱️ DRAG SYSTEM
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
uis.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- 📑 SIDEBAR
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 130, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 6)

-- 📦 CONTENT AREA
local content = Instance.new("Frame", mainFrame)
content.Size = UDim2.new(1, -130, 1, -35)
content.Position = UDim2.new(0, 130, 0, 35)
content.BackgroundTransparency = 1

-- 📌 SISTEM TAB
local tabs = {}
local function createTab(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -14, 0, 40)
    btn.Position = UDim2.new(0, 7, 0, #tabs * 45 + 10)
    btn.Text = "🍎 " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(65, 65, 65) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end)

    local frame = Instance.new("ScrollingFrame", content)
    frame.Size = UDim2.new(1, -10, 1, -10)
    frame.Position = UDim2.new(0, 5, 0, 5)
    frame.Visible = false
    frame.BackgroundTransparency = 1
    frame.ScrollBarThickness = 6
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    frame.ScrollBarImageTransparency = 0.3

    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.frame.Visible = false end
        frame.Visible = true
    end)

    table.insert(tabs, {btn = btn, frame = frame})
    return frame
end

-- ✅ UTIL: BIKIN BUTTON
local function makeButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Text = "🍎 " .. text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ✅ UTIL: BIKIN TOGGLE
local function makeToggle(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local state = false
    local function updateVisual()
        btn.Text = "🍎 " .. text .. (state and " [ON]" or " [OFF]")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    end

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
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

-- // FLY MODE
local flying = false
local flySpeed = 80
local bodyVel, bodyGyro

makeToggle(mainTab,120,"Fly",function(on)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")

    flying = on
    if on then
        -- Jangan pakai PlatformStand biar gak kaku
        hum:ChangeState(Enum.HumanoidStateType.Physics)

        -- BodyVelocity untuk gerakan terbang
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(1e5,1e5,1e5)
        bodyVel.Velocity = Vector3.new()
        bodyVel.Parent = root

        -- BodyGyro biar player selalu hadap sesuai kamera
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e5,1e5,1e5)
        bodyGyro.P = 1e4
        bodyGyro.CFrame = root.CFrame
        bodyGyro.Parent = root

    else
        -- Matikan semua saat off
        if bodyVel then bodyVel:Destroy() bodyVel=nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro=nil end
        if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end
end)

-- // Update posisi fly setiap frame
game:GetService("RunService").RenderStepped:Connect(function()
    if flying and player.Character and bodyVel and bodyGyro then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local camCF = workspace.CurrentCamera.CFrame
        bodyGyro.CFrame = camCF

        -- Gerakan sesuai input WASD
        local moveDir = Vector3.zero
        local uis = game:GetService("UserInputService")
        if uis:IsKeyDown(Enum.KeyCode.W) then moveDir += camCF.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then moveDir -= camCF.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then moveDir -= camCF.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then moveDir += camCF.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
        if uis:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0,1,0) end

        if moveDir.Magnitude > 0 then
            bodyVel.Velocity = moveDir.Unit * flySpeed
        else
            bodyVel.Velocity = Vector3.zero
        end
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
scroll.ScrollBarImageColor3 = Color3.fromRGB(255,255,255) -- scrollbar putih
scroll.ScrollBarImageTransparency = 0.3 -- transparan dikit biar elegan
scroll.BackgroundColor3 = Color3.fromRGB(30,30,30)
scroll.BorderSizePixel = 0
scroll.ClipsDescendants = true

-- Efek gradient di kanan biar kelihatan modern
local gradient = Instance.new("UIGradient", scroll)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200,200,200))
}
gradient.Rotation = 90
gradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.2, 0.5),
    NumberSequenceKeypoint.new(1, 1)
}

-- Layout otomatis biar tombol rapi
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,5)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local function teleportToPlayer(plr)
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = player.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(2,1,2)
        end
    end
end

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
    btn.AutoButtonColor = true

    -- Auto teleport pas klik
    btn.MouseButton1Click:Connect(function()
        teleportToPlayer(plr)
    end)

    return btn
end

local function refreshPlayers()
    scroll:ClearAllChildren()
    for _,plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player then
            createPlayerBtn(plr)
        end
    end
end

refreshPlayers()
game.Players.PlayerAdded:Connect(refreshPlayers)
game.Players.PlayerRemoving:Connect(refreshPlayers)

---------------------------------------------------
-- MOVEMENT TAB
local moveTab = createTab("Movement")

-- VARIABEL AWAL
local speed = 16
local jump = 50

-- UPDATE SPEED KE PLAYER
local function setSpeed()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = speed end
end

-- UPDATE JUMP KE PLAYER
local function setJump()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then 
        hum.UseJumpPower = true
        hum.JumpPower = jump
    end
end

-- LABEL SPEED
local speedLabel = Instance.new("TextLabel", moveTab)
speedLabel.Size = UDim2.new(0,200,0,30)
speedLabel.Position = UDim2.new(0,20,0,20)
speedLabel.Text = "🍎 Speed: "..speed
speedLabel.TextColor3 = Color3.fromRGB(255,255,255)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 14
speedLabel.BackgroundTransparency = 1

-- BUTTON SPEED +
local speedPlus = Instance.new("TextButton", moveTab)
speedPlus.Size = UDim2.new(0,90,0,30)
speedPlus.Position = UDim2.new(0,20,0,55)
speedPlus.Text = "+ Speed"
speedPlus.TextColor3 = Color3.fromRGB(255,255,255)
speedPlus.Font = Enum.Font.GothamBold
speedPlus.TextSize = 14
speedPlus.BackgroundColor3 = Color3.fromRGB(50,50,50)
speedPlus.MouseButton1Click:Connect(function()
    speed = speed + 5
    speedLabel.Text = "🍎 Speed: "..speed
    setSpeed()
end)

-- BUTTON SPEED -
local speedMinus = Instance.new("TextButton", moveTab)
speedMinus.Size = UDim2.new(0,90,0,30)
speedMinus.Position = UDim2.new(0,130,0,55)
speedMinus.Text = "- Speed"
speedMinus.TextColor3 = Color3.fromRGB(255,255,255)
speedMinus.Font = Enum.Font.GothamBold
speedMinus.TextSize = 14
speedMinus.BackgroundColor3 = Color3.fromRGB(50,50,50)
speedMinus.MouseButton1Click:Connect(function()
    speed = speed - 5
    if speed < 0 then speed = 0 end
    speedLabel.Text = "🍎 Speed: "..speed
    setSpeed()
end)

-- LABEL JUMP
local jumpLabel = Instance.new("TextLabel", moveTab)
jumpLabel.Size = UDim2.new(0,200,0,30)
jumpLabel.Position = UDim2.new(0,20,0,100)
jumpLabel.Text = "🍎 Jump Power: "..jump
jumpLabel.TextColor3 = Color3.fromRGB(255,255,255)
jumpLabel.Font = Enum.Font.GothamBold
jumpLabel.TextSize = 14
jumpLabel.BackgroundTransparency = 1

-- BUTTON JUMP +
local jumpPlus = Instance.new("TextButton", moveTab)
jumpPlus.Size = UDim2.new(0,90,0,30)
jumpPlus.Position = UDim2.new(0,20,0,135)
jumpPlus.Text = "+ Jump"
jumpPlus.TextColor3 = Color3.fromRGB(255,255,255)
jumpPlus.Font = Enum.Font.GothamBold
jumpPlus.TextSize = 14
jumpPlus.BackgroundColor3 = Color3.fromRGB(50,50,50)
jumpPlus.MouseButton1Click:Connect(function()
    jump = jump + 5
    jumpLabel.Text = "🍎 Jump Power: "..jump
    setJump()
end)

-- BUTTON JUMP -
local jumpMinus = Instance.new("TextButton", moveTab)
jumpMinus.Size = UDim2.new(0,90,0,30)
jumpMinus.Position = UDim2.new(0,130,0,135)
jumpMinus.Text = "- Jump"
jumpMinus.TextColor3 = Color3.fromRGB(255,255,255)
jumpMinus.Font = Enum.Font.GothamBold
jumpMinus.TextSize = 14
jumpMinus.BackgroundColor3 = Color3.fromRGB(50,50,50)
jumpMinus.MouseButton1Click:Connect(function()
    jump = jump - 5
    if jump < 0 then jump = 0 end
    jumpLabel.Text = "🍎 Jump Power: "..jump
    setJump()
end)

-- INFINITE JUMP TOGGLE
local infjump = false
local infBtn = Instance.new("TextButton", moveTab)
infBtn.Size = UDim2.new(0,200,0,40)
infBtn.Position = UDim2.new(0,20,0,180)
infBtn.Text = "❌ Infinite Jump"
infBtn.TextColor3 = Color3.fromRGB(255,255,255)
infBtn.Font = Enum.Font.GothamBold
infBtn.TextSize = 14
infBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
infBtn.BorderSizePixel = 0

infBtn.MouseButton1Click:Connect(function()
    infjump = not infjump
    infBtn.Text = (infjump and "✅ Infinite Jump" or "❌ Infinite Jump")
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infjump and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
---------------------------------------------------
-- 🛠️ MISC TAB
local miscTab = createTab("Misc")

-- Scrolling Frame Container
local miscFrame = Instance.new("ScrollingFrame", miscTab)
miscFrame.Size = UDim2.new(1, -20, 1, -20)
miscFrame.Position = UDim2.new(0,10,0,10)
miscFrame.BackgroundTransparency = 1
miscFrame.ScrollBarThickness = 6
miscFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local layout = Instance.new("UIListLayout", miscFrame)
layout.Padding = UDim.new(0,8)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Contoh Tombol Respawn
local respawnBtn = Instance.new("TextButton", miscFrame)
respawnBtn.Size = UDim2.new(0,200,0,40)
respawnBtn.Text = "🔄 Respawn"
respawnBtn.TextColor3 = Color3.fromRGB(255,255,255)
respawnBtn.Font = Enum.Font.GothamBold
respawnBtn.TextSize = 14
respawnBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
respawnBtn.BorderSizePixel = 0
respawnBtn.MouseButton1Click:Connect(function()
    if player.Character then
        player.Character:BreakJoints() -- cara cepat respawn
    end
end)

-- Contoh Tombol Rejoin
local rejoinBtn = Instance.new("TextButton", miscFrame)
rejoinBtn.Size = UDim2.new(0,200,0,40)
rejoinBtn.Text = "♻️ Rejoin Game"
rejoinBtn.TextColor3 = Color3.fromRGB(255,255,255)
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.TextSize = 14
rejoinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
rejoinBtn.BorderSizePixel = 0
rejoinBtn.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)

-- Contoh Tombol Copy Discord
local copyBtn = Instance.new("TextButton", miscFrame)
copyBtn.Size = UDim2.new(0,200,0,40)
copyBtn.Text = "📋 Copy Telegram Link"
copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 14
copyBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
copyBtn.BorderSizePixel = 0
copyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://t.me/welahdalhh") -- ganti sesuai link
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