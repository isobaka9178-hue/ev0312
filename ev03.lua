--========================================================
-- EV03 CONTROL V3.8 - EXECUTOR STANDALONE EDITION
-- Creator: 阿叶ev03
-- Location: Client Executor (Standalone)
--========================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui", 10)
if not PG then return end

--========================================================
-- CLEAN OLD GUI
--========================================================

pcall(function()
	for _, name in ipairs({"EV03_CONTROL", "EV03_ESP"}) do
		local old = PG:FindFirstChild(name)
		if old then old:Destroy() end
	end
end)

--========================================================
-- COLORS
--========================================================

local C = {
	BG = Color3.fromRGB(13, 13, 17),
	SIDEBAR = Color3.fromRGB(19, 19, 24),
	PANEL = Color3.fromRGB(26, 26, 33),
	PANEL2 = Color3.fromRGB(36, 36, 44),
	RED = Color3.fromRGB(195, 31, 49),
	DARK_RED = Color3.fromRGB(105, 20, 30),
	GREEN = Color3.fromRGB(27, 155, 76),
	YELLOW = Color3.fromRGB(220, 175, 55),
	WHITE = Color3.fromRGB(245, 245, 245),
	GRAY = Color3.fromRGB(155, 155, 165),
}

local function validNumber(n)
	return typeof(n) == "number"
		and n == n
		and n ~= math.huge
		and n ~= -math.huge
end

local function create(className, props, parent)
	local success, obj = pcall(function()
		local inst = Instance.new(className)
		for key, value in pairs(props or {}) do
			pcall(function()
				inst[key] = value
			end)
		end
		inst.Parent = parent
		return inst
	end)
	return success and obj or nil
end

--========================================================
-- WINDOW SIZE
--========================================================

local camera = workspace.CurrentCamera
local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)

local windowWidth = math.floor(math.clamp(viewport.X - 30, 560, 900))
local windowHeight = math.floor(math.clamp(viewport.Y - 40, 440, 680))

--========================================================
-- GUI
--========================================================

