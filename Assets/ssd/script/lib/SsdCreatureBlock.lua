local e={}local n="creature_block"local o=ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
local i=ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
local a=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE
local l=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
local c={}function e.OnAllocate(e)end
function e.Init(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())e.InitMVars()e.InitializeInfoList()end
function e.OnReload(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())e.InitMVars()e.InitializeInfoList()end
function e.OnUpdate()local n=e.GetBlockState()if not n then
return
end
local t=mvars.crb_requestedLoad
local r=mvars.crb_requestedUnload
if not t and not r then
return
end
if t then
if n==a or n==l then
local n,t=Tpp.GetCurrentStageSmallBlockIndex()e.OnUpdateSmallBlockIndex(n,t)mvars.crb_requestedLoad=false
Mission.SendMessage("Mission","OnEndLoadingCreatureBlock",mvars.crb_currentInfoName)end
elseif r then
if n==o then
mvars.crb_requestedUnload=false
end
end
end
function e.Messages()return Tpp.StrCode32Table{Block={{msg="StageBlockCurrentSmallBlockIndexUpdated",func=e.OnUpdateSmallBlockIndex,option={isExecFastTravel=true}},{msg="OnScriptBlockStateTransition",func=function(t,e)if t==Fox.StrCode32(n)then
if e==ScriptBlock.TRANSITION_ACTIVATED then
local e
for t,n in ipairs(mvars.crb_loadableInfoList)do
local n=n.infoList
if n then
for t,n in ipairs(n)do
local t=n.name
if t==mvars.crb_currentInfoName then
e=n
end
end
end
end
if e then
local n=e.enemyTypeTable or nil
local t=e.enemyLevel or 0
local r=e.enemyLevelRandomRange or 0
local e=e.isSequenceEnemyLevel or false
TppEnemy.SetEnemyLevelCreatureBlock(n,t,r,e)end
end
end
end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}}}}end
function e.OnMessage(r,o,l,c,a,n,t)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,r,o,l,c,a,n,t)end
function e.InitializeBlockStatus()local e=ScriptBlock.GetScriptBlockId(n)if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
return
end
TppScriptBlock.ClearSavedScriptBlockInfo(e)end
function e.InitializeInfoList()mvars.crb_loadableInfoList={}local t={}local a=vars.locationCode
local r=SsdCreatureList.CREATURE_BLOCK_INFO_LIST
c={}for r,n in ipairs(r)do
if n.locationId==a then
table.insert(mvars.crb_loadableInfoList,n)for n,r in ipairs(n.infoList)do
local n=r.name
t[n]={}for r,e in ipairs(r.pack)do
table.insert(t[n],e)end
local r=r.npcs
if r~=nil then
c[n]=r
local e=e.GetNpcPackagePathList(r)if e then
for r,e in ipairs(e)do
table.insert(t[n],e)end
end
end
end
end
end
TppScriptBlock.RegisterCommonBlockPackList(n,t)end
function e.InitializeLoad()local n=e.GetBlockState()if not n then
return
end
local t,n=Tpp.GetCurrentStageSmallBlockIndex()e.OnUpdateSmallBlockIndex(t,n)end
function e.GetCurrentInfoName()return mvars.crb_currentInfoName
end
function e.InitMVars()mvars.crb_currentInfoName=nil
mvars.crb_currentInfo=nil
mvars.crb_requestedLoad=false
mvars.crb_requestedUnload=false
end
function e.GetBlockState()local e=ScriptBlock.GetScriptBlockId(n)if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
return
end
return ScriptBlock.GetScriptBlockState(e)end
function e.Load(r)local t=c[r]if t then
e.AssignNpcInfosToGameObjectType(t)end
local e=TppScriptBlock.Load(n,r)if e==false then
end
mvars.crb_requestedLoad=true
return e
end
function e.Unload()TppScriptBlock.Unload(n)mvars.crb_currentInfoName=nil
mvars.crb_currentInfo=nil
mvars.crb_requestedUnload=true
end
function e.ActivateBlock()local e=ScriptBlock.GetScriptBlockId(n)TppScriptBlock.ActivateScriptBlockState(e)end
function e.DeactivateBlock()local e=ScriptBlock.GetScriptBlockId(n)TppScriptBlock.DeactivateScriptBlockState(e)end
function e.OnUpdateSmallBlockIndex(r,t)local n=e.GetBlockState()if not n then
return
end
if(n==o)then
e.UpdateBlockStateAtNotLoaded(r,t)elseif(n==i)then
elseif(n==a)then
e.UpdateBlockStateAtInactive(r,t)elseif(n==l)then
e.UpdateBlockStateAtActive(r,t)end
end
function e.UpdateBlockStateAtNotLoaded(r,t)local n=mvars.crb_loadableInfoList
if not n then
return
end
if not Tpp.IsTypeTable(n)or not next(n)then
return
end
local n=e.SearchProperInfo("loadArea",r,t)if not n then
return
end
local e=e.Load(n)if e==false then
mvars.crb_currentInfoName=nil
mvars.crb_currentInfo=nil
end
end
function e.UpdateBlockStateAtInactive(t,r)local n=mvars.crb_currentInfo
if not n then
e.Unload()return
end
if mvars.crb_requestedUnload then
return
end
if not e.IsInsideArea("loadArea",n,t,r)then
e.Unload()return
end
if e.IsInsideArea("activeArea",n,t,r)then
e.ActivateBlock()end
end
function e.UpdateBlockStateAtActive(t,r)local n=mvars.crb_currentInfo
if not n then
e.Unload()return
end
if mvars.crb_requestedUnload then
return
end
if not e.IsInsideArea("loadArea",n,t,r)then
e.Unload()return
end
if not e.IsInsideArea("activeArea",n,t,r)then
e.DeactivateBlock()end
end
function e.SearchProperInfo(r,t,a)local n=mvars.crb_loadableInfoList
for o,n in ipairs(n)do
if e.IsInsideArea(r,n,t,a)then
for t,e in ipairs(n.infoList)do
if e.loadCondition and e.loadCondition()then
mvars.crb_currentInfoName=e.name
mvars.crb_currentInfo=n
return e.name
end
end
end
end
end
function e.IsInsideArea(t,e,n,r)if not e then
return
end
local e=e[t]if e==nil then
return
end
return Tpp.CheckBlockArea(e,n,r)end
function e.AssignNpcInfosToGameObjectType(e)for n,e in ipairs(e)do
SsdNpc.AssignInfosToGameObjectType{gameObjectType=e[1],npcType=e[2],partsType=e[3]}end
end
function e.GetNpcPackagePathList(n)local e={}for t,n in ipairs(n)do
local n=SsdNpc.GetGameObjectPackFilePathsFromPartsType{partsType=n[3]}for t,n in ipairs(n)do
table.insert(e,n)end
end
return e
end
function e.QARELEASE_DEBUG_Init()local e
if DebugMenu then
e=DebugMenu
else
return
end
mvars.qaDebug.showCurrentCrbState=false
e.AddDebugMenu("CreatureBlock","showCurrentState","bool",mvars.qaDebug,"showCurrentCrbState")end
function e.QAReleaseDebugUpdate()local t=DebugText.Print
local n=DebugText.NewContext()if mvars.qaDebug.showCurrentCrbState then
t(n,"")t(n,{.5,.5,1},"CreatureBlock")local r=e.GetBlockState()if r==nil then
t(n,"Block State : CreatureBlock isn't found...")return
end
local e={}e[o]="EMPTY"e[i]="PROCESSING"e[a]="INACTIVE"e[l]="ACTIVE"t(n,"Block State : "..tostring(e[r]))t(n,"Reqessted Load   : "..tostring(mvars.crb_requestedLoad))t(n,"Requested Unload : "..tostring(mvars.crb_requestedUnload))if mvars.crb_currentInfoName and mvars.crb_currentInfo then
t(n,"Loaded Info : "..tostring(mvars.crb_currentInfoName))for e,r in ipairs(mvars.crb_currentInfo.infoList)do
if r.name==mvars.crb_currentInfoName then
local e=1
for a,r in ipairs(r.pack)do
t(n,"Loaded Pack["..(tostring(e)..("] : "..tostring(r))))e=e+1
end
break
end
end
local e,r=Tpp.GetCurrentStageSmallBlockIndex()t(n,"CurrentBlock : ("..(tostring(e)..(", "..(tostring(r)..")"))))local e=mvars.crb_currentInfo.loadArea
t(n,"LoadArea   : ("..(tostring(e[1])..(", "..(tostring(e[2])..(")/("..(tostring(e[3])..(", "..(tostring(e[4])..")"))))))))e=mvars.crb_currentInfo.activeArea
t(n,"ActiveArea : ("..(tostring(e[1])..(", "..(tostring(e[2])..(")/("..(tostring(e[3])..(", "..(tostring(e[4])..")"))))))))end
end
end
return e