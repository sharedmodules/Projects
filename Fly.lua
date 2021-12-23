--[[
if you use this here is some reminders
Q makes you go down
E makes you go up
- makes you go slower
+ makes you go faster
]]

local LocalPlayer = game.Players.LocalPlayer

local newInstance = Instance.new
local newVector3, newCFrame, CFrameAngles = Vector3.new, CFrame.new, CFrame.Angles

local UserInputService = game:GetService('UserInputService')
local GetFocusedTextBox = UserInputService.GetFocusedTextBox

local Torso = LocalPlayer.Character.Torso
local Flying, FlySpeed = false, 1

local RunService = game:GetService('RunService')
local Stepped = RunService.Stepped

local FlyConnection

local Keys = {
	['W'] = false;
	['S'] = false;
	['D'] = false;
	['A'] = false;
	['E'] = false;
	['Q'] = false;
}

local Fly = function()
	Flying = not Flying
	if Flying then
		LocalPlayer.Character.Humanoid.PlatformStand = true

		local BodyPosition = newInstance('BodyPosition', Torso)
		local BodyGyro = newInstance('BodyGyro', Torso )

		local Idle = true
		local Camera = workspace.CurrentCamera
	
		BodyPosition.MaxForce = newVector3(math.huge, math.huge, math.huge)
		BodyPosition.Position = Torso.Position
		BodyGyro.MaxTorque = newVector3(9e9, 9e9, 9e9)
		BodyGyro.CFrame = Torso.CFrame
	
		coroutine.resume(coroutine.create(function()
			FlyConnection = Stepped:Connect(function()
				local Gyro = BodyGyro.CFrame - BodyGyro.CFrame.Position + BodyPosition.Position

				if Keys.W then
					Gyro = Gyro + Camera.CFrame.LookVector * FlySpeed
					BodyGyro.CFrame = Camera.CFrame * CFrameAngles(-math.rad(20), math.rad(0), math.rad(0))
				end
				if Keys.S then
					Gyro = Gyro - Camera.CFrame.LookVector * FlySpeed
					BodyGyro.CFrame = Camera.CFrame * CFrameAngles(math.rad(70), math.rad(0), math.rad(0))
				end
				if Keys.D then
					Gyro = Gyro * newCFrame(FlySpeed, 0, 0)
				end
				if Keys.A then
					Gyro = Gyro * newCFrame(-FlySpeed, 0, 0)
				end
				if Keys.E then
					Gyro = Gyro * newCFrame(0,FlySpeed,0)
				end
				if Keys.Q then
					Gyro = Gyro * newCFrame(0,-FlySpeed,0)
				end
				BodyPosition.Position = Gyro.Position

				if Idle and not Keys.S and not Keys.W  then
					BodyGyro.CFrame = Camera.CFrame
				end
			end)
		end))
	else
		LocalPlayer.Character.Humanoid.PlatformStand = false
		Torso.BodyPosition:Destroy()
		Torso.BodyGyro:Destroy()
		FlyConnection:Disconnect()
		FlyConnection = nil
	end
end

UserInputService.InputBegan:Connect(function(Key)
	if not GetFocusedTextBox(UserInputService) then
		if Key.KeyCode == Enum.KeyCode.W then
			Keys.W = true
		end
		if Key.KeyCode == Enum.KeyCode.S then
			Keys.S = true
		end
		if Key.KeyCode == Enum.KeyCode.D then
			Keys.D = true
		end
		if Key.KeyCode == Enum.KeyCode.A then
			Keys.A = true
		end
		if Key.KeyCode == Enum.KeyCode.E then
			Keys.E = true
		end
		if Key.KeyCode == Enum.KeyCode.Q then
			Keys.Q = true
		end
		if Key.KeyCode == Enum.KeyCode.F then
			Fly()
		end
		if Key.KeyCode == Enum.KeyCode.Equals then
			FlySpeed = FlySpeed + 0.1
		end
		if Key.KeyCode == Enum.KeyCode.Minus then
			FlySpeed = FlySpeed - 0.1
		end
	end
end)

UserInputService.InputEnded:Connect(function(Key)
	if not GetFocusedTextBox(UserInputService) then
		if Key.KeyCode == Enum.KeyCode.W then
			Keys.W = false
		end
		if Key.KeyCode == Enum.KeyCode.S then
			Keys.S = false
		end
		if Key.KeyCode == Enum.KeyCode.D then
			Keys.D = false
		end
		if Key.KeyCode == Enum.KeyCode.A then
			Keys.A = false
		end
		if Key.KeyCode == Enum.KeyCode.E then
			Keys.E = false
		end
		if Key.KeyCode == Enum.KeyCode.Q then
			Keys.Q = false
		end
	end
end)
