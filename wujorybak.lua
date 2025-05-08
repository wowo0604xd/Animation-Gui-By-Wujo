-- Wujorybak GUI - LocalScript (R15)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local playerGui = player:WaitForChild("PlayerGui")

-- Animacje (nazwy + ID)
local animations = {
    ["Sit"] = "rbxassetid://2506281703",
    ["Salute"] = "rbxassetid://421441683",
    ["Dance 1"] = "rbxassetid://507771019",
    ["Dance 2"] = "rbxassetid://507776043",
    ["Push Up"] = "rbxassetid://128777973",
    ["Jumping Jacks"] = "rbxassetid://128777973",
    ["Lay Down"] = "rbxassetid://282574440",
    ["Laugh"] = "rbxassetid://507770818",
    ["Wave"] = "rbxassetid://507770239",
    ["Point"] = "rbxassetid://507770453"
}

local activeTrack = nil

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WujorybakGUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 460)
mainFrame.Position = UDim2.new(0, 20, 0.5, -230)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.AnchorPoint = Vector2.new(0, 0)
mainFrame.BackgroundTransparency = 0.1
mainFrame.ClipsDescendants = true

-- Styl
mainFrame.UICorner = Instance.new("UICorner", mainFrame)
mainFrame.UICorner.CornerRadius = UDim.new(0, 12)

-- Tytuł
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🎣 Wujorybak GUI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = mainFrame

-- Layout
local layout = Instance.new("UIListLayout")
layout.Parent = mainFrame
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)

-- Dodajemy przycisk tytułu na górze layoutu
title.LayoutOrder = 0

-- Tworzenie przycisków
for name, id in pairs(animations) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 36)
	btn.Position = UDim2.new(0, 10, 0, 0)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.AutoButtonColor = true
	btn.Parent = mainFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		if activeTrack then
			activeTrack:Stop()
		end
		local anim = Instance.new("Animation")
		anim.AnimationId = id
		activeTrack = humanoid:LoadAnimation(anim)
		activeTrack:Play()
	end)
end

-- Stop Animation button
local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(1, -20, 0, 36)
stopBtn.Position = UDim2.new(0, 10, 0, 0)
stopBtn.Text = "🛑 Stop Animation"
stopBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 16
stopBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
stopBtn.Parent = mainFrame

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 8)
stopCorner.Parent = stopBtn

stopBtn.MouseButton1Click:Connect(function()
	if activeTrack then
		activeTrack:Stop()
		activeTrack = nil
	end
end)

-- Fajny cień (opcjonalnie)
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 60, 1, 60)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.BackgroundTransparency = 1
shadow.ZIndex = 0
shadow.Parent = mainFrame
