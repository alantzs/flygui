-- LH RECORDS & AZER PRIVATE FLY SCRIPT
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyButton = Instance.new("TextButton")

-- Настройка GUI в стиле (темный минимализм)
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "FlyGUI"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 150, 0, 80)
MainFrame.Active = true
MainFrame.Draggable = true -- Можно двигать по экрану

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0.4, 0)
Title.Text = "LH FLY"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

FlyButton.Name = "FlyButton"
FlyButton.Parent = MainFrame
FlyButton.Size = UDim2.new(0.8, 0, 0.4, 0)
FlyButton.Position = UDim2.new(0.1, 0, 0.5, 0)
FlyButton.Text = "FLY: OFF"
FlyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Логика полета
local flying = false
local speed = 50

FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyButton.Text = "FLY: ON"
        FlyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        
        local T = Player.Character.HumanoidRootPart
        local BG = Instance.new("BodyGyro", T)
        local BV = Instance.new("BodyVelocity", T)
        BG.P = 9e4
        BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.cframe = T.CFrame
        BV.velocity = Vector3.new(0, 0.1, 0)
        BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

        spawn(function()
            while flying do
                wait()
                Player.Character.Humanoid.PlatformStand = true
                BV.velocity = Mouse.Hit.lookVector * speed
                BG.cframe = CFrame.new(T.Position, Mouse.Hit.p)
            end
            BG:Destroy()
            BV:Destroy()
            Player.Character.Humanoid.PlatformStand = false
            FlyButton.Text = "FLY: OFF"
            FlyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end)
    else
        flying = false
    end
end)
