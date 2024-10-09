local espEnabled = false

local function createESP(player)
    local character = player.Character
    if character and character:FindFirstChild("Head") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "PlayerESP"
        billboard.Adornee = character.Head
        billboard.Size = UDim2.new(0, 100, 0, 100)
        billboard.AlwaysOnTop = true

        local frame = Instance.new("Frame", billboard)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 0.5
        frame.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))

        local textLabel = Instance.new("TextLabel", billboard)
        textLabel.Size = UDim2.new(1, 0, 0.2, 0)
        textLabel.Position = UDim2.new(0, 0, -0.2, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = player.Name
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeTransparency = 0.5
        textLabel.TextScaled = true

        billboard.Parent = character.Head
    end
end

local function removeESP(player)
    local character = player.Character
    if character and character:FindFirstChild("Head") then
        local esp = character.Head:FindFirstChild("PlayerESP")
        if esp then
            esp:Destroy()
        end
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                createESP(player)
            end
        end
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                removeESP(player)
            end
        end
    end
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if espEnabled then
            createESP(player)
        end
    end)
end)

game.Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    toggleESP()
end)
