script=game:GetObjects("rbxassetid://4513235536")[1].Goner.ServerScript

local MODULE = script.Parent
local PLAYER = game.Players.LocalPlayer
local CHARACTER = PLAYER.Character
local HUM = CHARACTER.Humanoid

local ROOT = HUM.Torso
local HEAD = CHARACTER.Head
local TORSO = CHARACTER.Torso
local RIGHTARM = CHARACTER["Right Arm"]
local LEFTARM = CHARACTER["Left Arm"]
local RIGHTLEG = CHARACTER["Right Leg"]
local LEFTLEG = CHARACTER["Left Leg"]
local ROOTJOINT = ROOT["RootJoint"]
local NECK = TORSO["Neck"]
local RIGHTSHOULDER = TORSO["Right Shoulder"]
local LEFTSHOULDER = TORSO["Left Shoulder"]
local RIGHTHIP = TORSO["Right Hip"]
local LEFTHIP = TORSO["Left Hip"]
local MOUSEPOS = ROOT.Position
local UserInputService = game:GetService("UserInputService")

IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor

print("gObl00x its a SIGMA 🔥")

local ANIM_SPEED = 3
local Mouse = PLAYER:GetMouse() -- FIX: Mouse n'etait pas defini
local MOUSE = Mouse
local FRAME_SPEED = 1 / 60
local CHANGE = 2 / ANIM_SPEED
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local KEYHOLD = false
local MOUSEHOLD = false
local SINE = 0
local ATTACKING = false
local Debris = game:GetService("Debris")
local Effects = IT("Folder",CHARACTER)
Effects.Name = "FXFolder"
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = FRAME_SPEED
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				ArtificialHB:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)

function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then 
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end
 
function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end
 
function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = ACOS(-cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((t - 1) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end

function WeldParts(A,B)
	local WLD = IT("ManualWeld")
	WLD.Part0 = A
	WLD.Part1 = B
	WLD.C1 = B.CFrame:inverse() * A.CFrame
	WLD.Parent = A
	return WLD
end

function NewSound(TABLE)
	local ID = "rbxassetid://"..(TABLE.ID or 0)
	local PARENT = (TABLE.PARENT or ROOT)
	local VOLUME = (TABLE.VOLUME or 0.5)
	local PITCH = (TABLE.PITCH or 1)
	local LOOP = (TABLE.LOOP or false)
	local MAXDISTANCE = (TABLE.MAXDISTANCE or 100)
	local EMITTERSIZE = (TABLE.EMITTERSIZE or 10)
	local PLAYING = (TABLE.PLAYING or true)
	local PLAYONREMOVE = (TABLE.PLAYONREMOVE or false)
	local DOESDEBRIS = (TABLE.DOESDEBRIS or true)
	if ID ~= "rbxassetid://0" then
		local SOUND = IT("Sound",PARENT)
		SOUND.SoundId = ID
		SOUND.Volume = VOLUME
		SOUND.Pitch = PITCH
		SOUND.Looped = LOOP
		SOUND.MaxDistance = MAXDISTANCE
		SOUND.EmitterSize = EMITTERSIZE
		SOUND.PlayOnRemove = PLAYONREMOVE
		if DOESDEBRIS == true and PLAYING == true and LOOP == false then
			Debris:AddItem(SOUND,SOUND.TimeLength+5)
		end
		if PLAYING == true then
			SOUND:Play()
		end
		return SOUND
	end
end

function OofOuchBlood(LOCATION,TO,AMOUNT)
	local BLOODMOD = MODULE:FindFirstChild("Blood")
	if not BLOODMOD then return end
	local P = CreatePart(3, Effects, "Granite", 0, 1, BRICKC("Pearl"), "Blood", VT(0,0,0), true)
	P.CFrame = CF(LOCATION,TO)
	local BLOOD = BLOODMOD:Clone()
	BLOOD.Parent = P
	BLOOD:Emit(AMOUNT)
	Debris:AddItem(P,2)
end

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = ROOT.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

function Raycast(POSITION, DIRECTION, RANGE, TABLE)
	local TABLE = ((type(TABLE) == "table" and TABLE) or {TABLE})
	return game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(POSITION, DIRECTION * RANGE), TABLE)
end

function HumanoidModels(INCLUDESELF)
	local LIST = {}
	for _, D in pairs(workspace:GetDescendants()) do
		if D:IsA("Humanoid") and D.Parent and D.Parent:IsA("Model") then
			if INCLUDESELF or not D:IsDescendantOf(CHARACTER) then
				table.insert(LIST, D.Parent)
			end
		end
	end
	return LIST
end

function CameraShake(AREA,RANGE,SHAKE,TIMER)
	local CAMSHAKEMOD = script:FindFirstChild("CamShake")
	if not CAMSHAKEMOD then return end
	for index, CHILD in pairs(HumanoidModels(true)) do
		if CHILD:FindFirstChildOfClass("Humanoid") then
			local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
			local ROOT = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
			if ROOT and game.Players:GetPlayerFromCharacter(CHILD) then
				if (ROOT.Position - AREA).Magnitude <= RANGE then
					if CHILD:FindFirstChild("CamShake") then
						Debris:AddItem(CHILD:FindFirstChild("CamShake"),0.05)
					end
					local CAMSHAKE = CAMSHAKEMOD:Clone()
					CAMSHAKE.Parent = CHILD
					local TIMER_V = IT("NumberValue",CAMSHAKE)
					TIMER_V.Name = "Timer"
					TIMER_V.Value = TIMER
					local SHAKE_V = IT("NumberValue",CAMSHAKE)
					SHAKE_V.Name = "Shake"
					SHAKE_V.Value = SHAKE
					CAMSHAKE.Disabled = false
					Debris:AddItem(CAMSHAKE,15)
				end
			end
		end
	end
end

function Debree(Table)
	local KindOf = (Table.Variant or "Ring")
	local Position = (Table.Location or ROOT.Position)
	local Coloration = (Table.Color or C3(1,1,1))
	local Texture = (Table.Material or "Slate")
	local Fling = (Table.Scatter or 1)
	local Number = (Table.Amount or 1)
	local Rocks = (Table.DebreeCount or 1)
	local Range = (Table.Distance or 1)
	local Scale = (Table.Size or 1)
	local Timer = (Table.Delay or 1.5)
	coroutine.resume(coroutine.create(function()
		local ScaleVector = VT(Scale,Scale,Scale)
		local Boulders = {}
		Position = CF(Position)
		if KindOf == "Ring" or KindOf == "Both" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),Range)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				BOULDER.Color = Coloration
				table.insert(Boulders,BOULDER)
			end
		end
		if KindOf == "Loose" or KindOf == "Both" then
			for RockValue = 1, Rocks do
				local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale-(Scale/2)),math.ceil(Scale-(Scale/2))),0.7)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, false)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				BOULDER.Velocity = CF(BOULDER.Position-VT(0,4,0),BOULDER.CFrame*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))*CF(0,5,0).p).lookVector*MRANDOM(Fling-(Fling/1.5),Fling+(Fling/1.5))
				BOULDER.Color = Coloration
				table.insert(Boulders,BOULDER)
			end
		end
		if KindOf == "Random" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),MRANDOM(0,Range))
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				BOULDER.Color = Coloration
				table.insert(Boulders,BOULDER)
			end
		end
		wait(Timer)
		for E = 1, 45 do
			Swait()
			for A = 1, #Boulders do
				Boulders[A].Transparency = Boulders[A].Transparency + 1/45
			end
		end
		for A = 1, #Boulders do
			Boulders[A]:Destroy()
		end
	end))
end

