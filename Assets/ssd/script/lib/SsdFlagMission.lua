local e={}local _=256
local o=0
local c=1
local s=0
local i="flag_mission_block"local r="FStep_Clear"local p=Fox.StrCode32
local m=Tpp.StrCode32Table
local a=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local u=Tpp.IsTypeString
local l=GkEventTimerManager.Start
local S={name="fms_systemFlags",arraySize=4,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}local f=TppDefine.Enum{"NONE","DEACTIVATE","DEACTIVATING","ACTIVATE"}local d=TppDefine.Enum{"OPEN","CLEAR","FAILURE","UPDATE"}if not Tpp.IsMaster()then
e.DEBUG_OnRestoreFvarsCallback={}end
function e.RegisterStepList(e)if not t(e)then
return
end
local n=#e
if n==0 then
return
end
if n>=_ then
return
end
table.insert(e,r)mvars.fms_stepList=Tpp.Enum(e)end
function e.RegisterStepTable(n)if not t(n)then
return
end
e.RegisterResultStepTable(n)mvars.fms_stepTable=n
end
local n=function()if TppRadioCommand.IsPlayingRadio()then
GkEventTimerManager.Start("SsdFlagMission_Clear",1)elseif not mvars.fms_clearStepFinished then
e.FadeOutAndResult()mvars.fms_clearStepFinished=true
end
end
function e.RegisterResultStepTable(a)a[r]={Messages=function(a)return m{Timer={{sender="SsdFlagMission_Clear",msg="Finish",func=n,option={isExecFastTravel=true}}},UI={{msg="BaseResultUiSequenceDaemonEnd",func=function()if mvars.fms_isReservedBaseResultStarted then
mvars.fms_isReservedBaseResultStarted=nil
e.OnEndResult()end
end}}}end,OnEnter=function()TppGameStatus.Set("FmsResult","S_DISABLE_PLAYER_PAD")TppRadio.Stop()if mvars.fms_clearState==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR then
if mvars.fms_blackRadioOnEnd then
BlackRadio.Close()BlackRadio.ReadJsonParameter(mvars.fms_blackRadioOnEnd)end
Player.SetPadMask{settingName="OnFlagMissionClear",except=true,sticks=PlayerPad.STICK_R}mvars.fms_clearStepFinished=nil
n()else
e.FadeOutAndUnloadBlock()end
end,OnLeave=function()end}end
function e.RegisterSystemCallbacks(n)if not t(n)then
return
end
mvars.fms_systemCallbacks=mvars.fms_systemCallbacks or{}local function t(n,e)if a(n[e])then
mvars.fms_systemCallbacks[e]=n[e]end
end
local e={"OnActivate","OnDeactivate","OnTerminate","OnAlertOutOfDefenseGameArea","OnOutOfDefenseGameArea"}for a=1,#e do
t(n,e[a])end
end
function e.SetNextStep(t)if not mvars.fms_stepTable then
return
end
if not mvars.fms_stepList then
return
end
local s=mvars.fms_stepTable[t]local n=mvars.fms_stepList[t]if s==nil then
return
end
if n==nil then
return
end
local i=gvars.fms_currentFlagStepNumber
if((n~=c)and(i~=n))and e.IsInvoking()then
local n=e.GetFlagStepTable(i)local e=n.OnLeave
if a(e)then
e(n)end
end
gvars.fms_currentFlagStepNumber=n
local n=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
local n=e.GetBlockState()if mvars.fms_allocated then
local e=s.OnEnter
if a(e)then
e(s)end
end
if Tpp.IsQARelease()or nil then
Mission.SetMiniText(1,"fmis:"..e.GetCurrentFlagMissionName())Mission.SetMiniText(2,"step:"..t)end
end
function e.ClearWithSave(a,n)if not n then
n=e.GetCurrentFlagMissionName()end
PlayRecord.RegistPlayRecord"FLAG_MISSION_END"e._EstablishMissionClear(a)if a==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR then
e.Clear(n)e.Save()elseif a==TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE then
e.Failure(n)e.Save()end
TppStory.UpdateStorySequence{updateTiming="FlagMissionEnd"}TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.FLAG_MISSION_END)end
function e.Clear(n)if n==nil then
n=e.GetCurrentFlagMissionName()if n==nil then
return
end
end
local a=e.GetMissionIndex(n)if a==nil then
return
end
TppResult.SetMissionFinalScore(TppDefine.MISSION_TYPE.FLAG)mvars.fms_clearState=TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR
e.SetNextStep(r)e.ShowAnnounceLog(d.CLEAR,n)e.CheckClearBounus(a,n)e.UpdateClearFlag(a,true)e.GetClearKeyItem(n)SsdMarker.UnregisterMarker{type="USER_001"}end
function e.Failure(n)if n==nil then
n=e.GetCurrentFlagMissionName()if n==nil then
return
end
end
local a=e.GetMissionIndex(n)if a==nil then
return
end
mvars.fms_clearState=TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE
e.UpdateClearFlag(a,false)e.SetNextStep(r)e.ShowAnnounceLog(d.FAILURE,n)end
function e._EstablishMissionClear(e)if e==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR then
fvars.fms_systemFlags[0]=true
fvars.fms_systemFlags[1]=true
TppMission.ResetGameOverCount()else
fvars.fms_systemFlags[0]=true
fvars.fms_systemFlags[1]=false
end
end
function e.Abort()local n=e.GetCurrentFlagMissionName()if not n then
return
end
local n=e.GetMissionIndex(n)if n==nil then
return
end
e.UpdateClearFlag(n,false)e.Save()e.UnloadFlagMissionBlock()end
function e.DeclareFVars(e)if not t(e)then
end
table.insert(e,1,S)TppScriptVars.DeclareFVars(e)Mission.RegisterUserFvars()mvars.fms_delaredFVarsList=e
end
function e.Save()TppSave.VarSave()TppSave.SaveGameData(vars.missionCode)end
function e.SetClearFlag(e)if e==nil then
return
end
local e=string.sub(e,-5)local e=SsdMissionList.MISSION_ENUM[e]if e and gvars.str_missionClearedFlag[e]then
gvars.str_missionClearedFlag[e]=true
end
end
function e.FadeOutAndUnloadBlock(e)if e==nil or e==0 then
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FlagFadeOutAndUnload",TppUI.FADE_PRIORITY.RESULT)else
l("UnloadFadeOutDelay",e)end
end
function e.FadeOutAndResult(e)TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FlagFadeOutAndResult",TppUI.FADE_PRIORITY.RESULT)end
function e.IsClearState()if not mvars.fms_stepList then
return false
end
local e=mvars.fms_stepList[r]if e==nil then
return false
end
if gvars.fms_currentFlagStepNumber==e then
return true
end
return false
end
function e.IsCurrentStepWaveName(n)local e=e.GetFlagStepTable(e.GetCurrentStepIndex())if not e then
return
end
if(e.waveName==n)then
return true
else
return false
end
end
function e.OnAllocate(e)end
function e.Init(n)e.OnInit()end
function e.OnReload(n)e.OnInit()end
function e.OnInit()e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())if not TppMission.IsFreeMission(vars.missionCode)then
return
end
local n=TppLocation.GetLocationName()if n then
e.InitializePackList(n)end
end
function e.OnEndResult()TppRadio.Stop()if mvars.fms_blackRadioOnEnd then
l("Timer_WaitBlackRadio",1)elseif mvars.fms_releaseAnnouncePopup then
ReleaseAnnouncePopupSystem.RequestOpen()elseif BaseResultUiSequenceDaemon.IsActive()then
mvars.fms_isReservedBaseResultStarted=true
BaseResultUiSequenceDaemon.SetReserved(false)else
TppSoundDaemon.SetMute"Loading"e.UnloadFlagMissionBlock()l("Timer_CheckUnload",1)end
end
function e.Messages()return m{UI={{msg="EndFadeOut",sender="FlagFadeOutAndUnload",func=function()e.UnloadFlagMissionBlock()l("Timer_CheckUnload",1)end,option={isExecFastTravel=true}},{msg="EndFadeOut",sender="FlagFadeOutAndResult",func=function()TppCrew.FinishFlagMission(gvars.fms_currentFlagMissionCode)if mvars.fms_resultRadio then
TppRadio.PlayResultRadio(e.OnEndResult)else
e.OnEndResult()end
end,option={isExecFastTravel=true}},{msg="EndFadeOut",sender="FlagFadeOutForRestart",func=function()e.UnloadFlagMissionBlock()l("Timer_CheckRestart",1)end,option={isExecFastTravel=true}},{msg="BlackRadioClosed",func=function(n)if not u(mvars.fms_blackRadioOnEnd)or n~=p(mvars.fms_blackRadioOnEnd)then
return
end
mvars.fms_blackRadioOnEnd=e.GetNextBlackRadioEndSetting()if mvars.fms_blackRadioOnEnd then
BlackRadio.Close()BlackRadio.ReadJsonParameter(mvars.fms_blackRadioOnEnd)else
TppSoundDaemon.SetKeepBlackRadioEnable(false)end
e.OnEndResult()end},{msg="ReleaseAnnouncePopupPushEnd",func=function()if not mvars.fms_releaseAnnouncePopup then
return
end
mvars.fms_releaseAnnouncePopup=nil
e.OnEndResult()end}},Marker={{msg="ChangeToEnable",func=function(t,s,a,n)e._ChangeToEnable(t,s,a,n)end}},Timer={{msg="Finish",sender="UnloadFadeOutDelay",func=function()TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FlagFadeOutAndUnload",TppUI.FADE_PRIORITY.FLAG)end,option={isExecFastTravel=true}},{msg="Finish",sender="Timer_CheckUnload",func=function()local n=function()SubtitlesCommand.SetIsEnabledUiPrioStrong(false)mvars.bfm_needSaveForMissionStart=true
end
e._CheckUnloadBlock("Timer_CheckUnload","FlagMissionEnd",n)end},{msg="Finish",sender="Timer_CheckRestart",func=function()local n=function()SubtitlesCommand.SetIsEnabledUiPrioStrong(false)e.SelectAndLoadMission(mvars.fms_reloadMissionName)e.Activate()mvars.fms_reloadMissionName=nil
end
e._CheckUnloadBlock("Timer_CheckRestart","FlagMissionRestart",n)end},{msg="Finish",sender="Timer_WaitBlackRadio",func=function(n)if not mvars.fms_blackRadioOnEnd then
e.OnEndResult()TppSoundDaemon.SetKeepBlackRadioEnable(false)return
end
TppRadio.StartBlackRadio()TppSoundDaemon.SetKeepBlackRadioEnable(true)end,option={isExecFastTravel=true}}}}end
function e._CheckUnloadBlock(t,s,n)local e=e.GetBlockState()if e==nil then
if n and a(n)then
n()end
Mission.SendMessage("Mission","OnFlagMissionUnloaded")return
end
if e==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
if n and a(n)then
n()end
Mission.SendMessage("Mission","OnFlagMissionUnloaded")else
l(t,1)end
end
function e.OnMessage(n,a,t,s,i,l,r)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,n,a,t,s,i,l,r)end
function e.OnSubScriptMessage(r,s,l,i,n,a,t)local o=mvars.fms_scriptBlockCommonMessageExecTable
if o then
local e=t
Tpp.DoMessage(o,TppMission.CheckMessageOption,r,s,l,i,n,a,e)end
local o=mvars.fms_scriptBlockMessageExecTable
if o then
local e=t
Tpp.DoMessage(o,TppMission.CheckMessageOption,r,s,l,i,n,a,e)end
if e.IsInvoking()and mvars.fms_stepList then
local o=gvars.fms_currentFlagStepNumber
local e=e.GetFlagStepTable(o)if e then
local o=e._commonMessageExecTable
if o then
local e=t
Tpp.DoMessage(o,TppMission.CheckMessageOption,r,s,l,i,n,a,e)end
local e=e._messageExecTable
if e then
local t=t
Tpp.DoMessage(e,TppMission.CheckMessageOption,r,s,l,i,n,a,t)end
end
end
end
function e.OnDeactivate(e)end
function e.InitializePackList(a)mvars.loadedInfoList={}local n={}local e=SsdMissionList.FLAG_MISSION_LIST
for t=1,#e do
local e=e[t]if e.location==a then
n[e.name]={}table.insert(mvars.loadedInfoList,e)table.insert(n[e.name],e.pack)end
end
TppScriptBlock.RegisterCommonBlockPackList(i,n)end
function e.InitializeActiveStatus()local n=e.GetBlockState()if n==nil then
return
end
if n==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
return
end
mvars.fms_requestInitializeActiveStatus=false
if n<ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE or not e._CanActivate()then
mvars.fms_requestInitializeActiveStatus=true
return
end
e.Invoke()end
function e.InitializeMissionLoad()if gvars.fms_currentFlagMissionCode==s then
return
end
local n=e.GetBlockState()if not n then
return
end
local n="k"..tostring(gvars.fms_currentFlagMissionCode)e.LoadMission(n)end
function e.IsEstablishedMissionClear()if gvars.fms_currentFlagMissionCode==s then
return false
end
local e=e.GetBlockState()if not e then
return false
end
return(mvars.fms_clearState==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR)end
function e.QARELEASE_DEBUG_Init()local e
if DebugMenu then
e=DebugMenu
else
return
end
mvars.qaDebug.historyFmsStep={}mvars.qaDebug.prevFmsViewMarkerFlag=false
mvars.qaDebug.showCurrentFmsState=false
e.AddDebugMenu("LuaFlagMission","showCurrentState","bool",mvars.qaDebug,"showCurrentFmsState")mvars.qaDebug.forceFmsClear=false
e.AddDebugMenu("LuaFlagMission","forceClear","bool",mvars.qaDebug,"forceFmsClear")mvars.qaDebug.forceFmsFail=false
e.AddDebugMenu("LuaFlagMission","forceFail","bool",mvars.qaDebug,"forceFmsFail")mvars.qaDebug.forceFmsLoad=false
e.AddDebugMenu("LuaFlagMission","forceLoad","bool",mvars.qaDebug,"forceFmsLoad")mvars.qaDebug.forceFmsLoadIndex=0
e.AddDebugMenu("LuaFlagMission","forceLoadIndex","int32",mvars.qaDebug,"forceFmsLoadIndex")mvars.qaDebug.forceFmsRestart=false
e.AddDebugMenu("LuaFlagMission","forceRestart","bool",mvars.qaDebug,"forceFmsRestart")mvars.qaDebug.forceFmsViewMarker=false
e.AddDebugMenu("LuaFlagMission","viewMarker","bool",mvars.qaDebug,"forceFmsViewMarker")mvars.qaDebug.bfmShowCraftStep=false
e.AddDebugMenu("LuaFlagMission","showCraftStep","bool",mvars.qaDebug,"bfmShowCraftStep")mvars.qaDebug.bfmShowKillCount=false
e.AddDebugMenu("LuaFlagMission","showKillCount","bool",mvars.qaDebug,"bfmShowKillCount")end
function e.QAReleaseDebugUpdate()local a=DebugText.Print
local n=DebugText.NewContext()local t=SsdMissionList.FLAG_MISSION_LIST
local s=#t
do
if s==0 then
mvars.qaDebug.forceFmsLoadIndex=0
elseif mvars.qaDebug.forceFmsLoadIndex<0 then
mvars.qaDebug.forceFmsLoadIndex=s
elseif mvars.qaDebug.forceFmsLoadIndex>s then
mvars.qaDebug.forceFmsLoadIndex=0
end
end
if mvars.qaDebug.forceFmsClear then
mvars.qaDebug.forceFmsClear=false
local n=e.GetCurrentFlagMissionName()if n then
e.ClearWithSave(TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR,n)end
end
if mvars.qaDebug.forceFmsFail then
mvars.qaDebug.forceFmsFail=false
local n=e.GetCurrentFlagMissionName()if n then
e.ClearWithSave(TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE,n)end
end
if mvars.qaDebug.showCurrentFmsState then
a(n,"")a(n,{.5,.5,1},"FlagMission showCurrentState")local s=e.GetCurrentFlagMissionName()if not s then
a(n,"Current Mission : -----")else
a(n,"Current Mission : "..tostring(s))end
local s=e.GetBlockState()if s==nil then
a(n,"Block State : FLAG MISSION BLOCK isn't found...")return
end
local e={}e[ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY]="EMPTY"e[ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING]="PROCESSING"e[ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE]="INACTIVE"e[ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE]="ACTIVE"a(n,"Block State : "..tostring(e[s]))a(n,"gvars.fms_currentFlagMissionCode : "..tostring(gvars.fms_currentFlagMissionCode))a(n,"gvars.fms_currentFlagStepNumber : "..tostring(gvars.fms_currentFlagStepNumber))if not mvars.fms_stepList then
a(n,"Sequence is not Defined...")else
local e=gvars.fms_currentFlagStepNumber
local e=mvars.fms_stepList[e]a(n,"Current Sequence : "..tostring(e))end
if mvars.qaDebug.forceFmsLoadIndex==0 then
a(n,"Selected Mission : -----")else
local e=t[mvars.qaDebug.forceFmsLoadIndex]if e then
a(n,"Selected Mission : "..tostring(e.name))end
end
end
if mvars.qaDebug.forceFmsLoad then
local n=mvars.qaDebug.forceFmsLoadIndex
mvars.qaDebug.forceFmsLoadIndex=0
mvars.qaDebug.forceFmsLoad=false
if n==0 then
return
end
local n=t[n]if not n then
return
else
e.SelectAndLoadMission(n.name)e.Activate()end
end
if mvars.qaDebug.forceFmsRestart then
mvars.qaDebug.forceFmsRestart=false
e.RestartMission()end
if mvars.qaDebug.forceFmsViewMarker~=mvars.qaDebug.prevFmsViewMarkerFlag then
local n=mvars.qaDebug.forceFmsViewMarker
local e=mvars.mar_missionMarkerList
if e and next(e)then
if n then
for n,e in ipairs(e)do
SsdMarker.Enable{gameObjectId=e,enable=true}end
else
for n,e in ipairs(e)do
SsdMarker.Enable{gameObjectId=e,enable=false}end
end
end
end
mvars.qaDebug.prevFmsViewMarkerFlag=mvars.qaDebug.forceFmsViewMarker
end
function e.ShowAnnounceLogMissionOpen()if mvars.fms_isNewOpenFlag==true then
mvars.fms_isNewOpenFlag=false
e.ShowAnnounceLog(d.OPEN)end
end
function e.OnInitialize(n)local s=n.GetCommonMessageTable
if a(s)then
local e=s()if t(e)and next(e)then
mvars.fms_scriptBlockCommonMessageExecTable=Tpp.MakeMessageExecTable(e)end
end
local s=n.Messages
if a(s)then
local e=s()if t(e)and next(e)then
mvars.fms_scriptBlockMessageExecTable=Tpp.MakeMessageExecTable(e)end
end
e.MakeFlagStepMessageExecTable()if n.score and n.score.missionScoreTable then
TppResult.SetMissionScoreTable(n.score.missionScoreTable)else
TppResult.SetMissionScoreTable{baseTime={S=300,A=600,B=1800,C=5580,D=6480,E=8280}}end
if n.clearRadio then
mvars.fms_clearRadio=n.clearRadio
end
mvars.fms_resultRadio=nil
if n.resultRadio then
mvars.fms_resultRadio=n.resultRadio
TppRadio.SetIndivResultRadioSetting(n.resultRadio)end
mvars.fms_blackRadioOnEnd=nil
mvars.fms_blackRadioOnEndSetting={}if n.blackRadioOnEnd then
if u(n.blackRadioOnEnd)then
mvars.fms_blackRadioOnEndSetting={n.blackRadioOnEnd}elseif t(n.blackRadioOnEnd)then
mvars.fms_blackRadioOnEndSetting=n.blackRadioOnEnd
end
mvars.fms_blackRadioOnEnd=e.GetNextBlackRadioEndSetting()end
mvars.fms_releaseAnnouncePopup=nil
if n.releaseAnnounce and t(n.releaseAnnounce)then
mvars.fms_releaseAnnouncePopup=n.releaseAnnounce
ReleaseAnnouncePopupSystem.SetInfos(mvars.fms_releaseAnnouncePopup)end
e._ResetFlagMissionInfo(n)e._LoadVars()SsdUiSystem.FlagMissionDidStart()if e.IsEstablishedMissionClear()then
TppGameStatus.Set("FmsResult","S_DISABLE_PLAYER_PAD")end
mvars.fms_skipServerSave=nil
if n.SKIP_SERVER_SAVE then
mvars.fms_skipServerSave=true
end
if a(n.OnRestoreFVars)then
n.OnRestoreFVars()end
TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.MISSION_START)end
function e._ResetFlagMissionInfo(n)local a=e.GetCurrentFlagMissionName()if not a then
local n=n.missionName
if n then
e.SetCurrentFlagMissionName(n)mvars.fms_currentFlagTable=e.GetMissionTable(n)end
end
end
function e._LoadVars()if mvars.fms_startFromSelect then
if not Tpp.IsMaster()then
e.DEBUG_ExecOnRestoreFvars()end
return
end
if gvars.fms_currentFlagMissionCode==40270 then
return
end
TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_FVARS,TppScriptVars.CATEGORY_MISSION)TppSave.RestoreToVars(TppScriptVars.GROUP_BIT_FVARS)if fvars.fms_systemFlags[0]then
if fvars.fms_systemFlags[1]then
mvars.fms_clearState=TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR
else
mvars.fms_clearState=TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE
end
end
if not Tpp.IsMaster()then
e.DEBUG_ExecOnRestoreFvars()end
end
function e.OnTerminate()e.ExecuteSystemCallback"OnTerminate"if(mvars.fms_clearState==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR)then
TppPlayer.ResetPlayerForReturnBaseCamp()end
Gimmick.RemoveUnitInterferer{key="flagMission"}gvars.fms_currentFlagStepNumber=o
mvars.fms_systemCallbacks=nil
mvars.fms_lastBlockState=nil
mvars.fms_stepList=nil
mvars.fms_stepTable=nil
mvars.fms_currentFlagTable=nil
mvars.fms_startFromSelect=nil
mvars.fms_clearState=nil
mvars.fms_skipServerSave=nil
mvars.fms_scriptBlockCommonMessageExecTable=nil
mvars.fms_scriptBlockMessageExecTable=nil
mvars.fms_resultRadio=nil
mvars.fms_blackRadioOnEnd=nil
mvars.fms_blackRadioOnEndSetting={}mvars.fms_releaseAnnouncePopup=nil
mvars.fms_isReservedBaseResultStarted=nil
mvars.fms_delaredFVarsList=nil
e.ClearCurrentFlagMissionName()local e=ScriptBlock.GetScriptBlockId(i)TppScriptBlock.FinalizeScriptBlockState(e)TppGameStatus.Reset("FmsResult","S_DISABLE_PLAYER_PAD")Mission.ResetFVarsList()MissionListMenuSystem.SetCurrentMissionCode(TppDefine.MISSION_CODE_NONE)TppRadio.ResetIndivResultRadioSetting()TppTutorial.ResetHelpTipsSettings()SsdUiSystem.FlagMissionWillFinish()TppMission.OnEndDefenseGame()TppQuest.UnregisterSkipStartQuestDemo()if Tpp.IsQARelease()or nil then
Mission.SetMiniText(1,"")Mission.SetMiniText(2,"")end
end
function e._CanActivate()if CrewBlockController and CrewBlockController.IsProcessing()then
return false
end
if not TppSequence.IsMissionPrepareFinished()then
return false
end
if not mvars.fms_activateFlag then
return false
end
return true
end
function e.OnUpdate()local s=e.GetBlockState()if s==nil then
return
end
local t=ScriptBlock
local n=mvars
local r=n.fms_lastBlockState
local i=t.SCRIPT_BLOCK_STATE_INACTIVE
local t=t.SCRIPT_BLOCK_STATE_ACTIVE
if n.fms_requestInitializeActiveStatus then
e.InitializeActiveStatus()return
end
if s==i then
if e._CanActivate()then
e.ActivateFlagMissionBlock()e.ClearBlockStateRequest()end
n.fms_lastInactiveToActive=false
elseif s==t then
if not e._CanActivate()then
return
end
local t
if e.IsInvoking()then
t=e.GetFlagStepTable(gvars.fms_currentFlagStepNumber)end
if n.fms_lastInactiveToActive then
n.fms_lastInactiveToActive=false
n.fms_deactivated=false
e.ExecuteSystemCallback"OnActivate"n.fms_allocated=true
e.Invoke()t=e.GetFlagStepTable(gvars.fms_currentFlagStepNumber)end
if(not r)or r<=i then
n.fms_lastInactiveToActive=true
end
if t and a(t.OnUpdate)then
t.OnUpdate(t)end
if n.fms_blockStateRequest==f.DEACTIVATE then
e.DeactivateFlagMissionBlock()e.ClearBlockStateRequest()end
else
n.fms_lastInactiveToActive=false
e.ClearBlockStateRequest()end
n.fms_lastBlockState=s
end
function e.OnMissionGameEnd()local n=e.GetBlockState()mvars.fms_isMissionEnd=true
if n==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
e._DoDeactivate()end
end
function e.ClearBlockStateRequest()mvars.fms_blockStateRequest=f.NONE
end
function e.Invoke()if gvars.fms_currentFlagStepNumber==o then
gvars.fms_currentFlagStepNumber=c
end
local n=mvars.fms_stepList[gvars.fms_currentFlagStepNumber]e.SetNextStep(n)if mvars.fms_startFromSelect then
PlayRecord.RegistPlayRecord"FLAG_MISSION_START"else
PlayRecord.RegistPlayRecord"FLAG_MISSION_CONTINUE"end
end
function e.SelectAndLoadMission(n)e.ResetFlagMissionStatus()e.LoadMission(n)mvars.fms_startFromSelect=true
end
function e.LoadMission(n)local a=TppScriptBlock.Load(i,n)if a==false then
return
end
e.SetCurrentFlagMissionName(n)mvars.fms_currentFlagTable=e.GetMissionTable(n)local e=gvars.fms_currentFlagMissionCode
MissionListMenuSystem.SetCurrentMissionCode(e)TppCrew.StartFlagMission(e)mvars.fms_activateFlag=false
end
function e.IsLoaded()if gvars.fms_currentFlagMissionCode==s then
return true
end
local e=e.GetBlockState()if not e then
return true
end
if e>=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
return true
end
return false
end
function e.Activate()if gvars.fms_currentFlagMissionCode==s then
return
end
local e=e.GetBlockState()if not e then
return
end
mvars.fms_activateFlag=true
end
function e.IsActive()if gvars.fms_currentFlagMissionCode==s then
return false
end
local e=e.GetBlockState()if not e then
return false
end
if e==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
return true
end
return false
end
function e.RestartMission()mvars.fms_reloadMissionName=mvars.fms_currentFlagName
if not mvars.fms_reloadMissionName then
return
end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FlagFadeOutForRestart",TppUI.FADE_PRIORITY.FLAG)end
function e.GetCurrentFlagMissionName()return mvars.fms_currentFlagName
end
function e.SetCurrentFlagMissionName(e)mvars.fms_currentFlagName=e
gvars.fms_currentFlagMissionCode=tonumber(string.sub(e,-5))end
function e.ClearCurrentFlagMissionName()mvars.fms_currentFlagName=nil
gvars.fms_currentFlagMissionCode=s
end
function e.ResetFlagMissionStatus()gvars.fms_currentFlagMissionCode=s
gvars.fms_currentFlagStepNumber=o
end
function e.UnloadFlagMissionBlock()TppScriptBlock.Unload(i)end
function e.ActivateFlagMissionBlock()local e=ScriptBlock.GetScriptBlockId(i)TppScriptBlock.ActivateScriptBlockState(e)end
function e.DeactivateFlagMissionBlock()local e=ScriptBlock.GetScriptBlockId(i)TppScriptBlock.DeactivateScriptBlockState(e)end
function e.GetCurrentMissionTable()return mvars.fms_currentFlagTable
end
function e.GetMissionTable(n)if not mvars.loadedInfoList then
return
end
for e=1,#mvars.loadedInfoList do
local e=mvars.loadedInfoList[e]if e.name==n then
return e
end
end
end
function e.GetMissionIndex(e)local e=string.sub(e,-5)local e=SsdMissionList.MISSION_ENUM[e]if e then
return e
end
end
function e.ExecuteSystemCallback(e,n)if mvars.fms_systemCallbacks==nil then
return
end
local e=mvars.fms_systemCallbacks[e]if e then
return e(n)end
end
function e.IsInvoking()if gvars.fms_currentFlagStepNumber~=o then
return true
else
return false
end
end
function e.UpdateActiveFlagMission(e)end
function e.IsRepop(e)end
function e.IsOpen(e)end
function e.IsCleared(n)local e=e.GetMissionIndex(n)if e==nil then
return
end
return gvars.str_missionClearedFlag[e]end
function e.IsEnd(n)if n==nil then
n=e.GetCurrentFlagMissionName()if n==nil then
return
end
end
if mvars.fms_stepList[gvars.fms_currentFlagStepNumber]==r then
return true
end
return false
end
function e._DoDeactivate()mvars.fms_deactivated=true
e.ExecuteSystemCallback"OnDeactivate"TppScriptVars.ClearFVars()e.ResetFlagMissionStatus()mvars.fms_allocated=false
end
function e.MakeFlagStepMessageExecTable()if not t(mvars.fms_stepTable)then
return
end
for n,e in pairs(mvars.fms_stepTable)do
local n=e.GetCommonMessageTable
if a(n)then
local n=n(e)if t(n)and next(n)then
e._commonMessageExecTable=Tpp.MakeMessageExecTable(n)end
end
local n=e.Messages
if a(n)then
local n=n(e)if t(n)and next(n)then
e._messageExecTable=Tpp.MakeMessageExecTable(n)end
end
end
end
function e.GetFlagStepTable(e)if mvars.fms_stepList==nil then
return
end
local e=mvars.fms_stepList[e]if e==nil then
return
end
local e=mvars.fms_stepTable[e]if e~=nil then
return e
else
return
end
end
function e.GetBlockState()local e=ScriptBlock.GetScriptBlockId(i)if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
return
end
return ScriptBlock.GetScriptBlockState(e)end
function e.CheckClearBounus(e,e)end
function e.UpdateClearFlag(e,n)if n then
gvars.str_missionClearedFlag[e]=true
end
end
function e.GetClearKeyItem(e)end
function e.ShowAnnounceLog(e,e,e,e)end
function e._ChangeToEnable(e,e,e,e)end
function e.OverWriteStepIndex(e)gvars.fms_currentFlagStepNumber=e
end
function e.GetCurrentStepIndex()return gvars.fms_currentFlagStepNumber
end
function e.GetCurrentStepName()return mvars.fms_stepList[e.GetCurrentStepIndex()]end
function e.GetStepName(e)return mvars.fms_stepList[e]end
function e.GetStepIndex(e)return mvars.fms_stepList[e]end
function e.InitFVars()if not t(mvars.fms_delaredFVarsList)then
return
end
for n,e in ipairs(mvars.fms_delaredFVarsList)do
local a,e,n=e.name,e.arraySize,e.value
if e and(e>1)then
for e=0,(e-1)do
fvars[a][e]=n
end
else
fvars[a]=n
end
end
end
function e.SetClearJingleName(e)mvars.fms_clearJingleName=e
end
function e.OverwriteResultRadioSetting(n)if e.IsClearState()then
return
end
TppRadio.ResetIndivResultRadioSetting()mvars.fms_resultRadio=n
TppRadio.SetIndivResultRadioSetting(n)end
function e.GetNextBlackRadioEndSetting()if not mvars.fms_blackRadioOnEndSetting then
return
end
if not next(mvars.fms_blackRadioOnEndSetting)then
return
end
local e=mvars.fms_blackRadioOnEndSetting[1]if not e then
return
end
table.remove(mvars.fms_blackRadioOnEndSetting,1)return e
end
if not Tpp.IsMaster()then
function e.DEBUG_AddCallbackOnRestoreFvars(n)if a(n)then
table.insert(e.DEBUG_OnRestoreFvarsCallback,n)end
end
function e.DEBUG_ExecOnRestoreFvars()for t,n in ipairs(e.DEBUG_OnRestoreFvarsCallback)do
if a(n)then
n()end
end
e.DEBUG_OnRestoreFvarsCallback={}end
end
return e