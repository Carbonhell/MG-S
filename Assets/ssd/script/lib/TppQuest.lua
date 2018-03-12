local e={}local q=256
local p=0
local Q=0
local t="quest_block"local c="QStep_Clear"local t=Fox.StrCode32
local T=Tpp.StrCode32Table
local o=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local m=Tpp.IsTypeString
local _=Tpp.IsTypeNumber
local u=TppDefine.Enum{"NONE","DEACTIVATE","DEACTIVATING","ACTIVATE"}local l=TppDefine.Enum{"OPEN","CLEAR","FAILURE","UPDATE"}local n=TppDefine.QUEST_BLOCK_TYPE_DEFINE
local r=TppDefine.QUEST_BLOCK_TYPE_INDEX
local a=#r
local i=ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
local h=ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
local f=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE
local d=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
local v={}local S={}function e.RegisterQuestPackList(e)if TppMission.IsMultiPlayMission(vars.missionCode)then
return
end
mvars.qst_questPackList=nil
if not t(e)then
return
end
if not next(e)then
return
end
mvars.qst_questPackList=e
end
function e.RegisterQuestList(s)if TppMission.IsMultiPlayMission(vars.missionCode)then
return
end
if not t(s)then
return
end
if not mvars.qst_questPackList then
return
end
local r=#s
if r==0 then
return
end
local a={}for n=1,r do
if not t(s[n])then
return
end
local r=s[n].infoList
if not t(r)then
Tpp.DEBUG_DumpTable(s,2)return
end
if#r==0 then
return
end
if not _(s[n].locationId)then
return
end
if not t(s[n].loadArea)then
return
end
if not m(s[n].blockType)then
return
end
if not m(s[n].areaName)then
return
end
mvars.qst_isLockedArea[s[n].areaName]=false
local t=s[n].blockType
if a[t]==nil then
a[t]={}end
for s,n in ipairs(r)do
if not m(n.name)then
return
end
if not m(n.invokeStepName)then
return
end
e.AddPackList(a[t],n.name)end
end
for e=1,#n do
local e=n[e]if a[e]then
TppScriptBlock.RegisterCommonBlockPackList(e,a[e])end
end
mvars.qst_questList=s
end
function e.InitializeQuestActiveStatus()for t=1,#n do
e._InitializeQuestActiveStatus(n[t])end
end
function e.GetQuestBlockIndex(t)if not t then
return
end
for e=1,a do
if mvars.qst_currentQuestName[e]==t then
return e
end
end
end
function e.RegisterQuestInfo(n)if not n then
return
end
local t=e.GetQuestBlockIndex(n)if not t then
t=e.SearchBlockIndex(n)if not t then
return
end
end
e.ResetQuestStatus(t)e.SetCurrentQuestName(t,n)mvars.qst_currentQuestTable[t]=e.GetQuestTable(t,n)return t
end
function e.RegisterQuestStepList(n,e)if not t(e)then
return
end
local t=#e
if t==0 then
return
end
if t>=q then
return
end
if not n then
return
end
table.insert(e,c)mvars.qst_questStepList[n]=Tpp.Enum(e)end
function e.RegisterQuestStepTable(n,e)if not t(e)then
return
end
e[c]={}mvars.qst_questStepTable[n]=e
end
function e.RegisterQuestSystemCallbacks(e,n)if not t(n)then
return
end
mvars.qst_systemCallbacks[e]=mvars.qst_systemCallbacks[e]or{}local function s(n,t)if o(n[t])then
mvars.qst_systemCallbacks[e][t]=n[t]end
end
local e={"OnActivate","OnOutOfAcitveArea","OnDeactivate","OnTerminate"}for t=1,#e do
s(n,e[t])end
end
function e.OnUpdate()for s=1,a do
local n=n[s]local t=e.GetQuestBlockState(n)if t then
e.UpdateChangeQuest(s,n,t)e.UpdateWatchingQuest(s,n,t)end
end
end
function e.OnDeactivate(e)end
function e.QuestBlockOnInitialize(s)local t=s.questBlockIndex
if not t then
local n=s.questName
if n then
t=e.SearchBlockIndex(n)end
if not t then
return
else
e.ResetQuestStatus(t)e.SetCurrentQuestName(t,n)mvars.qst_currentQuestTable[t]=e.GetQuestTable(t,n)end
end
local n=s.Messages
if o(n)then
local e=n()mvars.qst_questScriptMsgExecTable[t]=Tpp.MakeMessageExecTable(e)end
e.MakeQuestStepMessageExecTable(t)mvars.qst_isRadioTarget[t]=false
end
function e.QuestBlockOnUpdate(t)local t=t.questBlockIndex
if not t or t==0 then
return
end
local e=e
local a=n[t]local r=e.GetQuestBlockState(a)if r==nil then
return
end
local n=mvars
local l=n.qst_lastQuestBlockState[t]if n.qst_requestInitActiveStatus[t]then
e._InitializeQuestActiveStatus(a)return
end
local s=ScriptBlock
local i=f
local s=d
if r==i then
if l==s then
e._DoDeactivate(t)end
if n.qst_blockStateRequest[t]~=u.DEACTIVATE then
if e._CanActivateQuest()then
e.ActivateCurrentQuestBlock(a)e.ClearBlockStateRequest(t)end
else
e._DoDeactivate(t)end
n.qst_lastInactiveToActive[t]=false
elseif r==s then
if not e._CanActivateQuest()then
return
end
if not e.IsInvokingImpl(t)then
e.Invoke(a)return
end
local s=t-1
local s=e.GetQuestStepTable(t,gvars.qst_currentQuestStepNumber[s])if(not l)or l<=i then
n.qst_lastInactiveToActive[t]=true
end
if n.qst_lastInactiveToActive[t]then
n.qst_lastInactiveToActive[t]=false
e.ExecuteSystemCallback(t,"OnActivate")n.qst_allocated[t]=true
if s and o(s.OnEnter)then
s.OnEnter(s)end
end
if s and o(s.OnUpdate)then
s.OnUpdate(urrentStepTable)end
if n.qst_blockStateRequest[t]==u.DEACTIVATE then
e.DeactivateCurrentQuestBlock(a)e.ClearBlockStateRequest(t)end
else
n.qst_lastInactiveToActive[t]=false
e.ClearBlockStateRequest(t)end
n.qst_lastQuestBlockState[t]=r
end
function e.QuestBlockOnTerminate(t)local t=t.questBlockIndex
if not t then
return
end
if mvars.qst_reserveEnd[t]then
local t=mvars.qst_currentQuestName[t]if t then
local n=e.IsCleard(t)if(not n)or(n and e.IsRepop(t))then
e.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.FAILURE,t)end
end
end
e.ExecuteSystemCallback(t,"OnTerminate")mvars.qst_systemCallbacks[t]=nil
mvars.qst_questStepList[t]=nil
mvars.qst_questStepTable[t]=nil
mvars.qst_currentQuestTable[t]=nil
mvars.qst_isRadioTarget[t]=false
mvars.qst_lastQuestBlockState[t]=nil
mvars.qst_reserveEnd[t]=false
mvars.qst_isWatchingDefenseFlag[t]=false
gvars.qst_currentQuestStepNumber[t-1]=p
e.ClearCurrentQuestName(t)local e=n[t]local e=ScriptBlock.GetScriptBlockId(e)TppScriptBlock.FinalizeScriptBlockState(e)end
function e.SetNextQuestStep(t,s)if not t or t==0 then
return
end
if not mvars.qst_questStepTable[t]then
return
end
if not mvars.qst_questStepList[t]then
return
end
local n=mvars.qst_questStepTable[t]local a=mvars.qst_questStepList[t]local n=n[s]local s=a[s]if n==nil then
return
end
if s==nil then
return
end
local a=t-1
if e.IsInvokingImpl(t)then
local e=e.GetQuestStepTable(t,gvars.qst_currentQuestStepNumber[a])local t=e.OnLeave
if o(t)then
t(e)end
end
gvars.qst_currentQuestStepNumber[a]=s
if mvars.qst_allocated[t]then
local e=n.OnEnter
if o(e)then
e(n)end
end
end
function e.ClearWithSave(n,t)if not t then
return
end
local s=e.GetQuestIndex(t)if n==TppDefine.QUEST_CLEAR_TYPE.CLEAR then
e.AddStaffsFromTempBuffer()e.Clear(t)e.SetGimmickResourceValidity(t,false)e.Save()e.OpenWormhole("questEnd",t)e.OpenRewardCbox(t)e.GetNamePlate(t)elseif n==TppDefine.QUEST_CLEAR_TYPE.FAILURE then
e.AddStaffsFromTempBuffer()e.Failure(t)e.SetGimmickResourceValidity(t,false)e.Save()elseif n==TppDefine.QUEST_CLEAR_TYPE.UPDATE then
e.Update(t)end
end
function e.FadeOutAndDeativateQuestBlock(t)if not t then
for e=1,a do
mvars.qst_isRequestedDeactivate[e]=true
end
else
local e=e.GetQuestBlockIndex(t)if e~=nil and e>0 then
mvars.qst_isRequestedDeactivate[e]=true
end
end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeOutOnOutOfMissionArea",TppUI.FADE_PRIORITY.QUEST)end
function e.OnMissionGameEnd()for t=1,#n do
local n=n[t]local n=e.GetQuestBlockState(n)if n==d then
e._DoDeactivate(t)end
end
e.UpdateAllGimmickValidity(false)end
function e.UpdateActiveQuest(t)if not e.NeedUpdateActiveQuest(t)then
return
end
e.UpdateGimmickValidity(false)mvars.qst_loadableQuestNameList={}mvars.qst_openableQuestNameList={}mvars.qst_suspendedQuestNameList={}mvars.qst_acceptableQuestNameList={}e.UpdateQuestTimeCount()e.UpdateOpenQuest()for t=1,a do
e._UpdateActiveQuest(t)end
TppCrew.SetAcceptableQuestList(mvars.qst_acceptableQuestNameList)e.UpdateCloseQuest()e.UpdateOpenableQuest()e.UpdateLoadableQuestListForOtherLocation()e.UpdateTerminalDisplayQuest()e.UpdateGimmickValidity(true)end
function e.ShowAnnounceLogQuestOpen()if mvars.qst_isQuestNewOpenFlag==true then
mvars.qst_isQuestNewOpenFlag=false
e.ShowAnnounceLog(l.OPEN)end
end
function e.ClearAreaLock()if not mvars.qst_isLockedArea then
return
end
for e=1,#mvars.qst_isLockedArea do
mvars.qst_isLockedArea[e]=false
end
end
function e.StartWatchingOtherDefenseGame(e)if not e or e==0 then
return
end
mvars.qst_isWatchingDefenseFlag[e]=true
end
function e.StopWatchingOtherDefenseGame(e)if not e or e==0 then
return
end
mvars.qst_isWatchingDefenseFlag[e]=false
end
function e.RegisterSkipStartQuestDemo(e)mvars.qst_isSkipStartQuestDemo[e]=true
end
function e.UnregisterSkipStartQuestDemo()mvars.qst_isSkipStartQuestDemo={}end
function e.IsSkipStartQuestDemo(e)return mvars.qst_isSkipStartQuestDemo[e]end
function e.SetUnloadableAll(t)if mvars.qst_unloadableAllQuestFlag~=t then
mvars.qst_unloadableAllQuestFlag=t
if t==true then
for t=1,#n do
e.UnloadCurrentQuestBlock(n[t])end
end
e.UpdateActiveQuest()end
end
function e.AddPackList(n,e)local s=mvars.qst_questPackList[e]if s==nil then
return
end
if not t(s)then
return
end
if not n[e]then
n[e]={}end
for t,s in pairs(s)do
if type(s)=="number"then
table.insert(n[e],s)elseif t=="faceIdList"then
elseif t=="bodyIdList"then
elseif t=="randomFaceList"then
else
table.insert(n[e],s)end
end
end
function e._InitializeQuestActiveStatus(n)local s=e.GetQuestBlockState(n)if s==nil then
return
end
if s==i then
return
end
local t=r[n]if not t or t==0 then
return
end
mvars.qst_requestInitActiveStatus[t]=false
if s<f or not e._CanActivateQuest()then
mvars.qst_requestInitActiveStatus[t]=true
return
end
local s=e.GetCurrentQuestTable(t)if s==nil then
return
end
local r,a=Tpp.GetCurrentStageSmallBlockIndex()if e.IsInsideArea("loadArea",s,r,a)then
e.ActivateCurrentQuestBlock(n)end
if not e.IsInvokingImpl(t)then
e.Invoke(n)else
local n=t-1
gvars.qst_currentQuestStepNumber[n]=1
local n=mvars.qst_questStepList[t][1]e.SetNextQuestStep(t,n)end
end
function e.OnAllocate(t)e.InitMvars()end
function e.Init(t)e.CommonInit()end
function e.OnReload(t)e.CommonInit()e.RegisterQuestPackList(TppQuestList.questPackList)e.RegisterQuestList(TppQuestList.questList)e.UpdateActiveQuest()e.InitializeQuestLoad()end
function e.CommonInit()e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())e.InitMvars()e.InitLoadableQuestList()end
function e.InitMvars()mvars.qst_reserveUpdateTerminalFlag=false
mvars.qst_unloadableAllQuestFlag=false
mvars.qst_skipLoadQuestList={}mvars.qst_currentQuestName={}mvars.qst_currentQuestTable={}mvars.qst_loadableQuestList={}mvars.qst_loadableQuestInArea={}mvars.qst_loadableQuestNameList={}mvars.qst_loadableQuestNameList2={}mvars.qst_invokeReserveOnActivate={}mvars.qst_reserveNextQuest={}mvars.qst_questStepList={}mvars.qst_questStepTable={}mvars.qst_systemCallbacks={}mvars.qst_questScriptMsgExecTable={}mvars.qst_allocated={}mvars.qst_lastQuestBlockState={}mvars.qst_lastInactiveToActive={}mvars.qst_isRadioTarget={}mvars.qst_blockStateRequest={}mvars.qst_isRequestedDeactivate={}mvars.qst_requestInitActiveStatus={}mvars.qst_isLockedArea={}mvars.qst_reserveEnd={}mvars.qst_otherLocationQuestList={}mvars.qst_isWatchingDefenseFlag={}for e=1,a do
mvars.qst_currentQuestName[e]=nil
mvars.qst_currentQuestTable[e]={}mvars.qst_loadableQuestList[e]={}mvars.qst_loadableQuestInArea[e]={}mvars.qst_invokeReserveOnActivate[e]=false
mvars.qst_reserveNextQuest[e]=nil
mvars.qst_questStepList[e]=nil
mvars.qst_questStepTable[e]=nil
mvars.qst_systemCallbacks[e]=nil
mvars.qst_questScriptMsgExecTable[e]=nil
mvars.qst_allocated[e]=false
mvars.qst_lastQuestBlockState[e]=nil
mvars.qst_lastInactiveToActive[e]=nil
mvars.qst_isRadioTarget[e]=false
mvars.qst_blockStateRequest[e]=false
mvars.qst_isRequestedDeactivate[e]=false
mvars.qst_requestInitActiveStatus[e]=false
mvars.qst_reserveEnd[e]=false
mvars.qst_otherLocationQuestList[e]={}mvars.qst_isWatchingDefenseFlag[e]=false
end
mvars.qst_isSkipStartQuestDemo={}end
function e.InitLoadableQuestList()if TppMission.IsMultiPlayMission(vars.missionCode)then
return
end
local n=vars.locationCode
if not mvars.qst_questList then
return
end
local e=#mvars.qst_questList
if e==0 then
return
end
for e=1,e do
local t=mvars.qst_questList[e]local e=r[t.blockType]if not e or e>a then
return
end
if t.locationId==n then
table.insert(mvars.qst_loadableQuestList[e],t)else
table.insert(mvars.qst_otherLocationQuestList[e],t)end
end
end
function e.InitializeQuestLoad()end
function e.GetQuestBlockState(e)local e=ScriptBlock.GetScriptBlockId(e)if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
return
end
return ScriptBlock.GetScriptBlockState(e)end
function e.UnloadCurrentQuestBlock(e)TppScriptBlock.Unload(e)end
function e.IsNeedWaitCheckPoint()for s=1,#n do
local t=n[s]local t=e.GetQuestBlockState(t)if t~=nil and t~=i then
local t=mvars.qst_currentQuestName[s]if t then
local n=TppQuestList.questTimerList[t].isOnce
if n then
return true
end
local n=mvars.qst_reserveEnd[s]if n then
local n=e.IsCleard(t)local e=e.IsFailure(t)if(not n)and(not e)then
return true
end
end
end
end
end
return false
end
function e.ClearCurrentQuestName(e)if not e or e==0 then
return
end
mvars.qst_currentQuestName[e]=nil
gvars.qst_currentQuestName[e-1]=Q
end
function e.SetCurrentQuestName(e,t)if not e or e==0 then
return
end
mvars.qst_currentQuestName[e]=t
gvars.qst_currentQuestName[e-1]=Fox.StrCode32(t)end
function e.GetCurrentQuestName(e)return mvars.qst_currentQuestName[e]end
function e.ResetQuestStatus(e)if not e or e==0 then
for e=1,a do
gvars.qst_currentQuestName[e-1]=Q
gvars.qst_currentQuestStepNumber[e-1]=p
end
return
end
local e=e-1
gvars.qst_currentQuestName[e]=Q
gvars.qst_currentQuestStepNumber[e]=p
end
function e.UpdateQuestBlockStateAtNotLoaded(s,t,l)local n=r[s]if not n then
return
end
if not mvars.qst_loadableQuestList or not mvars.qst_loadableQuestList[n]then
return
end
local a=e.GetCurrentQuestName(n)local t=e.SearchQuestFromAllSpecifiedArea("loadArea",n,t,l)local l=e.GetQuestBlockState(s)local r=i
if t==nil then
if l~=r then
e.UnloadCurrentQuestBlock(s)e.ClearCurrentQuestName(n)e.ResetQuestStatus(n)end
return
end
if a then
if t then
if(l==r or a~=t)then
e.SetNewQuestAndLoadQuestBlock(s,t)end
if(l~=r)and(a==t)then
mvars.qst_currentQuestTable[n]=e.GetQuestTable(n,t)end
end
else
if t then
e.SetNewQuestAndLoadQuestBlock(s,t)end
end
return t
end
function e.UpdateQuestBlockStateAtInactive(e,t,t)local e=r[e]if not e then
return
end
mvars.qst_invokeReserveOnActivate[e]=true
end
function e.UpdateQuestBlockStateAtActive(n,l,a)local t=r[n]if not t or t==0 then
return
end
if mvars.qst_blockStateRequest[t]==u.DEACTIVATE then
return
end
if not e.IsInvoking(n)then
e.Invoke(n)return
end
local s=e.GetCurrentQuestTable(t)if s==nil then
return
end
if not e.IsInsideArea("loadArea",s,l,a)then
local r=e.GetCurrentQuestName(t)local s=e.SearchQuestFromAllSpecifiedArea("loadArea",t,l,a)if s==nil or r~=s then
e.UnloadCurrentQuestBlock(n)mvars.qst_reserveNextQuest[t]=s
end
end
end
function e.GetFirstPriorityQuest(s)if not t(s)then
return
end
local n
for s,t in ipairs(s)do
local t=t.name
local s=TppQuestList.QUEST_INDEX[t]if s then
gvars.qst_questActiveFlag[s]=false
if e.IsOpen(t)then
if not e.IsCleard(t)then
n=t
break
elseif not n and e.IsRepop(t)then
n=t
end
end
end
end
return n
end
function e._UpdateActiveQuest(s)local t=mvars.qst_loadableQuestList[s]if not t or not next(t)then
return
end
mvars.qst_loadableQuestInArea[s]={}if mvars.qst_unloadableAllQuestFlag then
return
end
local n=n[s]local n=e.GetQuestBlockState(n)if n==nil then
return
end
for n,t in ipairs(t)do
local n=t.areaName
local t=e.GetFirstPriorityQuest(t.infoList)if t then
mvars.qst_loadableQuestInArea[s][n]=t
table.insert(mvars.qst_loadableQuestNameList,t)local n=TppQuestList.QUEST_INDEX[t]gvars.qst_questActiveFlag[n]=true
TppCrew.UpdateActiveQuest(t)e._UpdateOrderQuest(t)if mvars.qst_openableQuestNameList[t]then
local e=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]local e=Mission.RequestOpenQuestToServer(e,TppQuestList.questTimerList[t].openTime)if e then
mvars.qst_openableQuestNameList[t]=false
end
end
end
end
end
function e._UpdateOrderQuest(t)if TppQuestList.questOrderList[t]and not e.IsAccepted(t)then
table.insert(mvars.qst_acceptableQuestNameList,t)local e=TppQuestList.QUEST_INDEX[t]gvars.qst_questActiveFlag[e]=false
end
end
function e.AssignNpcInfosToGameObjectType(e)for t,e in ipairs(e)do
SsdNpc.AssignInfosToGameObjectType{gameObjectType=e[1],npcType=e[2],partsType=e[3],isRegisterResource=false}end
end
function e.NeedUpdateActiveQuest(t)if not e.CanOpenSideOpsList()then
return false
end
if not SsdSaveSystem.IsIdle()then
return false
end
return true
end
function e.UpdateChangeQuest(t,s,n)if n~=i then
return
end
if mvars.qst_reserveNextQuest[t]then
local n=mvars.qst_reserveNextQuest[t]e.SetNewQuestAndLoadQuestBlock(s,n)mvars.qst_reserveNextQuest[t]=nil
end
end
function e.UpdateWatchingQuest(t,s,n)if n~=d then
return
end
if Mission.GetDefenseGameState()~=TppDefine.DEFENSE_GAME_STATE.NONE then
if not mvars.qst_isWatchingDefenseFlag[t]then
return
end
e.UnloadCurrentQuestBlock(s)local t=e.GetCurrentQuestName(t)table.insert(mvars.qst_skipLoadQuestList,t)e.UpdateTerminalDisplayQuest()else
if#mvars.qst_skipLoadQuestList>0 then
mvars.qst_skipLoadQuestList={}mvars.qst_reserveUpdateTerminalFlag=true
end
end
end
function e.IsSkipLoading(t)for n,e in ipairs(mvars.qst_skipLoadQuestList)do
if t==e then
return true
end
end
return false
end
function e.IsInvoking(t)local t=r[t]return e.IsInvokingImpl(t)end
function e.IsInvokingImpl(e)if not e or e==0 then
return
end
if gvars.qst_currentQuestStepNumber[e-1]~=p then
return true
else
return false
end
end
function e.Invoke(t)local t=r[t]if not t then
return
end
local n=e.GetCurrentQuestName(t)local s,n=e.GetQuestTable(t,n)local n=n.invokeStepName
e.SetNextQuestStep(t,n)end
function e.SetNewQuestAndLoadQuestBlock(s,t)local n=TppQuestList.npcsList[t]if n~=nil then
e.AssignNpcInfosToGameObjectType(n)end
local n=TppScriptBlock.Load(s,t)if n==false then
return
end
local n=r[s]e.ResetQuestStatus(n)e.SetCurrentQuestName(n,t)mvars.qst_currentQuestTable[n]=e.GetQuestTable(n,t)end
function e.GetQuestTable(e,n)local e=mvars.qst_loadableQuestList[e]local t=#e
for t=1,t do
local t=e[t]for s,e in ipairs(t.infoList)do
if e.name==n then
return t,e
end
end
end
end
function e.GetQuestStepTable(e,n)if mvars.qst_questStepList[e]==nil then
return
end
local t=mvars.qst_questStepList[e]local t=t[n]if t==nil then
return
end
local e=mvars.qst_questStepTable[e]if e==nil then
return
end
local e=e[t]if e~=nil then
return e
else
return
end
end
function e.SearchQuestFromAllSpecifiedArea(r,t,l,a)local s=mvars.qst_loadableQuestList[t]local n=mvars.qst_loadableQuestInArea[t]local t=#s
for t=1,t do
local t=s[t]if e.IsInsideArea(r,t,l,a)then
local t=t.areaName
if mvars.qst_isLockedArea[t]then
return
end
if n[t]then
local t=n[t]if e.IsActive(t)and not e.IsSkipLoading(t)then
return t
end
end
end
end
end
function e.SearchBlockIndex(s)local e=0
for t=1,#n do
if e~=0 then
break
end
if mvars.qst_loadableQuestList[t]then
local n=mvars.qst_loadableQuestList[t]for a=1,#n do
if e~=0 then
break
end
local n=n[a]for a,n in ipairs(n.infoList)do
if n.name==s then
e=t
break
end
end
end
end
end
return e
end
function e.IsInsideArea(n,e,t,s)local a=e.areaName
local e=e[n]if e==nil then
return
end
return Tpp.CheckBlockArea(e,t,s)end
function e.IsActive(e)local e=TppQuestList.QUEST_INDEX[e]if e then
return gvars.qst_questActiveFlag[e]end
end
function e.Messages()return T{GameObject={{msg="AcceptQuest",func=function(t)local t=TppQuestList.QUEST_DEFINE_HASH_TABLE[t]if not t then
return
end
e.Accept(t)end}},Block={{msg="StageBlockCurrentSmallBlockIndexUpdated",func=e.OnUpdateSmallBlockIndex,option={isExecFastTravel=true}}},UI={{msg="EndFadeOut",sender="FadeOutOnOutOfMissionArea",func=function()for e=1,a do
if mvars.qst_isRequestedDeactivate[e]then
mvars.qst_isRequestedDeactivate[e]=false
mvars.qst_blockStateRequest[e]=u.DEACTIVATE
end
end
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,nil,TppUI.FADE_PRIORITY.QUEST)end},{msg="QuestAreaAnnounceText",func=function(t)e.OnQuestAreaAnnounceText(t)end}},Marker={{msg="ChangeToEnable",func=function(a,n,s,t)e._ChangeToEnable(a,n,s,t)end}}}end
function e.OnMessage(i,o,l,s,r,t,n)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,i,o,l,s,r,t,n)for a=1,a do
e.ExecMessageToBlockScript(a,i,o,l,s,r,t,n)end
end
function e.ExecMessageToBlockScript(t,n,s,a,r,u,o,l)if mvars.qst_questScriptMsgExecTable==nil then
return
end
local i=mvars.qst_questScriptMsgExecTable[t]if i then
local e=l
local t
Tpp.DoMessage(i,TppMission.CheckMessageOption,n,s,a,r,u,o,e)end
if e.IsInvokingImpl(t)and mvars.qst_questStepList[t]then
local i=gvars.qst_currentQuestStepNumber[t-1]local e=e.GetQuestStepTable(t,i)if e then
local e=e._messageExecTable
if e then
local t=l
local l
Tpp.DoMessage(e,TppMission.CheckMessageOption,n,s,a,r,u,o,t)end
end
end
end
function e.MakeQuestStepMessageExecTable(e)if not t(mvars.qst_questStepTable[e])then
return
end
for t,e in pairs(mvars.qst_questStepTable[e])do
local t=e.Messages
if o(t)then
local t=t(e)e._messageExecTable=Tpp.MakeMessageExecTable(t)end
end
end
function e.OnUpdateSmallBlockIndex(s,a)for t=1,#n do
local t=n[t]e.OnUpdateQuestBlockState(t,s,a)end
if mvars.qst_reserveUpdateTerminalFlag then
mvars.qst_reserveUpdateTerminalFlag=false
e.UpdateTerminalDisplayQuest()end
end
function e.OnUpdateQuestBlockState(t,s,a)local r=r[t]local n=e.GetQuestBlockState(t)if n~=nil then
mvars.qst_invokeReserveOnActivate[r]=false
if(n==i)or(n==h)then
e.UpdateQuestBlockStateAtNotLoaded(t,s,a)elseif(n==f)then
e.UpdateQuestBlockStateAtInactive(t,s,a)elseif(n==d)then
e.UpdateQuestBlockStateAtActive(t,s,a)end
end
end
function e.GetCurrentQuestTable(e)return mvars.qst_currentQuestTable[e]end
function e.Clear(t)if t==nil then
return
end
local n=e.GetQuestIndex(t)if n==nil then
return
end
local s=e.GetQuestBlockIndex(t)if not s then
return
end
e.SetNextQuestStep(s,c)e.ShowAnnounceLog(l.CLEAR,t)e.CheckClearBounus(n,t)e.UpdateClearFlag(n,true)e.UpdateRepopFlag(s,n)e.CheckAllClearBounus()e.DecreaseElapsedClearCount(t)e.PlayClearRadio(t)e.GetClearKeyItem(t)TppStory.UpdateStorySequence{updateTiming="OnSideOpsClear"}gvars.qst_questSuspendFlag[n]=true
Mission.RequestClearQuestToServer(TppQuestList.QUEST_DEFINE_IN_NUMBER[t],TppQuestList.questTimerList[t].closeTime)e.UpdateTerminalDisplayQuest()end
function e.Failure(t)if t==nil then
return
end
local n=e.GetQuestIndex(t)if n==nil then
return
end
local s=e.GetQuestBlockIndex(t)if not s then
return
end
e.UpdateClearFlag(n,false)e.UpdateRepopFlag(s,n)e.SetNextQuestStep(s,c)e.ShowAnnounceLog(l.FAILURE,t)gvars.qst_questSuspendFlag[n]=true
if not TppQuestList.questTimerList[t].isOnce then
Mission.RequestClearQuestToServer(TppQuestList.QUEST_DEFINE_IN_NUMBER[t],TppQuestList.questTimerList[t].closeTime)end
e.UpdateTerminalDisplayQuest()end
function e.ReserveEnd(e)mvars.qst_reserveEnd[e]=true
end
function e.Update(t)if t==nil then
return
end
local n=e.GetQuestIndex(t)if n==nil then
return
end
local n,s=TppEnemy.GetQuestCount()if n>0 and s>1 then
e.ShowAnnounceLog(l.UPDATE,t,n,s)end
end
function e.IsOpen(e)local e=TppQuestList.QUEST_INDEX[e]if e then
if not gvars.qst_questOpenFlag[e]then
return false
end
if gvars.qst_questSuspendFlag[e]then
return false
end
return true
end
end
function e.IsCleard(e)local e=TppQuestList.QUEST_INDEX[e]if e then
return gvars.qst_questClearedFlag[e]end
end
function e.IsFailure(e)local e=TppQuestList.QUEST_INDEX[e]if e then
return gvars.qst_questFailureFlag[e]end
end
function e.IsRepop(e)local e=TppQuestList.QUEST_INDEX[e]if e then
return gvars.qst_questRepopFlag[e]end
end
function e.IsReservedClear(e)local e=TppQuestList.QUEST_DEFINE_IN_NUMBER[e]if e and Mission.IsReserveClearQuest(e)then
return true
end
return false
end
function e.IsAccepted(e)local e=TppQuestList.QUEST_INDEX[e]if e then
return gvars.qst_questAcceptedFlag[e]end
end
function e.Accept(t)local n=TppQuestList.QUEST_INDEX[t]if n then
local s=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]local t=Mission.RequestOpenQuestToServer(s,TppQuestList.questTimerList[t].openTime)if t then
gvars.qst_questAcceptedFlag[n]=true
e.UpdateActiveQuest()TppUiCommand.AnnounceLogViewQuestReceived{id={s}}end
end
end
function e.IsEnd(t)if t==nil then
return
end
local e=e.GetQuestBlockIndex(t)if not e then
return
end
local t=gvars.qst_currentQuestStepNumber[e-1]if mvars.qst_questStepList[e][t]==c then
return true
end
return false
end
function e.UpdateClearFlag(e,t)if t then
gvars.qst_questClearedFlag[e]=true
gvars.qst_questFailureFlag[e]=false
gvars.qst_questRepopFlag[e]=false
else
gvars.qst_questFailureFlag[e]=true
end
gvars.qst_questActiveFlag[e]=false
end
function e.UpdateRepopFlag(n,t)gvars.qst_questRepopFlag[t]=false
local t=e.GetCurrentQuestTable(n)if not t then
return
end
e.UpdateRepopFlagImpl(t)end
function e.UpdateRepopFlagImpl(s)local n=0
for t,s in ipairs(s.infoList)do
local t=s.name
if e.IsOpen(t)then
if not s.isOnce then
n=n+1
end
if e.IsRepop(t)or not e.IsCleard(t)then
return
end
end
end
if n==0 then
return
end
for n,t in ipairs(s.infoList)do
if e.IsCleard(t.name)and not t.isOnce then
end
end
end
function e.CheckAllClearBounus()local e=true
for t=1,#TppQuestList.QUEST_DEFINE do
if not gvars.qst_questClearedFlag[t]then
e=false
break
end
end
if e then
gvars.qst_allQuestCleared=true
end
end
function e.AddStaffsFromTempBuffer()TppTerminal.AddStaffsFromTempBuffer(true)end
function e.Save()end
function e.ExecuteSystemCallback(e,t)if mvars.qst_systemCallbacks[e]==nil then
return
end
local e=mvars.qst_systemCallbacks[e][t]if e then
return e()end
end
function e.ActivateCurrentQuestBlock(e)local e=ScriptBlock.GetScriptBlockId(e)TppScriptBlock.ActivateScriptBlockState(e)end
function e.DeactivateCurrentQuestBlock(e)local e=ScriptBlock.GetScriptBlockId(e)TppScriptBlock.DeactivateScriptBlockState(e)end
function e.ClearBlockStateRequest(e)mvars.qst_blockStateRequest[e]=u.NONE
end
function e.GetQuestIndex(e)local e=TppQuestList.QUEST_INDEX[e]if e then
return e
else
return
end
end
function e._CanActivateQuest()return true
end
function e._DoDeactivate(t)e.ExecuteSystemCallback(t,"OnDeactivate")mvars.qst_allocated[t]=false
end
function e.UpdateOpenQuest()local p=TppQuestList.QUEST_DEFINE_IN_NUMBER
local l=TppQuestList.questTimerList
local a=gvars.qst_questOpenFlag
local s=gvars.qst_questSuspendFlag
local d=gvars.qst_questLockedFlag
local u=gvars.qst_questFailureFlag
local i=gvars.qst_questAcceptedFlag
local o=gvars.qst_questRepopFlag
local r=vars.questTimeCounter
local m=TppQuestList.questOpenCondition
local f=TppQuestList.questLockCondition
mvars.qst_isQuestNewOpenFlag=false
for t,e in pairs(TppQuestList.QUEST_INDEX)do
local n=p[t]local Q=l[t].isOnce
local v=a[e]local n=s[e]local h=d[e]local c=r[e]if h then
a[e]=false
s[e]=false
u[e]=false
i[e]=false
o[e]=false
else
local f=f[t]if f and f()then
d[e]=true
local t=p[t]local t=Mission.RequestOpenQuestToServer(t,0)if not t then
d[e]=false
end
else
if Q then
s[e]=false
u[e]=false
else
if n then
if c==0 then
s[e]=false
u[e]=false
i[e]=false
o[e]=true
n=false
mvars.qst_openableQuestNameList[t]=true
r[e]=l[t].openTime
end
elseif v and not n then
if c==0 then
s[e]=true
o[e]=false
i[e]=false
n=true
table.insert(mvars.qst_suspendedQuestNameList,t)r[e]=l[t].closeTime
end
end
end
local s=m[t]if s then
if s()and not n then
if a[e]==false then
mvars.qst_isQuestNewOpenFlag=true
mvars.qst_openableQuestNameList[t]=true
r[e]=l[t].openTime
end
a[e]=true
end
end
end
end
end
end
function e.UpdateCloseQuest()if not mvars.qst_suspendedQuestNameList then
return
end
if not next(mvars.qst_suspendedQuestNameList)then
return
end
for t,e in ipairs(mvars.qst_suspendedQuestNameList)do
local t=TppQuestList.QUEST_DEFINE_IN_NUMBER[e]local t=Mission.RequestOpenQuestToServer(t,TppQuestList.questTimerList[e].closeTime)if not t then
local e=TppQuestList.QUEST_INDEX[e]gvars.qst_questSuspendFlag[e]=false
end
end
end
function e.UpdateOpenableQuest()if not mvars.qst_openableQuestNameList then
return
end
if not next(mvars.qst_openableQuestNameList)then
return
end
for e,t in pairs(mvars.qst_openableQuestNameList)do
if t then
local t=TppQuestList.QUEST_DEFINE_IN_NUMBER[e]local t=Mission.RequestOpenQuestToServer(t,TppQuestList.questTimerList[e].openTime)if not t then
local e=TppQuestList.QUEST_INDEX[e]gvars.qst_questOpenFlag[e]=false
end
end
end
end
function e.UpdateLoadableQuestListForOtherLocation()mvars.qst_loadableQuestNameList2={}for t=1,a do
local t=mvars.qst_otherLocationQuestList[t]if t and next(t)then
local t=t
for n,t in ipairs(t)do
local n=t.areaName
local e=e.GetFirstPriorityQuest(t.infoList)if e then
table.insert(mvars.qst_loadableQuestNameList2,e)end
end
end
end
end
function e.UpdateTerminalDisplayQuest()local n={}for s,t in ipairs(mvars.qst_loadableQuestNameList)do
if e.IsReservedClear(t)then
elseif TppQuestList.questOrderList[t]and not e.IsAccepted(t)then
elseif e.IsSkipLoading(t)then
elseif TppQuestList.questTimerList[t].isOnce and e.IsFailure(t)then
elseif#n<16 then
local e=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]if e then
table.insert(n,e)end
end
end
for s,t in ipairs(mvars.qst_loadableQuestNameList2)do
local s=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]if s then
if TppQuestList.questOrderList[t]and not e.IsAccepted(t)then
else
table.insert(n,s)end
end
end
MapInfoSystem.ClearAllActiveQuests()MapInfoSystem.SetActiveQuests{questCodes=n}e.DEBUG_SetExecutableQuestCode()end
function e.DEBUG_SetExecutableQuestCode()if not Mission.DEBUG_SetExecutableQuest then
return
end
local n={}for s,t in ipairs(mvars.qst_loadableQuestNameList)do
if e.IsReservedClear(t)then
elseif TppQuestList.questOrderList[t]and not e.IsAccepted(t)then
elseif e.IsSkipLoading(t)then
elseif#n<16 then
local e=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]if e then
table.insert(n,e)end
end
end
local t={}for s,n in ipairs(mvars.qst_loadableQuestNameList2)do
local s=TppQuestList.QUEST_DEFINE_IN_NUMBER[n]if s then
if TppQuestList.questOrderList[n]and not e.IsAccepted(n)then
else
table.insert(t,s)end
end
end
if vars.locationCode==TppDefine.LOCATION_ID.SSD_AFGH then
Mission.DEBUG_SetExecutableQuest{locationCode=TppDefine.LOCATION_ID.SSD_AFGH,questCodes=n}Mission.DEBUG_SetExecutableQuest{locationCode=TppDefine.LOCATION_ID.MAFR,questCodes=t}elseif vars.locationCode==TppDefine.LOCATION_ID.MAFR then
Mission.DEBUG_SetExecutableQuest{locationCode=TppDefine.LOCATION_ID.MAFR,questCodes=n}Mission.DEBUG_SetExecutableQuest{locationCode=TppDefine.LOCATION_ID.SSD_AFGH,questCodes=t}end
end
function e.UpdateQuestTimeCount()Mission.UpdateQuestTimeCount()end
function e.UpdateGimmickValidity(n)if not t(mvars.qst_loadableQuestNameList)then
return
end
for s,t in ipairs(mvars.qst_loadableQuestNameList)do
e.SetGimmickResourceValidity(t,n)end
end
function e.IsLoadableQuestName(n)for s,t in ipairs(mvars.qst_loadableQuestNameList)do
if n==t then
if(e.IsReservedClear(t)or(TppQuestList.questOrderList[t]and not e.IsAccepted(t)))or e.IsSkipLoading(t)then
return false
else
return true
end
end
end
return false
end
function e.UpdateAllGimmickValidity(s)if not t(mvars.loc_locationTreasureQuest)then
return
end
local n=mvars.loc_locationTreasureQuest.treasureTableList
if not t(n)then
return
end
for t,n in pairs(n)do
e.SetGimmickResourceValidity(t,s)end
end
function e.ShowAnnounceLog(n,t,a,s)if not n then
return
end
if n==l.OPEN then
TppUI.ShowAnnounceLog"quest_list_update"TppUI.ShowAnnounceLog"quest_add"elseif n==l.CLEAR then
if not t then
return
end
local n=e.GetQuestNameLangId(t)if n~=false then
local t=ANNOUNCE_LOG_TYPE_LIST[t]if t then
local e,n=TppEnemy.GetQuestCount()if e>1 then
TppUI.ShowAnnounceLog(t,e,n)end
end
TppUI.ShowAnnounceLog"quest_list_update"TppUI.ShowAnnounceLog("quest_complete",n)end
elseif n==l.FAILURE then
if not t then
return
end
local e=e.GetQuestNameLangId(t)if e~=false then
TppUI.ShowAnnounceLog"quest_list_update"TppUI.ShowAnnounceLog("quest_delete",e)end
elseif n==l.UPDATE then
if not t then
return
end
local e=ANNOUNCE_LOG_TYPE_LIST[t]if e then
TppUI.ShowAnnounceLog(e,a,s)end
end
end
function e.OnQuestAreaAnnounceText(t)local n=e.GetQuestName(t)local t
if n then
for s,e in pairs(QUEST_START_RADIO_LIST)do
if s==n then
if e.radioNameFirst then
if e.radioNameSecond then
if TppRadio.IsPlayed(e.radioNameFirst)then
t=e.radioNameSecond
else
t=e.radioNameFirst
end
else
t=e.radioNameFirst
end
end
end
end
if t~=nil then
TppRadio.Play(t,{delayTime="mid"})end
TppSoundDaemon.PostEvent"sfx_s_sideops_sted"end
end
function e._ChangeToEnable(s,s,n,t)if t~=Fox.StrCode32"Player"then
return
end
for t=1,a do
if e.IsInvokingImpl(t)then
local e=false
local s=TppGimmick.IsQuestTarget(n)local n=TppAnimal.IsQuestTarget(n)if(e or s)or n then
TppSoundDaemon.PostEvent"sfx_s_enemytag_quest_tgt"if mvars.qst_isRadioTarget[t]==false then
TppRadio.Play("f1000_rtrg2180",{delayTime="short"})mvars.qst_isRadioTarget[t]=true
end
end
end
end
end
function e.StartSafeTimer(t,n)e.StopTimer(t)GkEventTimerManager.Start(t,n)end
function e.StopTimer(e)if GkEventTimerManager.IsTimerActive(e)then
GkEventTimerManager.Stop(e)end
end
function e.GetQuestId(t)if t==nil then
t=e.GetCurrentQuestName()if t==nil then
return
end
end
local e=string.sub(t,-5)return e
end
function e.TelopStart(t)if t==nil then
t=e.GetCurrentQuestName()if t==nil then
return
end
end
local n
n=e.GetQuestId(t)QuestTelopSystem.SetInfo(n,QuestTelopType.Start)QuestTelopSystem.RequestOpen()end
function e.TelopComplete(t)if t==nil then
t=e.GetCurrentQuestName()if t==nil then
return
end
end
local n
n=e.GetQuestId(t)QuestTelopSystem.SetInfo(n,QuestTelopType.Complete)QuestTelopSystem.RequestOpen()end
function e.SetGimmickResourceValidity(s,n)if not t(mvars.loc_locationTreasureQuest)then
return
end
local e=mvars.loc_locationTreasureQuest.treasureTableList
if not t(e)then
return
end
local e=e[s]if not e then
return
end
local s=e.treasureBoxResourceTable
if t(s)then
for s,e in ipairs(s)do
if t(e)then
local e={name=e.name,dataSetName=e.dataSetName,validity=n}Gimmick.SetResourceValidity(e)end
end
end
local s=e.treasurePointResourceTable
if t(s)then
for s,e in ipairs(s)do
if t(e)then
local e={name=e.name,dataSetName=e.dataSetName,validity=n}Gimmick.SetResourceValidity(e)end
end
end
if n==true then
local e=e.treasureKubResourceTable
if t(e)then
for s,e in ipairs(e)do
if t(e)then
if e.gimmickId then
Gimmick.ResetGimmick(0,e.name,e.dataSetName,{gimmickId=e.gimmickId})else
local e={name=e.name,dataSetName=e.dataSetName,validity=n}Gimmick.SetResourceValidity(e)end
end
end
end
end
end
function e.GetGimmickResource(n)if not t(mvars.loc_locationTreasureQuest)then
return
end
local e=mvars.loc_locationTreasureQuest.treasureTableList
if not t(e)then
return
end
local e=e[n]if not e then
return
end
return e
end
function e.GetWormholeQuest(n)if not t(mvars.loc_locationWormholeQuest)then
return
end
local e=mvars.loc_locationWormholeQuest.wormholeQuestTable
if not t(e)then
return
end
if not e[n]then
return
end
return e[n]end
function e.OpenWormhole(s,n)local e=e.GetWormholeQuest(n)if not e then
return
end
local a=e[s]if not t(a)then
return
end
local r=mvars.loc_locationWormholeQuest.wormholeHeight or 10
local l=TppStory.GetCurrentStorySequence()local s={}local function o(n)if t(n)then
for t,e in ipairs(n)do
local t={}for e,n in ipairs(e.position)do
t[e]=n
end
t[2]=t[2]+r
local a=0
if _(n.level)then
a=n.level
end
local e={dropType=TppDefine.WORMHOLE_DROP_TYPE.NPC,position=t,radius=e.radius or 4,gameObjectType=e.gameObjectType or"SsdZombie",count=e.count or 1,level=a,routes=e.routes or{}}table.insert(s,e)end
end
end
for n,e in ipairs(a)do
local s=0
local n
if t(e)then
for e,a in ipairs(e)do
local e=a.storySequence or 0
local a=a.positionTable or nil
if((l>=e)and(e>=s))and t(a)then
s=e
n=a
end
end
end
if n then
o(n)end
end
if next(s)then
Mission.OpenWormhole(s)end
end
function e.GetOpenRewardCbox(n)if not t(mvars.loc_locationTreasureQuest)then
return
end
local e=mvars.loc_locationTreasureQuest.clearRewardCboxTableList
if not t(e)then
return
end
if not e[n]then
return
end
return e[n]end
function e.OpenRewardCbox(n)local e=e.GetOpenRewardCbox(n)if t(e)then
for n,e in ipairs(e)do
if(e.pos and e.model)and t(e.contents)then
SsdRewardCbox.DropCoopObjective{pos=e.pos,model=e.model,showRewardLog=e.showRewardLog or false,contents=e.contents}end
end
end
end
function e.GetNamePlate(n)if not t(mvars.loc_locationTreasureQuest)then
return
end
local e=mvars.loc_locationTreasureQuest.clearNamePlateTableList
if not t(e)then
return
end
if not e[n]then
return
end
local e=e[n]if t(e)then
for t,e in pairs(e)do
SsdSbm.AddNamePlate(e)end
end
end
function e.IsRandomFaceQuestName(t)if t==nil then
t=e.GetCurrentQuestName()if t==nil then
return
end
end
local e=TppDefine.QUEST_RANDOM_FACE_INDEX[t]if e then
return true
end
return false
end
function e.GetRandomFaceId(t)if t==nil then
t=e.GetCurrentQuestName()if t==nil then
return
end
end
local e=TppDefine.QUEST_RANDOM_FACE_INDEX[t]if e then
return gvars.qst_randomFaceId[e]end
end
function e.SetRandomFaceId(e,t)local e=TppDefine.QUEST_RANDOM_FACE_INDEX[e]if e then
gvars.qst_randomFaceId[e]=t
end
end
function e.GetSideOpsListTable()end
function e.CheckClearBounus(e,e)end
function e.DecreaseElapsedClearCount(e)end
function e.PlayClearRadio(e)end
function e.GetClearKeyItem(e)end
function e.GetSideOpsInfo(t)for n,e in ipairs(v)do
if e.questName==t then
return e
end
end
return nil
end
function e.IsShowSideOpsList(t)return e.GetSideOpsInfo()~=nil
end
function e.GetQuestNameLangId(t)local e=e.GetSideOpsInfo(t)if e then
local e="name_"..string.sub(e.questId,-6)return e
end
return false
end
function e.GetQuestNameId(t)local e=e.GetSideOpsInfo(t)if e then
local e=string.sub(e.questId,-6)return e
end
return false
end
function e.GetQuestName(t)for n,e in ipairs(v)do
local n=tonumber(string.sub(e.questId,-5))if t==n then
return e.questName
end
end
end
function e.CanOpenSideOpsList()return true
end
function e.IsImportant(t)local e=e.GetSideOpsInfo(t)if e then
return e.isImportant
end
return false
end
function e.OpenQuestForce(e)local e=TppQuestList.QUEST_INDEX[e]if e then
gvars.qst_questOpenFlag[e]=true
end
end
function e.CalcQuestClearedCount()local e=0
local t=0
for s,n in ipairs(v)do
local n=n.questName
local n=TppQuestList.QUEST_INDEX[n]if gvars.qst_questClearedFlag[n]then
e=e+1
end
t=t+1
end
return e,t
end
local s={}local a={}function e.AcquireKeyItemOnMissionStart()for n,t in pairs(S)do
if e.IsCleard(n)then
TppTerminal.AcquireKeyItem{dataBaseId=t,isShowAnnounceLog=true}end
end
for n,t in pairs(s)do
if e.IsCleard(n)then
TppTerminal.AcquireKeyItem{dataBaseId=t,isShowAnnounceLog=true}end
end
for n,t in pairs(a)do
if e.IsCleard(n)and not TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.dataBaseId}then
TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=t.dataBaseId,areaName=t.areaName,isNew=true}end
end
end
if(Tpp.IsQARelease()or nil)then
function e.QARELEASE_DEBUG_Init()local e
if DebugMenu then
e=DebugMenu
else
return
end
local t={}for n,e in ipairs(TppQuestList.QUEST_DEFINE)do
local e=tonumber(string.sub(e,-5))table.insert(t,e)end
if QuestTelopSystem.DEBUG_SetInfo then
QuestTelopSystem.DEBUG_SetInfo{questCodes=t}end
do
mvars.qaDebug.targetQuestBlockIndex=0
e.AddDebugMenu("LuaQuest","targetBlockIndex","int32",mvars.qaDebug,"targetQuestBlockIndex")mvars.qaDebug.showCurrentQuest=false
e.AddDebugMenu("LuaQuest","showCurrentQuest","bool",mvars.qaDebug,"showCurrentQuest")mvars.qaDebug.forceQuestClear=false
e.AddDebugMenu("LuaQuest","forceClear","bool",mvars.qaDebug,"forceQuestClear")mvars.qaDebug.updateQuestActive=false
e.AddDebugMenu("LuaQuest","updateActive","bool",mvars.qaDebug,"updateQuestActive")mvars.qaDebug.resetQuestClearFlagAll=false
e.AddDebugMenu("LuaQuest","resetClearFlagAll","bool",mvars.qaDebug,"resetQuestClearFlagAll")mvars.qaDebug.forceLoadQuestIndex=0
e.AddDebugMenu("LuaQuest","forceLoadIndex","int32",mvars.qaDebug,"forceLoadQuestIndex")mvars.qaDebug.enableForceLoadQuest=false
e.AddDebugMenu("LuaQuest","forceLoad","bool",mvars.qaDebug,"enableForceLoadQuest")mvars.qaDebug.enableCheckDefense=false
e.AddDebugMenu("LuaQuest","checkDefense","bool",mvars.qaDebug,"enableCheckDefense")mvars.qaDebug.showOpenedQuests=false
e.AddDebugMenu("LuaQuest","showOpenedQuests","bool",mvars.qaDebug,"showOpenedQuests")mvars.qaDebug.startTelopCheck=false
e.AddDebugMenu("LuaQuest","startTelopCheck","bool",mvars.qaDebug,"startTelopCheck")end
end
function e.QAReleaseDebugUpdate()if mvars.qaDebug.targetQuestBlockIndex>#n then
mvars.qaDebug.targetQuestBlockIndex=0
elseif mvars.qaDebug.targetQuestBlockIndex<0 then
mvars.qaDebug.targetQuestBlockIndex=#n
end
if mvars.qaDebug.forceLoadQuestIndex>#TppQuestList.QUEST_DEFINE then
mvars.qaDebug.forceLoadQuestIndex=0
elseif mvars.qaDebug.forceLoadQuestIndex<0 then
mvars.qaDebug.forceLoadQuestIndex=#TppQuestList.QUEST_DEFINE
end
local t=mvars.qaDebug.targetQuestBlockIndex
local n=mvars.qaDebug.forceLoadQuestIndex
if mvars.qaDebug.showCurrentQuest then
e.DEBUG_ShowQuestState()end
if mvars.qaDebug.forceQuestClear then
mvars.qaDebug.forceQuestClear=false
e.DEBUG_ForceClear(t)end
if mvars.qaDebug.updateQuestActive then
mvars.qaDebug.updateQuestActive=false
e.DEBUG_UpdateActive(t)end
if mvars.qaDebug.resetQuestClearFlagAll then
mvars.qaDebug.resetQuestClearFlagAll=false
e.DEBUG_ResetClearFlagAll()end
if mvars.qaDebug.enableForceLoadQuest then
e.DEBUG_ForceLoad(n)mvars.qaDebug.enableForceLoadQuest=false
mvars.qaDebug.forceLoadQuestIndex=0
end
if mvars.qaDebug.showOpenedQuests then
e.DEBUG_ShowOpenedQuests()end
if mvars.qaDebug.startTelopCheck then
mvars.qaDebug.startTelopCheck=false
if QuestTelopSystem.DEBUG_TelopCheckStart then
QuestTelopSystem.DEBUG_TelopCheckStart()end
end
end
function e.DEBUG_ShowQuestState()local s=DebugText.Print
local t=DebugText.NewContext()s(t,"")s(t,{.5,.5,1},"Quest ShowState")local a=mvars.qaDebug.forceLoadQuestIndex
if not a or a==0 then
s(t,"Load Target[-] : -----")else
local n=TppQuestList.QUEST_DEFINE[a]local e=e.SearchBlockIndex(n)s(t,"Load Target["..(tostring(e)..("] : "..tostring(n))))end
for r=1,#n do
local n=n[r]s(t,"Block : "..n)local a=e.GetCurrentQuestName(r)if not a then
s(t,"Current Quest : -----")else
s(t,"Current Quest : "..tostring(a))end
local a=e.GetQuestBlockState(n)if not a then
s(t,"Block State : -----")else
local n={}n[i]="EMPTY"n[h]="PROCESSING"n[f]="INACTIVE"n[d]="ACTIVE"s(t,"Block State : "..tostring(n[a]))local n=e.GetCurrentQuestTable(r)if n and a~=i then
s(t,"AreaName : "..tostring(n.areaName))local e=n.loadArea
local r,a,e,l=e[1],e[2],e[3],e[4]s(t,"LoadArea : { "..(tostring(r)..(", "..(tostring(a)..(", "..(tostring(e)..(", "..(tostring(l).." }"))))))))s(t,"InfoList : ")for n,e in ipairs(n.infoList)do
local e=e.name
s(t,"     "..tostring(e))end
end
end
end
end
function e.DEBUG_ShowOpenedQuests()Mission.DEBUG_DisplayQuestList()end
function e.DEBUG_ForceClear(s)if s==0 then
for t=1,#n do
local t=e.GetCurrentQuestName(t)if t then
e.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR,t)end
end
else
local t=e.GetCurrentQuestName(s)if t then
e.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR,t)end
end
end
function e.DEBUG_UpdateActive(t)if t==0 then
for t=1,#n do
e.UnloadCurrentQuestBlock(n[t])end
else
e.UnloadCurrentQuestBlock(n[t])end
e.UpdateActiveQuest()end
function e.DEBUG_ResetClearFlagAll()for e=1,#TppQuestList.QUEST_DEFINE do
gvars.qst_questClearedFlag[e]=false
gvars.qst_questFailureFlag[e]=false
end
end
function e.DEBUG_ForceLoad(t)if t==0 then
return
end
local t=TppQuestList.QUEST_DEFINE[t]if not t then
return
end
local s=e.SearchBlockIndex(t)if s==0 then
return
end
TppCrew.UpdateActiveQuest(t)Mission.RecreateBaseCrew()e.UnloadCurrentQuestBlock(n[s])mvars.qst_reserveNextQuest[s]=t
end
end
return e