local e={}local r=Tpp.ApendArray
local n=Tpp.DEBUG_StrCode32ToString
local i=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local P=TppScriptVars.IsSavingOrLoading
local h=ScriptBlock.UpdateScriptsInScriptBlocks
local M=Mission.GetCurrentMessageResendCount
local a={}local l=0
local u={}local o=0
local c={}local m=0
local T={}local f=0
local d={}local I={}local s=0
local S={}local y={}local p=0
local function n()if QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD then
QuarkSystem.PostRequestToLoad()coroutine.yield()while QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD do
coroutine.yield()end
end
end
function e.DisableGameStatus()TppMission.DisableInGameFlag()Tpp.SetGameStatus{target="all",enable=false,except={S_DISABLE_NPC=false},scriptName="TppMain.lua"}end
function e.DisableGameStatusOnGameOverMenu()TppMission.DisableInGameFlag()Tpp.SetGameStatus{target="all",enable=false,scriptName="TppMain.lua"}end
function e.EnableGameStatus()TppMission.EnableInGameFlag()Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}end
function e.EnableGameStatusForDemo()TppDemo.ReserveEnableInGameFlag()Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}end
function e.EnableAllGameStatus()TppMission.EnableInGameFlag()Tpp.SetGameStatus{target="all",enable=true,scriptName="TppMain.lua"}end
function e.EnablePlayerPad()TppGameStatus.Reset("TppMain.lua","S_DISABLE_PLAYER_PAD")end
function e.DisablePlayerPad()TppGameStatus.Set("TppMain.lua","S_DISABLE_PLAYER_PAD")end
function e.EnablePause()TppPause.RegisterPause"TppMain.lua"end
function e.DisablePause()TppPause.UnregisterPause"TppMain.lua"end
function e.EnableBlackLoading(e)TppGameStatus.Set("TppMain.lua","S_IS_BLACK_LOADING")if e then
TppUI.StartLoadingTips()end
end
function e.DisableBlackLoading()TppGameStatus.Reset("TppMain.lua","S_IS_BLACK_LOADING")TppUI.FinishLoadingTips()end
function e.OnAllocate(n)TppWeather.OnEndMissionPrepareFunction()e.DisableGameStatus()e.EnablePause()TppClock.Stop()a={}l=0
c={}m=0
if(Tpp.IsQARelease()or nil)then
TppDebug.RequestResetPlayLog()end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil)TppSave.WaitingAllEnqueuedSaveOnStartMission()if TppMission.IsFOBMission(vars.missionCode)then
TppMission.SetFOBMissionFlag()TppGameStatus.Set("Mission","S_IS_ONLINE")else
TppGameStatus.Reset("Mission","S_IS_ONLINE")end
Mission.Start()TppMission.WaitFinishMissionEndPresentation()TppMission.DisableInGameFlag()if(Tpp.IsQARelease()or nil)then
mvars.qaDebug={}TppSave.QARELEASE_DEBUG_Init()TppDebug.QARELEASE_DEBUG_Init()TppStory.QARELEASE_DEBUG_Init()TppRevenge.QARELEASE_DEBUG_Init()TppQuest.QARELEASE_DEBUG_Init()end
TppException.OnAllocate(n)TppClock.OnAllocate(n)TppTrap.OnAllocate(n)TppCheckPoint.OnAllocate(n)TppUI.OnAllocate(n)TppDemo.OnAllocate(n)TppScriptBlock.OnAllocate(n)TppSound.OnAllocate(n)TppPlayer.OnAllocate(n)TppMission.OnAllocate(n)TppTerminal.OnAllocate(n)TppEnemy.OnAllocate(n)TppRadio.OnAllocate(n)TppGimmick.OnAllocate(n)TppMarker.OnAllocate(n)TppRevenge.OnAllocate(n)e.ClearStageBlockMessage()TppQuest.OnAllocate(n)TppAnimal.OnAllocate(n)local function s()if TppLocation.IsAfghan()then
if afgh then
afgh.OnAllocate()end
elseif TppLocation.IsMiddleAfrica()then
if mafr then
mafr.OnAllocate()end
elseif TppLocation.IsCyprus()then
if cypr then
cypr.OnAllocate()end
elseif TppLocation.IsMotherBase()then
if mtbs then
mtbs.OnAllocate()end
end
end
s()if n.sequence then
if f30050_sequence then
function f30050_sequence.NeedPlayQuietWishGoMission()local n=TppQuest.IsCleard"mtbs_q99011"local t=not TppDemo.IsPlayedMBEventDemo"QuietWishGoMission"local e=TppDemo.GetMBDemoName()==nil
return(n and t)and e
end
end
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
local o={}for t,e in ipairs(Tpp._requireList)do
if _G[e]then
if _G[e].DeclareSVars then
r(o,_G[e].DeclareSVars(n))end
end
end
local s={}for n,e in pairs(n)do
if i(e.DeclareSVars)then
r(s,e.DeclareSVars())end
if t(e.saveVarsList)then
r(s,TppSequence.MakeSVarsTable(e.saveVarsList))end
end
r(o,s)TppScriptVars.DeclareSVars(o)TppScriptVars.SetSVarsNotificationEnabled(false)while P()do
coroutine.yield()end
TppRadioCommand.SetScriptDeclVars()local i=vars.mbLayoutCode
if gvars.ini_isTitleMode then
TppPlayer.MissionStartPlayerTypeSetting()else
if TppMission.IsMissionStart()then
TppVarInit.InitializeForNewMission(n)TppPlayer.MissionStartPlayerTypeSetting()if not TppMission.IsFOBMission(vars.missionCode)then
TppSave.VarSave(vars.missionCode,true)end
else
TppVarInit.InitializeForContinue(n)end
TppVarInit.ClearIsContinueFromTitle()end
TppUiCommand.ExcludeNonPermissionContents()TppStory.SetMissionClearedS10030()if(not TppMission.IsDefiniteMissionClear())then
TppTerminal.StartSyncMbManagementOnMissionStart()end
if TppLocation.IsMotherBase()then
if i~=vars.mbLayoutCode then
if vars.missionCode==30050 then
vars.mbLayoutCode=i
else
vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(TppMotherBaseManagement.GetMbsTopologyType())end
end
end
TppPlayer.FailSafeInitialPositionForFreePlay()e.StageBlockCurrentPosition(true)TppMission.SetSortieBuddy()if vars.missionCode~=10260 then
TppMission.ResetQuietEquipIfUndevelop()end
TppStory.UpdateStorySequence{updateTiming="BeforeBuddyBlockLoad"}if n.sequence then
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
if(vars.missionCode==11043)or(vars.missionCode==11044)then
TppBuddyService.SetDisableAllBuddy()end
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
TppRevenge.DecideRevenge(n)if TppEquip.CreateEquipMissionBlockGroup then
if(vars.missionCode>6e4)then
TppEquip.CreateEquipMissionBlockGroup{size=(380*1024)*24}else
TppPlayer.SetEquipMissionBlockGroupSize()end
end
if TppEquip.CreateEquipGhostBlockGroups then
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
TppEquip.CreateEquipGhostBlockGroups{ghostCount=16}elseif TppMission.IsFOBMission(vars.missionCode)then
TppEquip.CreateEquipGhostBlockGroups{ghostCount=1}end
end
TppEquip.StartLoadingToEquipMissionBlock()TppPlayer.SetMaxPickableLocatorCount()TppPlayer.SetMaxPlacedLocatorCount()TppEquip.AllocInstances{instance=60,realize=60}TppEquip.ActivateEquipSystem()if TppEnemy.IsRequiredToLoadDefaultSoldier2CommonPackage()then
TppEnemy.LoadSoldier2CommonBlock()end
if n.sequence then
mvars.mis_baseList=n.sequence.baseList
TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)end
end
function e.OnInitialize(n)if TppMission.IsFOBMission(vars.missionCode)then
TppMission.SetFobPlayerStartPoint()elseif TppMission.IsNeedSetMissionStartPositionToClusterPosition()then
TppMission.SetMissionStartPositionMtbsClusterPosition()e.StageBlockCurrentPosition(true)else
TppCheckPoint.SetCheckPointPosition()end
if TppEnemy.IsRequiredToLoadSpecialSolider2CommonBlock()then
TppEnemy.LoadSoldier2CommonBlock()end
if TppMission.IsMissionStart()then
TppTrap.InitializeVariableTraps()else
TppTrap.RestoreVariableTrapState()end
TppAnimalBlock.InitializeBlockStatus()if TppQuestList then
TppQuest.RegisterQuestList(TppQuestList.questList)TppQuest.RegisterQuestPackList(TppQuestList.questPackList)end
TppHelicopter.AdjustBuddyDropPoint()if n.sequence then
local e=n.sequence.NPC_ENTRY_POINT_SETTING
if t(e)then
TppEnemy.NPCEntryPointSetting(e)end
end
TppLandingZone.OverwriteBuddyVehiclePosForALZ()if n.enemy then
if t(n.enemy.vehicleSettings)then
TppEnemy.SetUpVehicles()end
if i(n.enemy.SpawnVehicleOnInitialize)then
n.enemy.SpawnVehicleOnInitialize()end
TppReinforceBlock.SetUpReinforceBlock()end
for t,e in pairs(n)do
if i(e.Messages)then
n[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
end
if mvars.loc_locationCommonTable then
mvars.loc_locationCommonTable.OnInitialize()end
TppLandingZone.OnInitialize()for t,e in ipairs(Tpp._requireList)do
if _G[e].Init then
_G[e].Init(n)end
end
if n.enemy then
if GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
GameObject.SendCommand({type="TppSoldier2"},{id="CreateFaceIdList"})end
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
if t(n.enemy.interrogation)then
TppInterrogation.InitInterrogation(n.enemy.interrogation)end
if t(n.enemy.useGeneInter)then
TppInterrogation.AddGeneInter(n.enemy.useGeneInter)end
if t(n.enemy.uniqueInterrogation)then
TppInterrogation.InitUniqueInterrogation(n.enemy.uniqueInterrogation)end
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
TppRevenge.SetUpEnemy()TppEnemy.ApplyPowerSettingsOnInitialize()TppEnemy.ApplyPersonalAbilitySettingsOnInitialize()TppEnemy.SetOccasionalChatList()TppEneFova.ApplyUniqueSetting()if n.enemy.SetUpEnemy and i(n.enemy.SetUpEnemy)then
n.enemy.SetUpEnemy()end
if TppMission.IsMissionStart()then
TppEnemy.RestoreOnMissionStart2()else
TppEnemy.RestoreOnContinueFromCheckPoint2()end
end
if not TppMission.IsMissionStart()then
TppWeather.RestoreFromSVars()TppMarker.RestoreMarkerLocator()end
TppPlayer.RestoreSupplyCbox()TppPlayer.RestoreSupportAttack()TppTerminal.MakeMessage()if n.sequence then
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
TppMission.RestoreShowMissionObjective()TppRevenge.SetUpRevengeMine()if TppPickable.StartToCreateFromLocators then
TppPickable.StartToCreateFromLocators()end
if TppPlaced and TppPlaced.StartToCreateFromLocators then
TppPlaced.StartToCreateFromLocators()end
if TppMission.IsMissionStart()then
TppRadioCommand.RestoreRadioState()else
TppRadioCommand.RestoreRadioStateContinueFromCheckpoint()end
TppMission.SetPlayRecordClearInfo()TppChallengeTask.RequestUpdateAllChecker()TppMission.PostMissionOrderBoxPositionToBuddyDog()e.SetUpdateFunction(n)e.SetMessageFunction(n)TppQuest.UpdateActiveQuest()TppDevelopFile.OnMissionCanStart()if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
if TppQuest.IsActiveQuestHeli()then
TppEnemy.ReserveQuestHeli()end
end
TppDemo.UpdateNuclearAbolitionFlag()TppQuest.AcquireKeyItemOnMissionStart()end
function e.SetUpdateFunction(e)a={}l=0
u={}o=0
c={}m=0
a={TppMission.Update,TppSequence.Update,TppSave.Update,TppDemo.Update,TppPlayer.Update,TppMission.UpdateForMissionLoad}l=#a
for n,e in pairs(e)do
if i(e.OnUpdate)then
o=o+1
u[o]=e.OnUpdate
end
end
if(Tpp.IsQARelease()or nil)then
T={TppSave.QAReleaseDebugUpdate,TppDebug.QAReleaseDebugUpdate,TppStory.QAReleaseDebugUpdate,TppRevenge.QAReleaseDebugUpdate,TppQuest.QAReleaseDebugUpdate}f=#T
end
end
function e.OnEnterMissionPrepare()if TppMission.IsMissionStart()then
TppScriptBlock.PreloadSettingOnMissionStart()end
TppScriptBlock.ReloadScriptBlock()end
function e.OnTextureLoadingWaitStart()if not TppMission.IsHelicopterSpace(vars.missionCode)then
StageBlockCurrentPositionSetter.SetEnable(false)end
gvars.canExceptionHandling=true
end
function e.OnMissionStartSaving()end
function e.OnMissionCanStart()if TppMission.IsMissionStart()then
TppWeather.SetDefaultWeatherProbabilities()TppWeather.SetDefaultWeatherDurations()if(not gvars.ini_isTitleMode)and(not TppMission.IsFOBMission(vars.missionCode))then
TppSave.VarSave(nil,true)end
end
TppLocation.ActivateBlock()TppWeather.OnMissionCanStart()TppMarker.OnMissionCanStart()TppResult.OnMissionCanStart()TppQuest.InitializeQuestLoad()TppRatBird.OnMissionCanStart()TppMission.OnMissionStart()if mvars.loc_locationCommonTable then
mvars.loc_locationCommonTable.OnMissionCanStart()end
TppLandingZone.OnMissionCanStart()if(Tpp.IsQARelease()or nil)then
if TPP_FOCUS_TEST_BUILD or TPP_ENABLE_PLAY_LOG_START then
TppDebug.SetPlayLogEnabled(true)end
end
TppOutOfMissionRangeEffect.Disable(0)if TppLocation.IsMiddleAfrica()then
TppGimmick.MafrRiverPrimSetting()end
if MotherBaseConstructConnector.RefreshGimmicks then
if vars.locationCode==TppDefine.LOCATION_ID.MTBS then
MotherBaseConstructConnector.RefreshGimmicks()end
end
if vars.missionCode==10240 and TppLocation.IsMBQF()then
Player.AttachGasMask()end
if(vars.missionCode==10150)then
local e=TppSequence.GetMissionStartSequenceIndex()if(e~=nil)and(e<TppSequence.GetSequenceIndex"Seq_Game_SkullFaceToPlant")then
if(svars.mis_objectiveEnable[17]==false)then
Gimmick.ForceResetOfRadioCassetteWithCassette()end
end
end
end
function e.OnMissionGameStart(n)TppClock.Start()if not gvars.ini_isTitleMode then
PlayRecord.RegistPlayRecord"MISSION_START"end
TppQuest.InitializeQuestActiveStatus()if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
e.EnableGameStatusForDemo()else
e.EnableGameStatus()end
if Player.RequestChickenHeadSound~=nil then
Player.RequestChickenHeadSound()end
TppTerminal.OnMissionGameStart()if TppSequence.IsLandContinue()then
TppMission.EnableAlertOutOfMissionAreaIfAlertAreaStart()end
TppSoundDaemon.ResetMute"Telop"end
function e.ClearStageBlockMessage()StageBlock.ClearLargeBlockNameForMessage()StageBlock.ClearSmallBlockIndexForMessage()end
function e.ReservePlayerLoadingPosition(n,s,o,t,i,p,a)e.DisableGameStatus()if n==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
if t then
TppHelicopter.ResetMissionStartHelicopterRoute()TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()TppPlayer.ResetNoOrderBoxMissionStartPosition()TppMission.ResetIsStartFromHelispace()TppMission.ResetIsStartFromFreePlay()elseif s then
if gvars.heli_missionStartRoute~=0 then
TppPlayer.SetStartStatusRideOnHelicopter()if mvars.mis_helicopterMissionStartPosition then
TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)end
else
TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)local e=TppDefine.NO_HELICOPTER_MISSION_START_POSITION[vars.missionCode]if e then
TppPlayer.SetInitialPosition(e,0)TppPlayer.SetMissionStartPosition(e,0)else
TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()end
end
TppPlayer.ResetNoOrderBoxMissionStartPosition()TppMission.SetIsStartFromHelispace()TppMission.ResetIsStartFromFreePlay()elseif i then
if TppLocation.IsMotherBase()then
TppPlayer.SetStartStatusRideOnHelicopter()else
TppPlayer.ResetInitialPosition()TppHelicopter.ResetMissionStartHelicopterRoute()TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)TppPlayer.SetMissionStartPositionToCurrentPosition()end
TppPlayer.ResetNoOrderBoxMissionStartPosition()TppMission.ResetIsStartFromHelispace()TppMission.ResetIsStartFromFreePlay()TppLocation.MbFreeSpecialMissionStartSetting(TppMission.GetMissionClearType())elseif(o and TppLocation.IsMotherBase())then
if gvars.heli_missionStartRoute~=0 then
TppPlayer.SetStartStatusRideOnHelicopter()else
TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()end
TppPlayer.ResetNoOrderBoxMissionStartPosition()TppMission.SetIsStartFromHelispace()TppMission.ResetIsStartFromFreePlay()else
if o then
if mvars.mis_orderBoxName then
TppMission.SetMissionOrderBoxPosition()TppPlayer.ResetNoOrderBoxMissionStartPosition()else
TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()local e={[10020]={1449.3460693359,339.18698120117,1467.4300537109,-104},[10050]={-1820.7060546875,349.78659057617,-146.44400024414,139},[10070]={-792.00512695313,537.3740234375,-1381.4598388672,136},[10080]={-439.28802490234,-20.472593307495,1336.2784423828,-151},[10140]={499.91635131836,13.07358455658,1135.1315917969,79},[10150]={-1732.0286865234,543.94067382813,-2225.7587890625,162},[10260]={-1260.0454101563,298.75305175781,1325.6383056641,51}}e[11050]=e[10050]e[11080]=e[10080]e[11140]=e[10140]e[10151]=e[10150]e[11151]=e[10150]local e=e[vars.missionCode]if TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(vars.missionCode)]and e then
TppPlayer.SetNoOrderBoxMissionStartPosition(e,e[4])else
TppPlayer.ResetNoOrderBoxMissionStartPosition()end
end
local e=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[vars.missionCode]if e then
TppPlayer.SetStartStatusRideOnHelicopter()TppMission.SetIsStartFromHelispace()TppMission.ResetIsStartFromFreePlay()else
TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)TppHelicopter.ResetMissionStartHelicopterRoute()TppMission.ResetIsStartFromHelispace()TppMission.SetIsStartFromFreePlay()end
local e=TppMission.GetMissionClearType()TppQuest.SpecialMissionStartSetting(e)else
TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()TppPlayer.ResetNoOrderBoxMissionStartPosition()TppMission.ResetIsStartFromHelispace()TppMission.ResetIsStartFromFreePlay()end
end
elseif n==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
TppPlayer.ResetInitialPosition()TppHelicopter.ResetMissionStartHelicopterRoute()TppMission.ResetIsStartFromHelispace()TppMission.ResetIsStartFromFreePlay()if p then
if i then
TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)TppHelicopter.ResetMissionStartHelicopterRoute()TppPlayer.SetMissionStartPositionToCurrentPosition()TppPlayer.ResetNoOrderBoxMissionStartPosition()elseif t then
TppPlayer.ResetMissionStartPosition()elseif vars.missionCode~=5 then
end
else
if t then
TppHelicopter.ResetMissionStartHelicopterRoute()TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()elseif i then
TppMission.SetMissionOrderBoxPosition()elseif vars.missionCode~=5 then
end
end
elseif n==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
elseif n==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
end
if s and a then
Mission.AddLocationFinalizer(function()e.StageBlockCurrentPosition()end)else
e.StageBlockCurrentPosition()end
end
function e.StageBlockCurrentPosition(e)if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)else
StageBlockCurrentPositionSetter.SetEnable(false)end
if TppMission.IsHelicopterSpace(vars.missionCode)then
StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.DisablePosition()if e then
while not StageBlock.LargeAndSmallBlocksAreEmpty()do
coroutine.yield()end
end
end
end
function e.OnReload(n)for t,e in pairs(n)do
if i(e.OnLoad)then
e.OnLoad()end
if i(e.Messages)then
n[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
end
if n.enemy then
if t(n.enemy.routeSets)then
TppClock.UnregisterClockMessage"ShiftChangeAtNight"TppClock.UnregisterClockMessage"ShiftChangeAtMorning"TppEnemy.RegisterRouteSet(n.enemy.routeSets)TppEnemy.MakeShiftChangeTable()end
end
for t,e in ipairs(Tpp._requireList)do
if _G[e].OnReload then
_G[e].OnReload(n)end
end
if mvars.loc_locationCommonTable then
mvars.loc_locationCommonTable.OnReload()end
if n.sequence then
TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)end
e.SetUpdateFunction(n)e.SetMessageFunction(n)end
function e.OnUpdate(e)local e
local n=a
local e=u
local t=c
for e=1,l do
n[e]()end
for n=1,o do
e[n]()end
h()if(Tpp.IsQARelease()or nil)then
for e=1,f do
T[e]()end
end
end
function e.OnChangeSVars(n,e,t)if(Tpp.IsQARelease()or nil)then
if(TppDebug.DEBUG_SkipOnChangeSVarsLog[e]==nil)then
end
end
for i,n in ipairs(Tpp._requireList)do
if _G[n].OnChangeSVars then
_G[n].OnChangeSVars(e,t)end
end
end
function e.SetMessageFunction(e)d={}s=0
S={}p=0
for n,e in ipairs(Tpp._requireList)do
if _G[e].OnMessage then
s=s+1
d[s]=_G[e].OnMessage
end
end
for n,t in pairs(e)do
if e[n]._messageExecTable then
p=p+1
S[p]=e[n]._messageExecTable
end
end
end
function e.OnMessage(n,e,t,i,o,a,r)local n=mvars
local l=""local T
local u=Tpp.DoMessage
local c=TppMission.CheckMessageOption
local T=TppDebug
local T=I
local T=y
local T=TppDefine.MESSAGE_GENERATION[e]and TppDefine.MESSAGE_GENERATION[e][t]if not T then
T=TppDefine.DEFAULT_MESSAGE_GENERATION
end
local m=M()if m<T then
return Mission.ON_MESSAGE_RESULT_RESEND
end
for n=1,s do
local s=l
d[n](e,t,i,o,a,r,s)end
for s=1,p do
local n=l
u(S[s],c,e,t,i,o,a,r,n)end
if n.loc_locationCommonTable then
n.loc_locationCommonTable.OnMessage(e,t,i,o,a,r,l)end
if n.order_box_script then
n.order_box_script.OnMessage(e,t,i,o,a,r,l)end
if n.animalBlockScript and n.animalBlockScript.OnMessage then
n.animalBlockScript.OnMessage(e,t,i,o,a,r,l)end
end
function e.OnTerminate(e)if e.sequence then
if i(e.sequence.OnTerminate)then
e.sequence.OnTerminate()end
end
end
return e