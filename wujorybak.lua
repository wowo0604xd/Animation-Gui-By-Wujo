-- Wujorybak GUI (naprawiony + przesuwalny)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local playerGui = player:WaitForChild("PlayerGui")

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

-- GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "WujorybakGUI"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 240, 0, 500)
mainFrame.Position = UDim2.new(0, 40, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🎣 Wujorybak GUI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextStrokeTransparency = 0.8
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Scrolling container
local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local listLayout = Instance.new("UIListLayout", scroll)
listLayout.Padding = UDim.new(0, 6)

-- Buttons
for name, id in pairs(animations) do
	local btn = Instance.new("TextButton", scroll)
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.AutoButtonColor = true

	local btnCorner = Instance.new("UICorner", btn)
	btnCorner.CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		if activeTrack then
			activeTrack:Stop()
		end
		local anim = Instance.new("Animation")
		anim.AnimationId = id
		pcall(function()
			activeTrack = humanoid:LoadAnimation(anim)
			activeTrack:Play()
		end)
	end)
end

-- Stop button
local stopBtn = Instance.new("TextButton", mainFrame)
stopBtn.Size = UDim2.new(1, -20, 0, 36)
stopBtn.Position = UDim2.new(0, 10, 1, -46)
stopBtn.Text = "🛑 Stop Animation"
stopBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
stopBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 16

local stopCorner = Instance.new("UICorner", stopBtn)
stopCorner.CornerRadius = UDim.new(0, 8)

stopBtn.MouseButton1Click:Connect(function()
	if activeTrack then
		activeTrack:Stop()
		activeTrack = nil
	end
end)

-- Automatyczna wysokość scrolla
scroll.CanvasSize = UDim2.new(0, 0, 0, #animations * 42)