local gui = create("ScreenGui", {
	Name = "EV03_CONTROL",
	ResetOnSpawn = false,
	IgnoreGuiInset = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, PG)

local espGui = create("ScreenGui", {
	Name = "EV03_ESP",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, PG)

local main = create("Frame", {
	Name = "Main",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(windowWidth, windowHeight),
	BackgroundColor3 = C.BG,
	BorderSizePixel = 0,
	Active = true,
	ClipsDescendants = true,
}, gui)

create("UICorner", {CornerRadius = UDim.new(0, 11)}, main)
create("UIStroke", {Color = C.RED, Thickness = 2}, main)

--========================================================
-- HEADER
--========================================================

local header = create("Frame", {
	Size = UDim2.new(1, 0, 0, 58),
	BackgroundColor3 = C.SIDEBAR,
	BorderSizePixel = 0,
}, main)

local dragArea = create("TextButton", {
	Size = UDim2.new(1, -110, 1, 0),
	BackgroundTransparency = 1,
	Text = "",
	AutoButtonColor = false,
	Active = true,
}, header)

create("TextLabel", {
	Size = UDim2.new(1, -20, 0, 29),
	Position = UDim2.fromOffset(15, 4),
	BackgroundTransparency = 1,
	Text = "EV03 CONTROL",
	TextColor3 = C.RED,
	TextSize = 23,
	Font = Enum.Font.GothamBlack,
	TextXAlignment = Enum.TextXAlignment.Left,
}, dragArea)

create("TextLabel", {
	Size = UDim2.new(1, -20, 0, 15),
	Position = UDim2.fromOffset(16, 34),
	BackgroundTransparency = 1,
	Text = "STANDALONE CLIENT EDITION // V3.8",
	TextColor3 = C.GRAY,
	TextSize = 9,
	Font = Enum.Font.Code,
	TextXAlignment = Enum.TextXAlignment.Left,
}, dragArea)

local function headerButton(text, offset)
	local button = create("TextButton", {
		Size = UDim2.fromOffset(36, 32),
		Position = UDim2.new(1, offset, 0, 13),
		BackgroundColor3 = C.DARK_RED,
		Text = text,
		TextColor3 = C.WHITE,
		TextSize = 18,
		Font = Enum.Font.GothamBold,
		BorderSizePixel = 0,
	}, header)

	create("UICorner", {CornerRadius = UDim.new(0, 6)}, button)
	return button
end

local minimizeButton = headerButton("—", -88)
local closeButton = headerButton("×", -45)

--========================================================
-- MAIN BODY
--========================================================

local body = create("Frame", {
	Position = UDim2.fromOffset(0, 58),
	Size = UDim2.new(1, 0, 1, -86),
	BackgroundTransparency = 1,
}, main)

local sidebar = create("Frame", {
	Size = UDim2.new(0, 158, 1, 0),
	BackgroundColor3 = C.SIDEBAR,
	BorderSizePixel = 0,
}, body)

create("TextLabel", {
	Size = UDim2.new(1, -20, 0, 23),
	Position = UDim2.fromOffset(12, 15),
	BackgroundTransparency = 1,
	Text = "NAVIGATION",
	TextColor3 = C.GRAY,
	TextSize = 10,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left,
}, sidebar)

local navContainer = create("Frame", {
	Position = UDim2.fromOffset(8, 48),
	Size = UDim2.new(1, -16, 0, 370),
	BackgroundTransparency = 1,
}, sidebar)

create("UIListLayout", {Padding = UDim.new(0, 7)}, navContainer)

local contentHost = create("Frame", {
	Position = UDim2.new(0, 158, 0, 0),
	Size = UDim2.new(1, -158, 1, 0),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
}, body)

local footer = create("Frame", {
	Position = UDim2.new(0, 0, 1, -28),
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundColor3 = C.SIDEBAR,
	BorderSizePixel = 0,
}, main)

local status = create("TextLabel", {
	Size = UDim2.new(1, -24, 1, 0),
	Position = UDim2.fromOffset(12, 0),
	BackgroundTransparency = 1,
	Text = "SYSTEM READY",
	TextColor3 = C.GREEN,
	TextSize = 10,
	Font = Enum.Font.Code,
	TextXAlignment = Enum.TextXAlignment.Left,
}, footer)

local function setStatus(message, color)
	pcall(function()
		status.Text = tostring(message)
		status.TextColor3 = color or C.GREEN
	end)
end

--========================================================
-- PAGE SYSTEM
--========================================================

local pages = {}
local navButtons = {}

local function createPage(name)
	local page = create("ScrollingFrame", {
		Name = name,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 5,
		ScrollBarImageColor3 = C.RED,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Visible = false,
	}, contentHost)

	create("UIPadding", {
		PaddingLeft = UDim.new(0, 13),
		PaddingRight = UDim.new(0, 13),
		PaddingTop = UDim.new(0, 13),
		PaddingBottom = UDim.new(0, 15),
	}, page)

	create("UIListLayout", {
		Padding = UDim.new(0, 12),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, page)

	pages[name] = page
	return page
end

local function createSection(parent, title, height)
	local card = create("Frame", {
		Name = title:gsub("%W", "") .. "Section",
		Size = UDim2.new(1, -5, 0, height),
		BackgroundColor3 = C.PANEL,
		BorderSizePixel = 0,
	}, parent)

	create("UICorner", {CornerRadius = UDim.new(0, 9)}, card)
	create("UIStroke", {Color = C.PANEL2, Thickness = 1}, card)

	create("TextLabel", {
		Size = UDim2.new(1, -24, 0, 26),
		Position = UDim2.fromOffset(12, 7),
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = C.RED,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, card)

	return card
end

--========================================================
-- BUTTON & INPUT HELPERS
--========================================================

local function makeButton(parent, text, x, y, width, height, callback)
	local button = create("TextButton", {
		Size = UDim2.new(width, 0, 0, height),
		Position = UDim2.new(x, 0, 0, y),
		BackgroundColor3 = C.DARK_RED,
		Text = text,
		TextColor3 = C.WHITE,
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		BorderSizePixel = 0,
		AutoButtonColor = true,
	}, parent)

	create("UICorner", {CornerRadius = UDim.new(0, 6)}, button)

	button.MouseButton1Click:Connect(function()
		local ok, err = pcall(callback)
		if not ok then
			warn("[EV03 UI ERROR]", err)
			setStatus("LOCAL ACTION ERROR", C.RED)
		end
	end)

	return button
end

local function makeInput(parent, placeholder, x, y, width, height, initial)
	local input = create("TextBox", {
		Size = UDim2.new(width, 0, 0, height),
		Position = UDim2.new(x, 0, 0, y),
		BackgroundColor3 = C.PANEL2,
		TextColor3 = C.WHITE,
		PlaceholderColor3 = C.GRAY,
		PlaceholderText = placeholder,
		Text = initial or "",
		TextSize = 13,
		Font = Enum.Font.Gotham,
		ClearTextOnFocus = false,
		BorderSizePixel = 0,
	}, parent)

	create("UICorner", {CornerRadius = UDim.new(0, 6)}, input)
	return input
end

local function makeToggle(parent, title, y, callback)
	local active = false
	local button

	local function setState(value, silent)
		local desired = value == true
		if not silent then
			local ok, result = pcall(callback, desired)
			if not ok then
				warn("[EV03 TOGGLE ERROR]", result)
				desired = false
			elseif result == false then
				desired = false
			end
		end
		active = desired
		button.Text = title .. (active and "  //  ON" or "  //  OFF")
		button.BackgroundColor3 = active and C.GREEN or C.DARK_RED
		return active
	end

	button = makeButton(parent, title .. "  //  OFF", 0, y, 1, 38, function()
		setState(not active)
	end)

	return button, setState
end

--========================================================
-- NAVIGATION
--========================================================

local function addNavigation(name, label, symbol)
	local button = create("TextButton", {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = C.SIDEBAR,
		Text = symbol .. "   " .. label,
		TextColor3 = C.GRAY,
		TextSize = 11,
		Font = Enum.Font.GothamBold,
		BorderSizePixel = 0,
	}, navContainer)

	create("UICorner", {CornerRadius = UDim.new(0, 6)}, button)
	navButtons[name] = button

	button.MouseButton1Click:Connect(function()
		for pageName, page in pairs(pages) do
			page.Visible = pageName == name
		end
		for pageName, nav in pairs(navButtons) do
			local selected = pageName == name
			nav.BackgroundColor3 = selected and C.DARK_RED or C.SIDEBAR
			nav.TextColor3 = selected and C.WHITE or C.GRAY
		end
		setStatus("PAGE: " .. name)
	end)

	return button
end

--========================================================
-- PAGES
--========================================================

local dashboardPage = createPage("DASHBOARD")
local playerPage = createPage("PLAYER")
local movementPage = createPage("MOVEMENT")
local espPage = createPage("ESP")
local hotkeyPage = createPage("HOTKEYS")
local aboutPage = createPage("ABOUT")

addNavigation("DASHBOARD", "Dashboard", "◆")
addNavigation("PLAYER", "Player", "◈")
addNavigation("MOVEMENT", "Movement", "↗")
addNavigation("ESP", "ESP System", "◎")
addNavigation("HOTKEYS", "Hotkeys", "⌨")
addNavigation("ABOUT", "About", "ⓘ")

--========================================================
-- CORE HELPER FUNCTIONS (CLIENT REFACTORED)
--========================================================

local function getParts(player)
	if not player or not player.Character then
		return nil, nil, nil
	end
	local character = player.Character
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root or humanoid.Health <= 0 then
		return nil, nil, nil
	end
	return character, humanoid, root
end

local function findTarget(prefix)
	if typeof(prefix) ~= "string" then
		return nil, "INVALID USERNAME"
	end
	prefix = prefix:match("^%s*(.-)%s*$")
	if not prefix or prefix == "" or #prefix > 20 then
		return nil, "INVALID USERNAME"
	end

	local needle = prefix:lower()
	local exactMatch = nil
	local matches = {}

	for _, player in ipairs(Players:GetPlayers()) do
		local username = player.Name:lower()
		if username == needle then
			exactMatch = player
			break
		end
		if username:sub(1, #needle) == needle then
			table.insert(matches, player)
		end
	end

	if exactMatch then return exactMatch end
	if #matches == 1 then return matches[1] end
	if #matches == 0 then return nil, "PLAYER NOT FOUND" end

	local names = {}
	for index = 1, math.min(#matches, 5) do
		table.insert(names, matches[index].Name)
	end
	return nil, "MULTIPLE MATCHES: " .. table.concat(names, ", ")
end

--========================================================
-- LOCAL NOCLIP
--========================================================

local noclipEnabled = false
local noclipConnection = nil

local function setNoclipStateInternal(state)
	noclipEnabled = state
	if noclipConnection then
		pcall(function() noclipConnection:Disconnect() end)
		noclipConnection = nil
	end

	if state then
		noclipConnection = RunService.PreSimulation:Connect(function()
			pcall(function()
				local char = LP.Character
				if char then
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)
		end)
		return true, "NOCLIP ENABLED"
	else
		pcall(function()
			local char = LP.Character
			if char then
				for _, part in ipairs(char:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = true
					end
				end
			end
		end)
		return true, "NOCLIP DISABLED"
	end
end

--========================================================
-- LOCAL INVISIBILITY
--========================================================

local invisibleEnabled = false
local invisibleConnection = nil
local invisibleOriginals = {}

local function getHiddenProperty(object)
	if object:IsA("BasePart") or object:IsA("Decal") or object:IsA("Texture") then
		return "Transparency", object.Transparency
	end
	if object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Beam")
		or object:IsA("Fire") or object:IsA("Smoke") or object:IsA("Sparkles")
		or object:IsA("BillboardGui") or object:IsA("SurfaceGui") or object:IsA("Highlight") then
		return "Enabled", object.Enabled
	end
	return nil
end

local function setInvisibleStateInternal(state)
	invisibleEnabled = state
	local char = LP.Character
	if not char then return false, "CHARACTER NOT READY" end
	local humanoid = char:FindFirstChildOfClass("Humanoid")

	if invisibleConnection then
		pcall(function() invisibleConnection:Disconnect() end)
		invisibleConnection = nil
	end

	if state then
		invisibleOriginals = {}
		pcall(function()
			if humanoid then
				humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			end
			for _, obj in ipairs(char:GetDescendants()) do
				local prop, orig = getHiddenProperty(obj)
				if prop then
					invisibleOriginals[obj] = {prop = prop, orig = orig}
					obj[prop] = prop == "Transparency" and 1 or false
				end
			end
		end)

		invisibleConnection = RunService.PreSimulation:Connect(function()
			pcall(function()
				if LP.Character ~= char then return end
				if humanoid and humanoid.Parent then
					humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				end
				for obj, data in pairs(invisibleOriginals) do
					if obj and obj.Parent then
						obj[data.prop] = data.prop == "Transparency" and 1 or false
					end
				end
			end)
		end)
		return true, "INVISIBILITY ENABLED"
	else
		pcall(function()
			if humanoid then
				humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
			end
			for obj, data in pairs(invisibleOriginals) do
				if obj and obj.Parent then
					obj[data.prop] = data.orig
				end
			end
		end)
		invisibleOriginals = {}
		return true, "INVISIBILITY DISABLED"
	end
end

--========================================================
-- ACTIONS: TELEPORT & FLING (CLIENT-SIDE)
--========================================================

local function teleportTarget(prefix)
	local target, err = findTarget(prefix)
	if not target then return false, err or "PLAYER NOT FOUND" end
	if target == LP then return false, "CANNOT TARGET YOURSELF" end

	local _, _, adminRoot = getParts(LP)
	local _, _, targetRoot = getParts(target)
	if not adminRoot or not targetRoot then return false, "CHARACTER NOT READY" end

	local ok = pcall(function()
		LP.Character:PivotTo(targetRoot.CFrame * CFrame.new(0, 0, 4))
		adminRoot.AssemblyLinearVelocity = Vector3.zero
	end)

	if not ok then return false, "TELEPORT FAILED" end
	return true, "TELEPORTED TO: " .. target.Name
end

local function flingPlayer(target)
	local _, _, root = getParts(LP)
	local _, _, tRoot = getParts(target)
	if not root or not tRoot then return false end

	pcall(function()
		local startTime = os.clock()
		local conn
		conn = RunService.Heartbeat:Connect(function()
			if os.clock() - startTime > 1.5 or not tRoot.Parent then
				if conn then conn:Disconnect() end
				root.AssemblyLinearVelocity = Vector3.zero
				return
			end
			root.AssemblyLinearVelocity = Vector3.new(math.random(-6000, 6000), 6000, math.random(-6000, 6000))
			root.CFrame = tRoot.CFrame
		end)
	end)
	return true
end

local function flingTarget(prefix)
	local target, err = findTarget(prefix)
	if not target then return false, err or "PLAYER NOT FOUND" end
	if target == LP then return false, "CANNOT TARGET YOURSELF" end
	flingPlayer(target)
	return true, "TARGET FLUNG: " .. target.Name
end

local function flingAll()
	local count = 0
	for _, target in ipairs(Players:GetPlayers()) do
		if target ~= LP then
			flingPlayer(target)
			count += 1
		end
	end
	return true, "AFFECTED PLAYERS: " .. tostring(count)
end

--========================================================
-- DASHBOARD PAGE
--========================================================

local dashboardCard = createSection(dashboardPage, "EV03 // DASHBOARD", 160)

create("TextLabel", {
	Size = UDim2.new(1, -28, 0, 35),
	Position = UDim2.fromOffset(14, 40),
	BackgroundTransparency = 1,
	Text = "WELCOME TO EV03 CONTROL",
	TextColor3 = C.WHITE,
	TextSize = 19,
	Font = Enum.Font.GothamBlack,
	TextXAlignment = Enum.TextXAlignment.Left,
}, dashboardCard)

create("TextLabel", {
	Size = UDim2.new(1, -28, 0, 70),
	Position = UDim2.fromOffset(14, 82),
	BackgroundTransparency = 1,
	Text = "Creator: 阿叶ev03\nVersion: V3.8 (Standalone Edition)\nPure Client Execution",
	TextColor3 = C.GRAY,
	TextSize = 12,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
}, dashboardCard)

--========================================================
-- PLAYER PAGE
--========================================================

local playerCard = createSection(playerPage, "PLAYER // MANAGEMENT", 160)
local targetInput = makeInput(
	playerCard,
	"Enter exact Roblox Username...",
	0, 39, 1, 36, ""
)

local function getTargetInputName()
	local name = targetInput.Text:match("^%s*(.-)%s*$")
	if not name or name == "" then
		setStatus("PLEASE ENTER USERNAME", C.RED)
		return nil
	end
	return name
end

makeButton(playerCard, "TELEPORT TO TARGET", 0, 88, 0.32, 40, function()
	local name = getTargetInputName()
	if name then
		local ok, msg = teleportTarget(name)
		setStatus(msg, ok and C.GREEN or C.RED)
	end
end)

makeButton(playerCard, "FLING TARGET", 0.34, 88, 0.32, 40, function()
	local name = getTargetInputName()
	if name then
		local ok, msg = flingTarget(name)
		setStatus(msg, ok and C.GREEN or C.RED)
	end
end)

makeButton(playerCard, "FLING ALL", 0.68, 88, 0.32, 40, function()
	local ok, msg = flingAll()
	setStatus(msg, ok and C.GREEN or C.RED)
end)

--========================================================
-- MOVEMENT PAGE
--========================================================

local movementCard = createSection(
	movementPage,
	"MOVEMENT // CAMERA FLY / SPEED / NOCLIP",
	365
)

local infiniteJump = false
local flyEnabled = false
local flySpeed = 80

local setJumpState
local setFlyState
local setNoclipState
local setInvisibleState

jumpButton, setJumpState = makeToggle(movementCard, "INFINITE JUMP", 42, function(state)
	infiniteJump = state
	return true
end)

local walkInput = makeInput(
	movementCard,
	"Walk speed (finite number)",
	0, 91, 0.62, 36, "32"
)

makeButton(movementCard, "APPLY WALK SPEED", 0.65, 91, 0.35, 36, function()
	local speed = tonumber(walkInput.Text)
	if not validNumber(speed) or speed < 0 then
		setStatus("INVALID WALK SPEED", C.RED)
		return
	end
	local _, humanoid = getParts(LP)
	if humanoid then
		humanoid.WalkSpeed = speed
		setStatus("WALK SPEED: " .. tostring(speed), C.GREEN)
	else
		setStatus("CHARACTER NOT READY", C.RED)
	end
end)

local flyInput = makeInput(
	movementCard,
	"Fly speed (finite number)",
	0, 141, 0.62, 36, "80"
)

makeButton(movementCard, "APPLY FLY SPEED", 0.65, 141, 0.35, 36, function()
	local speed = tonumber(flyInput.Text)
	if not validNumber(speed) or speed < 0 then
		setStatus("INVALID FLY SPEED", C.RED)
		return
	end
	flySpeed = speed
	setStatus("FLY SPEED: " .. tostring(speed), C.GREEN)
end)

--========================================================
-- CAMERA DIRECTION FLY ENGINE
--========================================================

local flyAttachment, flyVelocity, flyOrientation, flyConnection, flyHumanoid, oldAutoRotate

local function cleanupFly()
	if flyConnection then
		pcall(function() flyConnection:Disconnect() end)
		flyConnection = nil
	end
	for _, object in ipairs({flyVelocity, flyOrientation, flyAttachment}) do
		if object then pcall(function() object:Destroy() end) end
	end
	flyVelocity, flyOrientation, flyAttachment = nil, nil, nil
	if flyHumanoid and flyHumanoid.Parent then
		pcall(function()
			if oldAutoRotate ~= nil then flyHumanoid.AutoRotate = oldAutoRotate end
			if flyHumanoid.Health > 0 then flyHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
		end)
	end
	flyHumanoid, oldAutoRotate = nil, nil
end

local function getBodyForward(root, cameraCFrame)
	local look = cameraCFrame.LookVector
	local flat = Vector3.new(look.X, 0, look.Z)
	if flat.Magnitude < 0.001 then
		flat = Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z)
	end
	if flat.Magnitude < 0.001 then flat = Vector3.new(0, 0, -1) end
	return flat.Unit
end

local function setupFly()
	cleanupFly()
	local character = LP.Character
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root or humanoid.Health <= 0 then return false end

	local success = pcall(function()
		root.AssemblyAngularVelocity = Vector3.zero
		flyAttachment = Instance.new("Attachment", root)
		flyAttachment.Name = "EV03_FlyAttachment"

		flyVelocity = Instance.new("LinearVelocity", root)
		flyVelocity.Name = "EV03_FlyVelocity"
		flyVelocity.Attachment0 = flyAttachment
		flyVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
		flyVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
		flyVelocity.ForceLimitsEnabled = false
		flyVelocity.VectorVelocity = Vector3.zero

		flyOrientation = Instance.new("AlignOrientation", root)
		flyOrientation.Name = "EV03_FlyOrientation"
		flyOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
		flyOrientation.Attachment0 = flyAttachment
		flyOrientation.RigidityEnabled = true
		flyOrientation.Responsiveness = 200
		flyOrientation.MaxTorque = 1000000000
		flyOrientation.MaxAngularVelocity = 1000000

		local cam = workspace.CurrentCamera
		flyOrientation.CFrame = CFrame.lookAt(Vector3.zero, getBodyForward(root, cam and cam.CFrame or root.CFrame), Vector3.yAxis)

		flyHumanoid = humanoid
		oldAutoRotate = humanoid.AutoRotate
		humanoid.AutoRotate = false
		humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
	end)

	if not success then
		cleanupFly()
		return false
	end

	flyConnection = RunService.PreSimulation:Connect(function()
		if not flyEnabled then return end
		local currentCamera = workspace.CurrentCamera
		if not currentCamera then return end

		local cameraCFrame = currentCamera.CFrame
		local cameraForward = cameraCFrame.LookVector.Unit
		local cameraRight = Vector3.new(cameraCFrame.RightVector.X, 0, cameraCFrame.RightVector.Z)
		cameraRight = cameraRight.Magnitude > 0.001 and cameraRight.Unit or Vector3.new(1, 0, 0)

		pcall(function()
			flyOrientation.CFrame = CFrame.lookAt(Vector3.zero, getBodyForward(root, cameraCFrame), Vector3.yAxis)
		end)

		local movement = Vector3.zero
		if not UIS:GetFocusedTextBox() then
			if UIS:IsKeyDown(Enum.KeyCode.W) then movement += cameraForward end
			if UIS:IsKeyDown(Enum.KeyCode.S) then movement -= cameraForward end
			if UIS:IsKeyDown(Enum.KeyCode.A) then movement -= cameraRight end
			if UIS:IsKeyDown(Enum.KeyCode.D) then movement += cameraRight end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then movement += Vector3.yAxis end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl) then
				movement -= Vector3.yAxis
			end
		end

		if movement.Magnitude > 1 then movement = movement.Unit end
		pcall(function()
			flyVelocity.VectorVelocity = movement * flySpeed
		end)
	end)

	return true
end

flyButton, setFlyState = makeToggle(movementCard, "CAMERA FLY", 191, function(state)
	flyEnabled = state
	if state then
		if not setupFly() then
			flyEnabled = false
			setStatus("FLY INIT FAILED", C.RED)
			return false
		end
		setStatus("CAMERA FLY ENABLED", C.GREEN)
	else
		cleanupFly()
		setStatus("FLY DISABLED", C.RED)
	end
	return true
end)

noclipButton, setNoclipState = makeToggle(movementCard, "NOCLIP / 穿墙", 241, function(state)
	local ok, msg = setNoclipStateInternal(state)
	setStatus(msg, ok and C.GREEN or C.RED)
	return ok
end)

invisibleButton, setInvisibleState = makeToggle(movementCard, "INVISIBILITY / 隐身", 291, function(state)
	local ok, msg = setInvisibleStateInternal(state)
	setStatus(msg, ok and C.GREEN or C.RED)
	return ok
end)

--========================================================
-- INFINITE JUMP + RESPAWN HANDLING
--========================================================

UIS.JumpRequest:Connect(function()
	if not infiniteJump then return end
	pcall(function()
		local _, humanoid = getParts(LP)
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end)

LP.CharacterRemoving:Connect(function()
	cleanupFly()
end)

LP.CharacterAdded:Connect(function()
	task.wait(0.5)
	if flyEnabled and not setupFly() then
		flyEnabled = false
		setFlyState(false, true)
	end
end)

--========================================================
-- ESP SYSTEM
--========================================================

local espCard = createSection(espPage, "ESP // VISUAL SYSTEM", 145)
local espEnabled = false
local espObjects = {}
local playerConnections = {}

local function cleanupESP(data)
	if not data then return end
	for _, conn in ipairs(data.connections or {}) do pcall(function() conn:Disconnect() end) end
	for _, obj in ipairs(data.objects or {}) do pcall(function() obj:Destroy() end) end
end

local function removeESP(player)
	local data = espObjects[player]
	if not data then return end
	cleanupESP(data)
	espObjects[player] = nil
end

local function createESP(player)
	if not espEnabled or player == LP then return end
	removeESP(player)

	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root or humanoid.Health <= 0 then return end

	local objects = {}
	local connections = {}

	local ok = pcall(function()
		local highlight = create("Highlight", {
			Name = "EV03_Highlight",
			Adornee = character,
			FillColor = C.RED,
			OutlineColor = C.WHITE,
			FillTransparency = 0.82,
			OutlineTransparency = 0,
			DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
		}, character)
		table.insert(objects, highlight)

		local box = create("BoxHandleAdornment", {
			Name = "EV03_Box",
			Adornee = root,
			Size = Vector3.new(4, 6, 2),
			CFrame = CFrame.new(0, 1.5, 0),
			Color3 = C.RED,
			Transparency = 0.25,
			AlwaysOnTop = true,
			ZIndex = 10,
		}, root)
		table.insert(objects, box)

		local billboard = create("BillboardGui", {
			Name = "EV03_Info",
			Adornee = root,
			Size = UDim2.fromOffset(140, 40),
			StudsOffset = Vector3.new(0, 4, 0),
			AlwaysOnTop = true,
		}, espGui)
		table.insert(objects, billboard)

		create("TextLabel", {
			Size = UDim2.new(1, 0, 0, 20),
			BackgroundTransparency = 1,
			Text = player.Name,
			TextColor3 = C.WHITE,
			TextStrokeTransparency = 0.2,
			TextSize = 12,
			Font = Enum.Font.GothamBold,
		}, billboard)

		local bar = create("Frame", {
			Size = UDim2.new(1, -12, 0, 8),
			Position = UDim2.fromOffset(6, 25),
			BackgroundColor3 = C.PANEL2,
			BorderSizePixel = 0,
		}, billboard)
		create("UICorner", {CornerRadius = UDim.new(1, 0)}, bar)

		local fill = create("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = C.GREEN,
			BorderSizePixel = 0,
		}, bar)
		create("UICorner", {CornerRadius = UDim.new(1, 0)}, fill)

		local function updateHealth()
			if not fill.Parent then return end
			local ratio = math.clamp(humanoid.Health / math.max(humanoid.MaxHealth, 1), 0, 1)
			fill.Size = UDim2.fromScale(ratio, 1)
			fill.BackgroundColor3 = ratio > 0.5 and C.GREEN or C.RED
		end

		updateHealth()
		table.insert(connections, humanoid.HealthChanged:Connect(updateHealth))
		table.insert(connections, humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(updateHealth))
	end)

	if not ok then
		cleanupESP({objects = objects, connections = connections})
		return
	end

	espObjects[player] = {objects = objects, connections = connections}
end

local espButton, setESPState = makeToggle(espCard, "PLAYER ESP", 42, function(state)
	espEnabled = state
	if not state then
		for player in pairs(espObjects) do removeESP(player) end
	else
		for _, player in ipairs(Players:GetPlayers()) do createESP(player) end
	end
	return true
end)

create("TextLabel", {
	Size = UDim2.new(1, -24, 0, 25),
	Position = UDim2.fromOffset(12, 91),
	BackgroundTransparency = 1,
	Text = "HIGHLIGHT / BOX / NAME / HEALTH",
	TextColor3 = C.GRAY,
	TextSize = 10,
	Font = Enum.Font.Code,
	TextXAlignment = Enum.TextXAlignment.Left,
}, espCard)

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LP then
		player.CharacterAdded:Connect(function()
			task.wait(0.3)
			if espEnabled then createESP(player) end
		end)
		player.CharacterRemoving:Connect(function() removeESP(player) end)
	end
end

Players.PlayerAdded:Connect(function(player)
	if player == LP then return end
	player.CharacterAdded:Connect(function()
		task.wait(0.3)
		if espEnabled then createESP(player) end
	end)
	player.CharacterRemoving:Connect(function() removeESP(player) end)
end)

Players.PlayerRemoving:Connect(removeESP)

--========================================================
-- FEATURE HANDLERS & PANIC
--========================================================

local handlers = {}

handlers.InfiniteJump = function() setJumpState(not infiniteJump) end
handlers.Fly = function() setFlyState(not flyEnabled) end
handlers.Noclip = function() setNoclipState(not noclipEnabled) end
handlers.ESP = function() setESPState(not espEnabled) end
handlers.Invisible = function() setInvisibleState(not invisibleEnabled) end

handlers.Panic = function()
	setJumpState(false)
	setFlyState(false)
	setESPState(false)
	setNoclipState(false, true)
	setInvisibleState(false, true)
	noclipEnabled = false
	invisibleEnabled = false
	walkInput.Text = "16"
	local _, humanoid = getParts(LP)
	if humanoid then pcall(function() humanoid.WalkSpeed = 16 end) end
	setStatus("PANIC RESET COMPLETED", C.RED)
end

--========================================================
-- HOTKEYS PAGE
--========================================================

local hotkeyCard = createSection(hotkeyPage, "HOTKEYS // 快捷键分组", 605)

create("TextLabel", {
	Size = UDim2.new(1, -24, 0, 35),
	Position = UDim2.fromOffset(12, 37),
	BackgroundTransparency = 1,
	Text = "点击右侧按钮，再按下想绑定的新按键。\n重复按键会自动解除之前的绑定。",
	TextColor3 = C.GRAY,
	TextSize = 10,
	Font = Enum.Font.Code,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
}, hotkeyCard)

local bindings = {
	InfiniteJump = Enum.KeyCode.J,
	Fly = Enum.KeyCode.F,
	Noclip = Enum.KeyCode.N,
	ESP = Enum.KeyCode.E,
	Invisible = Enum.KeyCode.V,
	Panic = Enum.KeyCode.P,
	ToggleMenu = Enum.KeyCode.RightShift,
}

handlers.ToggleMenu = function()
	gui.Enabled = not gui.Enabled
end

local bindingRows = {
	{"InfiniteJump", "无限跳跃"},
	{"Fly", "摄像机飞行开关"},
	{"Noclip", "穿墙开关"},
	{"ESP", "ESP 开关"},
	{"Invisible", "隐身开关"},
	{"Panic", "Panic"},
	{"ToggleMenu", "菜单显示 / 隐藏"},
}

local bindButtons = {}
local listeningAction = nil

local function refreshBindingLabels()
	for action, button in pairs(bindButtons) do
		button.Text = bindings[action] and bindings[action].Name or "UNBOUND"
		button.BackgroundColor3 = C.DARK_RED
	end
end

local rowStart = 82
local rowSpacing = 39

for index, row in ipairs(bindingRows) do
	local action = row[1]
	local label = row[2]
	local y = rowStart + (index - 1) * rowSpacing

	create("TextLabel", {
		Size = UDim2.new(0.59, -5, 0, 32),
		Position = UDim2.fromOffset(12, y),
		BackgroundTransparency = 1,
		Text = label,
		TextColor3 = C.WHITE,
		TextSize = 11,
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, hotkeyCard)

	local bindButton
	bindButton = makeButton(hotkeyCard, bindings[action] and bindings[action].Name or "UNBOUND", 0.63, y, 0.34, 32, function()
		listeningAction = action
		bindButton.Text = "PRESS KEY..."
		bindButton.BackgroundColor3 = C.GREEN
		setStatus("REBINDING: " .. label, C.YELLOW)
	end)

	bindButtons[action] = bindButton
end

makeButton(hotkeyCard, "PANIC // DISABLE ALL", 0, 555, 1, 30, handlers.Panic)

--========================================================
-- ABOUT PAGE
--========================================================

local aboutCard = createSection(aboutPage, "ABOUT // 身份组", 285)

create("TextLabel", {
	Size = UDim2.new(1, -32, 0, 225),
	Position = UDim2.fromOffset(16, 42),
	BackgroundTransparency = 1,
	Text = table.concat({
		"PROJECT INFORMATION",
		"",
		"项目名称：EV03 CONTROL",
		"项目版本：V3.8 (Standalone)",
		"项目类型：Roblox Client Admin Script",
		"飞行模式：CAMERA DIRECTION",
		"",
		"CREATOR IDENTITY",
		"",
		"创作者：阿叶ev03",
		"身份：Creator / Developer",
		"项目归属：EV03",
	}, "\n"),
	TextColor3 = C.WHITE,
	TextSize = 12,
	Font = Enum.Font.Code,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	TextWrapped = true,
}, aboutCard)

--========================================================
-- DEFAULT PAGE
--========================================================

local function selectPage(name)
	if not pages[name] then return end
	for pageName, page in pairs(pages) do page.Visible = pageName == name end
	for pageName, button in pairs(navButtons) do
		local selected = pageName == name
		button.BackgroundColor3 = selected and C.DARK_RED or C.SIDEBAR
		button.TextColor3 = selected and C.WHITE or C.GRAY
	end
end

selectPage("DASHBOARD")

--========================================================
-- WINDOW DRAGGING & CONTROLS
--========================================================

local dragging, dragStart, startPosition, dragInput

dragArea.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPosition = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

dragArea.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if not dragging or input ~= dragInput then return end
	local delta = input.Position - dragStart
	main.Position = UDim2.new(
		startPosition.X.Scale, startPosition.X.Offset + delta.X,
		startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
	)
end)

local minimized = false
local originalSize = main.Size

minimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		originalSize = main.Size
		body.Visible = false
		footer.Visible = false
		main.Size = UDim2.fromOffset(windowWidth, 58)
		minimizeButton.Text = "+"
	else
		main.Size = originalSize
		body.Visible = true
		footer.Visible = true
		minimizeButton.Text = "—"
	end
end)

closeButton.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)

--========================================================
-- HOTKEY LISTENER
--========================================================

UIS.InputBegan:Connect(function(input, processed)
	if listeningAction then
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		if input.KeyCode == Enum.KeyCode.Escape then
			listeningAction = nil
			refreshBindingLabels()
			setStatus("BINDING CANCELLED", C.YELLOW)
			return
		end
		if input.KeyCode == Enum.KeyCode.Unknown then return end

		local action = listeningAction
		listeningAction = nil
		for otherAction, otherKey in pairs(bindings) do
			if otherAction ~= action and otherKey == input.KeyCode then
				bindings[otherAction] = nil
			end
		end
		bindings[action] = input.KeyCode
		refreshBindingLabels()
		setStatus(action .. " KEY: " .. input.KeyCode.Name, C.GREEN)
		return
	end

	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
	if processed then return end
	if UIS:GetFocusedTextBox() then return end

	for action, key in pairs(bindings) do
		if key and key == input.KeyCode then
			local handler = handlers[action]
			if handler then
				pcall(handler)
			end
			return
		end
	end
end)

--========================================================
-- READY
--========================================================

refreshBindingLabels()
setStatus("EV03 STANDALONE V3.8 READY", C.GREEN)

print("======================================")
print(" EV03 CONTROL V3.8 - STANDALONE")
print(" CREATOR: 阿叶ev03")
print(" PURE CLIENT EXECUTION READY")
print("======================================")
