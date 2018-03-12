local e={}local S=256
local c=0
local l=1
local u=0
local s="base_defense_block"local i="BStep_Clear"local p=600
local n=Fox.StrCode32
local T=Tpp.StrCode32Table
local a=Tpp.IsTypeFunc
local r=Tpp.IsTypeTable
local n=Tpp.IsTypeString
local d=GkEventTimerManager.Start
local f=TppDefine.Enum{"NONE","DEACTIVATE","DEACTIVATING","ACTIVATE"}local t=TppDefine.Enum{"OPEN","CLEAR","FAILURE","UPDATE"}local m={"S_DISABLE_TARGET","S_DISABLE_NPC_NOTICE","S_DISABLE_PLAYER_DAMAGE","S_DISABLE_THROWING","S_DISABLE_PLACEMENT"}local o={}function e.RegisterStepList(e)if not r(e)then
return
end
local n=#e
if n==0 then
return
end
if n>=S then
return
end
table.insert(e,i)mvars.bdf_stepList=Tpp.Enum(e)end
function e.RegisterStepTable(n)if not r(n)then
return
end
e.RegisterResultStepTable(n)mvars.bdf_stepTable=n
end
function e.RegisterResultStepTable(e)e[i]={OnEnter=function()end,OnLeave=function()end}end
function e.RegisterSystemCallbacks(t)if not r(t)then
return
end
mvars.bdf_systemCallbacks=mvars.bdf_systemCallbacks or{}local function s(n,e)if a(n[e])then
mvars.bdf_systemCallbacks[e]=n[e]end
end
local e={"OnActivate","OnDeactivate","OnTerminate","OnGameStart"}for n=1,#e do
s(t,e[n])end
end
function e.SetNextStep(t)if not mvars.bdf_stepTable then
return
end
if not mvars.bdf_stepList then
return
end
local n=mvars.bdf_stepTable[t]local t=mvars.bdf_stepList[t]if n==nil then
return
end
if t==nil then
return
end
if(t~=l)and e.IsInvoking()then
local n=e.GetStepTable(gvars.bdf_currentStepNumber)local e=n.OnLeave
if a(e)then
e(n)end
end
gvars.bdf_currentStepNumber=t
local t=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
local e=e.GetBlockState()if mvars.bdf_allocated then
local e=n.OnEnter
if a(e)then
e(n)end
end
end
function e.ClearWithSave(t,n)if not n then
n=e.GetCurrentMissionName()end
TppStory.UpdateStorySequence{updateTiming="BaseDefenseEnd"}if t==TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR then
e.Clear(n)elseif t==TppDefine.BASE_DEFENSE_CLEAR_TYPE.FAILURE then
e.Failure(n)end
BaseDefenseManager.WaveEnd()TppStory.UpdateStorySequence{updateTiming="OnBaseDefenseClear"}e.Save()end
function e.Clear(n)if n==nil then
n=e.GetCurrentMissionName()if n==nil then
return
end
end
e.ShowAnnounceLog(t.CLEAR,n)e.PlayClearRadio(n)e.GetClearKeyItem(n)TppMission.OnClearDefenseGame()end
function e.Failure(n)if n==nil then
n=e.GetCurrentMissionName()if n==nil then
return
end
end
BaseDefenseManager.Failure()e.ShowAnnounceLog(t.FAILURE,n)end
function e.Save()TppMission.VarSaveOnUpdateCheckPoint()end
function e.SetClearFlag(e)end
function e.SetDestructionTime(e)mvars.destructionTime=e
end
function e.StartDestruction()mvars.isStartDestruction=true
Mission.StartBaseDestruction{destructionTime=mvars.destructionTime}end
function e.GetCurrentWaveIndex()return BaseDefenseManager.GetCurrentWaveIndex()end
function e.GetTotalWaveCount()return BaseDefenseManager.GetTotalWaveCount()end
function e.OnAllocate(n)local n=BaseDefenseManager.GetMissionCodeList()local t={}for e=1,#n do
local e="d"..tostring(n[e])table.insert(t,e)end
o=TppDefine.Enum(t)BaseDefenseManager.RegisterCallback{onStart=e.OnStart,onFinish=e.OnFinish,onReceiveReward=e.OnRecvReward,onOutOfArea=e.OnOutOfMissionArea,onEndAutoDefense=e.OnEndAutoDefense}end
function e.Init(n)e.OnInit()end
function e.OnReload(n)e.OnInit()end
function e.OnInit()e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())if not TppMission.IsFreeMission(vars.missionCode)then
return
end
local n=TppLocation.GetLocationName()if n then
e.InitializePackList(n)end
mvars.isStartDestruction=false
mvars.destructionTime=p
end
function e.OnStart(e,n,t)mvars.bdf_loadMissionName=nil
if e==TppDefine.MISSION_CODE_NONE then
return
end
mvars.bdf_loadMissionName=("d"..tostring(e))mvars.bdf_skipBreakDiggingGameOver=true
local e="/Assets/ssd/level_asset/defense_game/debug/"..(tostring(mvars.bdf_loadMissionName)..("_attack_"..(tostring(n)..".json")))Mission.LoadDefenseGameDataJson(e)if not t then
TppPauseMenu.SetIgnoreActorPause(true)TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeOutOnStartBaseDefense",TppUI.FADE_PRIORITY.MISSION)end
end
function e.OnFinish(n,a)mvars.bdf_isAbandon=n
mvars.bdf_skipBreakDiggingGameOver=false
if n then
Mission.SendMessage("Mission","AbandonBaseDefense")e.ShowAnnounceLog(t.FAILURE,missionName)e.StartRewardSequence(TppDefine.BASE_DEFENSE_CLEAR_TYPE.ABANDON)end
end
function e.OnRecvReward(e)mvars.bdf_rewardCount=e
end
function e.OnOutOfMissionArea()TppPlayer.StoreTempInitialPosition()TppMission.ContinueFromCheckPoint()end
function e.OnEndAutoDefense(e)if e then
TppStory.UpdateStorySequence{updateTiming="OnBaseDefenseClear"}local e=BaseDefenseManager.GetCurrentMissionCode()if e==TppDefine.BASE_DEFENSE_TUTORIAL_MISSION then
BaseDefenseManager.SetClosedFlag(TppDefine.BASE_DEFENSE_TUTORIAL_MISSION,true)end
end
end
function e.StartRewardSequence(a)if mvars.bdf_isStartRewardSequence then
return
end
local n=BaseDefenseManager.GetCurrentMissionCode()if n==TppDefine.MISSION_CODE_NONE then
return
end
mvars.bdf_isStartRewardSequence=true
local t=e.GetCurrentMissionName()if not t then
t="d"..tostring(n)end
Gimmick.SetAllSwitchInvalid(true)e.ClearWithSave(a,t)e.OnStartRewardSequence(a,n)end
function e.OnStartRewardSequence(n,t)Player.SetPadMask{settingName="BaseDiggingClearDefense",except=false,buttons=((PlayerPad.HOLD+PlayerPad.FIRE)+PlayerPad.CALL)+PlayerPad.SUBJECT}for n,e in ipairs(m)do
TppGameStatus.Set("BaseBaseDigging",e)end
TppUiStatusManager.SetStatus("PauseMenu","INVALID")SsdUiSystem.RequestForceCloseForMissionClear()if n==TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR then
DefenceTelopSystem.SetInfo(t,DefenceTelopType.Complete)elseif n==TppDefine.BASE_DEFENSE_CLEAR_TYPE.ABANDON then
DefenceTelopSystem.SetInfo(t,DefenceTelopType.Abort)else
DefenceTelopSystem.SetInfo(t,DefenceTelopType.Failure)end
TppMission.StopDefenseTotalTime()GkEventTimerManager.Start("Timer_BdfOpenTelopWait",1)if(n==TppDefine.BASE_DEFENSE_CLEAR_TYPE.ABANDON)or(n==TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR and BaseDefenseManager.IsTerminalWave())then
mvars.bdf_viewTotalResult=true
GkEventTimerManager.Start("Timer_BdfOpenRewardWormhole",4)GkEventTimerManager.Start("Timer_BdfDestroySingularityEffect",12)GkEventTimerManager.Start("Timer_BdfBaseDiggingFinish",35)else
mvars.bdf_viewTotalResult=false
e.CloseRewardWormhole()GkEventTimerManager.Start("Timer_BdfBaseDiggingFinish",10)end
end
function e.OpenRewardWormhole()local e=TppGimmick.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetRewardMode"}local n=TppGimmick.GetDiggerDefensePosition(TppGimmick.GetAfghBaseDiggerIdentifier())if not n then
return
end
local n=Vector3(n[1],n[2]+20,n[3])Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetTargetPos",position=n}Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Open"}end
function e.CloseRewardWormhole()local e=TppGimmick.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Close"}end
function e.StartResultSequence()ResultSystem.OpenBaseDefenseResult()end
function e.OpenRewardResult()TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeOutOnOpenBdfReward",TppUI.FADE_PRIORITY.MISSION)end
function e.Messages()return T{GameObject={{msg="DiggingStartEffectEnd",func=function()if mvars.bdf_isStartRewardSequence then
GkEventTimerManager.Start("Timer_BdfCloseRewardWormhole",5)end
end}},Marker={{msg="ChangeToEnable",func=function(t,n,a,s)e._ChangeToEnable(t,n,a,s)end}},Timer={{msg="Finish",sender="Timer_BdfCheckUnload",func=function(n)local t=function()TppMain.EnablePlayerPad()if TppMission.IsInitMission(vars.missionCode)then
return
end
end
e._CheckUnloadBlock(n,"FadeInOnFinishDefense",t)end},{msg="Finish",sender="Timer_BdfRewardDrop",func=function(e)local e=BaseDefenseManager.DropRewardBox()if not e then
end
end},{msg="Finish",sender="Timer_BdfOpenTelopWait",func=function()DefenceTelopSystem.RequestOpen()end},{msg="Finish",sender="Timer_BdfCloseRewardWormhole",func=e.CloseRewardWormhole},{msg="Finish",sender="Timer_BdfOpenRewardWormhole",func=function()e.OpenRewardWormhole()end},{msg="Finish",sender="Timer_BdfDestroySingularityEffect",func=function()local e=TppGimmick.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="StopRewardWormhole"}end},{msg="Finish",sender="Timer_BdfBaseDiggingFinish",func=function()if mvars.bdf_viewTotalResult then
d("Timer_BdfRewardDrop",.1)end
e.StartResultSequence()e.SetNextStep(i)end}},UI={{msg="EndFadeOut",sender="FadeOutOnStartBaseDefense",func=function()TppMain.DisablePlayerPad()TppEnemy.SetEnemyLevelForBaseDefense()TppQuest.SetUnloadableAll(true)SsdBuildingMenuSystem.CloseBuildingMenu()SsdUiSystem.RequestForceCloseForMissionClear()e.LoadMission(mvars.bdf_loadMissionName)end},{msg="EndFadeOut",sender="FadeOutOnFinishBaseDefense",func=function()TppMain.DisablePlayerPad()e.UnloadBaseDefenseBlock()BaseDefenseManager.Finish()mvars.bdf_nextWaveWaitHour=0
mvars.bdf_isAbandon=false
mvars.bdf_isStartRewardSequence=false
mvars.bdf_viewTotalResult=false
SsdRewardCbox.ClearAll()TppMission.StopDefenseGame()TppPauseMenu.SetIgnoreActorPause(false)Gimmick.SetAllSwitchInvalid(false)local e=TppStory.GetCurrentStorySequence()TppEnemy.SetEnemyLevelBySequence(e)TppQuest.SetUnloadableAll(false)d("Timer_BdfCheckUnload",1)end},{msg="EndFadeIn",sender="FadeInOnStartDefense",func=function()TppMain.EnablePlayerPad()end},{msg="EndFadeIn",sender="FadeInOnFinishDefense",func=function()BaseDefenseManager.OpenNextWaveTime{displayTime=10}end},{msg="BaseDefenseMissionResultClosed",func=e.OpenRewardResult,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="BaseDefenseRewardClosed",func=e.FinishWave,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="FadeOutOnOpenBdfReward",func=function()if mvars.bdf_viewTotalResult then
TppMain.DisablePlayerPad()BaseDefenseRewardSystem.RequestOpen()else
e.FinishWave()end
end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}}}}end
function e.OnMessage(o,s,t,a,r,i,n)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,o,s,t,a,r,i,n)local l=mvars.bdf_scriptBlockMessageExecTable
if l then
local e=n
Tpp.DoMessage(l,TppMission.CheckMessageOption,o,s,t,a,r,i,e)end
if e.IsInvoking()and mvars.bdf_stepList then
local l=gvars.bdf_currentStepNumber
local e=e.GetStepTable(l)if e then
local e=e._messageExecTable
if e then
local n=n
Tpp.DoMessage(e,TppMission.CheckMessageOption,o,s,t,a,r,i,n)end
end
end
end
function e.OnDeactivate(e)end
function e.InitializePackList(e)if e~="afgh"then
return
end
mvars.loadedInfoList={}local e={}local n=BaseDefenseManager.GetMissionCodeList()local t="/Assets/ssd/pack/mission/defense/d50010/d50010.fpk"for a=1,#n do
local n=n[a]local n="d"..tostring(n)e[n]={}table.insert(mvars.loadedInfoList,n)table.insert(e[n],t)end
TppScriptBlock.RegisterCommonBlockPackList(s,e)end
function e.InitializeActiveStatus()local n=e.GetBlockState()if n==nil then
return
end
if n==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
return
end
mvars.bdf_requestInitializeActiveStatus=false
if n<ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE or not e._CanActivate()then
mvars.bdf_requestInitializeActiveStatus=true
return
end
gvars.bdf_currentStepNumber=l
local n=mvars.bdf_stepList[gvars.bdf_currentStepNumber]e.SetNextStep(n)end
function e.IsSkipBreakDiggingGameOver()return(mvars.bdf_skipBreakDiggingGameOver==true)end
function e.ResetSkipBreakDiggingGameOverFlag()mvars.bdf_skipBreakDiggingGameOver=false
end
function e.QARELEASE_DEBUG_Init()local e
if DebugMenu then
e=DebugMenu
else
return
end
mvars.qaDebug.historyBdfStep={}mvars.qaDebug.showCurrentBdfState=false
e.AddDebugMenu("LuaBaseDefense","showCurrentState","bool",mvars.qaDebug,"showCurrentBdfState")mvars.qaDebug.forceBdfClear=false
e.AddDebugMenu("LuaBaseDefense","forceClear","bool",mvars.qaDebug,"forceBdfClear")mvars.qaDebug.forceBdfFail=false
e.AddDebugMenu("LuaBaseDefense","forceFail","bool",mvars.qaDebug,"forceBdfFail")mvars.qaDebug.forceBdfLoad=false
e.AddDebugMenu("LuaBaseDefense","forceLoad","bool",mvars.qaDebug,"forceBdfLoad")mvars.qaDebug.forceBdfLoadIndex=0
e.AddDebugMenu("LuaBaseDefense","forceLoadIndex","int32",mvars.qaDebug,"forceBdfLoadIndex")end
function e.QAReleaseDebugUpdate()local n=DebugText.Print
local t=DebugText.NewContext()local i=BaseDefenseManager.GetMissionCodeList()local s=#i
if mvars.qaDebug.forceBdfClear then
mvars.qaDebug.forceBdfClear=false
local n=e.GetCurrentMissionName()if n then
e.ClearWithSave(TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR,n)end
e.UnloadBaseDefenseBlock()end
if mvars.qaDebug.forceBdfFail then
mvars.qaDebug.forceBdfFail=false
local n=e.GetCurrentMissionName()if n then
e.ClearWithSave(TppDefine.BASE_DEFENSE_CLEAR_TYPE.FAILURE,n)end
e.UnloadBaseDefenseBlock()end
if mvars.qaDebug.showCurrentBdfState then
n(t,"")n(t,{.5,.5,1},"BaseDefense showCurrentState")local a=e.GetCurrentMissionName()if not a then
n(t,"Current Mission : -----")else
n(t,"Current Mission : "..tostring(a))end
local a=e.GetBlockState()if a==nil then
n(t,"Block State : BASE DEFENSE BLOCK isn't found...")return
end
local e={}e[ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY]="EMPTY"e[ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING]="PROCESSING"e[ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE]="INACTIVE"e[ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE]="ACTIVE"n(t,"Block State : "..tostring(e[a]))n(t,"gvars.bdf_currentMissionName : "..tostring(gvars.bdf_currentMissionName))n(t,"gvars.bdf_currentStepNumber : "..tostring(gvars.bdf_currentStepNumber))if not mvars.bdf_stepList then
n(t,"Sequence is not Defined...")else
local e=gvars.bdf_currentStepNumber
local e=mvars.bdf_stepList[e]n(t,"Current Sequence : "..tostring(e))end
n(t,"--- Base Destruction State ---")if mvars.isStartDestruction then
n(t,"DestructionTime[sec] : "..tostring(mvars.destructionTime))local e=Mission.GetBaseDestructionRate()n(t,"   BaseDamageRate[%] : "..tostring(e*100))else
n(t,"Destruction isn't started yet...")end
n(t,"")n(t,"--- BaseDefense ThreatValue ---")end
do
if s==0 then
mvars.qaDebug.forceBdfLoadIndex=0
elseif mvars.qaDebug.forceBdfLoadIndex>s then
mvars.qaDebug.forceBdfLoadIndex=0
end
end
if mvars.qaDebug.forceBdfLoad then
local n=mvars.qaDebug.forceBdfLoadIndex
mvars.qaDebug.forceBdfLoadIndex=0
mvars.qaDebug.forceBdfLoad=false
if n==0 then
return
end
local n=i[n]if not n then
return
else
local n="d"..tostring(n)e.LoadMission(n)end
end
end
function e.OnInitialize(n)local t=n.Messages
if a(t)then
local e=t()mvars.bdf_scriptBlockMessageExecTable=Tpp.MakeMessageExecTable(e)end
e.MakeStepMessageExecTable()e._ResetMissionInfo(n)end
function e._ResetMissionInfo(t)local n=e.GetCurrentMissionName()if not n then
local n=t.missionName
if n then
e.ResetMissionStatus()e.SetCurrentMissionName(n)end
end
end
function e.OnTerminate()e.ExecuteSystemCallback"OnTerminate"mvars.bdf_systemCallbacks=nil
mvars.bdf_lastBlockState=nil
mvars.bdf_stepList=nil
mvars.bdf_stepTable=nil
gvars.bdf_currentStepNumber=c
mvars.bdf_scriptBlockMessageExecTable=nil
mvars.bdf_rewardCount=0
e.ClearCurrentMissionName()local e=ScriptBlock.GetScriptBlockId(s)TppScriptBlock.FinalizeScriptBlockState(e)TppMission.OnEndDefenseGame()TppMission.EnableBaseCheckPoint()end
function e._CanActivate()if BaseDefenseManager.IsBusy()then
return false
end
return true
end
function e.OnUpdate()local s=e.GetBlockState()if s==nil then
return
end
local t=ScriptBlock
local n=mvars
local i=n.bdf_lastBlockState
local r=t.SCRIPT_BLOCK_STATE_INACTIVE
local t=t.SCRIPT_BLOCK_STATE_ACTIVE
if n.bdf_requestInitializeActiveStatus then
e.InitializeActiveStatus()return
end
if s==r then
if e._CanActivate()then
e.ActivateBaseDefenseBlock()e.ClearBlockStateRequest()end
n.bdf_lastInactiveToActive=false
elseif s==t then
if not e._CanActivate()then
return
end
local t
if e.IsInvoking()then
t=e.GetStepTable(gvars.bdf_currentStepNumber)end
if n.bdf_lastInactiveToActive then
n.bdf_lastInactiveToActive=false
n.bdf_deactivated=false
e.ExecuteSystemCallback"OnActivate"n.bdf_allocated=true
e.Invoke()t=e.GetStepTable(gvars.bdf_currentStepNumber)e.ExecuteSystemCallback("OnGameStart",BaseDefenseManager.GetCurrentWaveIndex())BaseDefenseManager.RestoreScore()do
local e={-441.836,288.34,2232.67}local n=TppPlayer.GetPosition()local n=TppMath.FindDistance(e,n)local e={-441.8,288.15,2234}if n<4 then
TppPlayer.Warp{pos=e,rotY=0}Player.RequestToSetCameraRotation{rotX=20,rotY=-141,interpTime=0}end
end
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeInOnStartDefense",TppUI.FADE_PRIORITY.MISSION)end
if(not i)or i<=r then
n.bdf_lastInactiveToActive=true
end
if t and a(t.OnUpdate)then
t.OnUpdate(t)end
if n.bdf_blockStateRequest==f.DEACTIVATE then
e.DeactivateBaseDefenseBlock()e.ClearBlockStateRequest()end
else
n.bdf_lastInactiveToActive=false
e.ClearBlockStateRequest()end
n.bdf_lastBlockState=s
end
function e.GetOpenableMissionList()local e={}if not mvars.loadedInfoList then
return e
end
if#mvars.loadedInfoList==0 then
return e
end
for n=1,#mvars.loadedInfoList do
local n=mvars.loadedInfoList[n]table.insert(e,n)end
return e
end
function e.OnMissionGameEnd()local n=e.GetBlockState()if not n then
return
end
mvars.bdf_isMissionEnd=true
if n==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
e._DoDeactivate()end
end
function e.ClearBlockStateRequest()mvars.bdf_blockStateRequest=f.NONE
end
function e.Invoke()gvars.bdf_currentStepNumber=l
local n=mvars.bdf_stepList[gvars.bdf_currentStepNumber]e.SetNextStep(n)end
function e.LoadMission(n)local t=TppScriptBlock.Load(s,n)if t==false then
return
end
e.ResetMissionStatus()e.SetCurrentMissionName(n)TppMission.DisableBaseCheckPoint()end
function e.GetCurrentMissionName()return mvars.bdf_currentMissionName
end
function e.SetCurrentMissionName(e)mvars.bdf_currentMissionName=e
gvars.bdf_currentMissionName=Fox.StrCode32(e)end
function e.ClearCurrentMissionName()mvars.bdf_currentMissionName=nil
gvars.bdf_currentMissionName=u
end
function e.ResetMissionStatus()gvars.bdf_currentMissionName=u
gvars.bdf_currentStepNumber=c
end
function e.UnloadBaseDefenseBlock()TppScriptBlock.Unload(s)end
function e.ActivateBaseDefenseBlock()local e=ScriptBlock.GetScriptBlockId(s)TppScriptBlock.ActivateScriptBlockState(e)end
function e.DeactivateBaseDefenseBlock()local e=ScriptBlock.GetScriptBlockId(s)TppScriptBlock.DeactivateScriptBlockState(e)end
function e.ExecuteSystemCallback(e,n)if mvars.bdf_systemCallbacks==nil then
return
end
local e=mvars.bdf_systemCallbacks[e]if e then
return e(n)end
end
function e.IsInvoking()if gvars.bdf_currentStepNumber~=c then
return true
else
return false
end
end
function e.IsRepop(e)end
function e.IsOpen(e)end
function e.IsActive(e)end
function e.IsCleared(e)local e=tonumber(string.sub(e,-5))return BaseDefenseManager.IsCleared(e)end
function e.IsEnd(n)if n==nil then
n=e.GetCurrentMissionName()if n==nil then
return
end
end
if mvars.bdf_stepList[gvars.bdf_currentStepNumber]==i then
return true
end
return false
end
function e._DoDeactivate()mvars.bdf_deactivated=true
e.ExecuteSystemCallback"OnDeactivate"mvars.bdf_allocated=false
end
function e.MakeStepMessageExecTable()if not r(mvars.bdf_stepTable)then
return
end
for n,e in pairs(mvars.bdf_stepTable)do
local n=e.Messages
if a(n)then
local n=n(e)e._messageExecTable=Tpp.MakeMessageExecTable(n)end
end
end
function e.GetStepTable(e)if mvars.bdf_stepList==nil then
return
end
local e=mvars.bdf_stepList[e]if e==nil then
return
end
local e=mvars.bdf_stepTable[e]if e~=nil then
return e
else
return
end
end
function e.GetBlockState()local e=ScriptBlock.GetScriptBlockId(s)if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
return
end
return ScriptBlock.GetScriptBlockState(e)end
function e.PlayClearRadio(e)end
function e.GetClearKeyItem(e)end
function e.ShowAnnounceLog(e,e,e,e)end
function e._ChangeToEnable(e,e,e,e)end
function e.IsMissionActivated()return e.GetBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
end
function e.SetWaveIntervalTime(e)mvars.bdf_nextWaveWaitHour=e
end
function e.FinishWave()Player.ResetPadMask{settingName="BaseDiggingClearDefense"}for n,e in ipairs(m)do
TppGameStatus.Reset("BaseBaseDigging",e)end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnFinishBaseDefense",TppUI.FADE_PRIORITY.MISSION)end
function e._CheckUnloadBlock(s,t,n)local e=e.GetBlockState()if e==nil then
if n and a(n)then
n()end
Mission.SendMessage("Mission","OnBaseDefenseEnd")TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,t,TppUI.FADE_PRIORITY.MISSION)return
end
if e==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
if n and a(n)then
n()end
Mission.SendMessage("Mission","OnBaseDefenseEnd")TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,t,TppUI.FADE_PRIORITY.MISSION)else
d(s,1)end
end
return e