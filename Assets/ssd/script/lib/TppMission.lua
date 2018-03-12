local e={}local a=Fox.StrCode32
local s=Tpp.IsTypeFunc
local i=Tpp.IsTypeTable
local o=Tpp.IsTypeString
local d=Tpp.IsTypeNumber
local n=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
local u=TppScriptVars.SVarsIsSynchronized
local n=PlayRecord.RegistPlayRecord
local t=bit.bnot
local C,t,t=bit.band,bit.bor,bit.bxor
local t=GkEventTimerManager.Start
local p=GkEventTimerManager.Stop
local r=GkEventTimerManager.IsTimerActive
local _=Tpp.IsNotAlert
local E=Tpp.IsPlayerStatusNormal
local l=DemoDaemon.IsDemoPlaying
local l=10
local l=3
local I=5
local g=2.5
local l="Timer_outsideOfInnerZone"local m=0
local O=64
local c=1
local c=0
local c=(24*60)*60
local c=2
local c=TppDefine.MAX_32BIT_UINT
local function h()n"MISSION_TIMER_UPDATE"end
function e.GetMissionID()return vars.missionCode
end
function e.GetMissionName()return mvars.mis_missionName
end
function e.GetMissionClearType()return svars.mis_missionClearType
end
function e.IsDefiniteMissionClear()return svars.mis_isDefiniteMissionClear
end
function e.RegiserMissionSystemCallback(n)e.RegisterMissionSystemCallback(n)end
function e.RegisterMissionSystemCallback(n)if i(n)then
if s(n.OnEstablishMissionClear)then
e.systemCallbacks.OnEstablishMissionClear=n.OnEstablishMissionClear
end
if s(n.OnDisappearGameEndAnnounceLog)then
e.systemCallbacks.OnDisappearGameEndAnnounceLog=n.OnDisappearGameEndAnnounceLog
end
if s(n.OnEndMissionCredit)then
e.systemCallbacks.OnEndMissionCredit=n.OnEndMissionCredit
end
if s(n.OnEndMissionReward)then
e.systemCallbacks.OnEndMissionReward=n.OnEndMissionReward
end
if s(n.OnGameOver)then
e.systemCallbacks.OnGameOver=n.OnGameOver
end
if s(n.OnOutOfMissionArea)then
e.systemCallbacks.OnOutOfMissionArea=n.OnOutOfMissionArea
end
if s(n.OnUpdateWhileMissionPrepare)then
e.systemCallbacks.OnUpdateWhileMissionPrepare=n.OnUpdateWhileMissionPrepare
end
if s(n.OnFinishBlackTelephoneRadio)then
e.systemCallbacks.OnFinishBlackTelephoneRadio=n.OnFinishBlackTelephoneRadio
end
if s(n.OnOutOfHotZone)then
end
if s(n.OnOutOfHotZoneMissionClear)then
e.systemCallbacks.OnOutOfHotZoneMissionClear=n.OnOutOfHotZoneMissionClear
end
if s(n.OnUpdateStorySequenceInGame)then
e.systemCallbacks.OnUpdateStorySequenceInGame=n.OnUpdateStorySequenceInGame
end
if s(n.CheckMissionClearFunction)then
e.systemCallbacks.CheckMissionClearFunction=n.CheckMissionClearFunction
end
if s(n.OnReturnToMission)then
e.systemCallbacks.OnReturnToMission=n.OnReturnToMission
end
if s(n.OnAddStaffsFromTempBuffer)then
e.systemCallbacks.OnAddStaffsFromTempBuffer=n.OnAddStaffsFromTempBuffer
end
if s(n.CheckMissionClearOnRideOnFultonContainer)then
e.systemCallbacks.CheckMissionClearOnRideOnFultonContainer=n.CheckMissionClearOnRideOnFultonContainer
end
if s(n.OnRecovered)then
e.systemCallbacks.OnRecovered=n.OnRecovered
end
if s(n.OnSetMissionFinalScore)then
e.systemCallbacks.OnSetMissionFinalScore=n.OnSetMissionFinalScore
end
if s(n.OnEndDeliveryWarp)then
e.systemCallbacks.OnEndDeliveryWarp=n.OnEndDeliveryWarp
end
if s(n.OnMissionGameEndFadeOutFinish)then
e.systemCallbacks.OnMissionGameEndFadeOutFinish=n.OnMissionGameEndFadeOutFinish
end
if s(n.OnFultonContainerMissionClear)then
e.systemCallbacks.OnFultonContainerMissionClear=n.OnFultonContainerMissionClear
end
if s(n.OnOutOfDefenseGameArea)then
e.systemCallbacks.OnOutOfDefenseGameArea=n.OnOutOfDefenseGameArea
end
if s(n.OnAlertOutOfDefenseGameArea)then
e.systemCallbacks.OnAlertOutOfDefenseGameArea=n.OnAlertOutOfDefenseGameArea
end
end
end
function e.UpdateObjective(s)if not mvars.mis_missionObjectiveDefine then
return
end
if mvars.mis_objectiveSetting then
e.ShowUpdateObjective(mvars.mis_objectiveSetting)end
local n=s.radio
local a=s.radioSecond
local t=s.options
mvars.mis_objectiveSetting=s.objectives
mvars.mis_updateObjectiveRadioGroupName=nil
if not i(mvars.mis_objectiveSetting)then
return
end
local s=false
for n,i in pairs(mvars.mis_objectiveSetting)do
local n=not e.IsEnableMissionObjective(i)if n then
n=not e.IsEnableAnyParentMissionObjective(i)end
if n then
s=true
break
end
end
if i(n)then
if s then
mvars.mis_updateObjectiveRadioGroupName=TppRadio.GetRadioNameAndRadioIDs(n.radioGroups)local e=e.GetObjectiveRadioOption(n)TppRadio.Play(n.radioGroups,e)end
end
if i(a)then
if s then
local e=e.GetObjectiveRadioOption(a)e.isEnqueue=true
TppRadio.Play(a.radioGroups,e)end
end
if not i(n)then
e.ShowUpdateObjective(mvars.mis_objectiveSetting)end
end
function e.UpdateCheckPoint(e)TppCheckPoint.Update(e)end
function e.UpdateCheckPointAtCurrentPosition()TppCheckPoint.UpdateAtCurrentPosition()end
function e.EnableBaseCheckPoint()mvars.frm_disableBaseCheckPoint=false
end
function e.DisableBaseCheckPoint()mvars.frm_disableBaseCheckPoint=true
end
function e.IsBaseCheckPointEnabled()return(not mvars.frm_disableBaseCheckPoint)end
function e.IsMatchStartLocation(e)local e=TppPackList.GetLocationNameFormMissionCode(e)if TppLocation.IsAfghan()then
local e=TppDefine.LOCATION_ID[e]if e~=TppDefine.LOCATION_ID.AFGH and e~=TppDefine.LOCATION_ID.SSD_AFGH then
return false
end
elseif TppLocation.IsMiddleAfrica()then
if TppDefine.LOCATION_ID[e]~=TppDefine.LOCATION_ID.MAFR then
return false
end
elseif TppLocation.IsMotherBase()then
if TppDefine.LOCATION_ID[e]~=TppDefine.LOCATION_ID.MTBS then
return false
end
else
return false
end
return true
end
function e.RegistDiscoveryGameOver()mvars.mis_isExecuteGameOverOnDiscoveryNotice=true
end
function e.IsStartFromFreePlay()return gvars.mis_isStartFromFreePlay
end
function e.AcceptMission(n)e.SetNextMissionCodeForMissionClear(n)end
function e.AcceptMissionOnFreeMission(n,a,s)local i=e.IsMatchStartLocation(n)if not i then
return
end
local i=SsdMissionList.NO_ORDER_BOX_MISSION_ENUM[tostring(n)]if i then
e.ReserveMissionClear{nextMissionId=n,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}return
end
local i=n
if e.IsHardMission(i)then
i=e.GetNormalMissionCodeFromHardMission(i)end
local a=a[i]if a==nil then
return
end
if not e.IsSysMissionId(n)then
MissionListMenuSystem.SetCurrentMissionCode(n)end
svars[s]=n
TppScriptBlock.Load("orderBoxBlock",i,true)return true
end
function e.Reload(n)local r,o,a,i,t
if n then
r=n.isNoFade
o=n.missionPackLabelName
a=n.locationCode
t=n.showLoadingTips
mvars.mis_nextLayoutCode=n.layoutCode
mvars.mis_nextClusterId=n.clusterId
i=n.OnEndFadeOut
end
if t~=nil then
mvars.mis_showLoadingTipsOnReload=t
else
mvars.mis_showLoadingTipsOnReload=true
end
if o then
mvars.mis_missionPackLabelName=o
end
if a then
mvars.mis_nextLocationCode=a
end
if i and s(i)then
mvars.mis_reloadOnEndFadeOut=i
else
mvars.mis_reloadOnEndFadeOut=nil
end
gvars.mis_tempSequenceNumberForReload=svars.seq_sequence
if r then
e.ExecuteReload()else
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ReloadFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})end
end
function e.RestartMission(n)local s
local i
if n then
s=n.isNoFade
i=n.isReturnToMission
end
TppMain.EnablePause()if i then
mvars.mis_isReturnToMission=true
end
if s then
e.ExecuteRestartMission(mvars.mis_isReturnToMission)else
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"RestartMissionFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})end
end
function e.ExecuteRestartMission(n)e.SafeStopSettingOnMissionReload()TppQuest.OnMissionGameEnd()SsdFlagMission.OnMissionGameEnd()SsdBaseDefense.OnMissionGameEnd()TppPlayer.ResetInitialPosition()TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART)if not n then
e.VarResetOnNewMission()end
local i
if n then
i=e.ExecuteOnReturnToMissionCallback()end
local s=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)if s then
local e=TppDefine.LOCATION_ID[s]if e then
vars.locationCode=e
end
end
local s=nil
if n then
s=vars.missionCode
vars.missionCode=e.GetFreeMissionCode()end
TppSave.VarSave()if mvars.mis_needSaveConfigOnNewMission then
TppSave.VarSaveConfig()end
local n=function()TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")local n={force=true}e.RequestLoad(vars.missionCode,s,n)end
if i then
e.ShowAnnounceLogOnFadeOut(n)else
n()end
end
function e.ContinueFromCheckPoint(n)local a
local s
local i
if n then
a=n.isNoFade
s=n.isReturnToMission
i=n.isNeedUpdateBaseManagement
end
TppMain.EnablePause()if s then
mvars.mis_isReturnToMission=true
end
if i then
mvars.isNeedUpdateBaseManagement=true
end
if a then
e.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission,mvars.isNeedUpdateBaseManagement)else
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ContinueFromCheckPointFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})end
end
function e.ReturnToMission(n)local n=n or{}n.isReturnToMission=true
e.DisableInGameFlag()e.RestartMission(n)end
function e.ReturnToFreeMission()mvars.mis_abortWithSave=false
mvars.mis_nextMissionCodeForAbort=e.GetFreeMissionCode()e.ExecuteMissionAbort()e.DisconnectMatching(false)end
function e.ReturnToMatchingRoom()if IS_GC_2017_COOP then
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED)e.DisconnectMatching(false)e.GameOverReturnToTitle()return
end
mvars.mis_abortWithSave=false
mvars.mis_nextMissionCodeForAbort=e.GetCoopLobbyMissionCode()e.ExecuteMissionAbort()end
function e.ExecuteContinueFromCheckPoint(n,n,a,t)TppQuest.OnMissionGameEnd()SsdFlagMission.OnMissionGameEnd()SsdBaseDefense.OnMissionGameEnd()TppWeather.OnEndMissionPrepareFunction()e.SafeStopSettingOnMissionReload()e._OnEstablishMissionEnd()TppUI.PreloadLoadingTips(0)local s=vars.missionCode
e.IncrementRetryCount()if TppSystemUtility.GetCurrentGameMode()=="TPP"then
TppEnemy.StoreSVars(true)end
TppWeather.StoreToSVars()TppMarker.StoreMarkerLocator()TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT)TppPlayer.StorePlayerDecoyInfos()TppRadioCommand.StoreRadioState()local n
if a then
n=e.ExecuteOnReturnToMissionCallback()end
if Tpp.IsEditorNoLogin()then
TppSave.VarSave()TppSave.SaveGameData(vars.missionCode,nil,nil,true)local i=function()TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")SsdBuilding.SetLevel{level=0}e.RequestLoad(vars.missionCode,s)end
if n then
TppSave.LoadFromServer()e.ShowAnnounceLogOnFadeOut(i)else
gvars.sav_needCheckPointSaveOnMissionStart=true
TppSave.LoadFromServer(i)end
return
end
local n={}local s=function()n={}n.sav_continueForOutOfBaseArea=gvars.sav_continueForOutOfBaseArea
n.mis_gameoverCount=gvars.mis_gameoverCount
n.ply_startPosX=gvars.ply_startPosTempForBaseDefense[0]n.ply_startPosY=gvars.ply_startPosTempForBaseDefense[1]n.ply_startPosZ=gvars.ply_startPosTempForBaseDefense[2]n.ply_startRotY=gvars.ply_startPosTempForBaseDefense[3]end
local n=function()if not i(n)then
return
end
gvars.sav_continueForOutOfBaseArea=n.sav_continueForOutOfBaseArea
gvars.mis_gameoverCount=n.mis_gameoverCount
gvars.ply_startPosTempForBaseDefense[0]=n.ply_startPosX
gvars.ply_startPosTempForBaseDefense[1]=n.ply_startPosY
gvars.ply_startPosTempForBaseDefense[2]=n.ply_startPosZ
gvars.ply_startPosTempForBaseDefense[3]=n.ply_startRotY
n={}end
local n=function()local e=TppStory.GetCurrentStorySequence()s()TppVarInit.InitializeOnNewGame()TppScriptVars.InitOnTitle()Player.ResetVarsOnMissionStart()TppSave.ReserveVarRestoreForContinue()n()gvars.mis_skipOnPreLoadForContinue=true
gvars.sav_needCheckPointSaveOnMissionStart=false
gvars.mis_skipUpdateBaseManagement=true
gvars.str_storySequence=Mission.GetServerStorySequence()if not gvars.str_storySequence or gvars.str_storySequence==0 then
gvars.str_storySequence=e
end
if t then
gvars.mis_skipUpdateBaseManagement=false
end
Mission.InitializeDlcMission()end
local e=function()Mission.AddFinalizer(n)TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")local n,i=Mission.GetServerMissionInfo()if n==TppDefine.MISSION_CODE_NONE then
n=TppDefine.SYS_MISSION_ID.TITLE
i=TppDefine.LOCATION_ID.INIT
elseif i==0 then
i=TppDefine.LOCATION_ID[TppPackList.GetLocationNameFormMissionCode(n)]end
vars.missionCode=n
vars.locationCode=i
e.RequestLoad(n,nil,{force=true})end
TppSave.LoadFromServer(e)end
function e.IncrementRetryCount()PlayRecord.RegistPlayRecord"MISSION_RETRY"Tpp.IncrementPlayData"totalRetryCount"TppSequence.IncrementContinueCount()end
function e.ExecuteOnReturnToMissionCallback()local n
if e.systemCallbacks and e.systemCallbacks.OnReturnToMission then
n=e.systemCallbacks.OnReturnToMission
end
if n then
TppMain.DisablePause()Player.SetPause()TppUiStatusManager.ClearStatus"AnnounceLog"n()TppTerminal.AddStaffsFromTempBuffer()TppSave.VarSave()TppSave.SaveGameData(nil,nil,nil,true)end
return n
end
function e.CanAbortMission()if not e.CheckMissionState(isExecMissionClear,true)then
return false
end
if mvars.mis_isAborting then
return false
end
if TppGameStatus.IsSet("TppMission","S_IS_BLACK_LOADING")then
return false
end
return true
end
function e.AbortMission(n)local S
local M
local s
local O
local v
local c
local a
local p
local u
local l
local d
local o,r,t=0,0,TppUI.FADE_SPEED.FADE_NORMALSPEED
local m
local f
local T
if i(n)then
S=n.isNoFade
c=n.emergencyMissionId
a=n.nextMissionId
p=n.nextLayoutCode
u=n.nextClusterId
l=n.nextMissionStartRoute
O=n.isExecMissionClear
M=n.isNoSave
d=n.isAlreadyGameOver
v=n.isContinueCurrentPos
if n.delayTime then
o=n.delayTime
end
if n.fadeDelayTime then
r=n.fadeDelayTime
end
if n.fadeSpeed then
t=n.fadeSpeed
end
m=n.presentationFunction
s=n.isTitleMode
f=n.playRadio
if s then
a=TppDefine.SYS_MISSION_ID.TITLE
elseif mvars.mis_reservedNextMissionCodeForAbort then
a=mvars.mis_reservedNextMissionCodeForAbort
end
if n.isNoSurviveBox then
T=true
end
end
if not e.CanAbortMission()then
return
end
if o then
mvars.mis_missionAbortDelayTime=o
end
if r then
mvars.mis_missionAbortFadeDelayTime=r
end
if t then
mvars.mis_missionAbortFadeSpeed=t
end
mvars.mis_abortPresentationFunction=m
if s then
mvars.mis_abortIsTitleMode=s
end
mvars.mis_abortWithPlayRadio=f
mvars.mis_emergencyMissionCode=c
mvars.mis_nextMissionCodeForAbort=a
mvars.mis_nextLayoutCodeForAbort=p
mvars.mis_nextClusterIdForAbort=u
mvars.mis_nextMissionStartRouteForAbort=l
if M then
mvars.mis_abortWithSave=false
else
mvars.mis_abortWithSave=true
end
if S then
mvars.mis_abortWithFade=false
else
mvars.mis_abortWithFade=true
end
if v then
mvars.mis_isResetMissionPosition=false
else
mvars.mis_isResetMissionPosition=true
end
if T then
mvars.mis_abortWithoutSurviveBox=true
end
if not d then
e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.ABORT,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA,true)else
e.EstablishedMissionAbort()end
end
function e.ExecuteMissionAbort()e.VarSaveForMissionAbort()e.LoadForMissionAbort()end
function e.VarSaveForMissionAbort()if not mvars.mis_nextMissionCodeForAbort then
Tpp.DEBUG_Fatal"Not defined next missionId!!"e.RestartMission()return
end
e.SafeStopSettingOnMissionReload()local n=vars.missionCode
if gvars.ini_isTitleMode then
gvars.title_nextMissionCode=TppDefine.SYS_MISSION_ID.TITLE
gvars.title_nextLocationCode=TppDefine.LOCATION_ID.INIT
mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.TITLE
TppVarInit.InitializeForNewMission{}Player.SetPause()else
SsdFlagMission.Abort()end
MissionListMenuSystem.SetCurrentMissionCode(TppDefine.MISSION_CODE_NONE)if mvars.mis_missionAbortLoadingOption==nil then
mvars.mis_missionAbortLoadingOption={}end
local a=e.IsFreeMission(n)local s=e.IsFreeMission(mvars.mis_nextMissionCodeForAbort)local t=mvars.mis_isResetMissionPosition
vars.missionCode=mvars.mis_nextMissionCodeForAbort
mvars.mis_abortCurrentMissionCode=n
local i=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)if i then
local e=TppDefine.LOCATION_ID[i]if e then
vars.locationCode=e
end
end
TppCrew.FinishMission(n)TppEnemy.ClearDDParameter()if mvars.mis_abortWithSave then
TppPlayer.SaveCaptureAnimal()TppClock.SaveMissionStartClock()TppWeather.SaveMissionStartWeather()TppTerminal.AddStaffsFromTempBuffer()if gvars.solface_groupNumber>=4294967295 then
gvars.solface_groupNumber=0
else
gvars.solface_groupNumber=gvars.solface_groupNumber+1
end
gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)SsdSbm.StoreToSVars()Gimmick.StoreSaveDataPermanentGimmickFromMission()TppGimmick.DecrementCollectionRepopCount()TppBuddyService.SetVarsMissionStart()if s then
TppUiCommand.LoadoutSetMissionEndFromMissionToFree()end
else
TppPlayer.ResetMissionStartPosition()TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")end
TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT,a,s,t,mvars.mis_abortWithSave)TppWeather.OnEndMissionPrepareFunction()e.VarResetOnNewMission()gvars.mis_orderBoxName=0
if gvars.ini_isTitleMode then
mvars.mis_missionAbortLoadingOption.showLoadingTips=false
gvars.ini_isReturnToTitle=true
else
if e.IsInitMission(vars.missionCode)then
return
end
local e=false
if mvars.mis_abortWithSave then
e=true
end
gvars.sav_needCheckPointSaveOnMissionStart=true
TppSave.VarSave(n,e)TppSave.SaveGameData(n,nil,nil,true,e)if mvars.mis_needSaveConfigOnNewMission then
TppSave.VarSaveConfig()TppSave.SaveConfigData(nil,nil,reserveNextMissionStart)end
end
end
function e.LoadForMissionAbort()TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")e.RequestLoad(vars.missionCode,mvars.mis_abortCurrentMissionCode,mvars.mis_missionAbortLoadingOption)end
function e.ReturnToTitle()local n
if e.IsMultiPlayMission(vars.missionCode)then
e.DisconnectMatching(false)TppGameStatus.Reset("SimpleMissionController","S_IS_ONLINE")TppGameStatus.Reset("SimpleMissionController","S_IS_MULTIPLAY")n=true
end
vars.invitationDisableRecieveFlag=1
e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.TITLE,isNoSave=true,isTitleMode=true,isAlreadyGameOver=n}end
function e.GameOverReturnToTitle()if IS_GC_2017_COOP then
mvars.mis_missionAbortLoadingOption={showLoadingTips=true,waitOnLoadingTipsEnd=false}end
gvars.title_nextMissionCode=vars.missionCode
gvars.title_nextLocationCode=vars.locationCode
gvars.ini_isTitleMode=true
mvars.mis_abortWithSave=false
mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.TITLE
vars.invitationDisableRecieveFlag=1
e.ExecuteMissionAbort()end
function e.ReturnToTitleForException()gvars.title_nextMissionCode=vars.missionCode
gvars.title_nextLocationCode=vars.locationCode
gvars.ini_isTitleMode=false
mvars.mis_abortWithSave=false
mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.INIT
gvars.mis_tempSequenceNumberForReload=0
vars.invitationDisableRecieveFlag=1
e.ExecuteMissionAbort()end
function e.ReturnToTitleWithSave()vars.invitationDisableRecieveFlag=1
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,"ReturnToTitleWithSave",TppUI.FADE_PRIORITY.SYSTEM,{exceptGameStatus={AnnounceLog="SUSPEND_LOG"}})end
function e.ExecuteReturnToTitleWithSave()if TppSave.IsSaving()then
t("Timer_WaitSavingForReturnToTitle",1)return
end
TppSave.AddServerSaveCallbackFunc(e.ReturnToTitle)e.VarSaveOnUpdateCheckPoint()end
function e.ReserveGameOver(n,i,s)if svars.mis_isDefiniteMissionClear then
return false
end
mvars.mis_isAborting=s
mvars.mis_isReserveGameOver=true
svars.mis_isDefiniteGameOver=true
if type(n)=="number"and n<TppDefine.GAME_OVER_TYPE.MAX then
svars.mis_gameOverType=n
end
if type(i)=="number"and i<TppDefine.GAME_OVER_RADIO.MAX then
svars.mis_gameOverRadio=i
end
if e.IsMultiPlayMission(vars.missionCode)then
TppUI.PreloadLoadingTips(1)else
TppUI.PreloadLoadingTips(0)end
local n=vars.missionCode
if not e.IsMultiPlayMission(n)and not e.IsInitMission(n)then
local n=svars.mis_gameOverType
if(n==TppDefine.GAME_OVER_TYPE.PLAYER_DEAD or n==TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD)or n==TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD then
TppUI.SetDefaultGameOverMenu()else
TppUI.SetGameOverMenu{GameOverMenuType.CONTINUE_FROM_CHECK_POINT}end
if n~=TppDefine.GAME_OVER_TYPE.ABORT then
e.IncrementGameOverCount()end
else
TppUI.SetDefaultGameOverMenu()end
return true
end
function e.ReserveGameOverOnPlayerKillChild(n)if not mvars.mis_childGameObjectIdKilledPlayer then
mvars.mis_childGameObjectIdKilledPlayer=n
e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_KILL_CHILD_SOLDIER,TppDefine.GAME_OVER_RADIO.PLAYER_KILL_CHILD_SOLDIER)end
end
function e.IsGameOver()return svars.mis_isDefiniteGameOver
end
function e.IncrementGameOverCount()if gvars.mis_gameoverCount<255 then
gvars.mis_gameoverCount=gvars.mis_gameoverCount+1
end
end
function e.ResetGameOverCount()gvars.mis_gameoverCount=0
end
function e.GetGameOverCount()return gvars.mis_gameoverCount
end
function e.CanMissionClear(e)mvars.mis_needSetCanMissionClear=true
if i(e)then
if e.jingle then
mvars.mis_canMissionClearNeedJingle=e.jingle
else
mvars.mis_canMissionClearNeedJingle=true
end
end
end
function e._SetCanMissionClear()mvars.mis_needSetCanMissionClear=false
if svars.mis_canMissionClear then
return
end
svars.mis_canMissionClear=true
end
function e.IsCanMissionClear()return svars.mis_canMissionClear
end
function e.OnCanMissionClear()if mvars.mis_canMissionClearNeedJingle~=false then
TppSound.PostJingleOnCanMissionClear()end
local e=mvars.snd_bgmList
if e and e.bgm_escape then
mvars.mis_needSetEscapeBgm=true
end
end
function e.SetMissionClearState(e)if gvars.mis_missionClearState<e then
gvars.mis_missionClearState=e
return true
else
return false
end
end
function e.ResetMissionClearState()gvars.mis_missionClearState=TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET
end
function e.GetMissionClearState()return gvars.mis_missionClearState
end
function e.ReserveMissionClear(n)if svars.mis_isDefiniteGameOver then
return false
end
if mvars.mis_isReserveMissionClear or svars.mis_isDefiniteMissionClear then
return false
end
mvars.mis_isReserveMissionClear=true
mvars.mis_isResetMissionPosition=false
mvars.mis_isLocationChangeWithFastTravel=false
gvars.mis_skipUpdateBaseManagement=true
if n then
if n.missionClearType then
svars.mis_missionClearType=n.missionClearType
end
if n.nextMissionId then
e.SetNextMissionCodeForMissionClear(n.nextMissionId)end
if n.resetPlayerPos then
mvars.mis_isResetMissionPosition=n.resetPlayerPos
end
if n.isLocationChangeWithFastTravel then
mvars.mis_isLocationChangeWithFastTravel=n.isLocationChangeWithFastTravel
end
end
svars.mis_isDefiniteMissionClear=true
if e.IsMultiPlayMission(vars.missionCode)then
TppUI.PreloadLoadingTips(1)else
TppUI.PreloadLoadingTips(0)end
return true
end
function e.MissionGameEnd(n)local a=0
local s=0
local t=TppUI.FADE_SPEED.FADE_NORMALSPEED
if i(n)then
a=n.delayTime or 0
t=n.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
s=n.fadeDelayTime or 0
if n.loadStartOnResult~=nil then
mvars.mis_doMissionFinalizeOnMissionTelopDisplay=n.loadStartOnResult
else
mvars.mis_doMissionFinalizeOnMissionTelopDisplay=false
end
end
if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
e.SetNeedWaitMissionInitialize()else
e.ResetNeedWaitMissionInitialize()end
MissionListMenuSystem.SetCurrentMissionCode(TppDefine.MISSION_CODE_NONE)mvars.mis_missionGameEndDelayTime=a
e.ResetGameOverCount()e.FadeOutOnMissionGameEnd(s,t,"MissionGameEndFadeOutFinish")PlayRecord.RegistPlayRecord"MISSION_CLEAR"end
function e.FadeOutOnMissionGameEnd(s,n,i)if s==0 then
e._FadeOutOnMissionGameEnd(n,i)else
mvars.mis_missionGameEndFadeSpeed=n
mvars.mis_missionGameEndFadeId=i
t("Timer_FadeOutOnMissionGameEndStart",s)end
end
function e._FadeOutOnMissionGameEnd(e,n)TppUI.FadeOut(e,n,TppUI.FADE_PRIORITY.SYSTEM,{exceptGameStatus={AnnounceLog="SUSPEND_LOG"}})end
function e.CheckGameOverDemo(e)if e>TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK then
return false
end
if C(svars.mis_gameOverType,TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK)==e then
return true
else
return false
end
end
function e.ShowGameOverMenu(s)local n
if i(s)then
if type(s.delayTime)=="number"then
n=s.delayTime
end
end
if(Tpp.IsQARelease())then
mvars.mis_isGameOverMenuShown=true
end
if n and n>0 then
t("Timer_GameOverPresentation",n)else
e.ExecuteShowGameOverMenu()end
end
function e.ExecuteShowGameOverMenu()TppRadio.Stop()GameOverMenuSystem.SetType(GameOverType.Normal)local e=TppStory.GetCurrentStorySequence()if e<TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL then
GameOverMenuSystem.SetBgType(GameOverBg.TYPE_2)else
GameOverMenuSystem.SetBgType(GameOverBg.TYPE_1)end
GameOverMenuSystem.RequestOpen()end
function e.ShowMissionGameEndAnnounceLog()e.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.MISSION_GAME_END)e.ShowAnnounceLogOnFadeOut(e.OnEndResultBlockLoad)end
function e.ShowAnnounceLogOnFadeOut(e)if TppUiCommand.GetSuspendAnnounceLogNum()>0 then
TppUiStatusManager.ClearStatus"AnnounceLog"mvars.mis_endAnnounceLogFunction=e
else
e()end
end
function e.OnEndResultBlockLoad()TppUiStatusManager.SetStatus("GmpInfo","INVALID")if e.systemCallbacks.OnDisappearGameEndAnnounceLog then
e.systemCallbacks.OnDisappearGameEndAnnounceLog(svars.mis_missionClearType)end
end
function e.EnablePauseForShowResult()if not gvars.enableResultPause then
TppPause.RegisterPause("ShowResult",TppPause.PAUSE_LEVEL_GAMEPLAY_MENU)gvars.enableResultPause=true
end
end
function e.DisablePauseForShowResult()if gvars.enableResultPause then
TppPause.UnregisterPause"ShowResult"gvars.enableResultPause=false
end
end
function e.ShowMissionResult()TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")TppRadio.Stop()TppSoundDaemon.SetMute"Result"e.EnablePauseForShowResult()TppRadioCommand.SetEnableIgnoreGamePause(true)TppSound.SafeStopAndPostJingleOnShowResult()if e.IsStoryMission(vars.missionCode)and TppRadio.IsSetIndivResultRadioSetting()then
TppRadio.PlayResultRadio(e.ExecRewardProcess)else
e.ExecRewardProcess()end
end
function e.ExecRewardProcess()if mvars.mis_blackRadioSetting then
TppSoundDaemon.SetKeepBlackRadioEnable(true)TppRadio.StartBlackRadio()elseif mvars.mis_releaseAnnounceSetting then
ReleaseAnnouncePopupSystem.RequestOpen()else
e.DisablePauseForShowResult()e.ShowMissionReward()end
end
function e.ShowMissionReward()if TppReward.IsStacked()then
TppReward.ShowAllReward()else
e.OnEndMissionReward()end
end
function e.OnEndMissionReward()if gvars.needWaitMissionInitialize then
e.ResetMissionClearState()else
e.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.REWARD_END)end
if s(e.systemCallbacks.OnEndMissionReward)then
e.systemCallbacks.OnEndMissionReward()else
if gvars.needWaitMissionInitialize==false then
e.ExecuteMissionFinalize()end
end
e.ResetNeedWaitMissionInitialize()end
function e.MissionFinalize(n)TppSoundDaemon.SetMute"Loading"local o,t,a,s
if i(n)then
o=n.isNoFade
t=n.isExecGameOver
a=n.showLoadingTips
s=n.setMute
end
if a~=nil then
mvars.mis_showLoadingTipsOnMissionFinalize=a
else
mvars.mis_showLoadingTipsOnMissionFinalize=true
end
if s then
mvars.mis_setMuteOnMissionFinalize=s
end
if gvars.mis_nextMissionCodeForMissionClear~=m then
local n=e.IsStoryMission(vars.missionCode)local e=e.IsStoryMission(gvars.mis_nextMissionCodeForMissionClear)if n or e then
SsdMarker.UnregisterMarker{type="USER_001"}end
end
if o then
e.ExecuteMissionFinalize()else
if t then
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeAtGameOverFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})else
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})end
end
end
function e.ExecuteMissionFinalize()if not e.IsSysMissionId(vars.missionCode)then
TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.MISSION_END,e.ExecuteMissionFinalizeAfterServerSave)else
e.ExecuteMissionFinalizeAfterServerSave()end
end
function e.ExecuteMissionFinalizeAfterServerSave()local n=TppPackList.GetLocationNameFormMissionCode(gvars.mis_nextMissionCodeForMissionClear)if n then
mvars.mis_nextLocationCode=TppDefine.LOCATION_ID[n]end
e.SafeStopSettingOnMissionReload{setMute=mvars.mis_setMuteOnMissionFinalize}e.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.MISSION_FINALIZED)if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
if TppUiCommand.IsEndMissionTelop()then
end
e.ShowMissionReward()e.systemCallbacks.OnFinishBlackTelephoneRadio=nil
e.systemCallbacks.OnEndMissionCredit=nil
end
local r
local n=vars.missionCode
local o=vars.locationCode
local s,i,t,a
if gvars.mis_nextMissionCodeForMissionClear~=m then
s=e.IsFreeMission(vars.missionCode)i=e.IsFreeMission(gvars.mis_nextMissionCodeForMissionClear)t=mvars.mis_isResetMissionPosition
a=mvars.mis_isLocationChangeWithFastTravel
vars.locationCode=mvars.mis_nextLocationCode
vars.missionCode=gvars.mis_nextMissionCodeForMissionClear
else
Tpp.DEBUG_Fatal"Not defined next missionId!!"e.RestartMission()return
end
if i then
TppUiCommand.LoadoutSetMissionEndFromMissionToFree()end
TppGimmick.DecrementCollectionRepopCount()Gimmick.StoreSaveDataPermanentGimmickForMissionClear()Gimmick.StoreSaveDataPermanentGimmickFromMissionAfterClear()if s then
Gimmick.StoreSaveDataPermanentGimmickFromMission()end
if i then
vars.requestFlagsAboutEquip=255
end
TppEnemy.ClearDDParameter()if gvars.solface_groupNumber>=4294967295 then
gvars.solface_groupNumber=0
else
gvars.solface_groupNumber=gvars.solface_groupNumber+1
end
gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)SsdSbm.StoreToSVars()TppRadioCommand.StoreRadioState()local o=(vars.locationCode~=o)TppClock.SaveMissionStartClock()TppWeather.SaveMissionStartWeather()TppBuddyService.SetVarsMissionStart()TppBuddyService.BuddyMissionInit()TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE,s,i,t,nil,o,a)TppWeather.OnEndMissionPrepareFunction()e.VarResetOnNewMission()local s=true
TppSave.VarSave(n,true)local i=false
do
i=true
end
if i then
TppSave.SaveGameData(n,nil,nil,s,true)end
if mvars.mis_needSaveConfigOnNewMission then
TppSave.VarSaveConfig()TppSave.SaveConfigData(nil,nil,s)end
if TppRadio.playingBlackTelInfo then
mvars.mis_showLoadingTipsOnMissionFinalize=false
end
SsdBlankMap.DisableDefenseMode()TppCrew.FinishMission(n)e.RequestLoad(vars.missionCode,n,{showLoadingTips=mvars.mis_showLoadingTipsOnMissionFinalize,waitOnLoadingTipsEnd=r})end
function e.ParseMissionName(e)local i=string.sub(e,2)i=tonumber(i)local n=string.sub(e,1,1)local e
if(n=="s")then
e="story"elseif(n=="e")then
e="extra"elseif(n=="f")then
e="free"elseif(n=="k")then
e="flag"elseif(n=="d")then
e="defense"end
return i,e
end
function e.IsStoryMission(e)local e=math.floor(e/1e4)if e==1 then
return true
else
return false
end
end
function e.IsFreeMission(e)local e=math.floor(e/1e4)if e==3 then
return true
else
return false
end
end
function e.IsHardMission(e)local n=math.floor(e/1e3)local e=math.floor(e/1e4)*10
if(n-e)==1 then
return true
else
return false
end
end
function e.GetFreeMissionCode()if TppLocation.IsAfghan()then
return TppDefine.SYS_MISSION_ID.AFGH_FREE
elseif TppLocation.IsMiddleAfrica()then
return TppDefine.SYS_MISSION_ID.MAFR_FREE
end
end
function e.GetCoopLobbyMissionCode()local e=e.GetMissionID()if e==20005 or e==21005 then
return TppDefine.SYS_MISSION_ID.TUTORIAL_MATCHING_ROOM
elseif TppLocation.IsAfghan()then
return TppDefine.SYS_MISSION_ID.AFGH_MATCHING_ROOM
elseif TppLocation.IsMiddleAfrica()then
return TppDefine.SYS_MISSION_ID.MAFR_MATCHING_ROOM
elseif vars.locationCode==TppDefine.LOCATION_ID.INIT then
return TppDefine.SYS_MISSION_ID.NO_LOCATION_MATCHING_ROOM
elseif vars.locationCode==TppDefine.LOCATION_ID.SPFC then
return TppDefine.SYS_MISSION_ID.SPFC_MATCHING_ROOM
elseif vars.locationCode==TppDefine.LOCATION_ID.SSAV then
return TppDefine.SYS_MISSION_ID.SSAV_MATCHING_ROOM
else
return TppDefine.SYS_MISSION_ID.NO_LOCATION_MATCHING_ROOM
end
end
function e.GetAvaterMissionCode()if TppLocation.IsAfghan()then
return TppDefine.SYS_MISSION_ID.AVATAR_EDIT
elseif TppLocation.IsMiddleAfrica()then
return TppDefine.SYS_MISSION_ID.MAFR_AVATAR_EDIT
else
return TppDefine.SYS_MISSION_ID.AVATAR_EDIT
end
end
function e.GetNormalMissionCodeFromHardMission(e)return e-1e3
end
function e.IsMatchingRoom(e)if e==TppDefine.SYS_MISSION_ID.TITLE then
return true
end
local e=math.floor(e/1e3)return e==21
end
function e.IsMultiPlayMission(e)if e==TppDefine.SYS_MISSION_ID.TITLE then
return true
end
local e=math.floor(e/1e4)if e==2 then
return true
else
return false
end
end
function e.IsCoopMission(n)return(not e.IsMatchingRoom(n)and e.IsMultiPlayMission(n))end
function e.IsAvatarEditMission(e)return(e==TppDefine.SYS_MISSION_ID.AVATAR_EDIT)or(e==TppDefine.SYS_MISSION_ID.MAFR_AVATAR_EDIT)end
function e.IsInitMission(e)return(e==TppDefine.SYS_MISSION_ID.INIT or e==TppDefine.SYS_MISSION_ID.TITLE)end
function e.IsTitleMission(e)return e==TppDefine.SYS_MISSION_ID.TITLE
end
function e.IsEventMission(n)if not e.IsCoopMission(n)then
return false
end
if n>=22e3 then
return true
end
return false
end
function e.IsMissionStart()if gvars.sav_varRestoreForContinue then
return false
else
return true
end
end
function e.IsSysMissionId(n)local e
for i,e in pairs(TppDefine.SYS_MISSION_ID)do
if n==e then
return true
end
end
return false
end
function e.Messages()return Tpp.StrCode32Table{Player={{msg="Dead",func=e.OnPlayerDead,option={isExecGameOver=true}},{msg="AllDead",func=e.OnAllPlayersDead,option={isExecGameOver=true}},{msg="InFallDeathTrapLocal",func=e.OnPlayerFallDead,option={isExecGameOver=true}},{msg="Exit",sender="outerZone",func=function()mvars.mis_isOutsideOfMissionArea=true
end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Enter",sender="outerZone",func=function()mvars.mis_isOutsideOfMissionArea=false
end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Exit",sender="innerZone",func=function()if mvars.mis_fobDisableAlertMissionArea==true then
return
end
mvars.mis_isAlertOutOfMissionArea=true
if not e.CheckMissionClearOnOutOfMissionArea()then
e.EnableAlertOutOfMissionArea()end
end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Enter",sender="innerZone",func=function()mvars.mis_isAlertOutOfMissionArea=false
e.DisableAlertOutOfMissionArea()end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Exit",sender="hotZone",func=function()mvars.mis_isOutsideOfHotZone=true
e.ExitHotZone()end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Enter",sender="hotZone",func=function()mvars.mis_isOutsideOfHotZone=false
if TppSequence.IsMissionPrepareFinished()then
e.PlayCommonRadioOnInsideOfHotZone()end
end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="OnInjury",func=function()TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RECOMMEND_CURE)end},{msg="PlayerFultoned",func=e.OnPlayerFultoned},{msg="WarpEnd",func=function()if mvars.mis_finishWarpToBaseCallBack then
mvars.mis_finishWarpToBaseCallBack()mvars.mis_finishWarpToBaseCallBack=nil
end
end,option={isExecGameOver=true,isExecFastTravel=true}}},UI={{msg="EndTelopCast",func=function()if mvars.f30050_demoName=="NuclearEliminationCeremony"then
return
end
TppUiStatusManager.ClearStatus"AnnounceLog"end},{msg="EndFadeOut",sender="MissionGameEndFadeOutFinish",func=e.OnMissionGameEndFadeOutFinish,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="MissionFinalizeFadeOutFinish",func=e.ExecuteMissionFinalize,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="MissionFinalizeAtGameOverFadeOutFinish",func=e.ExecuteMissionFinalize,option={isExecGameOver=true,isExecMissionClear=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="RestartMissionFadeOutFinish",func=function()e.ExecuteRestartMission(mvars.mis_isReturnToMission)end,option={isExecMissionClear=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="ContinueFromCheckPointFadeOutFinish",func=function()e.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission,mvars.isNeedUpdateBaseManagement)end,option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="ReloadFadeOutFinish",func=function()if mvars.mis_reloadOnEndFadeOut then
mvars.mis_reloadOnEndFadeOut()end
e.ExecuteReload()end,option={isExecMissionClear=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="AbortMissionFadeOutFinish",func=function()if mvars.mis_missionAbortDelayTime>0 then
t("Timer_MissionAbort",mvars.mis_missionAbortDelayTime)else
e.OnEndFadeOutMissionAbort()end
end,option={isExecGameOver=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="GameOverReturnToBaseFadeOut",func=e.ExecuteGameOverReturnToBase,option={isExecGameOver=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="ReturnToTitleWithSave",func=e.ExecuteReturnToTitleWithSave,option={isExecMissionClear=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndFadeIn",sender="FadeInOnGameStart",func=function()e.ShowAnnounceLogOnGameStart()end},{msg="EndFadeIn",sender="FadeInOnStartMissionGame",func=function()e.ShowAnnounceLogOnGameStart()end},{msg="GameOverOpen",func=TppMain.DisableGameStatusOnGameOverMenu,option={isExecGameOver=true,isExecFastTravel=true}},{msg="GameOverContinueFromCheckPoint",func=e.ExecuteContinueFromCheckPoint,option={isExecGameOver=true,isExecFastTravel=true}},{msg="GameOverReturnToBase",func=e.GameOverReturnToBase,option={isExecGameOver=true,isExecMissionClear=true,isExecFastTravel=true}},{msg="GameOverMenuAutomaticallyClosed",func=function()if IS_GC_2017_COOP then
local n=mvars.mis_isReserveGameOver or svars.mis_isDefiniteGameOver
if n then
e.GameOverReturnToTitle()end
return
end
e.ReturnToMatchingRoom()end,option={isExecGameOver=true,isExecFastTravel=true}},{msg="PauseMenuCheckpoint",func=e.ContinueFromCheckPoint},{msg="PauseMenuAbortMission",func=e.AbortMissionByMenu},{msg="PauseMenuAbortMissionGoToAcc",func=e.AbortMissionByMenu},{msg="PauseMenuFinishFobManualPlaecementMode",func=e.AbortMissionByMenu},{msg="PauseMenuRestart",func=e.RestartMission},{msg="PauseMenuReturnToTitle",func=function()e.ReturnToTitle()vars.isAbandonFromUser=1
end},{msg="PauseMenuReturnToMission",func=function()e.ReturnToMission{withServerPenalty=true}end},{msg="PauseMenuReturnToBase",func=e.ReturnToBaseByMenu},{msg="RequestPlayRecordClearInfo",func=e.SetPlayRecordClearInfo},{msg="AiPodMenuCancelMissionSelected",func=function()e.AbortMissionByMenu{isNoSurviveBox=true}end},{msg="EndMissionTelopDisplay",func=function()if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
e.MissionFinalize{isNoFade=true,setMute="Result"}end
end,option={isExecMissionClear=true,isExecGameOver=true,isExecFastTravel=true}},{msg="EndAnnounceLog",func=function()if mvars.mis_endAnnounceLogFunction then
mvars.mis_endAnnounceLogFunction()mvars.mis_endAnnounceLogFunction=nil
end
end,option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndResultBlockLoad",func=e.OnEndResultBlockLoad,option={isExecMissionClear=true,isExecGameOver=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="StoryMissionResultClosed",func=function()e.ExecRewardProcess()end},{msg="BlackRadioClosed",func=function(n)if not o(mvars.mis_blackRadioSetting)or n~=a(mvars.mis_blackRadioSetting)then
return
end
mvars.mis_blackRadioSetting=nil
TppSoundDaemon.SetKeepBlackRadioEnable(false)e.ExecRewardProcess()end},{msg="ReleaseAnnouncePopupPushEnd",func=function()if not mvars.mis_releaseAnnounceSetting then
return
end
mvars.mis_releaseAnnounceSetting=nil
e.ExecRewardProcess()end},{msg="PresetRadioEditMenuClosed",func=TppSave.SaveEditData},{msg="CommunicationMarkerEditMenuClosed",func=TppSave.SaveEditData},{msg="GestureEditMenuClosed",func=TppSave.SaveEditData},{msg="AbandonFromPauseMenu",func=function()vars.isAbandonFromUser=1
if e.IsCoopMission(vars.missionCode)then
return
end
e.AbandonMission()end},{msg="AiPodMenuMoveToAssemblyPointSelected",func=function(n,n)if not e.IsMultiPlayMission(vars.missionCode)then
e.GoToCoopLobbyWithSave()end
end},{msg="PopupClose",sender=TppDefine.ERROR_ID.SESSION_ABANDON,func=function()e.AbandonMission()end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="AiPodMenuReturnToTitleWithSaveSelected",func=e.ReturnToTitleWithSave}},Radio={{msg="Finish",func=e.OnFinishUpdateObjectiveRadio}},Timer={{msg="Finish",sender="Timer_OutsideOfHotZoneCount",func=e.OutsideOfHotZoneCount,nil},{msg="Finish",sender="Timer_OnEndReturnToTile",func=e.RestartMission,option={isExecGameOver=true,isExecFastTravel=true},nil},{msg="Finish",sender="Timer_GameOverPresentation",func=e.ExecuteShowGameOverMenu,option={isExecGameOver=true,isExecFastTravel=true},nil},{msg="Finish",sender="Timer_MissionGameEndStart",func=e.OnMissionGameEndFadeOutFinish2nd,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_MissionGameEndStart2nd",func=e.ShowMissionGameEndAnnounceLog,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_FadeOutOnMissionGameEndStart",func=function()e._FadeOutOnMissionGameEnd(mvars.mis_missionGameEndFadeSpeed,mvars.mis_missionGameEndFadeId)end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_StartMissionAbortFadeOut",func=e.FadeOutOnMissionAbort,option={isExecGameOver=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_MissionAbort",func=e.OnEndFadeOutMissionAbort,option={isExecGameOver=true,isExecFastTravel=true}},{msg="Finish",sender=l,func=function()if(mvars.mis_isAlertOutOfMissionArea==false)then
return
end
if e.CheckMissionClearOnOutOfMissionArea()then
if mvars.mis_enableAlertOutOfMissionArea then
e.DisableAlertOutOfMissionArea()end
else
if not mvars.mis_enableAlertOutOfMissionArea then
e.EnableAlertOutOfMissionArea()end
end
end},{msg="Finish",sender="Timer_UpdateCheckPoint",func=function()TppStory.UpdateStorySequence{updateTiming="OnUpdateCheckPoint",isInGame=true}end},{msg="Finish",sender="Timer_WaitStartMigration",func=function()e.AbandonMission()end},{msg="Finish",sender="Timer_WaitFinishMigration",func=function()e.AbandonMission()end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_SessionAbandon",func=function()e.AbandonMission()end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_WaitSavingForReturnToTitle",func=e.ExecuteReturnToTitleWithSave,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}}},GameObject={{msg="ChangePhase",func=function(i,n)if mvars.mis_isExecuteGameOverOnDiscoveryNotice then
if n==TppGameObject.PHASE_ALERT then
e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.ON_DISCOVERY,TppDefine.GAME_OVER_RADIO.OTHERS)end
end
end},{msg="DisableTranslate",func=function(e)local e=TppEnemy.GetSoldierType(e)if e==EnemyType.TYPE_SOVIET then
if not TppQuest.IsCleard"ruins_q19010"then
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_RUSSIAN,true)end
elseif e==EnemyType.TYPE_PF then
if not TppQuest.IsCleard"outland_q19011"then
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_AFRIKANS,true)end
end
end},{msg="FinishWaveInterval",func=function()Mission.EndWaveResult()end},{msg="GameOverConfirm",func=e.OnAllPlayersDead,option={isExecGameOver=true,isExecFastTravel=true}}},MotherBaseManagement={{msg="CompletedPlatform",func=function(e,e,e)TppStory.UpdateStorySequence{updateTiming="OnCompletedPlatform",isInGame=true}end},{msg="RequestSaveMbManagement",func=function()if((TppSave.IsForbidSave()or(vars.missionCode==10030))or(vars.missionCode==10115))or(not e.CheckMissionState())then
TppMotherBaseManagement.SetRequestSaveResultFailure()return
end
TppSave.SaveOnlyMbManagement(TppSave.ReserveNoticeOfMbSaveResult)end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},{msg="RequestSavePersonal",func=function()TppSave.CheckAndSavePersonalData()end}},Trap={{msg="Enter",sender="trap_mission_failed_area",func=function()e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA)end,option={isExecFastTravel=true}}},Network={{msg="StartHostMigration",func=function()if r"Timer_WaitStartMigration"then
p"Timer_WaitStartMigration"end
t("Timer_WaitFinishMigration",120)gvars.mis_processingHostmigration=true
gvars.mis_lastResultOfHostmigration=true
end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="FinishHostMigration",func=function(e)gvars.mis_processingHostmigration=false
if r"Timer_WaitFinishMigration"then
p"Timer_WaitFinishMigration"end
end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="FailedHostMigration",func=function()gvars.mis_lastResultOfHostmigration=false
end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="AcceptedInvate",func=function()if e.IsMultiPlayMission(vars.missionCode)then
e.AbandonMission()elseif e.IsAvatarEditMission(vars.missionCode)then
else
e.GoToCoopLobby()end
end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}}}}end
function e.MessagesWhileLoading()return Tpp.StrCode32Table{UI={{msg="StoryMissionResultClosed",func=function()e.ExecRewardProcess()end},{msg="BlackRadioClosed",func=function(n)TppPause.UnregisterPause"BlackRadio"if not o(mvars.mis_blackRadioSetting)or n~=a(mvars.mis_blackRadioSetting)then
return
end
mvars.mis_blackRadioSetting=nil
TppSoundDaemon.SetKeepBlackRadioEnable(false)e.ExecRewardProcess()end},{msg="ReleaseAnnouncePopupPushEnd",func=function()if not mvars.mis_releaseAnnounceSetting then
return
end
mvars.mis_releaseAnnounceSetting=nil
e.ExecRewardProcess()end},{msg="BonusPopupAllClose",func=e.OnEndMissionReward},{msg="EndFadeIn",sender="OnEndWarpByFastTravel",func=TppPlayer.OnEndFadeInWarpByFastTravel},{msg="EndFadeOut",sender="FadeOutForMovieEnd",func=function()mvars.mov_checkEndFadeOut=true
end}},Radio={{msg="Finish",func=TppRadio.OnFinishRadioWhileLoading},nil},Video={{msg="VideoPlay",func=function(e)TppMovie.DoMessage(e,"onStart")end},{msg="VideoStopped",func=function(e)TppMovie.DoMessage(e,"onEnd")end}}}end
local v=a"FallDeath"local S=a"Suicide"function e.OnPlayerDead(e,e)end
function e.OnAllPlayersDead(i,n)if e.IsCoopMission(vars.missionCode)then
return
end
if not TppNetworkUtil.IsHost()then
return
end
if mvars.mis_isAllDead==true then
return
end
mvars.mis_isAllDead=true
e._OnDeadCommon(n)end
function e.OnPlayerFallDead()TppPlayer.PlayFallDeadCamera()end
function e.OnAbortMissionPreparation()e.SetNextMissionCodeForMissionClear(m)end
function e.WaitFinishMissionEndPresentation()while(not TppUiCommand.IsEndMissionTelop())do
if TppUiCommand.KeepMissionStartTelopBg then
TppUiCommand.KeepMissionStartTelopBg(false)end
if DebugText then
DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Waiting end result: TppUiCommand.IsEndMissionTelop() = "..tostring(TppUiCommand.IsEndMissionTelop()))end
if DebugText and(TppRadio.playingBlackTelInfo~=nil)then
DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Waiting end blackTelephoneRadio : radioGroupName = "..tostring(TppRadio.playingBlackTelInfo.radioName))end
coroutine.yield()end
while(TppRadio.playingBlackTelInfo~=nil)do
if DebugText then
DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Waiting end blackTelephoneRadio : radioGroupName = "..tostring(TppRadio.playingBlackTelInfo.radioName))end
coroutine.yield()end
TppUiCommand.StartResultBlockUnload()if gvars.needWaitMissionInitialize then
TppMain.DisablePause()end
while(gvars.needWaitMissionInitialize)do
if DebugText then
DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Waiting end reward popup : gvars.needWaitMissionInitialize = "..tostring(gvars.needWaitMissionInitialize))end
coroutine.yield()end
TppMain.EnablePause()end
function e.SetNeedWaitMissionInitialize()gvars.needWaitMissionInitialize=true
end
function e.ResetNeedWaitMissionInitialize()gvars.needWaitMissionInitialize=false
end
function e.CancelLoadOnResult()mvars.mis_doMissionFinalizeOnMissionTelopDisplay=nil
e.ResetNeedWaitMissionInitialize()end
function e.OnAllocate(n)vars.invitationDisableRecieveFlag=0
e.systemCallbacks={OnEstablishMissionClear=function()e.MissionGameEnd{loadStartOnResult=false}end,OnDisappearGameEndAnnounceLog=e.ShowMissionResult,OnEndMissionCredit=nil,OnEndMissionReward=nil,OnGameOver=nil,OnOutOfMissionArea=nil,OnUpdateWhileMissionPrepare=nil,OnFinishBlackTelephoneRadio=function()if not gvars.needWaitMissionInitialize then
e.ShowMissionReward()end
end,OnOutOfHotZone=nil,OnOutOfHotZoneMissionClear=nil,OnUpdateStorySequenceInGame=nil,CheckMissionClearFunction=nil,OnReturnToMission=nil,OnAddStaffsFromTempBuffer=nil,CheckMissionClearOnRideOnFultonContainer=nil,OnRecovered=nil,OnSetMissionFinalScore=nil,OnEndDeliveryWarp=nil,OnFultonContainerMissionClear=nil,OnOutOfDefenseGameArea=nil,OnAlertOutOfDefenseGameArea=nil}e.RegisterMissionID()Mission.AddFinalizer(e.OnMissionFinalize)if n.sequence then
if n.sequence.MISSION_WORLD_CENTER then
TppCoder.SetWorldCenter(n.sequence.MISSION_WORLD_CENTER)end
local a=n.sequence.missionObjectiveDefine
local s=n.sequence.missionObjectiveTree
local t=n.sequence.missionObjectiveEnum
if a and s then
e.SetMissionObjectives(a,s,t)end
if n.sequence.missionStartPosition then
if i(n.sequence.missionStartPosition.orderBoxList)then
mvars.mis_orderBoxList=n.sequence.missionStartPosition.orderBoxList
end
end
if e.IsStoryMission(vars.missionCode)then
if n.sequence.blackRadioOnEnd then
if o(n.sequence.blackRadioOnEnd)then
mvars.mis_blackRadioSetting=n.sequence.blackRadioOnEnd
end
end
if n.sequence.releaseAnnounce then
if i(n.sequence.releaseAnnounce)then
mvars.mis_releaseAnnounceSetting=n.sequence.releaseAnnounce
ReleaseAnnouncePopupSystem.SetInfos(mvars.mis_releaseAnnounceSetting)end
end
end
if n.sequence.DEFENSE_MAP_LOCATOR_NAME then
SsdBlankMap.EnableDefenseMode{areaName=n.sequence.DEFENSE_MAP_LOCATOR_NAME}else
SsdBlankMap.DisableDefenseMode()end
end
mvars.mis_isOutsideOfMissionArea=false
mvars.mis_isOutsideOfHotZone=true
e.MessageHandler={OnMessage=function(n,i,s,t,a,o)e.OnMessageWhileLoading(n,i,s,t,a,o)end}GameMessage.SetMessageHandler(e.MessageHandler,{"UI","Radio","Video","Network","Nt"})end
function e.DisableInGameFlag()mvars.mis_missionStateIsNotInGame=true
end
function e.EnableInGameFlag(e)if gvars.mis_missionClearState<=TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET then
mvars.mis_missionStateIsNotInGame=false
if not e then
TppSoundDaemon.ResetMute"Loading"end
else
mvars.mis_missionStateIsNotInGame=true
end
end
function e.ExecuteSystemCallback(i,n)local e=e.systemCallbacks[i]if s(e)then
return e(n)end
end
function e.Init(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())e.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(e.MessagesWhileLoading())mvars.mis_isAlertOutOfMissionArea=false
mvars.mis_isAllDead=false
gvars.mis_skipOnPreLoadForContinue=false
mvars.mis_defeseGameAreaTrapTable={}end
function e.OnReload(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())e.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(e.MessagesWhileLoading())if n.sequence then
local i=n.sequence.missionObjectiveDefine
local s=n.sequence.missionObjectiveTree
local n=n.sequence.missionObjectiveEnum
if i and s then
e.SetMissionObjectives(i,s,n)end
end
local n={"OnEstablishMissionClear","OnDisappearGameEndAnnounceLog","OnEndMissionCredit","OnEndMissionReward","OnGameOver","OnOutOfMissionArea","OnUpdateWhileMissionPrepare","OnFinishBlackTelephoneRadio","OnOutOfHotZone","OnOutOfHotZoneMissionClear","OnUpdateStorySequenceInGame","CheckMissionClearFunction","OnReturnToMission","OnAddStaffsFromTempBuffer","CheckMissionClearOnRideOnFultonContainer","OnRecovered","OnMissionGameEndFadeOutFinish","OnFultonContainerMissionClear"}for i,n in ipairs(n)do
local i=_G.TppMission.systemCallbacks
if i then
local i=i[n]e.systemCallbacks=e.systemCallbacks or{}e.systemCallbacks[n]=i
end
end
end
function e.RegisterMissionID()mvars.mis_missionName=e._CreateMissionName(vars.missionCode)end
function e.DeclareSVars()return{{name="mis_canMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,notify=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mis_isDefiniteGameOver",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_gameOverType",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_gameOverRadio",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mis_isDefiniteMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_missionClearType",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_isAbandonMission",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_objectiveEnable",arraySize=O,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}end
function e.CheckMessageOptionWhileLoading()return true
end
function e.OnMessageWhileLoading(o,r,t,s,n,i)local a=Tpp.DEBUG_StrCode32ToString
local a
Tpp.DoMessage(e.messageExecTableWhileLoading,e.CheckMessageOptionWhileLoading,o,r,t,s,n,i,a)end
function e.OnMessage(r,o,i,a,t,n,s)Tpp.DoMessage(e.messageExecTable,e.CheckMessageOption,r,o,i,a,t,n,s)if mvars.mis_defeseGameAreaMessageExecTable then
Tpp.DoMessage(mvars.mis_defeseGameAreaMessageExecTable,e.CheckMessageOption,r,o,i,a,t,n,s)end
end
function e.CheckMessageOption(n)local t=false
local s=false
local o=false
local r=false
local l=false
if n and i(n)then
t=n[a"isExecMissionClear"]s=n[a"isExecGameOver"]o=n[a"isExecDemoPlaying"]r=n[a"isExecMissionPrepare"]l=n[a"isExecFastTravel"]end
return e.CheckMissionState(t,s,o,r,l)end
function e.CheckMissionState(t,a,s,o,r)local n=mvars
local e=svars
if e==nil then
return
end
local l=n.mis_isReserveMissionClear or e.mis_isDefiniteMissionClear
local d=n.mis_isReserveGameOver or e.mis_isDefiniteGameOver
local m=TppDemo.IsNotPlayable()local i=false
if e.seq_sequence<=1 then
i=true
end
local e=(n.ply_deliveryWarpState~=nil)if l and not t then
return false
elseif d and not a then
return false
elseif m and not s then
return false
elseif i and not o then
return false
elseif e and not r then
return false
else
return true
end
end
function e.CheckMissionClearOnOutOfMissionArea()if e.systemCallbacks.CheckMissionClearFunction then
return e.systemCallbacks.CheckMissionClearFunction()else
return false
end
end
function e.EnableAlertOutOfMissionAreaIfAlertAreaStart()if mvars.mis_isAlertOutOfMissionArea then
e.EnableAlertOutOfMissionArea()end
end
function e.IgnoreAlertOutOfMissionAreaForBossQuiet(e)if e==true then
mvars.mis_ignoreAlertOfMissionArea=true
else
mvars.mis_ignoreAlertOfMissionArea=false
end
end
function e.EnableAlertOutOfMissionArea()local e=false
if mvars.mis_ignoreAlertOfMissionArea==true then
e=true
end
if svars.mis_canMissionClear then
return
end
if mvars.mis_missionStateIsNotInGame then
return
end
mvars.mis_enableAlertOutOfMissionArea=true
TppUI.ShowAnnounceLog"closeOutOfMissionArea"if not e then
TppOutOfMissionRangeEffect.Enable(3)end
end
function e.DisableAlertOutOfMissionArea()mvars.mis_enableAlertOutOfMissionArea=false
TppOutOfMissionRangeEffect.Disable(1)TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",false)end
function e.ExitHotZone()e.ExecuteSystemCallback"OnOutOfHotZone"if svars.mis_canMissionClear then
TppUI.ShowAnnounceLog"leaveHotZone"if not _()then
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT)else
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE)end
end
end
function e.PlayCommonRadioOnInsideOfHotZone()if svars.mis_canMissionClear then
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RETURN_HOTZONE)end
end
function e.OutsideOfHotZoneCount()if mvars.mis_isOutsideOfHotZone then
e.ReserveMissionClearOnOutOfHotZone()end
end
local function c()if r"Timer_OutsideOfHotZoneCount"then
p"Timer_OutsideOfHotZoneCount"end
end
function e.CheckMissionClearOnRideOnFultonContainer()if e.systemCallbacks.CheckMissionClearOnRideOnFultonContainer then
return e.systemCallbacks.CheckMissionClearOnRideOnFultonContainer()else
return false
end
end
function e.OnPlayerFultoned()end
function e.Update()local n=mvars
local i=svars
local s=e.GetMissionName()if n.mis_needSetCanMissionClear then
e._SetCanMissionClear()end
if n.mov_checkEndFadeOut then
n.mov_checkEndFadeOut=nil
TppMovie.OnEndFadeOut()end
if n.mis_missionStateIsNotInGame then
return
end
local f,m,d,o=e.GetSyncMissionStatus()local u=n.mis_isAlertOutOfMissionArea
local s=n.mis_isOutsideOfMissionArea
local c=n.mis_isOutsideOfHotZone
local a=i.mis_canMissionClear
if f and m then
TppMain.DisableGameStatus()HighSpeedCamera.RequestToCancel()e.EstablishedMissionClear(i.mis_missionClearType)e._OnEstablishMissionEnd()elseif d and o then
TppMain.DisableGameStatus()HighSpeedCamera.RequestToCancel()if n.mis_isAborting then
e.EstablishedMissionAbort()else
e.EstablishedGameOver()end
e._OnEstablishMissionEnd()elseif a then
e.UpdateAtCanMissionClear(c,s)else
if s then
if e.CheckMissionClearOnOutOfMissionArea()then
e.ReserveMissionClearOnOutOfHotZone()else
if e.systemCallbacks.OnOutOfMissionArea==nil then
e.AbortForOutOfMissionArea{isNoSave=false}else
e.systemCallbacks.OnOutOfMissionArea()end
end
end
if u then
if not r(l)then
t(l,g)end
else
if r(l)then
p(l)end
end
end
if TppSequence.IsMissionPrepareFinished()then
h()end
e.ResumeMbSaveCoroutine()if n.mis_needSetEscapeBgm then
if vars.playerPhase>TppEnemy.PHASE.SNEAK then
TppSound.StartEscapeBGM()else
TppSound.StopEscapeBGM()end
end
if n.mis_isMultiPlayMission then
return
end
TppQuest.OnUpdate()SsdFlagMission.OnUpdate()SsdBaseDefense.OnUpdate()SsdCreatureBlock.OnUpdate()end
function e.UpdateForMissionLoad()if mvars.mis_loadRequest then
e.Load(mvars.mis_loadRequest.nextMission,mvars.mis_loadRequest.currentMission,mvars.mis_loadRequest.options)mvars.mis_loadRequest=nil
end
end
function e.CreateMbSaveCoroutine()local function n()while(not TppMotherBaseManagement.IsEndedSyncControl())do
if DebugText then
DebugText.Print(DebugText.NewContext(),"WaitMbSyncAndSave:")end
coroutine.yield()end
if TppMotherBaseManagement.IsResultSuccessedSyncControl()then
TppSave.SaveOnlyMbManagement()end
end
e.waitMbSyncAndSaveCoroutine=coroutine.create(n)end
function e.ResumeMbSaveCoroutine()if e.waitMbSyncAndSaveCoroutine then
local n,n=coroutine.resume(e.waitMbSyncAndSaveCoroutine)if coroutine.status(e.waitMbSyncAndSaveCoroutine)=="dead"then
e.waitMbSyncAndSaveCoroutine=nil
return
end
end
end
function e.GetSyncMissionStatus()local t=mvars
local e=svars
local r=TppNetworkUtil.IsHost()local o=TppNetworkUtil.IsSessionConnect()local a=false
local s=false
local i=false
local n=false
if not o then
a=t.mis_isReserveMissionClear
s=true
i=t.mis_isReserveGameOver
n=true
else
if r then
a=e.mis_isDefiniteMissionClear and u"mis_isDefiniteMissionClear"s=u"mis_missionClearType"i=e.mis_isDefiniteGameOver and u"mis_isDefiniteGameOver"n=u"mis_gameOverType"else
a=e.mis_isDefiniteMissionClear
s=true
i=e.mis_isDefiniteGameOver
n=e.mis_gameOverType
end
end
return a,s,i,n
end
function e.EstablishedMissionAbort()TppQuest.OnMissionGameEnd()SsdFlagMission.OnMissionGameEnd()SsdBaseDefense.OnMissionGameEnd()if mvars.mis_abortWithPlayRadio then
TppRadio.PlayGameOverRadio()end
if mvars.mis_abortPresentationFunction then
mvars.mis_abortPresentationFunction()end
if mvars.mis_abortWithFade then
if mvars.mis_missionAbortFadeDelayTime==0 then
e.FadeOutOnMissionAbort()else
t("Timer_StartMissionAbortFadeOut",mvars.mis_missionAbortFadeDelayTime)end
else
e._CreateSurviveCBox()e.ExecuteMissionAbort()end
end
function e.FadeOutOnMissionAbort()local e
if mvars.mis_abortWithSave then
e={AnnounceLog="SUSPEND_LOG"}else
e={AnnounceLog="INVALID_LOG"}end
TppUI.FadeOut(mvars.mis_missionAbortFadeSpeed,"AbortMissionFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true,exceptGameStatus=e})end
function e.OnEndFadeOutMissionAbort()if mvars.mis_abortIsTitleMode then
gvars.ini_isTitleMode=true
end
e._CreateSurviveCBox()e.VarSaveForMissionAbort()e.ShowAnnounceLogOnFadeOut(e.LoadForMissionAbort)end
function e.EstablishedGameOver()TppMusicManager.StopJingleEvent()if not e.IsMultiPlayMission(vars.missionCode)then
TppScriptVars.ResetAliveTime()end
Mission.SetRevivalDisabled(true)local n={}local i=TppStory.GetCurrentStorySequence()for e=i,TppDefine.STORY_SEQUENCE.STORY_START,-1 do
local e=TppDefine.CONTINUE_TIPS_TABLE[e]if e then
for i,e in ipairs(e)do
table.insert(n,e)end
end
end
SsdUiSystem.RequestForceCloseForMissionClear()if#n>0 then
local e=gvars.continueTipsCount
if(e>#n)then
e=1
gvars.continueTipsCount=1
end
local n=n[e]local e
if n then
e=TppDefine.TIPS[n]end
if d(e)then
gvars.continueTipsCount=gvars.continueTipsCount+1
end
end
local n
if e.systemCallbacks.OnGameOver then
n=e.systemCallbacks.OnGameOver()end
if not n then
local n=false
if e.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD)then
n=true
e.ShowGameOverMenu{delayTime=TppPlayer.PLAYER_FALL_DEAD_DELAY_TIME}elseif e.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.TARGET_DEAD)then
local i=TppPlayer.SetTargetDeadCameraIfReserved()if i then
n=true
e.ShowGameOverMenu{delayTime=6}end
elseif e.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.DEFENSE_TARGET_WAS_DESTROYED)then
local i=TppPlayer.SetDefenseTargetBrokenCameraIfReserved()if i then
n=true
e.ShowGameOverMenu{delayTime=6}end
end
if not n then
e.ShowGameOverMenu()end
end
if(Tpp.IsQARelease())then
if not(e.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.ABORT)or e.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.S10060_RETURN_END))and(not mvars.mis_isGameOverMenuShown)then
end
end
end
function e.UpdateAtCanMissionClear(n,s)if not n then
mvars.mis_lastOutSideOfHotZoneButAlert=nil
c()return
end
local i=_()local n=E()if s then
if n then
c()e.ReserveMissionClearOnOutOfHotZone()end
else
if i and n then
if not r"Timer_OutsideOfHotZoneCount"then
t("Timer_OutsideOfHotZoneCount",I)end
else
if not i then
mvars.mis_lastOutSideOfHotZoneButAlert=true
end
c()end
end
end
function e.ReserveMissionClearOnOutOfHotZone()if e.systemCallbacks.OnOutOfHotZoneMissionClear then
e.systemCallbacks.OnOutOfHotZoneMissionClear()return
end
e._ReserveMissionClearOnOutOfHotZone()end
function e._ReserveMissionClearOnOutOfHotZone()if mvars.mis_lastOutSideOfHotZoneButAlert then
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_CHANGE_SNEAK)end
if TppLocation.IsAfghan()then
e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE}elseif TppLocation.IsMiddleAfrica()then
e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_FREE}else
e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE}end
end
function e.DisconnectMatching(e)local n=TppNetworkUtil.IsHost()if n then
svars.mis_isAbandonMission=true
end
SsdMatching.RequestCancelAutoMatch()if(e)then
SsdMatching.RequestLeaveRoomAndSession()end
end
function e.AbandonMission()if not e.IsCoopMission(vars.missionCode)then
if e.IsMatchingRoom(vars.missionCode)then
e.AbandonCoopLobbyMission(vars.missionCode)end
return
end
e.DisconnectMatching(true)e.ReturnToMatchingRoom()end
function e.AbandonCoopLobbyMission(n)if not e.IsMatchingRoom(vars.missionCode)then
return
end
if IS_GC_2017_COOP then
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED)e.DisconnectMatching(false)e.GameOverReturnToTitle()return
end
local n=e.IsMultiPlayMission(n)e.DisconnectMatching(n)Mission.RequestCancelMatchingScreen()if not n then
local n={}n.isNeedUpdateBaseManagement=true
e.ContinueFromCheckPoint(n)else
mvars.mis_abortWithSave=false
mvars.mis_nextMissionCodeForAbort=e.GetCoopLobbyMissionCode()if mvars.mis_missionAbortLoadingOption==nil then
mvars.mis_missionAbortLoadingOption={}end
mvars.mis_missionAbortLoadingOption.force=true
e.ExecuteMissionAbort()end
end
function e.AbortMissionByMenu(n)if e.IsCoopMission(vars.missionCode)then
e.AbandonMission()else
local n=n or{}if e.IsMultiPlayMission(vars.missionCode)then
n.isNoSurviveBox=true
end
e.AbortForOutOfMissionArea(n)end
end
function e.AbortForOutOfMissionArea(t)local s=false
local n=false
local r
local l,o
local a
if i(t)then
if t.isNoSave then
s=true
end
if t.isNoSurviveBox then
n=true
end
end
if TppLocation.IsAfghan()then
e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE,isNoSave=s,fadeDelayTime=l,fadeSpeed=o,presentationFunction=r,playRadio=a,isNoSurviveBox=n}elseif TppLocation.IsMiddleAfrica()then
e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_FREE,isNoSave=s,fadeDelayTime=l,fadeSpeed=o,presentationFunction=r,playRadio=a,isNoSurviveBox=n}else
e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE,isNoSave=s,fadeDelayTime=l,fadeSpeed=o,presentationFunction=r,playRadio=a,isNoSurviveBox=n}end
end
function e.GameOverAbortMission()local n=TppDefine.SYS_MISSION_ID.AFGH_FREE
if TppLocation.IsMiddleAfrica()then
n=TppDefine.SYS_MISSION_ID.MAFR_FREE
end
e.AbortMission{nextMissionId=n,isAlreadyGameOver=true}end
function e.GameOverAbortForOutOfMissionArea()mvars.mis_abortWithSave=true
if TppLocation.IsAfghan()then
mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_FREE
elseif TppLocation.IsMiddleAfrica()then
mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MAFR_FREE
else
mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_FREE
end
end
function e.GameOverReturnToBase()TppRadio.Stop()TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"GameOverReturnToBaseFadeOut",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})end
function e.ExecuteGameOverReturnToBase()local n=function()local i=function()TppUI.HideAccessIcon()TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"GameOverReturnToBaseFadeIn",TppUI.FADE_PRIORITY.SYSTEM)end
Player.ResetPadMask{settingName="FastTravel"}local n=ScriptParam.GetValue{category=ScriptParamCategory.PLAYER,paramName="minLifeRateByContinue"}local s=ScriptParam.GetValue{category=ScriptParamCategory.PLAYER,paramName="minOxygenRateByContinue"}local t=ScriptParam.GetValue{category=ScriptParamCategory.PLAYER,paramName="minHungerRateByContinue"}local a=ScriptParam.GetValue{category=ScriptParamCategory.PLAYER,paramName="minThirstRateByContinue"}local n={id="Revive",revivalType="Return",invincibleTime=0,lifeRecoveryRate=n,oxygenRecoveryRate=s,hungerRecoveryRate=t,thirstRecoveryRate=a,cureInjuryAll=false}GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},n)GameOverMenuSystem.RequestClose()TppMain.EnableGameStatus()TppGameStatus.Reset("TppMission.GameOverReturnToBase","S_IS_BLACK_LOADING")TppGameStatus.Reset("TppMission.GameOverReturnToBase","S_DISABLE_TARGET")TppSave.AddServerSaveCallbackFunc(i)if mvars.mis_isNeedSaveForGameOverReturnToBase then
e.VarSaveOnUpdateCheckPoint()end
end
svars.mis_isDefiniteGameOver=false
svars.mis_gameOverType=0
mvars.mis_isAborting=false
mvars.mis_isReserveGameOver=false
mvars.mis_isAllDead=false
mvars.mis_isGameOverReasonSuicide=false
mvars.mis_isNeedSaveForGameOverReturnToBase=false
if TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")then
mvars.mis_isNeedSaveForGameOverReturnToBase=true
end
e._CreateSurviveCBox()e._WarpToBase(n)TppGameStatus.Set("TppMission.GameOverReturnToBase","S_IS_BLACK_LOADING")TppGameStatus.Set("TppMission.GameOverReturnToBase","S_DISABLE_TARGET")TppUI.ShowAccessIcon()end
function e.ReturnToBaseByMenu()if e.IsMultiPlayMission(vars.missionCode)then
e.AbortMissionByMenu()return
end
if mvars.mis_isReserveMissionClear or mvars.mis_isReserveGameOver then
return
end
if TppPlayer.IsFastTraveling()then
return
end
TppPlayer.StartFastTravelByReturnBase()end
function e._WarpToBase(e)mvars.mis_finishWarpToBaseCallBack=nil
if s(e)then
mvars.mis_finishWarpToBaseCallBack=e
end
local e="fast_afgh_basecamp"if TppLocation.IsMiddleAfrica()then
e="fast_mafr_basecamp"end
local i,n=SsdFastTravel.GetFastTravelPointName(a(e))if not i or not n then
local e={afgh=Vector3(-442,288,2239),mafr=Vector3(2790,96,-910)}local n=TppLocation.GetLocationName()local i=e[n]if not i then
i=e.afgh
end
local i={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}local e={id="WarpAndWaitBlock",pos=e[n],resetState=true}GameObject.SendCommand(i,e)return
end
local e,n=Tpp.GetLocatorByTransform(i,n)local i=Tpp.GetRotationY(n)if e then
e=e+Vector3(0,.8,0)end
local n={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}local e={id="WarpAndWaitBlock",pos=e,rotY=TppMath.DegreeToRadian(i),resetState=true}GameObject.SendCommand(n,e)end
function e.OnChangeSVars(n,i)if n=="mis_isDefiniteMissionClear"then
if(svars.mis_isDefiniteMissionClear)then
mvars.mis_isReserveMissionClear=true
end
end
if n=="mis_isDefiniteGameOver"then
if(svars.mis_isDefiniteGameOver)then
mvars.mis_isDefiniteGameOver=true
end
end
if n=="mis_canMissionClear"then
if svars.mis_canMissionClear then
e.OnCanMissionClear()end
if mvars.mis_isAlertOutOfMissionArea then
e.EnableAlertOutOfMissionArea()else
e.DisableAlertOutOfMissionArea()end
if mvars.mis_isOutsideOfHotZone then
e.ExitHotZone()end
end
if n=="mis_isAbandonMission"then
if svars.mis_isAbandonMission then
local n=TppNetworkUtil.IsHost()if not n then
if Mission.IsHostMigrationActive()then
e.StartWaitHostMigrationTimer()else
if Mission.IsIgnoreExceptionDisconnectFromHost()then
return
end
TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.SESSION_ABANDON)e.DisconnectMatching(true)end
end
end
end
end
function e.StartWaitHostMigrationTimer()if Mission.IsHostMigrationActive()then
t("Timer_WaitStartMigration",60)end
end
function e.PostMissionOrderBoxPositionToBuddyDog()if(not e.IsFreeMission(vars.missionCode))then
if mvars.mis_orderBoxList then
local n={}for s,i in pairs(mvars.mis_orderBoxList)do
local e,i=e.GetOrderBoxLocatorByTransform(i)if e then
table.insert(n,e)end
end
TppBuddyService.SetMissionGroundStartPositions{positions=n}else
TppBuddyService.ResetDogLeakedInformation()end
else
TppBuddyService.ResetDogLeakedInformation()end
end
function e.SetIsStartFromFreePlay()gvars.mis_isStartFromFreePlay=true
end
function e.ResetIsStartFromHelispace()end
function e.ResetIsStartFromFreePlay()gvars.mis_isStartFromFreePlay=false
end
function e.CanMissionAbortByMenu()if gvars.mis_isStartFromFreePlay then
return true
else
return false
end
end
function e.SetMissionOrderBoxPosition()if not mvars.mis_orderBoxList then
return
end
if gvars.mis_orderBoxName==0 then
return
end
local n=e.FindOrderBoxName(gvars.mis_orderBoxName)return e._SetMissionOrderBoxPosition(n)end
function e._SetMissionOrderBoxPosition(n)local e,n=e.GetOrderBoxLocator(n)if e then
local i=Vector3(0,-.75,1.98)local s=Vector3(e[1],e[2],e[3])local e=-Quat.RotationY(TppMath.DegreeToRadian(n)):Rotate(i)local e=e+s
local e=TppMath.Vector3toTable(e)local n=n
TppPlayer.SetInitialPosition(e,n)TppPlayer.SetMissionStartPosition(e,n)return true
end
end
function e.FindOrderBoxName(n)for i,e in pairs(mvars.mis_orderBoxList)do
if a(e)==n then
return e
end
end
end
function e.GetOrderBoxLocator(e)if not o(e)then
return
end
return Tpp.GetLocator("OrderBoxIdentifier",e)end
function e.GetOrderBoxLocatorByTransform(e)if not o(e)then
end
return Tpp.GetLocatorByTransform("OrderBoxIdentifier",e)end
function e.EstablishedMissionClear()DemoDaemon.StopAll()GkEventTimerManager.StopAll()if Tpp.IsHorse(vars.playerVehicleGameObjectId)then
GameObject.SendCommand(vars.playerVehicleGameObjectId,{id="HorseForceStop"})end
vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
if e.systemCallbacks.OnSetMissionFinalScore then
e.systemCallbacks.OnSetMissionFinalScore(svars.mis_missionClearType)end
e.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.ESTABLISHED_CLEAR)e.systemCallbacks.OnEstablishMissionClear(svars.mis_missionClearType)end
function e.OnMissionGameEndFadeOutFinish()TppEnemy.FultonRecoverOnMissionGameEnd()TppPlayer.SaveCaptureAnimal()if Player.CallRemovingChickenCapSE~=nil then
Player.CallRemovingChickenCapSE()end
if e.systemCallbacks.OnMissionGameEndFadeOutFinish then
e.systemCallbacks.OnMissionGameEndFadeOutFinish()end
if(mvars.mis_missionGameEndDelayTime>.1)then
t("Timer_MissionGameEndStart",mvars.mis_missionGameEndDelayTime)else
t("Timer_MissionGameEndStart",.1)end
end
function e.OnMissionGameEndFadeOutFinish2nd()TppUiStatusManager.ClearStatus"GmpInfo"TppStory.UpdateStorySequence{updateTiming="OnMissionClear",missionId=e.GetMissionID()}TppResult.SetMissionFinalScore(TppDefine.MISSION_TYPE.STORY)TppQuest.OnMissionGameEnd()SsdFlagMission.OnMissionGameEnd()SsdBaseDefense.OnMissionGameEnd()TppTerminal.OnEstablishMissionClear()if mvars.mis_blackRadioSetting then
BlackRadio.Close()BlackRadio.ReadJsonParameter(mvars.mis_blackRadioSetting)end
TppTutorial.OpenTipsOnCurrentStory()local e=e.GetMissionClearType()if(e==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO)or(e==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX)then
TppUiCommand.LoadoutSetMissionRecieveFromFreeToMission()end
TppPlayer.AggregateCaptureAnimal()TppTerminal.AddStaffsFromTempBuffer()TppSave.EraseAllGameDataSaveRequest()TppSave.VarSave()if DebugMenu then
TppSave.QARELEASE_DEBUG_ExecuteReservedDestroySaveData()end
t("Timer_MissionGameEndStart2nd",.1)end
function e.SetMissionObjectives(n,i,e)mvars.mis_missionObjectiveDefine=n
mvars.mis_missionObjectiveTree=i
mvars.mis_missionObjectiveEnum=e
if mvars.mis_missionObjectiveTree then
for n,e in Tpp.BfsPairs(mvars.mis_missionObjectiveTree)do
for e,i in pairs(e)do
local e=mvars.mis_missionObjectiveDefine[e]if e then
e.parent=e.parent or{}e.parent[n]=true
end
end
end
end
if mvars.mis_missionObjectiveTree and mvars.mis_missionObjectiveEnum==nil then
return
end
if#mvars.mis_missionObjectiveEnum>O then
return
end
end
function e.OnFinishUpdateObjectiveRadio(n)if n==a(mvars.mis_updateObjectiveRadioGroupName)then
e.ShowUpdateObjective(mvars.mis_objectiveSetting)end
end
function e.ShowUpdateObjective(n)if not i(n)then
return
end
local i={}for n,s in pairs(n)do
local n=mvars.mis_missionObjectiveDefine[s]local a=true
local a=not e.IsEnableMissionObjective(s)if a then
a=(not e.IsEnableAnyParentMissionObjective(s))end
if n and a then
e.DisableChildrenObjective(s)e._ShowObjective(n,true)local a={isMissionAnnounce=false,subGoalId=nil}if n.announceLog then
a.isMissionAnnounce=true
if n.subGoalId then
a.subGoalId=n.subGoalId
end
i[n.announceLog]=a
end
e.SetMissionObjectiveEnable(s,true)end
end
if next(i)then
for e=1,#TppUI.ANNOUNCE_LOG_PRIORITY do
local n=TppUI.ANNOUNCE_LOG_PRIORITY[e]local e=i[n]if e then
if e.isMissionAnnounce then
TppUI.ShowAnnounceLog(n)if e.subGoalId and e.subGoalId>0 then
TppUI.ShowAnnounceLog("subGoalContent",nil,nil,nil,e.subGoalId)end
end
i[n]=nil
end
end
if next(i)then
for e,n in pairs(i)do
TppUI.ShowAnnounceLog(e)end
end
TppSoundDaemon.PostEvent"sfx_s_terminal_data_fix"end
mvars.mis_objectiveSetting=nil
mvars.mis_updateObjectiveRadioGroupName=nil
end
function e._ShowObjective(e,n)if e.packLabel then
if not TppPackList.IsMissionPackLabelList(e.packLabel)then
return
end
end
if e.setInterrogation==nil then
e.setInterrogation=true
end
if e.gameObjectName then
TppMarker.Enable(e.gameObjectName,e.visibleArea,e.goalType,e.viewType,e.randomRange,e.setImportant,e.setNew,e.langId,e.guidelinesId)end
if e.gimmickId then
local i,n=TppGimmick.GetGameObjectId(e.gimmickId)if i then
TppMarker.Enable(n,e.visibleArea,e.goalType,e.viewType,e.randomRange,e.setImportant,e.setNew,e.langId,e.guidelinesId)end
end
if e.subGoalId then
TppUI.EnableMissionSubGoal(e.subGoalId)if e.subGoalId>0 then
if not e.announceLog then
e.announceLog="updateMissionInfo"end
end
end
if e.showEnemyRoutePoints then
if TppUiCommand.ShowEnemyRoutePoints then
local n=e.showEnemyRoutePoints.radioGroupName
if o(n)then
e.showEnemyRoutePoints.radioGroupName=a(n)end
TppUiCommand.ShowEnemyRoutePoints(e.showEnemyRoutePoints)end
end
if e.targetBgmCp then
TppEnemy.LetCpHasTarget(e.targetBgmCp,true)end
if e.missionTask then
TppUI.EnableMissionTask(e.missionTask,n)end
if e.seEventName then
if n then
TppSoundDaemon.PostEvent(e.seEventName)end
end
end
function e.RestoreShowMissionObjective()if not mvars.mis_missionObjectiveEnum then
return
end
for i,n in ipairs(mvars.mis_missionObjectiveEnum)do
if not svars.mis_objectiveEnable[i]then
local n=mvars.mis_missionObjectiveDefine[n]if n then
e.DisableObjective(n)end
end
end
for i,n in ipairs(mvars.mis_missionObjectiveEnum)do
if svars.mis_objectiveEnable[i]then
local n=mvars.mis_missionObjectiveDefine[n]if n then
e._ShowObjective(n,false)end
end
end
end
function e.SetMissionObjectiveEnable(e,n)if not mvars.mis_missionObjectiveEnum then
return
end
local e=mvars.mis_missionObjectiveEnum[e]if not e then
return
end
svars.mis_objectiveEnable[e]=n
end
function e.IsEnableMissionObjective(e)if not mvars.mis_missionObjectiveEnum then
return
end
local e=mvars.mis_missionObjectiveEnum[e]if not e then
return
end
return svars.mis_objectiveEnable[e]end
function e.GetParentObjectiveName(e)local e=mvars.mis_missionObjectiveDefine[e]if not e then
return
end
return e.parent
end
function e.IsEnableAnyParentMissionObjective(n)local n=mvars.mis_missionObjectiveDefine[n]if not n then
return
end
if not n.parent then
return false
end
local i
for n,s in pairs(n.parent)do
if e.IsEnableMissionObjective(n)then
return true
else
i=e.IsEnableAnyParentMissionObjective(n)if i then
return true
end
end
end
return false
end
function e.DisableChildrenObjective(s)local n
for i,e in Tpp.BfsPairs(mvars.mis_missionObjectiveTree)do
if i==s then
n=e
break
end
end
if not n then
return
end
for i,n in Tpp.BfsPairs(n)do
local n=mvars.mis_missionObjectiveDefine[i]if n then
e.SetMissionObjectiveEnable(i,false)e.DisableObjective(n)end
end
end
function e.DisableObjective(e)if e.packLabel then
if not TppPackList.IsMissionPackLabelList(e.packLabel)then
return
end
end
if e.gameObjectName then
TppMarker.Disable(e.gameObjectName,e.mapRadioName)end
if e.gimmickId then
local i,n=TppGimmick.GetGameObjectId(e.gimmickId)if i then
TppMarker.Disable(n,e.mapRadioName)end
end
if e.showEnemyRoutePoints then
local e=e.showEnemyRoutePoints.groupIndex
if TppUiCommand.InitEnemyRoutePoints then
TppUiCommand.InitEnemyRoutePoints(e)end
end
if e.targetBgmCp then
TppEnemy.LetCpHasTarget(e.targetBgmCp,false)end
if e.missionTask then
TppUiCommand.DisableMissionTask(e.missionTask)end
end
function e.VarSaveOnUpdateCheckPoint(n)gvars.isNewGame=false
TppTerminal.AddStaffsFromTempBuffer(true)TppSave.ReserveVarRestoreForContinue()TppEnemy.StoreSVars()TppWeather.StoreToSVars()TppMarker.StoreMarkerLocator()TppPlayer.StorePlayerDecoyInfos()SsdSbm.StoreToSVars()e.VarSaveForBuilding()SsdCrewSystem.Store()SsdBaseManagement.Store()svars.ply_isUsedPlayerInitialAction=true
TppRadioCommand.StoreRadioState()Gimmick.StoreSaveDataPermanentGimmickFromCheckPoint()TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.CHECK_POINT)end
function e.VarSaveForBuilding()if TppLocation.IsOMBS()or TppLocation.IsInit()then
return
end
SsdBuilding.Save()end
function e.SafeStopSettingOnMissionReload(e)local n
if e and e.setMute then
n=e.setMute
end
mvars.mis_missionStateIsNotInGame=true
gvars.canExceptionHandling=false
SubtitlesCommand.SetIsEnabledUiPrioStrong(false)TppRadio.Stop()TppMusicManager.StopMusicPlayer(1)TppMusicManager.EndSceneMode()TppRadioCommand.SetEnableIgnoreGamePause(false)if TppBuddy2BlockController.Unload then
TppBuddy2BlockController.Unload()end
GkEventTimerManager.StopAll()if Tpp.IsHorse(vars.playerVehicleGameObjectId)then
GameObject.SendCommand(vars.playerVehicleGameObjectId,{id="HorseForceStop"})end
if n then
TppSoundDaemon.SetMute(n)else
TppSound.SetMuteOnLoading()end
TppOutOfMissionRangeEffect.Disable(1)TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",false)end
function e.VarResetOnNewMission()TppScriptVars.InitForNewMission()TppCheckPoint.Reset()TppQuest.ResetQuestStatus()SsdFlagMission.ResetFlagMissionStatus()TppPackList.SetDefaultMissionPackLabelName()TppPlayer.UnsetRetryFlag()if GameConfig.GetStealthAssistEnabled()then
mvars.mis_needSaveConfigOnNewMission=true
GameConfig.SetStealthAssistEnabled(false)end
TppPlayer.ResetStealthAssistCount()TppSave.ReserveVarRestoreForMissionStart()e.SetNextMissionCodeForMissionClear(m)e.ResetMissionClearState()end
function e.RequestLoad(i,n,e)if not mvars then
return
end
if gvars.isLoadedInitMissionOnSignInUserChanged then
return
end
TppMain.EnablePause()mvars.mis_loadRequest={nextMission=i,currentMission=n,options=e}end
function e.OnPreLoadWithChunkCheck()local n,i,s=gvars.mis_nextMissionAfterChunkCheck,gvars.mis_currentMissionAfterChunkCheck,gvars.mis_needLoadMissionAfterChunkCheck
if DebugText then
local e=DebugText.NewContext()DebugText.Print(e,{.5,.5,1},"Requested load : nextMission = "..(tostring(n)..(", currentMission = "..tostring(i))))end
if vars.locationCode==TppDefine.LOCATION_ID.INIT or n>=6e4 then
e._OnPreLoadWithChunkCheckEnd(i,n)return
else
do
if mvars.mis_popupTypeChunkInstalling==nil then
if TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.NOW_INSTALLING)then
mvars.mis_popupTypeChunkInstalling=TppDefine.ERROR_ID.NOW_INSTALLING
end
elseif not TppUiCommand.IsShowPopup()then
if mvars.mis_popupTypeChunkInstalling==TppDefine.ERROR_ID.NOW_INSTALLING then
TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.INSTALL_CANCEL,Popup.TYPE_TWO_BUTTON)mvars.mis_popupTypeChunkInstalling=TppDefine.ERROR_ID.INSTALL_CANCEL
return
elseif mvars.mis_popupTypeChunkInstalling==TppDefine.ERROR_ID.INSTALL_CANCEL then
if TppUiCommand.GetPopupSelect()==1 then
mvars.mis_isCancelChunkLoadingOnMissionLoad=true
else
mvars.mis_popupTypeChunkInstalling=nil
end
else
mvars.mis_popupTypeChunkInstalling=nil
end
end
end
if not mvars.mis_isCancelChunkLoadingOnMissionLoad then
local n=Tpp.GetChunkIndexList(vars.locationCode,n)if e.IsChunkLoading(n,true)then
return
end
else
s=true
gvars.ini_isTitleMode=true
n=TppDefine.SYS_MISSION_ID.INIT
vars.missionCode=n
vars.locationCode=TppDefine.LOCATION_ID.INIT
gvars.waitLoadingTipsEnd=false
TppUI.SetFadeColorToBlack()end
end
e._OnPreLoadWithChunkCheckEnd(i,n,s)end
function e._OnPreLoadWithChunkCheckEnd(n,i,s)Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)if s then
Mission.LoadMission(n,i,{showLoadingTips=true,force=true})end
if(n~=i)then
e.LoadLocation(n,i)end
mvars.mis_isCancelChunkLoadingOnMissionLoad=nil
mvars.mis_isChunkLoadingOnMissionLoad=nil
gvars.mis_chunkingCheckOnPreLoad=false
gvars.mis_needLoadMissionAfterChunkCheck=false
gvars.mis_nextMissionAfterChunkCheck=1
gvars.mis_currentMissionAfterChunkCheck=1
end
function e.IsChunkLoading(i,s)if SplashScreen.GetSplashScreenWithName"konamiLogo"then
return true
end
if SplashScreen.GetSplashScreenWithName"kjpLogo"then
return true
end
if SplashScreen.GetSplashScreenWithName"foxLogo"then
return true
end
Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)for e,n in ipairs(i)do
local e=Chunk.GetChunkState(n)if e==Chunk.STATE_INSTALLED then
elseif e==Chunk.STATE_INSTALLING then
if not TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.INSTALL_CANCEL)then
Tpp.ShowChunkInstallingPopup(i,s)end
return true
elseif e==Chunk.STATE_EMPTY then
Chunk.PrefetchChunk(n)return true
end
end
if TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.NOW_INSTALLING)or TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.NOW_INSTALLING)then
TppUiCommand.ErasePopup()end
Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)return false
end
function e.Load(n,s,i)local a
if(i and i.showLoadingTips~=nil)then
a=i.showLoadingTips
else
a=true
end
local t=(s and not e.IsMultiPlayMission(s))local o=e.IsMultiPlayMission(n)local r=e.IsAvatarEditMission(n)local t=(n==TppDefine.SYS_MISSION_ID.INIT)if(i and i.waitOnLoadingTipsEnd~=nil)then
gvars.waitLoadingTipsEnd=i.waitOnLoadingTipsEnd
else
local e=(((((o or r)or InvitationManagerController.IsGoingCoopMission())or gvars.mis_isReloaded)or gvars.ini_isTitleMode)or t)if e then
gvars.waitLoadingTipsEnd=false
else
gvars.waitLoadingTipsEnd=true
end
end
TppMain.EnablePause()TppMain.EnableBlackLoading(a)if not TppEnemy.IsLoadedDefaultSoldier2CommonPackage()then
TppEnemy.UnloadSoldier2CommonBlock()end
if o or t then
BaseDefenseManager.Reset()end
local i=((i and i.force)or((e.IsMatchingRoom(n)and e.IsMatchingRoom(s))and InvitationManagerController.HasInviteConsumed()))or(n==TppDefine.SYS_MISSION_ID.TITLE)if(s~=n)or i then
if TppSystemUtility.GetCurrentGameMode()=="TPP"then
TppEneFova.InitializeUniqueSetting()TppEnemy.PreMissionLoad(n,s)end
if not Mission.IsReadyGameSequence()or i then
e.LoadLocation(s,n,i)end
Mission.LoadMission{force=i}else
Mission.RequestToReload()end
TppUI.ShowAccessIcon()end
function e.ExecuteReload()if gvars.exc_processingForDisconnect then
return
end
if mvars.mis_nextLocationCode then
vars.locationCode=mvars.mis_nextLocationCode
end
if mvars.mis_nextClusterId then
vars.mbClusterId=mvars.mis_nextClusterId
end
gvars.sav_skipRestoreToVars=true
gvars.mis_isReloaded=true
gvars.mis_skipUpdateBaseManagement=true
TppStory.UpdateStorySequence{updateTiming="OnMissionReload"}e.SafeStopSettingOnMissionReload()TppPackList.SetMissionPackLabelName(mvars.mis_missionPackLabelName)TppSave.VarSave()TppSave.CheckAndSavePersonalData()e.RequestLoad(vars.missionCode,nil,{force=true,showLoadingTips=mvars.mis_showLoadingTipsOnReload})end
function e.CanStart()if mvars.mis_alwaysMissionCanStart then
return true
else
return Mission.CanStart()end
end
function e.SetNextMissionCodeForMissionClear(e)gvars.mis_nextMissionCodeForMissionClear=e
gvars.mis_nextLocationCodeForMissionClear=vars.locationCode
local e=TppPackList.GetLocationNameFormMissionCode(e)if e then
gvars.mis_nextLocationCodeForMissionClear=TppDefine.LOCATION_ID[e]end
end
function e.GetNextMissionCodeForMissionClear()return gvars.mis_nextMissionCodeForMissionClear
end
function e.AlwaysMissionCanStart()mvars.mis_alwaysMissionCanStart=true
end
function e.SetSortieBuddy()end
function e.GetObjectiveRadioOption(n)local e={}if i(n.radioOptions)then
for i,n in pairs(n.radioOptions)do
e[i]=n
end
end
if FadeFunction.IsFadeProcessing()then
local n=e.delayTime
local i=TppUI.FADE_SPEED.FADE_NORMALSPEED+1.2
if o(n)then
e.delayTime=TppRadio.PRESET_DELAY_TIME[n]+i
elseif d(n)then
e.delayTime=n+i
else
e.delayTime=i
end
end
return e
end
function e.OnMissionStart()local n=vars.missionCode
if e.IsCoopMission(n)then
Mission.StartVotingSystem()end
if not e.IsSysMissionId(n)then
MissionListMenuSystem.SetCurrentMissionCode(n)end
mvars.mis_isMultiPlayMission=e.IsMultiPlayMission(n)gvars.mis_isReloaded=false
end
function e.OnMissionFinalize()local e=vars.missionCode
SsdSbm.SetKubTemporalStorageMode(false)end
function e.SetPlayRecordClearInfo()local e,n=TppStory.CalcAllMissionClearedCount()TppUiCommand.SetPlayRecordClearInfo{recordId="MissionClear",clearCount=e,allCount=n}local n,e=TppStory.CalcAllMissionTaskCompletedCount()TppUiCommand.SetPlayRecordClearInfo{recordId="MissionTaskClear",clearCount=n,allCount=e}local n,e=TppQuest.CalcQuestClearedCount()TppUiCommand.SetPlayRecordClearInfo{recordId="SideOpsClear",clearCount=n,allCount=e}end
function e.IsBossBattle()if not mvars.mis_isBossBattle then
return false
end
return true
end
function e.StartBossBattle()mvars.mis_isBossBattle=true
end
function e.FinishBossBattle()mvars.mis_isBossBattle=false
end
function e.ShowAnnounceLogOnGameStart()local n,e=e.ParseMissionName(e.GetMissionName())if e=="free"then
if gvars.mis_isExistOpenMissionFlag then
TppUI.ShowAnnounceLog"missionListUpdate"TppUI.ShowAnnounceLog"missionAdd"gvars.mis_isExistOpenMissionFlag=false
end
TppQuest.ShowAnnounceLogQuestOpen()end
end
function e.SetDefensePosition(n)if not i(n)then
return
end
local e
if n.useCurrentLocationBaseDiggerPosition then
e=TppGimmick.GetCurrentLocationDiggerPosition()else
e=n
end
Mission.SetDefensePosition{pos=e}end
function e.RegisterDefenseGameArea(t,s,i)mvars.mis_defeseGameAreaTrapTable=mvars.mis_defeseGameAreaTrapTable or{}local n=mvars.mis_defeseGameAreaTrapTable
n.trapList=n.trapList or{}table.insert(n.trapList,t)n.alertTrapList=n.alertTrapList or{}table.insert(n.alertTrapList,s)n.trapToWaveName=n.trapToWaveName or{}n.trapToWaveName[a(t)]=i
n.trapToWaveName[a(s)]=i
mvars.mis_defeseGameAreaMessageExecTable=Tpp.MakeMessageExecTable(Tpp.StrCode32Table{Trap={{msg="Exit",sender=n.trapList,func=e.OnExitDefenseGameArea},{msg="Exit",sender=n.alertTrapList,func=e.OnExitAlertDefenseGameAreaTrap}}})end
function e.OnExitDefenseGameArea(n)if(not e.systemCallbacks.OnOutOfDefenseGameArea)or(not mvars.mis_defeseGameAreaTrapTable.trapToWaveName)then
return
end
local n=mvars.mis_defeseGameAreaTrapTable.trapToWaveName[n]e.systemCallbacks.OnOutOfDefenseGameArea(n)end
function e.OnExitAlertDefenseGameAreaTrap(n)if((not e.systemCallbacks.OnAlertOutOfDefenseGameArea)or(not mvars.mis_defeseGameAreaTrapTable.trapToWaveName))or(Mission.GetDefenseGameState()==TppDefine.DEFENSE_GAME_STATE.NONE)then
return
end
local n=mvars.mis_defeseGameAreaTrapTable.trapToWaveName[n]e.systemCallbacks.OnAlertOutOfDefenseGameArea(n)end
function e.RegisterFreePlayWaveSetting(e)if not i(e)then
return
end
mvars.mis_freeWaveSetting=e
end
function e.GetFreePlayWaveSetting()return mvars.mis_freeWaveSetting
end
function e.SetUpWaveSetting(a)if not i(a)then
return
end
local n,t,s,o={},{},{},{}for a,i in ipairs(a)do
for i,e in ipairs(i[1])do
table.insert(n,e)end
Tpp.MergeTable(t,i[2])Tpp.MergeTable(s,i[3])Tpp.MergeTable(o,i[4])end
e.RegisterWaveList(Tpp.Enum(n))e.RegisterWavePropertyTable(t)local i,e=TppEnemy.MakeSpawnSettingTable(n,s,o)local n=TppEnemy.MakeWaveSettingTable(n,s)TppEnemy.RegisterWaveSpawnPointList(e)local e={type="TppCommandPost2"}GameObject.SendCommand(e,{id="SetSpawnSetting",settingTable=i})GameObject.SendCommand(e,{id="SetWaveSetting",settingTable=n})end
function e.RegisterWaveList(e)if not i(e)then
return
end
mvars.mis_waveList=e
end
function e.RegisterWavePropertyTable(e)if not i(e)then
return
end
mvars.mis_wavePropertyTable=e
end
function e.GetWaveLimitTime(e)if not mvars.mis_wavePropertyTable then
return
end
local e=mvars.mis_wavePropertyTable[e]if not e then
return
end
return e.limitTimeSec
end
function e.GetWaveIntervalTime(e)if not mvars.mis_wavePropertyTable then
return
end
local e=mvars.mis_wavePropertyTable[e]if not e then
return
end
return e.intervalTimeSec
end
function e.GetWaveProperty(e)if not mvars.mis_wavePropertyTable then
return
end
return mvars.mis_wavePropertyTable[e]end
function e.IsTerminalWave(e)if not mvars.mis_wavePropertyTable then
return
end
return mvars.mis_wavePropertyTable[e].isTerminal
end
function e.GetCurrentWaveName()if not mvars.mis_waveList then
return
end
if not mvars.mis_waveIndex then
return
end
return mvars.mis_waveList[mvars.mis_waveIndex]end
function e.GetNextWaveName()if not mvars.mis_waveList then
return
end
if not mvars.mis_waveIndex then
return
end
return mvars.mis_waveList[mvars.mis_waveIndex+1]end
function e.SetInitialWaveName(e)local n=mvars.mis_waveList[e]if not n then
return
end
mvars.mis_initialWaveName=e
end
if(Tpp.IsQARelease()or nil)then
function e.DEBUG_SetInitialWaveName(n)e.SetInitialWaveName(n)end
function e.DEBUG_GetInitialWaveName(e)return mvars.mis_initialWaveName
end
end
function e.GetInitialWaveName()return mvars.mis_initialWaveName
end
function e.GetCurrentWaveIndex()return mvars.mis_waveIndex
end
function e.AddDefenseGameTargetKillCount(e)if not Mission.AddDefenseGameTargetKillCount then
return
end
if e==nil then
e=1
end
Mission.AddDefenseGameTargetKillCount(e)end
function e.GetDefenseGameTargetKillCount()if not Mission.AddDefenseGameTargetKillCount then
return 0
end
return Mission.GetDefenseGameTargetKillCount()end
function e.SetDiggerLifeBreakSetting(e)if not Mission.SetDiggerLifeBreakSetting then
return
end
Mission.SetDiggerLifeBreakSetting(e)end
function e.StartDefenseGame(i,s,a,n)if n==nil then
n={}end
mvars.mis_waveIndex=1
if mvars.mis_initialWaveName then
local e=mvars.mis_waveList[mvars.mis_initialWaveName]if not e then
return
end
mvars.mis_waveIndex=e
end
TppUI.SetDefenseGameMenu()if not e.IsMultiPlayMission(vars.missionCode)then
SsdSbm.SetKubTemporalStorageMode(true)end
if mvars.mis_defeseGameAreaTrapTable and mvars.mis_defeseGameAreaTrapTable.trapList then
for n,e in ipairs(mvars.mis_defeseGameAreaTrapTable.trapList)do
MapInfoSystem.SetSingleMissionDefenseGameArea(e)end
end
Mission.StartDefenseGame{limitTime=i,prepareTime=(n.prepareTime or i),alertTime=s,defenseType=a,finishType=n.finishType,killCount=n.killCount,shockWaveEffect=n.shockWaveEffect,miniMap=n.miniMap,prepareTimerLangId=n.prepareTimerLangId,waveTimerLangId=n.waveTimerLangId,intervalTimerLangId=n.intervalTimerLangId,showWaveTimer=n.showWaveTimer}end
function e.StartDefenseGameWithWaveProperty(n)if not i(n)then
return
end
local s=n.defenseGameType
local r=n.defenseTimeSec
local o=n.alertTimeSec
local d=n.endEffectName or"explosion"local i=n.finishType
local u=n.miniMap
local m=n.prepareTimerLangId
local t=n.waveTimerLangId
local l=n.intervalTimerLangId
local a=n.showWaveTimer
local a=n.isBaseDigging
local a=n.prepareTime
local n=n.showWaveTimer
local n={shockWaveEffect=d,miniMap=u,prepareTime=a,prepareTimerLangId=m,waveTimerLangId=t,intervalTimerLangId=l,showWaveTimer=n}if i then
n.finishType=i.type
n.killCount=i.maxCount
end
e.StartDefenseGame(r,o,s,n)end
function e.StopDefenseGame()TppGimmick.DeactivateRegisterdDefenseTarget()if TppLocation.IsAfghan()then
TppGimmick.ResetAfghBaseDiggerTarget()TppEnemy.SetUnrealAllFreeZombie(false)end
Mission.DisableWaveEffect()Mission.StopDefenseGame()TppUI.UnsetDefenseGameMenu()SsdSbm.SetKubTemporalStorageMode(false)if mvars.mis_defeseGameAreaTrapTable and mvars.mis_defeseGameAreaTrapTable.trapList then
for n,e in ipairs(mvars.mis_defeseGameAreaTrapTable.trapList)do
MapInfoSystem.ClearSingleMissionDefenseGameArea(e)end
end
mvars.mis_waveIndex=nil
mvars.mis_initialWaveName=nil
end
function e.StopDefenseTotalTime()Mission.DisableWaveEffect()Mission.StopDefenseTotalTime()end
function e.ExtendTimeLimit(e)Mission.ExtendTimeLimit{extendTime=e}end
function e.StartWaveInterval(s)local n,t,a
if d(s)then
n=s
elseif i(s)then
t=e.GetCurrentWaveName()a=e.GetNextWaveName()n=e.GetWaveIntervalTime(t)if not n then
return
end
TppEnemy.StartWaveInterval(a)else
return
end
local e=e.GetWaveProperty(a)if e then
if e.enemyLaneRouteList then
Mission.RegisterEnemyLaneRouteTable{[""]=e.enemyLaneRouteList}end
end
Mission.StartWaveInterval{intervalTime=n}Mission.StartWaveResult()end
function e.ShowPrepareInitWaveUI(n)local e=e.GetWaveProperty(n)if e then
if e.enemyLaneRouteList then
Mission.RegisterEnemyLaneRouteTable{[""]=e.enemyLaneRouteList}end
TppEnemy.EnableWaveSpawnPointEffect(n)Mission.EnableWaveEffect()SsdMinimap.Open()if e.defenseTargetGimmickProperty then
local e=TppGimmick.MakeDefenseTargetListFromWaveProperty(e.defenseTargetGimmickProperty)if e then
TppGimmick.SetDefenseTargetWithList(e,true)TppGimmick.RegisterActivatedDefenseTargetList(e)end
end
TppUI.SetDefenseGameMenu()end
end
function e.DisablePrepareInitWaveUI(e)TppGimmick.DeactivateRegisterdDefenseTarget()Mission.DisableWaveEffect()MapInfoSystem.ClearVisibleEnemyRouteInfos()TppEffectUtility.RemoveEnemyRootView()SsdMinimap.Close()TppUI.UnsetDefenseGameMenu()end
function e.StartInitialWave(n,T)e.SetInitialWaveName(n)local n=e.GetWaveProperty(n)if not i(n)then
return
end
local t=n.defenseTimeSec
if not t then
t=(30*3)end
local o=n.alertTimeSec
if not o then
o=t/10
end
local a=n.defenseGameType
if not a then
a=TppDefine.DEFENSE_GAME_TYPE.BASE
end
local f=n.endEffectName or"explosion"local r=n.finishType
local c=n.miniMap
local u=n.prepareTimerLangId
local p=n.waveTimerLangId
local m=n.intervalTimerLangId
local s=n.showWaveTimer
local l=n.isBaseDigging
local s={shockWaveEffect=f,miniMap=c,prepareTimerLangId=u,waveTimerLangId=p,intervalTimerLangId=m,showWaveTimer=s}if r then
s.finishType=r.type
s.killCount=r.maxCount
end
if not T then
e.StartDefenseGame(t,o,a,s)end
local t={.75,.5,.25}local o=2
local r=n.diggerLifeBreakPoints or t
local t=n.diggerLifeBreakShockWaveRadius or o
e.SetDiggerLifeBreakSetting{breakPoints=r,radius=t}local t=60
local t=n.waveFinishShockWaveRadius or t
if t then
Mission.SetDiggerShockWaveRadiusAtWaveFinish(t)end
if((TppLocation.IsAfghan()and(a==TppDefine.DEFENSE_GAME_TYPE.BASE))and s.finishType~=TppDefine.DEFENSE_FINISH_TYPE.KILL_COUNT)and not(l)then
TppGimmick.SetAfghBaseDiggerTargetToReturnWormhole()TppGimmick.OpenAfghBaseDigger()TppEnemy.SetUnrealAllFreeZombie(true)end
local t
local s,o=(n.defensePosition or n.pos),n.radius
local a=n.useSpecifiedAreaEnemy
if i(a)then
if i(a[1])and a[1].pos then
if not s then
s,o=a[1].pos,a[1].radius
end
else
a=nil
end
end
if not s then
s={useCurrentLocationBaseDiggerPosition=true}end
if o and d(s[1])then
t=t or{}t.useSpecifiedAreaEnemy=a or{{pos=s,radius=o}}end
e.SetDefensePosition(s)if n.defenseTargetGimmickProperty then
local e=TppGimmick.MakeDefenseTargetListFromWaveProperty(n.defenseTargetGimmickProperty)if e then
TppGimmick.SetDefenseTargetWithList(e,true)TppGimmick.RegisterActivatedDefenseTargetList(e)local e=n.defenseTargetGimmickProperty.identificationTable
if e and e.fastTravelPoint then
TppGimmick.SetDefenseTargetLevelByWaveProperty(n)end
end
end
if n.enemyLaneRouteList then
Mission.RegisterEnemyLaneRouteTable{[""]=n.enemyLaneRouteList}end
local e=e.GetCurrentWaveName()TppEnemy.StartWave(e,true,t)end
function e.StartNextWave()if not mvars.mis_waveIndex then
return
end
if not mvars.mis_waveList then
return
end
local n=mvars.mis_waveIndex+1
if n>#mvars.mis_waveList then
return
end
mvars.mis_waveIndex=n
local e=e.GetCurrentWaveName()TppEnemy.StartWave(e,false)return e
end
function e.StopWaveInterval()Mission.StopWaveInterval()end
function e.OnClearDefenseGame()SsdSbm.AddKubInTemporalStorage()end
function e.OnEndDefenseGame()local e=Gimmick.BreakAtTheBaseDefenseEnd()Gimmick.SetAllSwitchInvalid(false)SsdSbm.SetKubTemporalStorageMode(false)end
function e.IsHostmigrationProcessing()return gvars.mis_processingHostmigration
end
function e.IsLastResultOfHostmigration()return gvars.mis_lastResultOfHostmigration
end
function e.WaitJoinedRoomIfAcceptedInvite()while(SsdMatching.IsBusy())do
coroutine.yield()end
InvitationManagerController.RequestJoinInviteRoom()while(SsdMatching.IsBusy())do
coroutine.yield()end
end
function e.WaitCreateRoom()if not e.IsMatchingRoom(vars.missionCode)then
return
end
if Mission.IsJoinedCoopRoom()then
return
end
if gvars.ini_isTitleMode then
return
end
while(SsdMatching.IsBusy()or TppException.IsProcessing())do
coroutine.yield()end
SsdMatching.RequestCreateJoinRoom()while(SsdMatching.IsBusy())do
coroutine.yield()end
end
function e.InitializeCoopMission()if e.IsMultiPlayMission(vars.missionCode)and TppServerManager.IsLoginKonami()then
e.WaitJoinedRoomIfAcceptedInvite()if not Mission.IsJoinedCoopRoom()then
Mission.ResetCoopLobbyParams()e.WaitCreateRoom()end
end
end
function e.IsInvitationStart()return gvars.title_isInvitationStart
end
function e.SetInvitationStart(e)gvars.title_isInvitationStart=e
end
function e._CreateMissionName(i)local n=string.sub(tostring(i),1,1)local e
if(n=="1")then
e="s"elseif(n=="2")then
e="e"elseif(n=="3")then
e="f"elseif(n=="4")then
e="h"elseif(n=="5")then
e="o"else
if(Tpp.IsQARelease())and i>=6e4 then
return tostring(i).."(for test)"end
return nil
end
return e..tostring(i)end
function e._PushReward(e,i,n)TppReward.Push{category=e,langId=i,rewardType=n}end
function e._OnDeadCommon(n)if n==v then
mvars.mis_isGameOverReasonSuicide=true
e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD,TppDefine.GAME_OVER_RADIO.PLAYER_DEAD)else
if n==S then
mvars.mis_isGameOverReasonSuicide=true
end
e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_DEAD,TppDefine.GAME_OVER_RADIO.PLAYER_DEAD)end
end
function e._OnEstablishMissionEnd()TppPlayer.EnableSwitchIcon()end
function e._CreateSurviveCBox()if mvars.mis_abortWithoutSurviveBox then
return
end
SsdSbm.CreateSurviveCbox()end
function e.OnAfterMissionFinalize(i,n)if InvitationManagerController.IsGoingCoopMission()and(not e.IsMultiPlayMission(n))then
TppSave.VarRestoreOnContinueFromCheckPoint()vars.missionCode=e.GetCoopLobbyMissionCode()gvars.sav_skipRestoreToVars=true
end
end
local n=nil
function e.OnPreLoad(a,i)local s=false
if gvars.mis_skipOnPreLoadForContinue then
elseif e.IsMatchingRoom(i)then
local n=Mission.GetCoopMissionCode()if Mission.CanJoinSession()then
if Mission.IsSortiedCoopMission()and e.IsCoopMission(n)then
vars.missionCode=n
vars.locationCode=TppDefine.LOCATION_ID[TppPackList.GetLocationNameFormMissionCode(n)]gvars.sav_skipRestoreToVars=true
s=true
end
else
e.DisconnectMatching(true)TppException.OnFailedJoinSession()if not Mission.CanSortieMission()then
Mission.OpenPopupSortieReadyFailed()end
end
end
gvars.mis_chunkingCheckOnPreLoad=true
gvars.mis_needLoadMissionAfterChunkCheck=true
gvars.mis_nextMissionAfterChunkCheck=i
gvars.mis_currentMissionAfterChunkCheck=a
end
function e.LoadLocation(a,s,i)local n=TppPackList.GetLocationNameFormMissionCode(s)local a=TppPackList.GetLocationNameFormMissionCode(a)if(s==10010)then
n=TppLocation.GetLocationName()end
if e.IsMatchingRoom(s)and(i)then
n=TppLocation.GetLocationName()end
if e.IsAvatarEditMission(s)then
n=TppLocation.GetLocationName()end
local i=TppDefine.LOCATION_ID[n]local n=""local a=""if i==TppDefine.LOCATION_ID.SSD_AFGH or i==TppDefine.LOCATION_ID.AFGH then
n="/Assets/ssd/pack/gimmick/common/gimmick_main_afgh.fpk"if not e.IsMultiPlayMission(s)then
a="/Assets/ssd/pack/gimmick/common/gimmick_main_base.fpk"end
elseif i==TppDefine.LOCATION_ID.MAFR then
n="/Assets/ssd/pack/gimmick/common/gimmick_main_mafr.fpk"elseif i==TppDefine.LOCATION_ID.SBRI then
n="/Assets/ssd/pack/gimmick/common/gimmick_main_sbri.fpk"elseif i==TppDefine.LOCATION_ID.SPFC then
n="/Assets/ssd/pack/gimmick/common/gimmick_main_spfc.fpk"elseif i==TppDefine.LOCATION_ID.SSAV then
n="/Assets/ssd/pack/gimmick/common/gimmick_main_ssav.fpk"elseif i==TppDefine.LOCATION_ID.INIT then
n="/Assets/ssd/pack/gimmick/common/gimmick_main_init.fpk"elseif i==TppDefine.LOCATION_ID.AFTR then
n="/Assets/ssd/pack/gimmick/common/gimmick_main_aftr.fpk"end
TppGimmickBlockController.Setup{packagePath=n,packagePathSub=a,totalSize=(1024*1024)*57,unitSize0=1024*18+512,unitCount0=768,unitCountPart0=192,unitSize1=1024*24,unitCount1=128,unitCountPart1=64,unitSize2=1024*34,unitCount2=64,unitCountPart2=0}Mission.LoadLocation()end
function e.GoToCoopLobby()e.EnableInGameFlag()GameOverMenuSystem.RequestForceClose()local i=e.GetCoopLobbyMissionCode()if i then
TppDemo.EnableNpc()if InvitationManagerController.IsGoingCoopMission()then
local n={}n.isNeedUpdateBaseManagement=false
e.ContinueFromCheckPoint(n)else
mvars.mis_nextMissionCodeForAbort=i
mvars.mis_abortWithSave=false
e.ExecuteMissionAbort()end
end
end
function e.GoToCoopLobbyWithSave()e.UpdateCheckPointAtCurrentPosition()if mvars.mis_skipServerSave or mvars.fms_skipServerSave then
e.GoToCoopLobby(false)else
local e=function()e.GoToCoopLobby(false)end
TppSave.AddServerSaveCallbackFunc(e)TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,"GoToCoopLobbyWait",TppUI.FADE_PRIORITY.SYSTEM)end
end
function e.GoToAvatarEditWithSave()e.UpdateCheckPointAtCurrentPosition()local n=e.GetAvaterMissionCode()if mvars.mis_skipServerSave or mvars.fms_skipServerSave then
e.AbortMission{nextMissionId=n}else
local e=function()e.AbortMission{nextMissionId=n}end
TppSave.AddServerSaveCallbackFunc(e)TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"GoToAvatarEditWait",TppUI.FADE_PRIORITY.SYSTEM)end
end
function e.IsFromAvatarRoom()return gvars.mis_isFromAvatarRoom
end
function e.SetIsFromAvatarRoom(e)gvars.mis_isFromAvatarRoom=e
end
return e