function Chatter(Text,Timer)
	local chat = coroutine.wrap(function()
		if CHARACTER:FindFirstChild("SpeechBoard")~= nil then
			CHARACTER:FindFirstChild("SpeechBoard"):destroy()
		end
		local naeeym2 = IT("BillboardGui",CHARACTER)
		naeeym2.Size = UD2(0,320,0,40)
		naeeym2.StudsOffset = Vector3.new(0,2,0)
		naeeym2.Adornee = HEAD
		naeeym2.Name = "SpeechBoard"
		naeeym2.AlwaysOnTop = true
		local tecks2 = IT("TextLabel",naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = "Legacy"
		tecks2.TextSize = 15
		tecks2.TextStrokeTransparency = 0
		tecks2.TextColor3 = Color3.new(1,1,1)
		tecks2.TextStrokeColor3 = Color3.new(0,0,0)
		tecks2.Size = UDim2.new(1,0,0.5,0)
		for i = 1,string.len(Text),1 do
			if naeeym2.Parent ~= CHARACTER then 
				break
			end
			NewSound({ID = 418252437,PARENT = HEAD,VOLUME = 1,PITCH = MRANDOM(8,12)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			tecks2.Text = string.sub(Text,1,i)
			wait(Timer)
		end
		wait(1)
		naeeym2:Destroy()
	end)
	chat()
end

function Notify(TEXT)
	pcall(function()
		Chatter(string.sub(tostring(TEXT),1,70),0.02)
	end)
end

function SpawnPuddle(POSITION,IGNR,GOO)
	local SURFACEMOD = script:FindFirstChild("PuddleSurface")
	if not SURFACEMOD then return end
	local HIT,POS,NOR = Raycast(POSITION, CFrame.new(POSITION,POSITION-Vector3.new(0,1,0)).lookVector, 12, {IGNR,CHARACTER})
	if HIT then
		coroutine.resume(coroutine.create(function()
			local GOREPART = CreatePart(3, Effects, "Slate", 0, 1, "Pearl", "Gore", VT(3,0,3), true)
			local SURFACE = SURFACEMOD:Clone()
			SURFACE.Parent = GOREPART
			if GOO == true then
				SURFACE.Image.ImageColor3 = C3(0,0,0)
			end
			GOREPART.CFrame = CFrame.new(POS,POS+NOR)*CFrame.Angles(math.rad(-90),math.rad(math.random(0,360)),0)
			for i = 1, math.random(25,65) do
				Swait()
				GOREPART.Size = GOREPART.Size + Vector3.new(0.1,0,0.1)
			end
			wait(math.random(10,25)/50)
			for i = 1, 25 do
				Swait()
				SURFACE.Image.ImageTransparency = SURFACE.Image.ImageTransparency + 1/25
			end
			GOREPART:Remove()
		end))
	end
end

function Dismember(MAN,DOWHAT)
	if not MAN then return end
	for index, CHILD in pairs(MAN:GetDescendants()) do
		if CHILD:IsA("Script") or CHILD:IsA("LocalScript") then
			CHILD:Destroy()
		end
	end
	if DOWHAT == "Ragdoll" then
		local HUM = MAN:FindFirstChildOfClass("Humanoid")
		if HUM then
			HUM.Health = 0
		end
		local RAGDOLL = script:FindFirstChild("R6Ragdoll")
		if MAN:FindFirstChild("UpperTorso") then
			RAGDOLL = script:FindFirstChild("R15Ragdoll")
		end
		if RAGDOLL then
			RAGDOLL = RAGDOLL:Clone()
			RAGDOLL.Parent = MAN
			RAGDOLL.Disabled = false
		end
		MAN:BreakJoints()
	else
		local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
		local HED = MAN:FindFirstChild("Head")
		if TORSO and HED then
			if DOWHAT == "Head" then
				if TORSO:FindFirstChild("TorsoA4") then
					TORSO:FindFirstChild("TorsoA4"):Remove()
				elseif MAN:FindFirstChild("RagdollConstraintHead") then
					MAN:FindFirstChild("RagdollConstraintHead"):Remove()
				end
				HED:BreakJoints()
			elseif DOWHAT == "RightArm" then
				if TORSO:FindFirstChild("TorsoA3") then
					TORSO:FindFirstChild("TorsoA3"):Remove()
				elseif MAN:FindFirstChild("RagdollConstraintRightUpperArm") then
					MAN:FindFirstChild("RagdollConstraintRightUpperArm"):Remove()
				end
			elseif DOWHAT == "LeftArm" then
				if TORSO:FindFirstChild("TorsoA2") then
					TORSO:FindFirstChild("TorsoA2"):Remove()
				elseif MAN:FindFirstChild("RagdollConstraintLeftUpperArm") then
					MAN:FindFirstChild("RagdollConstraintLeftUpperArm"):Remove()
				end
			elseif DOWHAT == "Legs" then
				if TORSO.Name == "Torso" then
					if TORSO:FindFirstChild("TorsoA") then
						TORSO:FindFirstChild("TorsoA"):Remove()
					end
					if TORSO:FindFirstChild("TorsoA1") then
						TORSO:FindFirstChild("TorsoA1"):Remove()
					end
				elseif MAN:FindFirstChild("RagdollConstraintUpperTorso") then
					MAN:FindFirstChild("RagdollConstraintUpperTorso"):Remove()
				end
			end
		end
	end
end

function Speak(ID)
	local CHORUS = script:FindFirstChild("ChorusSoundEffect")
	local PITCHMOD = script:FindFirstChild("Pitch")
	local S = NewSound({ID = ID,PARENT = HEAD,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 300,EMITTERSIZE = 35,PLAYING = false,PLAYONREMOVE = false,DOESDEBRIS = true})
	if not S then return end
	if CHORUS then CHORUS:Clone().Parent = S end
	if PITCHMOD then PITCHMOD:Clone().Parent = S end
	S:Play()
	Debris:AddItem(S,S.TimeLength+5)
end

local ARMOR = IT("Model",CHARACTER)
ARMOR.Name = "Goner"
HEAD:ClearAllChildren()
HEAD.Size = VT(1,1,1)
NECK.Parent = TORSO
local PARTS = {}

for index, CHILD in pairs(CHARACTER:GetChildren()) do
	if CHILD:IsA("BasePart") then
		CHILD.Transparency = 1
		local BITS = MODULE.Bits:Clone()
		BITS.Parent = CHILD
		BITS.Enabled = true
	else
		if CHILD:IsA("Accessory") then
			CHILD:Destroy()
		end
	end
end

local Players = game:GetService("Players")
local SKIN_ID = 5091088802
local SKIN_MAP = {
	["Torso"] = "Torso", ["UpperTorso"] = "Torso", ["LowerTorso"] = "Torso",
	["Head"] = "Head",
	["Right Arm"] = "Right Arm", ["RightUpperArm"] = "Right Arm", ["RightLowerArm"] = "Right Arm", ["RightHand"] = "Right Arm",
	["Left Arm"] = "Left Arm", ["LeftUpperArm"] = "Left Arm", ["LeftLowerArm"] = "Left Arm", ["LeftHand"] = "Left Arm",
	["Right Leg"] = "Right Leg", ["RightUpperLeg"] = "Right Leg", ["RightLowerLeg"] = "Right Leg", ["RightFoot"] = "Right Leg",
	["Left Leg"] = "Left Leg", ["LeftUpperLeg"] = "Left Leg", ["LeftLowerLeg"] = "Left Leg", ["LeftFoot"] = "Left Leg"
}
local BODY = {}
for _, NAME in ipairs({"Torso","Head","Right Arm","Left Arm","Right Leg","Left Leg"}) do
	local P = CHARACTER:FindFirstChild(NAME)
	if P and P:IsA("BasePart") then
		table.insert(BODY, P)
	end
end

local function LoadSkin(ID)
	local MODEL = nil
	local OK = pcall(function()
		MODEL = Players:CreateHumanoidModelFromUserId(ID)
	end)
	if (not OK) or (not MODEL) then
		MODEL = nil
		pcall(function()
			MODEL = Players:GetCharacterAppearanceAsync(ID)
		end)
	end
	return MODEL
end

-- FIX: compte les parties de skin soudees a la tete (l'ancienne verification etait toujours a 0
-- et affichait la vraie tete en cube noir)
local HEADWELDED = 0

local function ApplyModuleArmor()
	for index, CHILD in pairs(CHARACTER:GetChildren()) do
		if CHILD:IsA("BasePart") and MODULE:FindFirstChild(CHILD.Name) then
			local P = MODULE:FindFirstChild(CHILD.Name)
			P.Parent = CHARACTER
			P:SetPrimaryPartCFrame(CHILD.CFrame)
			for index, PART in pairs(P:GetChildren()) do
				if PART ~= P.PrimaryPart and PART:IsA("BasePart") then
					PART.Anchored = false
					PART.CanCollide = false
					PART.Massless = true
					WeldParts(CHILD,PART)
					if CHILD == HEAD then HEADWELDED = HEADWELDED + 1 end
					PART.Parent = ARMOR
					table.insert(PARTS,PART)
				end
			end
			P:Destroy()
		end
	end
end

local function BlackenPart(PART)
	if not PART or not PART:IsA("BasePart") then return end
	PART.Color = C3(0,0,0)
	PART.BrickColor = BRICKC("Really black")
	PART.Material = "SmoothPlastic"
	PART.Reflectance = 0
	for _, M in pairs(PART:GetChildren()) do
		if M:IsA("DataModelMesh") then
			pcall(function() M.TextureId = "" end)
			pcall(function() M.VertexColor = VT(0,0,0) end)
		end
	end
	for _, D in pairs(PART:GetChildren()) do
		if D:IsA("Decal") or D:IsA("Texture") then
			D:Destroy()
		end
	end
end

local WELDED = 0

local OKSKIN, ERRSKIN = pcall(function()
	local SKIN = LoadSkin(SKIN_ID)
	if SKIN then
		for index, CHILD in pairs(SKIN:GetDescendants()) do
			if CHILD:IsA("Motor6D") or CHILD:IsA("Weld") or CHILD:IsA("WeldConstraint") or CHILD:IsA("Snap") or CHILD:IsA("Humanoid") or CHILD:IsA("Animator") or CHILD:IsA("Script") or CHILD:IsA("LocalScript") then
				CHILD:Destroy()
			end
		end

		local SKINROOT = SKIN:FindFirstChild("HumanoidRootPart") or SKIN:FindFirstChild("Torso") or SKIN:FindFirstChild("UpperTorso")
		if SKINROOT then
			local DELTA = ROOT.CFrame * SKINROOT.CFrame:Inverse()
			for index, PART in pairs(SKIN:GetDescendants()) do
				if PART:IsA("BasePart") then
					PART.CFrame = DELTA * PART.CFrame
				end
			end
		end

		for index, PART in pairs(SKIN:GetDescendants()) do
			if PART:IsA("BasePart") then
				local TARGET = nil
				if SKIN_MAP[PART.Name] then
					TARGET = CHARACTER:FindFirstChild(SKIN_MAP[PART.Name])
				end
				if not TARGET then
					local BEST = math.huge
					for _, B in pairs(BODY) do
						local D = (B.Position - PART.Position).Magnitude
						if D < BEST then
							BEST = D
							TARGET = B
						end
					end
				end
				if TARGET then
					PART.Anchored = false
					PART.CanCollide = false
					PART.Massless = true
					WeldParts(TARGET,PART)
					if TARGET == HEAD then HEADWELDED = HEADWELDED + 1 end
					PART.Parent = ARMOR
					table.insert(PARTS,PART)
					WELDED = WELDED + 1
				end
			end
		end
		SKIN:Destroy()
	end
end)

if not OKSKIN then
	warn("Goner skin: "..tostring(ERRSKIN))
end

if WELDED == 0 then
	pcall(ApplyModuleArmor)
end

-- FIX: plus de cube noir, la vraie tete reste invisible
pcall(function()
	for _, PART in pairs(PARTS) do
		BlackenPart(PART)
	end
	HEAD.Transparency = 1
end)

-- FIX: lunettes bien placees devant le visage (+ plan B si l'asset ne charge pas)
pcall(function()
	local OKA, OBJ = pcall(function()
		return game:GetObjects("rbxassetid://4085923851")[1]
	end)
	local ACC = nil
	if OKA and OBJ then
		if OBJ:IsA("Accessory") then
			ACC = OBJ
		else
			ACC = OBJ:FindFirstChildWhichIsA("Accessory", true)
		end
	end
	local HANDLE = ACC and ACC:FindFirstChild("Handle")

	if HANDLE then
		HANDLE.Anchored = false
		HANDLE.CanCollide = false
		HANDLE.Massless = true
		local ATT = HANDLE:FindFirstChildWhichIsA("Attachment")
		local OFFSETS = {
			FaceFrontAttachment = CF(0,0,-0.6),
			FaceCenterAttachment = CF(0,0,0),
			HatAttachment = CF(0,0.5,0),
			HairAttachment = CF(0,0.5,0),
		}
		local W = IT("Weld")
		W.Name = "GlassesWeld"
		W.Part0 = HEAD
		W.Part1 = HANDLE
		if ATT then
			W.C0 = OFFSETS[ATT.Name] or CF(0,0,-0.6)
			W.C1 = ATT.CFrame
		else
			W.C0 = CF(0,0.1,-0.6)
		end
		W.Parent = HEAD
		HANDLE.Parent = ARMOR
	else
		local function GlassPart(NAME, SIZE, OFFSET)
			local P = IT("Part")
			P.Name = NAME
			P.Size = SIZE
			P.Color = C3(0,0,0)
			P.Material = "SmoothPlastic"
			P.Anchored = false
			P.CanCollide = false
			P.Massless = true
			P.Locked = true
			P.CFrame = HEAD.CFrame * OFFSET
			local W = IT("Weld")
			W.Part0 = HEAD
			W.Part1 = P
			W.C0 = OFFSET
			W.Parent = HEAD
			P.Parent = ARMOR
		end
		GlassPart("LensL", VT(0.4,0.28,0.1), CF(-0.25,0.1,-0.58))
		GlassPart("LensR", VT(0.4,0.28,0.1), CF(0.25,0.1,-0.58))
		GlassPart("Bridge", VT(0.15,0.08,0.1), CF(0,0.15,-0.58))
	end

	if OBJ then
		OBJ:Destroy()
	end
end)

for _, c in pairs(CHARACTER:GetDescendants()) do
	if c:IsA("BasePart") then
		c.Locked = true
	end
end
local SWORD = MODULE.Sword
SWORD.Parent = ARMOR
SWORD.Anchored = false
local GRIPC0 = CF(0,-0.9,0)*ANGLES(RAD(90),RAD(90),0)
local HOLD = IT("ManualWeld")
HOLD.Part0 = RIGHTARM
HOLD.Part1 = SWORD
HOLD.C0 = GRIPC0
HOLD.C1 = CF(0,-SWORD.Size.Y/3,0)
HOLD.Parent = RIGHTARM
HOLD.Name = "GripWeld"
local TRAIL = SWORD:FindFirstChild("Trail") or {Enabled = false} -- FIX: plus de crash si pas de Trail
local SOUND_SNAP = 150315649
local SUBMERGED = false
table.insert(PARTS,SWORD)

-- FIX: GUI protege pour ne pas bloquer le reste du script
pcall(function()
	local GUI = MODULE.ControlsGUI
	GUI.Parent = PLAYER.PlayerGui
	GUI.ToggleButton.MouseButton1Click:Connect(function()
		GUI.ToggleButton.Controls.Visible = not GUI.ToggleButton.Controls.Visible
	end)
end)

function Slash()
	if ATTACKING then return end
	ATTACKING = true
	for i=0, 0.2, 0.1 / ANIM_SPEED do
		Swait()
		ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.5 / ANIM_SPEED)
		NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * ANGLES(RAD(25), RAD(180), RAD(0)) * RIGHTSHOULDERC0, 2 / ANIM_SPEED)
		HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)), 2 / ANIM_SPEED)
		LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
		RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
		LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
	end
	TRAIL.Enabled = true
	NewSound({ID = 211059653,PARENT = SWORD,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
	for i=0, 0.1, 0.1 / ANIM_SPEED do
		Swait()
		ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
		NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(0), RAD(0), RAD(-90)) * RIGHTSHOULDERC0, 0.65 / ANIM_SPEED)
		HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)), 0.75 / ANIM_SPEED)
		LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(-5), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
		RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
		LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
	end
	for index, CHILD in pairs(HumanoidModels()) do
		if CHILD:FindFirstChildOfClass("Humanoid") and CHILD ~= CHARACTER then
			local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
			local ROOT2 = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
			if ROOT2 then
				if (ROOT2.Position - ROOT.CFrame*CF(0,0,-2).p).Magnitude < 8 then
					local HEAD = CHILD:FindFirstChild("Head")
					if HEAD then
						local FACE = HEAD:FindFirstChild("face")
						if FACE then
							FACE.Texture = "http://www.roblox.com/asset/?id=145854465"
							FACE.Transparency = 0.5
						end
					end
					Dismember(CHILD,"Ragdoll")
					Dismember(CHILD,"Head")
					NewSound({ID = 264486467,PARENT = ROOT2,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					NewSound({ID = SOUND_SNAP,PARENT = ROOT2,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					for i = 1, 7 do
						OofOuchBlood(ROOT2.Position,CF(ROOT2.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
					end
					coroutine.resume(coroutine.create(function()
						for i = 1, 25 do
							SpawnPuddle(ROOT2.Position,CHILD,false)
							Swait()
						end
					end))
				end
			end
		end
	end
	for i=0, 0.3, 0.1 / ANIM_SPEED do
		Swait()
		ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
		NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(0), RAD(0), RAD(-90)) * RIGHTSHOULDERC0, 0.65 / ANIM_SPEED)
		HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)), 0.75 / ANIM_SPEED)
		LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(-5), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
		RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
		LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
	end
	TRAIL.Enabled = false
	ATTACKING = false
end

function ExecuteInner(INPUT)
	local TARGET = nil
	local DIST = 12
	local DEADTARGET = nil
	local DEADDIST = 12
	for _, CHILD in pairs(HumanoidModels()) do
		local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
		local ROOT2 = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
		if HUMAN and ROOT2 and CHILD ~= CHARACTER then
			local DD = (ROOT2.Position - ROOT.Position).Magnitude
			if HUMAN.Health > 0 then
				if DD < DIST then
					TARGET = CHILD
					DIST = DD
				end
			elseif DD < DEADDIST then
				DEADTARGET = CHILD
				DEADDIST = DD
			end
		end
	end
	TARGET = TARGET or DEADTARGET
	if not TARGET then print("Goner: no target within 12 studs") Notify("No target nearby") end
	if TARGET and (SUBMERGED == false or ((INPUT == "x" or INPUT == "z" or INPUT == "c") and SUBMERGED == true)) then
		local DedFace = function()
			local HEAD = TARGET:FindFirstChild("Head")
			if HEAD then
				local FACE = HEAD:FindFirstChild("face")
				if FACE then
					FACE.Texture = "http://www.roblox.com/asset/?id=145854465"
					FACE.Transparency = 0.5
				end
			end
		end
		local STATICMOD = script:FindFirstChild("GonerStatic")
		local TARGETSTATIC = nil
		if STATICMOD then
			if game:GetService("Players"):GetPlayerFromCharacter(TARGET) then
				TARGETSTATIC = STATICMOD:Clone()
				TARGETSTATIC.Parent = game:GetService("Players"):GetPlayerFromCharacter(TARGET).PlayerGui
				local SOUND = NewSound({ID = 2737898305,PARENT = TARGETSTATIC.Script,VOLUME = 3,PITCH = 1,LOOP = true,MAXDISTANCE = 125,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = false})
				if SOUND then SOUND.Name = "Static" end
				Swait()
				TARGETSTATIC.Script.Disabled = false
			end
			local STATIC = STATICMOD:Clone()
			STATIC.Parent = PLAYER.PlayerGui
			local SOUND = NewSound({ID = 2737898305,PARENT = STATIC.Script,VOLUME = 3,PITCH = 1,LOOP = true,MAXDISTANCE = 125,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = false})
			if SOUND then SOUND.Name = "Static" end
			Swait()
			STATIC.Script.Disabled = false
			STATIC.Name = "GonerStaticLocal"
		end
		local TARGETTORSO = TARGET:FindFirstChild("Torso") or TARGET:FindFirstChild("UpperTorso")
		pcall(function()
			local THUM = TARGET:FindFirstChildOfClass("Humanoid")
			THUM.WalkSpeed = 0
			THUM.JumpPower = 0
			THUM.PlatformStand = true
		end)
		local GRABA = IT("Attachment",LEFTARM)
		GRABA.Position = VT(0,-1.5,0)
		local GRABB = IT("Attachment",TARGETTORSO)
		local GRAB = IT("BallSocketConstraint",GRABA)
		GRAB.Attachment0 = GRABA
		GRAB.Attachment1 = GRABB
		local GYRO = IT("BodyGyro")
		GYRO.D = 20
		GYRO.P = 5000
		GYRO.MaxTorque = VT(0,4000000,0)
		GYRO.CFrame = CF(TARGETTORSO.Position,ROOT.Position)
		GYRO.Parent = TARGETTORSO
		ATTACKING = true
		ROOT.Anchored = true
		if INPUT == "z" then
			for i=0, 1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(90)) * ANGLES(RAD(25), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(85), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = true
			NewSound({ID = 211059653,PARENT = SWORD,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i=0, 0.1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(35), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(85), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			CameraShake(ROOT.Position,4.6,15,25)
			Dismember(TARGET,"Ragdoll")
			Dismember(TARGET,"Head")
			DedFace()
			GYRO:Remove()
			NewSound({ID = 264486467,PARENT = TARGETTORSO,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i = 1, 7 do
				OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
			end
			coroutine.resume(coroutine.create(function()
				for i = 1, 25 do
					SpawnPuddle(TARGETTORSO.Position,TARGET,false)
					Swait()
				end
			end))
			for i=0, 0.9, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-1)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(35), RAD(0), RAD(-90)) * ANGLES(RAD(25), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(85), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = false
		elseif INPUT == "x" then
			for i=0, 1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(0), RAD(90)) * ANGLES(RAD(25), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(125), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = true
			NewSound({ID = 536642316,PARENT = SWORD,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i=0, 0.1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.35, -0.85) * ANGLES(RAD(-25), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(125), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			CameraShake(ROOT.Position,4.6,15,25)
			Dismember(TARGET,"Ragdoll")
			Dismember(TARGET,"Legs")
			DedFace()
			GYRO:Remove()
			NewSound({ID = 264486467,PARENT = TARGETTORSO,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i = 1, 7 do
				OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
			end
			coroutine.resume(coroutine.create(function()
				for i = 1, 25 do
					SpawnPuddle(TARGETTORSO.Position,TARGET,false)
					Swait()
				end
			end))
			for i=0, 0.9, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-1)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.35, -0.85) * ANGLES(RAD(-25), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(125), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = false
		elseif INPUT == "c" then
			if SUBMERGED == false then
				GRABA:Remove()
				GRABB:Remove()
				TARGETTORSO.Anchored = true
				local DEAD = false
				Dismember(TARGET,"Ragdoll")
				coroutine.resume(coroutine.create(function()
					repeat
						Swait()
						if TARGETTORSO and TARGETTORSO.Parent then
							TARGETTORSO.CFrame = Clerp(TARGETTORSO.CFrame,ROOT.CFrame*CF(0,-3,-1.5) * ANGLES(RAD(-90), RAD(0), RAD(0)),0.3)
						end
					until DEAD == true
					coroutine.resume(coroutine.create(function()
						for i = 1, 25 do
							SpawnPuddle(TARGETTORSO.Position+VT(0,1,0),TARGET,false)
							Swait()
						end
					end))
					DedFace()
				end))
				for i=0, 1.5, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-5)) * CF(0,-0.75,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
				end
				for i = 1, 7 do
					OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
				end
				CameraShake(ROOT.Position,4.6,15,25)
				Dismember(TARGET,"LeftArm")
				local ARM = TARGET:FindFirstChild("Left Arm") or TARGET:FindFirstChild("LeftUpperArm")
				if ARM then
					local BV = IT("BodyVelocity")
					BV.MaxForce = BV.MaxForce * 500
					BV.Velocity = CF(ARM.Position,ROOT.Position+VT(0,2,0)).lookVector*65
					BV.Parent = ARM
					Debris:AddItem(BV,0.05)
				end
				NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1.1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				for i=0, 0.3, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 1) * ANGLES(RAD(90), RAD(0), RAD(-5)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
				end
				for i=0, 0.3, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.5) * ANGLES(RAD(90), RAD(0), RAD(85)) * CF(0,-1.25,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
				end
				for i = 1, 7 do
					OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
				end
				CameraShake(ROOT.Position,4.6,15,25)
				Dismember(TARGET,"RightArm")
				local ARM = TARGET:FindFirstChild("Right Arm") or TARGET:FindFirstChild("RightUpperArm")
				if ARM then
					local BV = IT("BodyVelocity")
					BV.MaxForce = BV.MaxForce * 500
					BV.Velocity = CF(ARM.Position,ROOT.Position+VT(0,2,0)).lookVector*65
					BV.Parent = ARM
					Debris:AddItem(BV,0.05)
				end
				NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1.1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				DEAD = true
				for i=0, 0.3, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 1) * ANGLES(RAD(90), RAD(0), RAD(85)) * CF(0,0.75,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
				end
				-- planter la lame dans le torse (la lame est orientee par code vers la cible)
				local BLADEY = SWORD.Size.Y
				local function AimBlade(ALPHA)
					local TPOS = TARGETTORSO.Position
					local GRIP = (RIGHTARM.CFrame * CF(0,-0.9,0)).p
					local DIR = TPOS - GRIP
					if DIR.Magnitude < 0.1 then DIR = VT(0,-1,0) end
					DIR = DIR.Unit
					local ROTONLY = CF(VT(0,0,0), DIR) * ANGLES(RAD(-90), 0, 0)
					local CENTERA = GRIP + DIR * (BLADEY / 3)
					local CENTERB = (TPOS + DIR * 0.3) - DIR * (BLADEY / 2)
					local CENTER = CENTERA:Lerp(CENTERB, ALPHA)
					HOLD.C0 = RIGHTARM.CFrame:inverse() * (CF(CENTER) * ROTONLY) * HOLD.C1
				end
				for i=0, 0.4, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(20), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(150), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
					AimBlade(0)
				end
				for i=0, 0.15, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(25), RAD(0), RAD(0)), 3 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(20), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 3 / ANIM_SPEED)
					AimBlade(math.min(i / 0.1, 1))
				end
				AimBlade(1)
				CameraShake(ROOT.Position,4.6,15,25)
				NewSound({ID = 264486467,PARENT = TARGETTORSO,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 0.9,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				for i = 1, 10 do
					OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,25)
				end
				for i=0, 0.6, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(25), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(20), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					AimBlade(1)
				end
			else
				TARGETTORSO.Anchored = true
				Dismember(TARGET,"Ragdoll")
				TARGET.Parent = Effects
				for i = 1, 60 do
					Swait()
					SpawnPuddle(TARGETTORSO.Position,TARGET,true)
					TARGETTORSO.CFrame = TARGETTORSO.CFrame*CF(0,-0.1,0)
				end
				for i = 1, 7 do
					OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,50,-1).p,3)
				end
				TARGET:Remove()
			end
		elseif INPUT == "v" then
			local VHELD = true
			GRABA:Remove()
			GRABB:Remove()
			TARGETTORSO.Anchored = true
			local DEAD = false
			coroutine.resume(coroutine.create(function()
				repeat
					Swait()
					if TARGETTORSO and TARGETTORSO.Parent then
						if VHELD then
							-- tenue par le cou au bout de la main gauche
							local HANDPOS = (LEFTARM.CFrame * CF(0,-1,0)).p + VT(0,-1,0)
							TARGETTORSO.CFrame = Clerp(TARGETTORSO.CFrame, CF(HANDPOS) * (ROOT.CFrame - ROOT.Position) * ANGLES(0,RAD(180),0), 0.4)
						else
							TARGETTORSO.CFrame = Clerp(TARGETTORSO.CFrame,ROOT.CFrame*CF(0,-3,-1.2) * ANGLES(RAD(-90), RAD(0), RAD(0)),0.3)
						end
					end
				until DEAD == true
				DedFace()
				Dismember(TARGET,"Ragdoll")
				coroutine.resume(coroutine.create(function()
					for i = 1, 25 do
						SpawnPuddle(TARGETTORSO.Position+VT(0,1,0),TARGET,false)
						Swait()
					end
				end))
			end))
			-- 1) attrape la cible par le cou et la soulève
			for i=0, 1.0, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(120), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)), 1.5 / ANIM_SPEED)
			end
			-- 2) la balance au sol
			for i=0, 0.25, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.5) * ANGLES(RAD(25), RAD(0), RAD(0)), 2 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 2 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * ANGLES(RAD(-5),RAD(0),RAD(0)), 2 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(35), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 2.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)), 2 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)), 2 / ANIM_SPEED)
			end
			VHELD = false
			CameraShake(ROOT.Position,4.6,15,25)
			NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 3,PITCH = 1.1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i = 1, 7 do
				OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
			end
			-- 3) piétinement
			for i=0, 0.5, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0.3, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(20)), 1.5 / ANIM_SPEED)
			end
			for i = 1, MRANDOM(6,12) do
				for i=0, 0.5, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0.3, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(20)), 1.5 / ANIM_SPEED)
				end
				for i=0, 0.1, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(-20)), 1.5 / ANIM_SPEED)
				end
				CameraShake(ROOT.Position,4.6,15,25)
				NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 1,PITCH = 1.25,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
				for i = 1, 7 do
					OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
				end
				for i=0, 0.2, 0.1 / ANIM_SPEED do
					Swait()
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(-20)), 1.5 / ANIM_SPEED)
				end
			end
			DEAD = true
			for i=0, 0.6, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(-20)), 1.5 / ANIM_SPEED)
			end
		end
		GYRO:Remove()
		if (INPUT ~= "c" or SUBMERGED == false) then
			Speak(2291326656)
		end
		if TARGETSTATIC then
			TARGETSTATIC:Remove()
		end
		GRABA:Remove()
		GRABB:Remove()
		ROOT.Anchored = false
		ATTACKING = false
	end
