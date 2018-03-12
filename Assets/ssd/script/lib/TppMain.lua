local e={}local o=Tpp.ApendArray
local n=Tpp.DEBUG_StrCode32ToString
local i=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local _=TppScriptVars.IsSavingOrLoading
local E=ScriptBlock.UpdateScriptsInScriptBlocks
local M=Mission.GetCurrentMessageResendCount
local s={}local r=0
local u={}local a=0
local T={}local m=0
local S={}local f=0
local c={}local I={}local p=0
local d={}local A={}local l=0
local function n()if QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD then
QuarkSystem.PostRequestToLoad()coroutine.yield()while QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD do
coroutine.yield()end
end
end
function e.DisableGameStatus()TppMission.DisableInGameFlag()Tpp.SetGameStatus{target="all",enable=false,except={S_DISABLE_NPC=false},scriptName="TppMain.lua"}end
function e.DisableGameStatusOnGameOverMenu()TppMission.DisableInGameFlag()Tpp.SetGameStatus{target="all",enable=false,scriptName="TppMain.lua"}end
function e.EnableGameStatus()TppMission.EnableInGameFlag()Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true,S_DISABLE_HUD=true},enable=true,scriptName="TppMain.lua"}end
function e.EnableGameStatusForDemo()TppDemo.ReserveEnableInGameFlag()Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true,S_DISABLE_HUD=true},enable=true,scriptName="TppMain.lua"}end
function e.EnableAllGameStatus()TppMission.EnableInGameFlag()Tpp.SetGameStatus{target="all",enable=true,scriptName="TppMain.lua"}end
function e.EnablePlayerPad()TppGameStatus.Reset("TppMain.lua","S_DISABLE_PLAYER_PAD")end
function e.DisablePlayerPad()TppGameStatus.Set("TppMain.lua","S_DISABLE_PLAYER_PAD")end
function e.EnablePause()TppPause.RegisterPause"TppMain.lua"end
function e.DisablePause()TppPause.UnregisterPause"TppMain.lua"end
function e.EnableBlackLoading(e)TppGameStatus.Set("TppMain.lua","S_IS_BLACK_LOADING")if e then
TppUI.StartLoadingTips()end
end
function e.DisableBlackLoading()TppGameStatus.Reset("TppMain.lua","S_IS_BLACK_LOADING")TppUI.FinishLoadingTips()end
function e.OnAllocate(n)TppWeather.OnEndMissionPrepareFunction()e.DisableGameStatus()e.EnablePause()TppClock.Stop()s={}r=0
T={}m=0
if(Tpp.IsQARelease()or nil)then
TppDebug.RequestResetPlayLog()end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,TppUI.FADE_PRIORITY.SYSTEM)TppSave.WaitingAllEnqueuedSaveOnStartMission()TppMission.InitializeCoopMission()Mission.Start()TppMission.WaitFinishMissionEndPresentation()TppMission.DisableInGameFlag()if(Tpp.IsQARelease()or nil)then
mvars.qaDebug={}TppSave.QARELEASE_DEBUG_Init()TppDebug.QARELEASE_DEBUG_Init()TppStory.QARELEASE_DEBUG_Init()TppEnemy.QARELEASE_DEBUG_Init()TppQuest.QARELEASE_DEBUG_Init()TppRadio.QARELEASE_DEBUG_Init()SsdFlagMission.QARELEASE_DEBUG_Init()SsdBaseDefense.QARELEASE_DEBUG_Init()SsdCreatureBlock.QARELEASE_DEBUG_Init()TppAnimalBlock.QARELEASE_DEBUG_Init()end
TppException.OnAllocate(n)TppClock.OnAllocate(n)TppTrap.OnAllocate(n)TppCheckPoint.OnAllocate(n)TppUI.OnAllocate(n)TppDemo.OnAllocate(n)TppScriptBlock.OnAllocate(n)TppSound.OnAllocate(n)TppPlayer.OnAllocate(n)TppMission.OnAllocate(n)TppTerminal.OnAllocate(n)TppEnemy.OnAllocate(n)TppRadio.OnAllocate(n)TppGimmick.OnAllocate(n)TppMarker.OnAllocate(n)e.ClearStageBlockMessage()TppQuest.OnAllocate(n)TppAnimal.OnAllocate(n)SsdFlagMission.OnAllocate(n)SsdBaseDefense.OnAllocate(n)SsdCreatureBlock.OnAllocate(n)local function a()if TppLocation.IsAfghan()then
if afgh then
afgh.OnAllocate()end
elseif TppLocation.IsMiddleAfrica()then
if mafr then
mafr.OnAllocate()end
end
end
a()if n.sequence then
if i(n.sequence.MissionPrepare)then
n.sequence.MissionPrepare()end
if i(n.sequence.OnEndMissionPrepareSequence)then
TppSequence.SetOnEndMissionPrepareFunction(n.sequence.OnEndMissionPrepareSequence)end
end
for n,e in pairs(n)do
if i(e.OnLoad)then
e.OnLoad()end
end
do
local s={}for i,e in ipairs(Tpp._requireList)do
if _G[e]then
if _G[e].DeclareSVars then
o(s,_G[e].DeclareSVars(n))end
end
end
local a={}for n,e in pairs(n)do
if i(e.DeclareSVars)then
o(a,e.DeclareSVars())end
if t(e.saveVarsList)then
o(a,TppSequence.MakeSVarsTable(e.saveVarsList))end
end
o(s,a)TppScriptVars.DeclareSVars(s)Mission.RegisterUserSvars()TppScriptVars.SetSVarsNotificationEnabled(false)while _()do
coroutine.yield()end
while not SsdSaveSystem.IsIdle()do
coroutine.yield()end
TppRadioCommand.SetScriptDeclVars()if gvars.ini_isTitleMode then
TppPlayer.MissionStartPlayerTypeSetting()else
if TppMission.IsMissionStart()then
TppVarInit.InitializeForNewMission(n)TppPlayer.MissionStartPlayerTypeSetting()TppSave.VarSave(vars.missionCode,true)else
TppVarInit.InitializeForContinue(n)end
TppVarInit.ClearIsContinueFromTitle()end
TppUiCommand.ExcludeNonPermissionContents()if(not TppMission.IsDefiniteMissionClear())then
TppTerminal.StartSyncMbManagementOnMissionStart()end
TppPlayer.FailSafeInitialPositionForFreePlay()e.StageBlockCurrentPosition(true)TppMission.SetSortieBuddy()if n.sequence then
local e=n.sequence.DISABLE_BUDDY_TYPE
if e then
local n
if t(e)then
n=e
else
n={e}end
for n,e in ipairs(n)do
TppBuddyService.SetDisableBuddyType(e)end
end
end
if TppGameSequence.GetGameTitleName()=="TPP"then
if n.sequence and n.sequence.OnBuddyBlockLoad then
n.sequence.OnBuddyBlockLoad()end
if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica()then
TppBuddy2BlockController.Load()end
end
TppSequence.SaveMissionStartSequence()TppScriptVars.SetSVarsNotificationEnabled(true)end
if n.enemy then
if t(n.enemy.soldierPowerSettings)then
TppEnemy.SetUpPowerSettings(n.enemy.soldierPowerSettings)end
end
if TppEquip.CreateEquipMissionBlockGroup then
if(vars.missionCode>6e4)then
TppEquip.CreateEquipMissionBlockGroup{size=(380*1024)*24}else
TppPlayer.SetEquipMissionBlockGroupSize()end
end
if TppEquip.CreateEquipGhostBlockGroups then
TppEquip.CreateEquipGhostBlockGroups{ghostCount=3}end
TppEquip.StartLoadingToEquipMissionBlock()TppPlayer.SetMaxPickableLocatorCount()TppPlayer.SetMaxPlacedLocatorCount()TppEquip.AllocInstances{instance=60,realize=60}TppEquip.ActivateEquipSystem()if TppEnemy.IsRequiredToLoadDefaultSoldier2CommonPackage()then
TppEnemy.LoadSoldier2CommonBlock()end
mvars.mis_skipServerSave=false
if n.sequence then
mvars.mis_baseList=n.sequence.baseList
TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)if n.sequence.SKIP_SERVER_SAVE then
mvars.mis_skipServerSave=true
end
end
end
function e.OnInitialize(n)TppCheckPoint.SetCheckPointPosition()if TppEnemy.IsRequiredToLoadSpecialSolider2CommonBlock()then
TppEnemy.LoadSoldier2CommonBlock()end
if TppMission.IsMissionStart()then
TppTrap.InitializeVariableTraps()else
TppTrap.RestoreVariableTrapState()end
TppAnimalBlock.InitializeBlockStatus()SsdCreatureBlock.InitializeBlockStatus()TppQuest.RegisterQuestPackList(TppQuestList.questPackList)TppQuest.RegisterQuestList(TppQuestList.questList)if n.enemy then
TppReinforceBlock.SetUpReinforceBlock()end
for t,e in pairs(n)do
if i(e.Messages)then
n[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
end
if mvars.loc_locationCommonTable then
mvars.loc_locationCommonTable.OnInitialize()end
for i,e in ipairs(Tpp._requireList)do
if _G[e].Init then
_G[e].Init(n)end
end
if n.enemy then
if t(n.enemy.soldierDefine)then
TppEnemy.DefineSoldiers(n.enemy.soldierDefine)end
if n.enemy.InitEnemy and i(n.enemy.InitEnemy)then
n.enemy.InitEnemy()end
if t(n.enemy.soldierPersonalAbilitySettings)then
TppEnemy.SetUpPersonalAbilitySettings(n.enemy.soldierPersonalAbilitySettings)end
if t(n.enemy.travelPlans)then
TppEnemy.SetTravelPlans(n.enemy.travelPlans)end
TppEnemy.SetUpSoldiers()if t(n.enemy.soldierDefine)then
TppEnemy.InitCpGroups()TppEnemy.RegistCpGroups(n.enemy.cpGroups)TppEnemy.SetCpGroups()if mvars.loc_locationGimmickCpConnectTable then
TppGimmick.SetCommunicateGimmick(mvars.loc_locationGimmickCpConnectTable)end
end
do
local e
if t(n.enemy.routeSets)then
e=n.enemy.routeSets
for e,n in pairs(e)do
if not t(mvars.ene_soldierDefine[e])then
end
end
end
if e then
TppEnemy.RegisterRouteSet(e)TppEnemy.MakeShiftChangeTable()TppEnemy.SetUpCommandPost()TppEnemy.SetUpSwitchRouteFunc()end
end
if n.enemy.soldierSubTypes then
TppEnemy.SetUpSoldierSubTypes(n.enemy.soldierSubTypes)end
TppEneFova.ApplyUniqueSetting()if n.enemy.SetUpEnemy and i(n.enemy.SetUpEnemy)then
n.enemy.SetUpEnemy()end
if TppMission.IsMissionStart()then
TppEnemy.RestoreOnMissionStart2()else
TppEnemy.RestoreOnContinueFromCheckPoint2()end
end
if not TppMission.IsMissionStart()then
TppWeather.RestoreFromSVars()end
local t=vars.missionCode
if TppMission.IsStoryMission(t)or TppMission.IsFreeMission(t)then
local e=true
if gvars.mis_skipUpdateBaseManagement then
e=false
end
BaseDefenseManager.Restore(e)gvars.mis_skipUpdateBaseManagement=false
end
TppMarker.RestoreMarkerLocator()TppTerminal.MakeMessage()if n.sequence then
local e=n.sequence.SetUpRoutes
if e and i(e)then
e()end
TppEnemy.RegisterRouteAnimation()local e=n.sequence.SetUpLocation
if e and i(e)then
e()end
end
for n,e in pairs(n)do
if e.OnRestoreSVars then
e.OnRestoreSVars()end
end
TppMission.RestoreShowMissionObjective()if TppPickable.StartToCreateFromLocators then
TppPickable.StartToCreateFromLocators()end
if TppPlaced and TppPlaced.StartToCreateFromLocators then
TppPlaced.StartToCreateFromLocators()end
if TppMission.IsMissionStart()then
TppRadioCommand.RestoreRadioState()else
TppRadioCommand.RestoreRadioStateContinueFromCheckpoint()end
TppMission.SetPlayRecordClearInfo()TppMission.PostMissionOrderBoxPositionToBuddyDog()e.SetUpdateFunction(n)e.SetMessageFunction(n)TppQuest.UpdateActiveQuest()TppQuest.AcquireKeyItemOnMissionStart()TppUI.HideAccessIcon()end
function e.SetUpdateFunction(e)s={}r=0
u={}a=0
T={}m=0
s={TppMission.Update,TppSequence.Update,TppSave.Update,TppDemo.Update,TppPlayer.Update,TppMission.UpdateForMissionLoad}r=#s
for n,e in pairs(e)do
if i(e.OnUpdate)then
a=a+1
u[a]=e.OnUpdate
end
end
if(Tpp.IsQARelease()or nil)then
S={TppSave.QAReleaseDebugUpdate,TppDebug.QAReleaseDebugUpdate,TppStory.QAReleaseDebugUpdate,TppEnemy.QAReleaseDebugUpdate,TppQuest.QAReleaseDebugUpdate,TppRadio.QAReleaseDebugUpdate,SsdFlagMission.QAReleaseDebugUpdate,SsdBaseDefense.QAReleaseDebugUpdate,SsdCreatureBlock.QAReleaseDebugUpdate,TppAnimalBlock.QAReleaseDebugUpdate}f=#S
end
end
function e.OnEnterMissionPrepare()TppScriptBlock.PreloadSettingOnMissionStart()TppScriptBlock.ReloadScriptBlock()end
function e.OnTextureLoadingWaitStart()StageBlockCurrentPositionSetter.SetEnable(false)gvars.canExceptionHandling=true
end
function e.OnMissionStartSaving()end
function e.OnMissionCanStart()TppWeather.SetDefaultWeatherProbabilities()TppWeather.SetDefaultWeatherDurations()if TppMission.IsMissionStart()then
end
SsdCreatureBlock.InitializeLoad()TppLocation.ActivateBlock()TppWeather.OnMissionCanStart()TppMarker.OnMissionCanStart()TppResult.OnMissionCanStart()TppQuest.InitializeQuestLoad()TppRatBird.OnMissionCanStart()TppMission.OnMissionStart()SsdFlagMission.InitializeMissionLoad()TppPlayer.OnMissionCanStart()if mvars.loc_locationCommonTable then
mvars.loc_locationCommonTable.OnMissionCanStart()end
if(Tpp.IsQARelease()or nil)then
if TPP_FOCUS_TEST_BUILD or TPP_ENABLE_PLAY_LOG_START then
TppDebug.SetPlayLogEnabled(true)end
end
TppOutOfMissionRangeEffect.Disable(0)if TppLocation.IsMiddleAfrica()then
TppGimmick.MafrRiverPrimSetting()end
end
function e.OnMissionGameStart(n)if gvars.sav_needCheckPointSaveOnMissionStart then
TppMission.VarSaveOnUpdateCheckPoint()gvars.sav_needCheckPointSaveOnMissionStart=false
else
TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.MISSION_START)end
TppClock.Start()if not gvars.ini_isTitleMode then
PlayRecord.RegistPlayRecord"MISSION_START"end
TppQuest.InitializeQuestActiveStatus()SsdFlagMission.InitializeActiveStatus()SsdBaseDefense.InitializeActiveStatus()if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
e.EnableGameStatusForDemo()else
e.EnableGameStatus()end
if Player.RequestChickenHeadSound~=nil then
Player.RequestChickenHeadSound()end
TppTerminal.OnMissionGameStart()if TppSequence.IsLandContinue()then
TppMission.EnableAlertOutOfMissionAreaIfAlertAreaStart()end
TppUI.SetCoopFullUiLockType()TppSoundDaemon.ResetMute"Telop"end
function e.ClearStageBlockMessage()StageBlock.ClearLargeBlockNameForMessage()StageBlock.ClearSmallBlockIndexForMessage()end
function e.ReservePlayerLoadingPosition(n,s,i,t,a,o,p)e.DisableGameStatus()if n==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
if i then
TppPlayer.ResetInitialPosition()TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)TppPlayer.ResetNoOrderBoxMissionStartPosition()TppMission.ResetIsStartFromFreePlay()if t then
TppPlayer.ResetMissionStartPosition()elseif p then
TppPlayer.SetMissionStartPositionToBaseFastTravelPoint()else
TppPlayer.SetMissionStartPositionToCurrentPosition()end
else
TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()if s then
TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)TppMission.SetIsStartFromFreePlay()else
TppPlayer.ResetNoOrderBoxMissionStartPosition()TppMission.ResetIsStartFromFreePlay()end
end
elseif n==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
TppPlayer.ResetInitialPosition()TppMission.ResetIsStartFromFreePlay()if a then
if i then
TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)if t then
TppPlayer.ResetMissionStartPosition()else
TppPlayer.SetMissionStartPositionToCurrentPosition()end
TppPlayer.ResetNoOrderBoxMissionStartPosition()elseif vars.missionCode~=TppDefine.SYS_MISSION_ID.TITLE then
end
else
if i then
TppMission.SetMissionOrderBoxPosition()elseif vars.missionCode~=TppDefine.SYS_MISSION_ID.TITLE then
end
end
elseif n==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
elseif n==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
end
if o then
Mission.AddLocationFinalizer(function()e.StageBlockCurrentPosition()end)else
e.StageBlockCurrentPosition()end
end
function e.StageBlockCurrentPosition(e)if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)else
StageBlockCurrentPositionSetter.SetEnable(false)end
end
function e.OnReload(n)for t,e in pairs(n)do
if i(e.OnLoad)then
e.OnLoad()end
if i(e.Messages)then
n[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
end
if n.enemy then
if t(n.enemy.routeSets)then
TppClock.UnregisterClockMessage"ShiftChangeAtNight"TppClock.UnregisterClockMessage"ShiftChangeAtMorning"TppClock.UnregisterClockMessage"ShiftChangeAtMidNight"TppEnemy.RegisterRouteSet(n.enemy.routeSets)TppEnemy.MakeShiftChangeTable()end
end
for i,e in ipairs(Tpp._requireList)do
if _G[e].OnReload then
_G[e].OnReload(n)end
end
if mvars.loc_locationCommonTable then
mvars.loc_locationCommonTable.OnReload()end
if n.sequence then
TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)end
e.SetUpdateFunction(n)e.SetMessageFunction(n)end
function e.OnUpdate(e)local e
local i=s
local n=u
local e=T
for e=1,r do
i[e]()end
for e=1,a do
n[e]()end
E()if(Tpp.IsQARelease()or nil)then
for e=1,f do
S[e]()end
end
end
function e.OnChangeSVars(n,e,i)if(Tpp.IsQARelease()or nil)then
if(TppDebug.DEBUG_SkipOnChangeSVarsLog[e]==nil)then
end
end
for t,n in ipairs(Tpp._requireList)do
if _G[n].OnChangeSVars then
_G[n].OnChangeSVars(e,i)end
end
end
function e.SetMessageFunction(e)c={}p=0
d={}l=0
for n,e in ipairs(Tpp._requireList)do
if _G[e].OnMessage then
p=p+1
c[p]=_G[e].OnMessage
end
end
for n,i in pairs(e)do
if e[n]._messageExecTable then
l=l+1
d[l]=e[n]._messageExecTable
end
end
end
function e.OnMessage(s,e,n,i,a,o,t)local r=mvars
local s=""local S
local u=Tpp.DoMessage
local T=TppMission.CheckMessageOption
local S=TppDebug
local S=I
local S=A
local S=TppDefine.MESSAGE_GENERATION[e]and TppDefine.MESSAGE_GENERATION[e][n]if not S then
S=TppDefine.DEFAULT_MESSAGE_GENERATION
end
local m=M()if m<S then
return Mission.ON_MESSAGE_RESULT_RESEND
end
for p=1,p do
local s=s
c[p](e,n,i,a,o,t,s)end
for p=1,l do
local s=s
u(d[p],T,e,n,i,a,o,t,s)end
SsdFlagMission.OnSubScriptMessage(e,n,i,a,o,t,s)if r.loc_locationCommonTable then
r.loc_locationCommonTable.OnMessage(e,n,i,a,o,t,s)end
if r.order_box_script then
r.order_box_script.OnMessage(e,n,i,a,o,t,s)end
if TppAnimalBlock.OnMessage then
TppAnimalBlock.OnMessage(e,n,i,a,o,t,s)end
end
function e.OnTerminate(e)if e.sequence then
if i(e.sequence.OnTerminate)then
e.sequence.OnTerminate()end
end
Mission.ResetVarsList()end
return e