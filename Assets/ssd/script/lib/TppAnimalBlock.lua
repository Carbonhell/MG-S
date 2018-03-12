local e={}local l=ScriptBlock.GetCurrentScriptBlockId
local a=ScriptBlock.GetScriptBlockState
local r=GameObject.NULL_ID
local o=Tpp.IsTypeTable
local c=Tpp.IsTypeString
e.HERBIVORE_BLOCK_GROUP_NAME="herbivore_block"e.CARNIVORE_BLOCK_GROUP_NAME="carnivore_block"e.ANIMAL_BLOCK_GROUP_NAMES={e.HERBIVORE_BLOCK_GROUP_NAME,e.CARNIVORE_BLOCK_GROUP_NAME}local i=Tpp.CheckBlockArea
local a={Goat={type="SsdGoat",locatorFormat="anml_goat_%04d",routeFormat="rt_anml_goat_%04d",isHerd=true,isDead=false},Sheep={type="SsdSheep",locatorFormat="anml_sheep_%04d",routeFormat="rt_anml_sheep_%04d",isHerd=true,isDead=false},Wolf={type="SsdWolf",locatorFormat="anml_wolf_%04d",routeFormat="rt_anml_wolf_%04d",isHerd=true,isDead=false},Nubian={type="SsdNubian",locatorFormat="anml_nubian_%04d",routeFormat="rt_anml_nubian_%04d",isHerd=true,isDead=false},Jackal={type="SsdJackal",locatorFormat="anml_jackal_%04d",routeFormat="rt_anml_jackal_%04d",isHerd=true,isDead=false},Zebra={type="SsdZebra",locatorFormat="anml_Zebra_%04d",routeFormat="rt_anml_Zebra_%04d",isHerd=true,isDead=false},Bear={type="SsdBear",locatorFormat="anml_bear_%04d",routeFormat="rt_anml_bear_%04d",isHerd=false,isDead=false},Rat={type="TppRat",locatorFormat="anml_rat_%04d",routeFormat="rt_anml_rat_%04d",isHerd=false,isDead=false},NoAnimal={type="NoAnimal",locatorFormat="anml_NoAnimal_%04d",routeFormat="rt_anml_BuddyPuppy_%04d",isHerd=false,isDead=false}}function e.InitializeBlockStatus()mvars.animalBlockNameList={}mvars.animalBlockKeyNames={}mvars.animalBlockLoadSetting={}mvars.animalBlockScript={}for e,a in ipairs(e.ANIMAL_BLOCK_GROUP_NAMES)do
local e=ScriptBlock.GetScriptBlockId(a)if e~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
TppScriptBlock.ClearSavedScriptBlockInfo(e)mvars.animalBlockNameList[e]=a
mvars.animalBlockScript[e]=nil
end
end
end
function e.OnMessage(i,o,r,a,t,n,l)if not mvars.animalBlockScript or not next(mvars.animalBlockScript)then
return
end
for c,e in ipairs(e.ANIMAL_BLOCK_GROUP_NAMES)do
local e=ScriptBlock.GetScriptBlockId(e)if e~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID and mvars.animalBlockScript[e]then
mvars.animalBlockScript[e].OnMessage(i,o,r,a,t,n,l)end
end
end
function e.OnReload()if not mvars.loc_locationAnimalSettingTable or not mvars.animalBlockNameList then
return
end
local a=mvars.loc_locationAnimalSettingTable
for t,a in ipairs(e.ANIMAL_BLOCK_GROUP_NAMES)do
local a=ScriptBlock.GetScriptBlockId(a)e._MakeMessageExecTable(a)end
end
function e.OnAllocate(a)local e=l()TppScriptBlock.InitScriptBlockState(e)mvars.animalBlockScript[e]=a
mvars.animalBlockScript[e].OnMessage=function(e,e,e,e,e,e,e)end
end
function e.OnInitializeAnimalBlock()coroutine.yield()coroutine.yield()if not mvars.animalBlockNameList then
return
end
local a=l()local t=mvars.animalBlockNameList[a]if not t then
return
end
local n,t=Tpp.GetCurrentStageSmallBlockIndex()e._UpdateActiveAnimalBlock(n,t)mvars.animalBlockScript[a].DidInitialized=true
mvars.animalBlockScript[a].Messages=Tpp.StrCode32Table{Block={{msg="StageBlockCurrentSmallBlockIndexUpdated",func=function(a,t)e._UpdateActiveAnimalBlock(a,t)end,option={isExecFastTravel=true}},{msg="OnScriptBlockStateTransition",func=function(n,t)for l,a in ipairs(e.ANIMAL_BLOCK_GROUP_NAMES)do
if n==Fox.StrCode32(a)then
if t==ScriptBlock.TRANSITION_ACTIVATED then
e._OnActivateScriptBlock(a)end
end
end
end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}}}}mvars.animalBlockScript[a].OnReload=e.OnReload
mvars.animalBlockScript[a].OnMessage=function(l,n,t,c,o,r,i)Tpp.DoMessage(mvars.animalBlockScript[a].messageExecTable,TppMission.CheckMessageOption,l,n,t,c,o,r,i)end
e._MakeMessageExecTable(a)end
function e.OnTerminate()local e=l()TppScriptBlock.FinalizeScriptBlockState(e)mvars.animalBlockScript[e].DidInitialized=nil
mvars.animalBlockScript[e].OnReload=nil
mvars.animalBlockScript[e].OnMessage=nil
mvars.animalBlockScript[e]=nil
end
function e.UpdateLoadAnimalBlock(l,o)if mvars.anm_stopAnimalBlockLoad then
return
end
local t=mvars
local a=t.loc_locationAnimalSettingTable
local a=a.animalAreaSetting
local n=e._GetAnimalBlockAreaSetting(a,"loadArea",l,o)if not n or not next(n)then
for n,a in ipairs(e.ANIMAL_BLOCK_GROUP_NAMES)do
if t.animalBlockKeyNames[a]then
TppScriptBlock.Unload(a)e.ClearKeyName(a)end
end
return
end
for r,a in ipairs(e.ANIMAL_BLOCK_GROUP_NAMES)do
local n=n[a]if n then
local e=n.loadKeyName
local r=ScriptBlock.GetScriptBlockId(a)if r==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
else
local r=t.animalBlockKeyNames[a]if r~=e then
t.animalBlockKeyNames[a]=e
t.animalBlockLoadSetting[a]=n
local t=false
if i(n.activeArea,l,o)then
t=true
end
TppScriptBlock.Load(a,e,t)end
end
else
if t.animalBlockKeyNames[a]then
TppScriptBlock.Unload(a)e.ClearKeyName(a)end
end
end
end
function e.StopAnimalBlockLoad()mvars.anm_stopAnimalBlockLoad=true
end
function e.ClearKeyName(e)mvars.animalBlockKeyNames[e]=nil
mvars.animalBlockLoadSetting[e]=nil
end
function e._OnActivateScriptBlock(a)e._UpdateAnimalSetting(a)end
function e._UpdateActiveAnimalBlock(l,o)for t,a in ipairs(e.ANIMAL_BLOCK_GROUP_NAMES)do
if mvars.animalBlockKeyNames[a]then
local t=ScriptBlock.GetScriptBlockId(a)if t~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
local n=mvars.animalBlockLoadSetting[a]if i(n.activeArea,l,o)then
TppScriptBlock.ActivateScriptBlockState(t)else
if e._GetAnimalBlockState(a)==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
TppScriptBlock.DeactivateScriptBlockState(t)end
end
end
end
end
end
function e._UpdateAnimalSetting(t)local a=mvars.loc_locationAnimalSettingTable
if not a then
return
end
local a=a.animalTypeSetting[mvars.animalBlockKeyNames[t]]if a and next(a)then
for l,t in pairs(a)do
local a
local n
if c(t)then
a=t
elseif o(t)then
a=l
n=t
end
local t=e._GetSetupTable(a)if t~=nil and a~="NoAnimal"then
e._InitializeCommonAnimalSetting(a,n,t)end
end
end
end
function e._GetAnimalBlockAreaSetting(a,n,l,t)local e=a
local e={}for o,a in ipairs(a)do
local n=a[n]if i(n,l,t)then
for t,n in ipairs(a.defines)do
if(not Tpp.IsTypeFunc(n.conditionFunc))or(n.conditionFunc())then
local t=a.blockName
e[t]={}e[t].loadKeyName=n.keyName
e[t].areaName=a.areaName
e[t].loadArea=a.loadArea
e[t].activeArea=a.activeArea
break
end
end
end
end
return e
end
function e._GetSetupTable(e)if e=="Goat"then
return a.Goat
elseif e=="Sheep"then
return a.Sheep
elseif e=="Wolf"then
return a.Wolf
elseif e=="Bear"then
return a.Bear
elseif e=="Nubian"then
return a.Nubian
elseif e=="Jackal"then
return a.Jackal
elseif e=="Zebra"then
return a.Zebra
elseif e=="Rat"then
return a.Rat
elseif e=="NoAnimal"then
return a.NoAnimal
else
return nil
end
end
function e._InitializeCommonAnimalSetting(n,t,a)local n=1
if o(t)then
n=t.groupNumber or 0
end
if a.isDead==false then
if a.isHerd==false then
for t=0,(n-1)do
e._SetRoute(a.type,a.locatorFormat,a.routeFormat,t)end
else
for t=0,(n-1)do
e._SetHerdRoute(a.type,a.locatorFormat,a.routeFormat,t)end
end
else
e._ChangeDeadState(a.type,t.position,t.degRotationY)end
end
function e._SetHerdRoute(e,t,n,a)local e={type=e,index=0}if e==r then
return
end
local t=string.format(t,a)local a=string.format(n,a)local a={id="SetHerdEnabledCommand",type="Route",name=t,instanceIndex=0,route=a}GameObject.SendCommand(e,a)end
function e._SetRoute(e,l,n,a)local t={type=e,index=0}if t==r then
return
end
local l=string.format(l,a)local n=string.format(n,a)local a
if e=="TppRat"then
a=0
end
local e={id="SetRoute",name=l,route=n,ratIndex=a}GameObject.SendCommand(t,e)end
function e._ChangeDeadState(e,a,t)local e={type=e,index=0}if e==r then
return
end
local a=a or Vector3(0,0,0)local t=t or 0
local a={id="ChangeDeadState",position=a,degRotationY=t}GameObject.SendCommand(e,a)end
function e._ChangeRouteAtTime(t,a)local a=l()local a=mvars.animalBlockNameList[a]local n=mvars.loc_locationAnimalSettingTable
local a=n.animalTypeSetting[mvars.animalBlockKeyNames[a]]local n=-1
for e in string.gmatch(t,"%d+")do
n=tonumber(e)end
if n==-1 then
return
end
if not a then
return
end
local t=0
local l=nil
local r=nil
for d,e in pairs(a)do
local i
local a
if c(e)then
i=e
elseif o(e)then
i=d
a=e
end
local e=a.groupNumber or 0
if t<=n and n<t+e then
l=i
r=a
break
end
t=t+e
end
if l==nil or r==nil then
return
end
local a=e._GetSetupTable(l)if a==nil then
return
end
local t=n-t
if l=="Bear"then
e._SetRoute(a.type,a.locatorFormat,a.routeFormat,t)else
e._SetHerdRoute(a.type,a.locatorFormat,a.routeFormat,t)end
end
function e._MakeMessageExecTable(e)if mvars.animalBlockScript[e]then
mvars.animalBlockScript[e].messageExecTable=Tpp.MakeMessageExecTable(mvars.animalBlockScript[e].Messages)end
end
function e._GetAnimalBlockState(e)local e=ScriptBlock.GetScriptBlockId(e)if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
return
end
return ScriptBlock.GetScriptBlockState(e)end
function e.OnActivateAnimalBlock(e)end
if(Tpp.IsQARelease()or nil)then
function e.QARELEASE_DEBUG_Init()local e
if DebugMenu then
e=DebugMenu
else
return
end
mvars.qaDebug.showCurrentAnimal=false
e.AddDebugMenu("LuaAnimal","showCurrentAnimal","bool",mvars.qaDebug,"showCurrentAnimal")end
function e.QAReleaseDebugUpdate()local l=mvars
local a=DebugText.Print
local t=DebugText.NewContext()if l.qaDebug.showCurrentAnimal then
a(t,{.5,.5,1},"LuaAnimal showCurrentAnimal")for o,n in ipairs(e.ANIMAL_BLOCK_GROUP_NAMES)do
a(t,"BLOCK NAME : "..tostring(n))a(t,"Current Key Name : "..tostring(l.animalBlockKeyNames[n]))local n=e._GetAnimalBlockState(n)local e={}e[ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY]="EMPTY"e[ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING]="PROCESSING"e[ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE]="INACTIVE"e[ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE]="ACTIVE"a(t,"Animal block state : "..tostring(e[n]))a(t,"")end
end
end
end
return e