end

function Execute(INPUT)
	if ATTACKING then return end
	local OKX, ERRX = pcall(ExecuteInner, INPUT)
	if not OKX then
		warn("Goner Execute: "..tostring(ERRX)) Notify("ERROR: "..tostring(ERRX))
	end
	for _, G in pairs(PLAYER.PlayerGui:GetChildren()) do
		if G.Name == "GonerStaticLocal" then
			G:Destroy()
		end
	end
	ROOT.Anchored = false
	ATTACKING = false
end

function Shriek()
	if ATTACKING then return end
	ATTACKING = true
	ROOT.Anchored = true
	local OKX, ERRX = pcall(function()
		for i=0, 0.15, 0.1 / ANIM_SPEED do
			Swait()
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.2) * ANGLES(RAD(0), RAD(0), RAD(10)), 2 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(5), RAD(0)), 2 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.7, 0) * ANGLES(RAD(25), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 2 / ANIM_SPEED)
			HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 2 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(45), RAD(-10), RAD(25)) * LEFTSHOULDERC0, 2 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.8, -0.4) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-20)), 2 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -0.8, -0.4) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(20)), 2 / ANIM_SPEED)
		end
		local FACE = IT("Attachment",HEAD)
		local VOICEMOD = MODULE:FindFirstChild("Voice")
		local SPEAK = nil
		if VOICEMOD then
			SPEAK = VOICEMOD:Clone()
			SPEAK.Size = NumberSequence.new(0,25)
			SPEAK.Parent = FACE
			SPEAK.Enabled = true
		end
		Speak(2466752906)
		CameraShake(ROOT.Position,65,8,150)
		-- ===== BULLE DE SANG ULTRA REALISTE =====
		local RADIUSMAX = 45
		local Lighting = game:GetService("Lighting")
		local CAM = workspace.CurrentCamera
		GONERLBACK = {
			Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient, Brightness = Lighting.Brightness,
			FogColor = Lighting.FogColor, FogStart = Lighting.FogStart, FogEnd = Lighting.FogEnd,
			FOV = CAM and CAM.FieldOfView or 70
		}
		local LB = GONERLBACK
		local function Atmos(T)
			Lighting.Ambient = LB.Ambient:Lerp(C3(0.35,0,0),T)
			Lighting.OutdoorAmbient = LB.OutdoorAmbient:Lerp(C3(0.4,0,0),T)
			Lighting.Brightness = LB.Brightness * (1 - 0.6 * T)
			Lighting.FogColor = LB.FogColor:Lerp(C3(0.25,0,0),T)
			Lighting.FogStart = 0
			Lighting.FogEnd = math.exp((1 - T) * math.log(math.max(LB.FogEnd,200)) + T * math.log(150))
		end

		local function MakeSphere(NAME, MATERIAL, COLOR, TRANSP)
			local P = IT("Part")
			P.Name = NAME
			P.Shape = Enum.PartType.Ball
			P.Material = MATERIAL
			P.Color = COLOR
			P.Transparency = TRANSP
			P.Anchored = true
			P.CanCollide = false
			P.CastShadow = false
			P.Locked = true
			P.Size = VT(2,2,2)
			P.CFrame = ROOT.CFrame
			P.Parent = Effects
			Debris:AddItem(P,14)
			return P
		end
		local FIELD = MakeSphere("BloodField", "ForceField", C3(0.8,0,0), 0.35)
		local SHELL = MakeSphere("BloodShell", "Glass", C3(0.5,0,0), 0.55)
		SHELL.Reflectance = 0.1
		local CORE = MakeSphere("BloodCore", "Neon", C3(0.3,0,0), 0.85)
		local MIST = MakeSphere("BloodMist", "SmoothPlastic", C3(0.2,0,0), 1)
		local LIGHT = IT("PointLight",CORE)
		LIGHT.Color = C3(1,0,0)
		LIGHT.Range = 60
		LIGHT.Brightness = 3

		local function Emitter(HOST, TEXTURE, COLOR, SIZE, TRANSP, LIFE, RATE, SPEED, ACCEL)
			local E = IT("ParticleEmitter",HOST)
			if TEXTURE then E.Texture = TEXTURE end
			E.Color = COLOR
			E.Size = SIZE
			E.Transparency = TRANSP
			E.Lifetime = LIFE
			E.Rate = RATE
			E.Speed = SPEED
			E.Acceleration = ACCEL
			E.LightEmission = 0
			E.LightInfluence = 1
			E.Rotation = NumberRange.new(0,360)
			E.RotSpeed = NumberRange.new(-30,30)
			E.SpreadAngle = Vector2.new(180,180)
			pcall(function()
				E.Shape = Enum.ParticleEmitterShape.Sphere
				E.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
			end)
			return E
		end
		local MISTEMIT = Emitter(MIST, "rbxasset://textures/particles/smoke_main.dds", ColorSequence.new(C3(0.35,0,0),C3(0.12,0,0)), NumberSequence.new({NumberSequenceKeypoint.new(0,5),NumberSequenceKeypoint.new(1,12)}), NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.2,0.55),NumberSequenceKeypoint.new(1,1)}), NumberRange.new(1.5,2.5), 200, NumberRange.new(0,3), VT(0,0,0))
		local RAINEMIT = Emitter(MIST, nil, ColorSequence.new(C3(0.45,0,0),C3(0.2,0,0)), NumberSequence.new(0.4), NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,0.4)}), NumberRange.new(1,2), 450, NumberRange.new(2,10), VT(0,-70,0))

		-- effets d'ecran : teinte, flou, gouttes de sang qui coulent sur l'ecran
		local CC = IT("ColorCorrectionEffect")
		CC.Name = "BloodTint"
		CC.Parent = Lighting
		Debris:AddItem(CC,14)
		local BLUR = IT("BlurEffect")
		BLUR.Name = "BloodBlur"
		BLUR.Size = 0
		BLUR.Parent = Lighting
		Debris:AddItem(BLUR,14)
		local SCREEN = IT("ScreenGui")
		SCREEN.Name = "BloodScreen"
		SCREEN.ResetOnSpawn = false
		SCREEN.IgnoreGuiInset = true
		SCREEN.Parent = PLAYER.PlayerGui
		Debris:AddItem(SCREEN,14)
		local SPLATS = {}
		local function AddSplat()
			local F = IT("Frame")
			local SZ = MRANDOM(40,170)
			F.Size = UD2(0,SZ,0,SZ * MRANDOM(10,17) / 10)
			F.Position = UD2(MRANDOM(0,100)/100,0,MRANDOM(-10,60)/100,0)
			F.BackgroundColor3 = C3(MRANDOM(35,60)/100,0,0)
			F.BackgroundTransparency = 0.2
			F.BorderSizePixel = 0
			F.Rotation = MRANDOM(0,360)
			local CORNER = IT("UICorner",F)
			CORNER.CornerRadius = UDim.new(0.5,0)
			F.Parent = SCREEN
			table.insert(SPLATS,{F = F, SPEED = MRANDOM(1,4)/2})
		end

		local GOREFOLDER = IT("Folder",workspace)
		GOREFOLDER.Name = "GonerGore"
		Debris:AddItem(GOREFOLDER,45)
		local VICTIMS = HumanoidModels()

		-- eclaboussure de sang collee sur un mur / le sol
		local function WorldSplat(POS, NORMAL, SIZE, LIFE)
			local P = IT("Part")
			P.Name = "Splat"
			P.Shape = Enum.PartType.Cylinder
			P.Size = VT(0.05,SIZE,SIZE)
			P.Color = C3(MRANDOM(28,50)/100,0,0)
			P.Material = "SmoothPlastic"
			P.Reflectance = 0.15
			P.Anchored = true
			P.CanCollide = false
			P.Locked = true
			P.CFrame = CF(POS + NORMAL * 0.04, POS + NORMAL * 2) * ANGLES(0,RAD(90),0)
			P.Parent = GOREFOLDER
			Debris:AddItem(P,LIFE)
		end
		-- grosse flaque qui s'etale doucement
		local function BloodPool(POS, MAXR)
			local P = IT("Part")
			P.Name = "Pool"
			P.Shape = Enum.PartType.Cylinder
			P.Size = VT(0.06,0.5,0.5)
			P.Color = C3(0.28,0,0)
			P.Material = "SmoothPlastic"
			P.Reflectance = 0.3
			P.Anchored = true
			P.CanCollide = false
			P.Locked = true
			P.CFrame = CF(POS + VT(0,0.05,0)) * ANGLES(0,0,RAD(90))
			P.Parent = GOREFOLDER
			Debris:AddItem(P,35)
			coroutine.resume(coroutine.create(function()
				for i = 1, 150 do
					Swait()
					if not P.Parent then break end
					local R = 0.5 + (MAXR * 2 - 0.5) * (1 - (1 - i / 150) ^ 2)
					P.Size = VT(0.06,R,R)
				end
			end))
		end

		local function Gore(CHILD, ROOT2)
			local HED = CHILD:FindFirstChild("Head") or ROOT2
			local IGN = {CHARACTER, GOREFOLDER, CHILD}
			Dismember(CHILD,"Ragdoll")
			for _, PART in pairs(CHILD:GetDescendants()) do
				if PART:IsA("BasePart") then
					pcall(function()
						PART.Color = C3((30+MRANDOM(0,15))/100,0,0)
						PART.Material = "SmoothPlastic"
						PART.Reflectance = 0.12
						local DIR = PART.Position - ROOT.Position
						if DIR.Magnitude < 0.1 then DIR = VT(0,1,0) end
						PART.Velocity = DIR.Unit * MRANDOM(15,40) + VT(0,MRANDOM(25,55),0)
						PART.RotVelocity = VT(MRANDOM(-20,20),MRANDOM(-20,20),MRANDOM(-20,20))
					end)
				end
			end
			-- morceaux de chair, os et organes, qui laissent du sang quand ils tombent
			local GIBCOUNT = 22
			if #VICTIMS > 6 then GIBCOUNT = 10 end
			for g = 1, GIBCOUNT do
				local KIND = MRANDOM(1,3)
				local CHUNK = IT("Part")
				CHUNK.Locked = true
				CHUNK.CanCollide = true
				if KIND == 1 then
					CHUNK.Name = "Flesh"
					CHUNK.Size = VT(MRANDOM(3,8)/10,MRANDOM(3,8)/10,MRANDOM(3,8)/10)
					CHUNK.Color = C3(MRANDOM(25,45)/100,0,0)
					CHUNK.Material = "SmoothPlastic"
				elseif KIND == 2 then
					CHUNK.Name = "Bone"
					CHUNK.Size = VT(0.15,MRANDOM(6,14)/10,0.15)
					CHUNK.Color = C3(0.92,0.88,0.78)
					CHUNK.Material = "SmoothPlastic"
				else
					local SZ = MRANDOM(5,10)/10
					CHUNK.Name = "Organ"
					CHUNK.Shape = Enum.PartType.Ball
					CHUNK.Size = VT(SZ,SZ*0.8,SZ)
					CHUNK.Color = C3(0.55,0.08,0.12)
					CHUNK.Material = "SmoothPlastic"
					CHUNK.Reflectance = 0.2
				end
				CHUNK.CFrame = CF(ROOT2.Position + VT(MRANDOM(-10,10)/10,MRANDOM(-10,10)/10,MRANDOM(-10,10)/10)) * ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				CHUNK.Velocity = VT(MRANDOM(-35,35),MRANDOM(20,55),MRANDOM(-35,35))
				CHUNK.RotVelocity = VT(MRANDOM(-15,15),MRANDOM(-15,15),MRANDOM(-15,15))
				CHUNK.Parent = GOREFOLDER
				Debris:AddItem(CHUNK,14)
				if g <= 8 then
					local TRAILB = IT("ParticleEmitter",CHUNK)
					TRAILB.Color = ColorSequence.new(C3(0.5,0,0))
					TRAILB.Size = NumberSequence.new(0.4)
					TRAILB.Transparency = NumberSequence.new(0,1)
					TRAILB.Lifetime = NumberRange.new(0.4,0.8)
					TRAILB.Rate = 40
					TRAILB.Speed = NumberRange.new(0,2)
				end
				local USED = false
				CHUNK.Touched:Connect(function(HIT)
					if USED then return end
					if HIT:IsDescendantOf(CHARACTER) or HIT:IsDescendantOf(GOREFOLDER) or HIT:IsDescendantOf(CHILD) then return end
					USED = true
					local H,POS,NOR = Raycast(CHUNK.Position + VT(0,1,0), VT(0,-1,0), 4, IGN)
					if H then WorldSplat(POS, NOR, MRANDOM(10,25)/10, 30) end
				end)
			end
			-- jet de sang
			pcall(function()
				local SPRAY = IT("ParticleEmitter",ROOT2)
				SPRAY.Color = ColorSequence.new(C3(0.5,0,0),C3(0.25,0,0))
				SPRAY.Size = NumberSequence.new(0.6)
				SPRAY.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,0.5)})
				SPRAY.Lifetime = NumberRange.new(1,2)
				SPRAY.Speed = NumberRange.new(20,45)
				SPRAY.Acceleration = VT(0,-60,0)
				SPRAY.SpreadAngle = Vector2.new(180,180)
				SPRAY.Rate = 0
				SPRAY:Emit(120)
				Debris:AddItem(SPRAY,3)
			end)
			for b = 1, 10 do
				OofOuchBlood(HED.Position,CF(HED.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,70)
			end
			-- sang sur les murs, le sol et grosse flaque
			for r = 1, 14 do
				local DIR = VT(MRANDOM(-100,100),MRANDOM(-60,100),MRANDOM(-100,100))
				if DIR.Magnitude > 1 then
					local H,POS,NOR = Raycast(ROOT2.Position, DIR.Unit, 30, IGN)
					if H then WorldSplat(POS, NOR, MRANDOM(15,45)/10, 30) end
				end
			end
			local HG,PG = Raycast(ROOT2.Position + VT(0,2,0), VT(0,-1,0), 40, IGN)
			if HG then BloodPool(PG, MRANDOM(35,55)/10) end
			NewSound({ID = 264486467,PARENT = ROOT2,VOLUME = 3,PITCH = 0.5,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			NewSound({ID = SOUND_SNAP,PARENT = ROOT2,VOLUME = 6,PITCH = 0.6,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			coroutine.resume(coroutine.create(function()
				for i = 1, 10 do
					SpawnPuddle(ROOT2.Position+VT(0,1,0),CHILD,false)
					Swait()
				end
			end))
		end

		local TAKEN = {}
		local function Victim(CHILD, HUMAN, ROOT2)
			TAKEN[CHILD] = true
			coroutine.resume(coroutine.create(function()
				local EXTRAS = {}
				pcall(function()
					local HOVER = ROOT2.Position
					local BASEROT = ROOT2.CFrame - ROOT2.Position
					local HED = CHILD:FindFirstChild("Head") or ROOT2
					local ORIGCOL = {}
					for _, PT in pairs(CHILD:GetDescendants()) do
						if PT:IsA("BasePart") then ORIGCOL[PT] = PT.Color end
					end
					-- veines de sang qui relient la victime a toi
					local AT0 = IT("Attachment",ROOT)
					local AT1 = IT("Attachment",ROOT2)
					table.insert(EXTRAS,AT0)
					table.insert(EXTRAS,AT1)
					for b = 1, 3 do
						local BM = IT("Beam")
						BM.Attachment0 = AT0
						BM.Attachment1 = AT1
						BM.Color = ColorSequence.new(C3(0.5,0,0))
						BM.Width0 = 0.35
						BM.Width1 = 0.2
						BM.Segments = 24
						BM.CurveSize0 = MRANDOM(-12,12)
						BM.CurveSize1 = MRANDOM(-12,12)
						BM.FaceCamera = true
						BM.LightEmission = 0.15
						BM.Transparency = NumberSequence.new(0.05)
						BM.Parent = AT0
						table.insert(EXTRAS,BM)
					end
					-- sang qui coule des yeux et de la bouche
					local LEAK = IT("ParticleEmitter",HED)
					LEAK.Color = ColorSequence.new(C3(0.5,0,0))
					LEAK.Size = NumberSequence.new(0.25)
					LEAK.Transparency = NumberSequence.new(0,1)
					LEAK.Lifetime = NumberRange.new(0.6,1.1)
					LEAK.Rate = 60
					LEAK.Speed = NumberRange.new(2,6)
					LEAK.Acceleration = VT(0,-40,0)
					LEAK.SpreadAngle = Vector2.new(35,35)
					table.insert(EXTRAS,LEAK)
					ROOT2.Anchored = true
					for f = 1, 54 do
						Swait()
						if not ROOT2.Parent then break end
						local K = f / 54
						ROOT2.CFrame = CF(HOVER + VT(MRANDOM(-10,10)/100*(1+K*3), f * 0.07 + MRANDOM(-10,10)/100*K, MRANDOM(-10,10)/100*(1+K*3))) * BASEROT * ANGLES(RAD(MRANDOM(-10,10)*(1+K*2)),RAD(MRANDOM(-10,10)*(1+K*2)),RAD(MRANDOM(-10,10)*(1+K*2)))
						-- la peau vire au rouge
						for PT, COL in pairs(ORIGCOL) do
							if PT.Parent then PT.Color = COL:Lerp(C3(0.4,0,0),K) end
						end
						if f % 5 == 0 then
							OofOuchBlood(ROOT2.Position,CF(ROOT2.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,10 + 20 * K)
						end
						if f % 9 == 0 then
							NewSound({ID = SOUND_SNAP,PARENT = ROOT2,VOLUME = 3,PITCH = 1.2 + MRANDOM(0,5)/10,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
						end
					end
					ROOT2.Anchored = false
				end)
				for _, X in pairs(EXTRAS) do
					pcall(function() X:Destroy() end)
				end
				Gore(CHILD, ROOT2)
			end))
		end

		local LASTSHAKE = -1
		local FRAME = 0
		for i=0, 1.75, 0.1 / ANIM_SPEED do
			FRAME = FRAME + 1
			local T = math.min(i / 1.2, 1)
			local EASE = 1 - (1 - T)^3
			local RADIUS = 1 + (RADIUSMAX - 1) * EASE + SIN(i * 60) * 0.5 * (1 - T)
			FIELD.Size = VT(RADIUS*2+1.5,RADIUS*2+1.5,RADIUS*2+1.5)
			SHELL.Size = VT(RADIUS*2,RADIUS*2,RADIUS*2)
			CORE.Size = VT(math.max(RADIUS*2-1,0.5),math.max(RADIUS*2-1,0.5),math.max(RADIUS*2-1,0.5))
			MIST.Size = VT(math.max(RADIUS*2-3,0.5),math.max(RADIUS*2-3,0.5),math.max(RADIUS*2-3,0.5))
			FIELD.CFrame = ROOT.CFrame
			SHELL.CFrame = ROOT.CFrame
			CORE.CFrame = ROOT.CFrame
			MIST.CFrame = ROOT.CFrame
			CORE.Transparency = 0.85 + 0.08 * SIN(i * 30)
			LIGHT.Brightness = 3 + SIN(i * 50)
			CC.TintColor = C3(1,1,1):Lerp(C3(1,0.5,0.5),T)
			CC.Contrast = 0.25 * T
			CC.Brightness = -0.05 * T
			BLUR.Size = 6 * T
			Atmos(T)
			if CAM then CAM.FieldOfView = LB.FOV + 7 * math.max(0, SIN(i * 14)) ^ 3 end
			if FLOOR(i * 10) ~= LASTSHAKE then
				LASTSHAKE = FLOOR(i * 10)
				CameraShake(ROOT.Position,RADIUS,6,30)
			end
			if FRAME % 2 == 0 and #SPLATS < 45 then AddSplat() end
			for _, SP in pairs(SPLATS) do
				SP.F.Position = SP.F.Position + UD2(0,0,0,SP.SPEED)
			end
			if MRANDOM(1,2) == 1 then
				local ANG = RAD(MRANDOM(0,359))
				local R = MRANDOM(0,100)/100 * RADIUS
				SpawnPuddle(ROOT.Position + VT(COS(ANG)*R,0.5,SIN(ANG)*R),CHARACTER,false)
			end
			for d = 1, 3 do
				local ANG = RAD(MRANDOM(0,359))
				local R = MRANDOM(0,100)/100 * RADIUS
				local DROP = IT("Part")
				DROP.Shape = Enum.PartType.Ball
				DROP.Size = VT(0.35,0.35,0.35) * (MRANDOM(5,12) / 10)
				DROP.Color = C3(MRANDOM(35,55)/100,0,0)
				DROP.Material = "SmoothPlastic"
				DROP.CanCollide = false
				DROP.Locked = true
				DROP.Position = ROOT.Position + VT(COS(ANG)*R, MRANDOM(10,30), SIN(ANG)*R)
				DROP.Velocity = VT(0,-MRANDOM(10,40),0)
				DROP.Parent = GOREFOLDER
				Debris:AddItem(DROP,2.5)
			end
			Swait()
			for _, CHILD in pairs(VICTIMS) do
				if CHILD and CHILD.Parent and not TAKEN[CHILD] then
					local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
					local ROOT2 = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
					if HUMAN and ROOT2 and (ROOT2.Position - ROOT.Position).Magnitude < RADIUS then
						Victim(CHILD, HUMAN, ROOT2)
					end
				end
			end
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.5 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-25+MRANDOM(-5,5)), RAD(5+MRANDOM(-5,5)), RAD(MRANDOM(-5,5))), 0.5 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
			HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(45+MRANDOM(-5,5)), RAD(-10+MRANDOM(-5,5)), RAD(-25+MRANDOM(-5,5))) * ANGLES(RAD(-75), RAD(0), RAD(0)) * LEFTSHOULDERC0, 0.5 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
		end
		if SPEAK then SPEAK.Enabled = false end
		-- la bulle eclate (les victimes en cours de levitation finissent leur explosion)
		MISTEMIT.Enabled = false
		RAINEMIT.Rate = 150
		for i = 1, 40 do
			Swait()
			local F = i / 40
			FIELD.Transparency = 0.35 + 0.65 * F
			SHELL.Transparency = 0.55 + 0.45 * F
			CORE.Transparency = 0.9 + 0.1 * F
			FIELD.Size = FIELD.Size + VT(1.2,1.2,1.2)
			SHELL.Size = SHELL.Size + VT(1.2,1.2,1.2)
			CC.TintColor = C3(1,0.5,0.5):Lerp(C3(1,1,1),F)
			CC.Contrast = 0.25 * (1 - F)
			CC.Brightness = -0.05 * (1 - F)
			BLUR.Size = 6 * (1 - F)
			Atmos(1 - F)
			if CAM then CAM.FieldOfView = LB.FOV end
			for _, SP in pairs(SPLATS) do
				SP.F.Position = SP.F.Position + UD2(0,0,0,SP.SPEED)
				SP.F.BackgroundTransparency = 0.2 + 0.8 * F
			end
		end
		FIELD:Destroy()
		SHELL:Destroy()
		CORE:Destroy()
		coroutine.resume(coroutine.create(function()
			for i = 1, 180 do Swait() end
			RAINEMIT.Enabled = false
			Debris:AddItem(MIST,3)
		end))
		CC:Destroy()
		BLUR:Destroy()
		SCREEN:Destroy()
		Debris:AddItem(FACE,1)
	end)
	if not OKX then
		warn("Goner Shriek: "..tostring(ERRX))
		Notify("G ERROR: "..tostring(ERRX))
	end
	-- on remet toujours l'ambiance d'origine, meme si ca a plante
	pcall(function()
		local L = game:GetService("Lighting")
		local LB = GONERLBACK
		if LB then
			L.Ambient = LB.Ambient
			L.OutdoorAmbient = LB.OutdoorAmbient
			L.Brightness = LB.Brightness
			L.FogColor = LB.FogColor
			L.FogStart = LB.FogStart
			L.FogEnd = LB.FogEnd
			if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = LB.FOV end
		end
		for _, N in pairs({"BloodTint","BloodBlur"}) do
			local X = L:FindFirstChild(N)
			if X then X:Destroy() end
		end
		local SG = PLAYER.PlayerGui:FindFirstChild("BloodScreen")
		if SG then SG:Destroy() end
	end)
	GONERLBACK = nil
	ATTACKING = false
	ROOT.Anchored = false
end

-- FIX: Speech ne touche plus a ATTACKING (ca pouvait bloquer toutes les attaques)
function Speech(INPUT)
	if INPUT == "t" then
		Speak(2316600989)
	elseif INPUT == "y" then
		Speak(2290634374)
	elseif INPUT == "u" then
		Speak(2291325961)
	end
end

-- FIX: si une attaque plante, on remet tout a zero au lieu de rester bloque
function SafeRun(FUNC, ...)
	local OK, ERR = pcall(FUNC, ...)
	if not OK then
		warn("Goner error: "..tostring(ERR)) Notify("ERROR: "..tostring(ERR))
		TRAIL.Enabled = false
		ROOT.Anchored = false
		ATTACKING = false
	end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not ATTACKING and not SUBMERGED then
        MOUSEHOLD = true
        SafeRun(Slash)
    elseif processed then
        return
    elseif input.KeyCode == Enum.KeyCode.E then
        KEYHOLD = true
        if ROOT:FindFirstChild("BGM_MUSIC") then
            ROOT:FindFirstChild("BGM_MUSIC"):Remove()
        else
            local M = NewSound({ID = 2598782592,PARENT = ROOT,VOLUME = 1.5,PITCH = 0.4,LOOP = true,MAXDISTANCE = 300,EMITTERSIZE = 300,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
            M.Name = "BGM_MUSIC"
        end
    elseif input.KeyCode == Enum.KeyCode.Z or input.KeyCode == Enum.KeyCode.X or input.KeyCode == Enum.KeyCode.C or input.KeyCode == Enum.KeyCode.V then
        Execute(input.KeyCode.Name:lower())
    elseif input.KeyCode == Enum.KeyCode.G and not SUBMERGED then
        Shriek()
    elseif input.KeyCode == Enum.KeyCode.Q then
        if not SUBMERGED then
            SUBMERGED = true
        else
            ROOT.Anchored = false
            SUBMERGED = false
            ROOT.CFrame = ROOT.CFrame * CF(0, 3, 0)
        end
    elseif input.KeyCode == Enum.KeyCode.T or input.KeyCode == Enum.KeyCode.Y or input.KeyCode == Enum.KeyCode.U then
        Speech(input.KeyCode.Name:lower())
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        MOUSEHOLD = false
    elseif input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D then
        KEYHOLD = false
    end
end)

local M = NewSound({ID = 2598782592,PARENT = ROOT,VOLUME = 1.5,PITCH = 0.4,LOOP = true,MAXDISTANCE = 300,EMITTERSIZE = 300,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
M.Name = "BGM_MUSIC"

HUM.HealthChanged:Connect(function()
	HUM.PlatformStand = false
	HUM.MaxHealth = 3000
	HUM.Health = 3000
	HUM.Name = PLAYER.UserId
end)
HUM.PlatformStand = false
HUM.MaxHealth = 3000
HUM.Health = 3000
HUM.Name = PLAYER.UserId
script.Parent = PLAYER.Backpack
local TWITCH = 0
while true do
	Swait()
	SINE = SINE + CHANGE
	if CHARACTER:FindFirstChild("Animate") then
		CHARACTER:FindFirstChild("Animate"):Destroy()
	end
	if CHARACTER:FindFirstChild("Sound") then
		CHARACTER:FindFirstChild("Sound"):Destroy()
	end
	for _,v in next, HUM:GetPlayingAnimationTracks() do
		v:Stop();
	end
	local TORSOVELOCITY = (ROOT.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = ROOT.Velocity.y
	local HITFLOOR,HITPOS = Raycast(ROOT.Position, (CF(ROOT.Position, ROOT.Position + VT(0, -1, 0))).lookVector, 4+HUM.HipHeight, CHARACTER)
	local WALKSPEEDVALUE = 10
	local SITTING = HUM.Sit
	if ANIM == "Walk" and TORSOVELOCITY > 1 and ATTACKING == false and SITTING == false then
		ROOTJOINT.C1 = Clerp(ROOTJOINT.C1, ROOTC0 * CF(0, 0, -0.015 * COS(SINE / (WALKSPEEDVALUE / 2))) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 * (HUM.WalkSpeed / 16) / ANIM_SPEED)
		NECK.C1 = Clerp(NECK.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - HEAD.RotVelocity.Y / 30), 0.2 * (HUM.WalkSpeed / 16) / ANIM_SPEED)
		RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 0.875 - 0.3 * SIN(SINE / WALKSPEEDVALUE), -0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(35 * COS(SINE / WALKSPEEDVALUE))), 0.6 / ANIM_SPEED)
		LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 0.875 + 0.3 * SIN(SINE / WALKSPEEDVALUE), 0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ -0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(35 * COS(SINE / WALKSPEEDVALUE))), 0.6 / ANIM_SPEED)
	elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) or ATTACKING == true or SITTING == true then
		ROOTJOINT.C1 = Clerp(ROOTJOINT.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		NECK.C1 = Clerp(NECK.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
	end
	if SITTING == false then
		if HITFLOOR then
			if SUBMERGED == false then
				HUM.JumpPower = 50
				HUM.WalkSpeed = 8
				if TORSOVELOCITY < 1 and HITFLOOR ~= nil then
					ANIM = "Idle"
					if MRANDOM(1,15) == 1 and ATTACKING == false then
						SpawnPuddle(HITPOS+VT(0,0.5,0),CHARACTER,true)
					end
					if ATTACKING == false then
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 0.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 0.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
					end
				elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
					ANIM = "Walk"
					if MRANDOM(1,5) == 1 and ATTACKING == false then
						SpawnPuddle(HITPOS+VT(0,0.5,0),CHARACTER,true)
					end
					if ATTACKING == false then
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.05) * ANGLES(RAD(5), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 1 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5-0.015 * COS(SINE / (WALKSPEEDVALUE / 2)), 0) * ANGLES(RAD(25), RAD(20), RAD(5)) * RIGHTSHOULDERC0, 0.75 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(5)), 0.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.45, 0.5-0.015 * SIN(SINE / (WALKSPEEDVALUE / 2)), -0.5) * ANGLES(RAD(95), RAD(-5), RAD(-5)) * LEFTSHOULDERC0, 0.75 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(-15)), 2 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(15)), 2 / ANIM_SPEED)
					end
				end
			elseif SUBMERGED == true then
				HUM.JumpPower = 0
				HUM.WalkSpeed = 0
				MOUSEPOS = Mouse.Hit.Position
				if MRANDOM(1,2) == 1 then
					SpawnPuddle(HITPOS+VT(0,0.5,0),CHARACTER,true)
				end
				ANIM = "Submerged"
				ROOT.Anchored = true
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1.5) * ANGLES(RAD(90), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 0.75 / ANIM_SPEED)
					HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(90)), 0.5 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 0.75 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / ANIM_SPEED)
				end
				if ATTACKING == false and not UserInputService:GetFocusedTextBox() then
					local MV = VT(0,0,0)
					if UserInputService:IsKeyDown(Enum.KeyCode.W) then MV = MV + VT(0,0,-0.6) end
					if UserInputService:IsKeyDown(Enum.KeyCode.S) then MV = MV + VT(0,0,0.35) end
					if UserInputService:IsKeyDown(Enum.KeyCode.A) then MV = MV + VT(-0.4,0,0) end
					if UserInputService:IsKeyDown(Enum.KeyCode.D) then MV = MV + VT(0.4,0,0) end
					if MV.Magnitude > 0 then
						local FACING = CF(ROOT.Position, VT(MOUSEPOS.X, ROOT.Position.Y, MOUSEPOS.Z))
						local NEWPOS = (FACING * CF(MV)).p
						local H2, P2 = Raycast(NEWPOS + VT(0,3,0), VT(0,-1,0), 10, CHARACTER)
						if H2 then HITPOS = P2 end
						ROOT.CFrame = CF(VT(NEWPOS.X, HITPOS.Y + 0.05, NEWPOS.Z), VT(MOUSEPOS.X, HITPOS.Y + 0.05, MOUSEPOS.Z))
						HITPOS = VT(NEWPOS.X, HITPOS.Y, NEWPOS.Z)
					end
				end
				ROOT.CFrame = CF(HITPOS+VT(0,0.05,0))*ANGLES(0,RAD(ROOT.Orientation.Y),0)
			end
		else
			SUBMERGED = false
			ANIM = "Midair"
			if ATTACKING == false then
				ROOT.Anchored = false
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(20), RAD(0), RAD(0)), 1 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 1 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1 / ANIM_SPEED)
			end
		end
	else
		SUBMERGED = false
		ANIM = "Sit"
		if ATTACKING == false then
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.5) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.65, 0) * ANGLES(RAD(50), RAD(10), RAD(-45))*CF(0,-0.25,0) * RIGHTSHOULDERC0, 1.25 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.65, 0) * ANGLES(RAD(50), RAD(-10), RAD(45))*CF(0,-0.25,0) * LEFTSHOULDERC0, 1.25 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.25, -1) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.25 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -0.25, -1) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.25 / ANIM_SPEED)
		end
	end
	if TWITCH > 0 then
		TWITCH = TWITCH - 1
		NECK.C0 = NECK.C0 * ANGLES(RAD(MRANDOM(-5,5)), RAD(MRANDOM(-5,5)), RAD(MRANDOM(-5,5)))
	else
		if MRANDOM(1,25) == 1 then
			TWITCH = MRANDOM(2,12)
		end
	end
end
