local e={}local i={}local a={}local l=256
local c=0
local d=180
local S=Fox.StrCode32
local m=Tpp.IsTypeFunc
local r=Tpp.IsTypeTable
local s=GkEventTimerManager.Start
local n=TppScriptVars.SVarsIsSynchronized
e.MISSION_PREPARE_STATE=Tpp.Enum{"START","WAIT_INITALIZE","WAIT_TEXTURE_LOADING","END_TEXTURE_LOADING","WAIT_SAVING_FILE","END_SAVING_FILE","FINISH"}local function t(n)local e=mvars.seq_sequenceTable
if e then
return e[n]end
end
local function _(n)local e=mvars.seq_sequenceNames
if e then
return t(e[n])end
end
function e.RegisterSequences(n)if not r(n)then
return
end
local s=#n
if s>(l-1)then
return
end
local t={}mvars.seq_demoSequneceList={}for e=1,e.SYS_SEQUENCE_LENGTH do
t[e]=a[e]end
for s=1,#n do
local e=e.SYS_SEQUENCE_LENGTH+s
t[e]=n[s]local n=string.sub(n[s],5,8)if n=="Demo"then
mvars.seq_demoSequneceList[e]=true
end
if(mvars.seq_heliStartSequence==nil)and(n=="Game")then
mvars.seq_heliStartSequence=e
end
end
mvars.seq_sequenceNames=Tpp.Enum(t)end
function e.RegisterSequenceTable(e)if e==nil then
return
end
mvars.seq_sequenceTable=Tpp.MergeTable(e,i,true)local s={}for t,n in ipairs(mvars.seq_sequenceNames)do
if e[n]==nil then
e[n]=s
end
end
end
function e.SetNextSequence(u,n)local s=nil
if mvars.seq_sequenceNames then
s=mvars.seq_sequenceNames[u]end
if s==nil then
return
end
local i=false
local t=false
local a=false
local o=true
if n and r(n)then
i=n.isExecMissionClear
t=n.isExecGameOver
a=n.isExecDemoPlaying
o=n.isExecMissionPrepare
end
if TppMission.CheckMissionState(i,t,a,o)then
if Tpp.IsQARelease()or nil then
local n=TppMission.GetMissionName()local e=e.GetCurrentSequenceName()Mission.SetMiniText(0,u)end
svars.seq_sequence=s
return
end
end
function e.ReserveNextSequence(n,s)TppScriptVars.SetSVarsNotificationEnabled(false)e.SetNextSequence(n,s)TppScriptVars.SetSVarsNotificationEnabled(true)end
function e.GetCurrentSequenceIndex()return svars.seq_sequence
end
function e.GetSequenceIndex(n)local e=mvars.seq_sequenceNames
if e then
return e[n]end
end
function e.GetSequenceNameWithIndex(n)local e=mvars.seq_sequenceNames
if e then
local e=e[n]if e then
return e
end
end
return""end
local r=e.GetSequenceNameWithIndex
function e.GetCurrentSequenceName()if svars then
return r(svars.seq_sequence)end
end
function e.GetMissionStartSequenceName()if mvars.seq_missionStartSequence then
return r(mvars.seq_missionStartSequence)end
end
function e.GetMissionStartSequenceIndex()return mvars.seq_missionStartSequence
end
function e.GetContinueCount()local e=svars.seq_sequence
return svars.seq_sequenceContinueCount[e]end
function e.MakeSVarsTable(s)local n={}local e,t,t=1
for i,s in pairs(s)do
local t=type(s)if t=="boolean"then
n[e]={name=i,type=TppScriptVars.TYPE_BOOL,value=s,save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}elseif t=="number"then
n[e]={name=i,type=TppScriptVars.TYPE_INT32,value=s,save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}elseif t=="string"then
n[e]={name=i,type=TppScriptVars.TYPE_UINT32,value=S(s),save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}elseif t=="table"then
n[e]=s
end
e=e+1
end
return n
end
local u=1
local t=6
local n=2
a={"Seq_Mission_Prepare"}e.SYS_SEQUENCE_LENGTH=#a
i.Seq_Mission_Prepare={Messages=function(e)return Tpp.StrCode32Table{UI={{msg="EndFadeIn",sender="FadeInOnGameStart",func=function()end,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="StartMissionTelopFadeIn",func=function()s("Timer_HelicopterMoveStart",t)end,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="StartMissionTelopFadeOut",func=function()mvars.seq_nowWaitingStartMissionTelopFadeOut=nil
e.FadeInStartOnGameStart()end,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="PushEndLoadingTips",func=function()mvars.seq_nowWaitingPushEndLoadingTips=nil
s("Timer_WaitStartingGame",1)end,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}}},Timer={{msg="Finish",sender="Timer_WaitStartingGame",func=e.MissionGameStart,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="Finish",sender="Timer_HelicopterMoveStart",func=e.HelicopterMoveStart,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="Finish",sender="Timer_FadeInStartOnNoTelopHelicopter",func=e.FadeInStartOnGameStart,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}}}}end,OnEnter=function(n)if Tpp.IsQARelease()or nil then
Mission.SetMiniText(0,"Seq_Mission_Prepare")end
mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.WAIT_INITALIZE
mvars.seq_textureLoadWaitStartTime=c
mvars.seq_canMissionStartWaitStartTime=Time.GetRawElapsedTimeSinceStartUp()TppMain.OnEnterMissionPrepare()TppMain.DisablePause()if TppMission.IsFOBMission(vars.missionCode)==true then
TppNetworkUtil.RequestGetFobServerParameter()end
end,OnLeave=function(s,n)TppMain.OnMissionGameStart(n)e.DoOnEndMissionPrepareFunction()if e.IsFirstLandStart()then
if not TppSave.IsReserveVarRestoreForContinue()then
TppUiStatusManager.ClearStatus"AnnounceLog"TppUiStatusManager.SetStatus("AnnounceLog","SUSPEND_LOG")TppMission.UpdateCheckPointAtCurrentPosition()end
end
end,HelicopterMoveStart=function()if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
TppHelicopter.SetRouteToHelicopterOnStartMission()end
end,MissionGameStart=function()if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
TppMain.DisableBlackLoading()e.SetMissionGameStartSequence()else
if mvars.seq_isHelicopterStart then
if mvars.seq_noMissionTelopOnHelicopter then
i.Seq_Mission_Prepare.HelicopterMoveStart()s("Timer_FadeInStartOnNoTelopHelicopter",n)else
TppSoundDaemon.ResetMute"Loading"mvars.seq_nowWaitingStartMissionTelopFadeOut=true
TppUI.StartMissionTelop()end
else
i.Seq_Mission_Prepare.FadeInStartOnGameStart()end
end
end,FadeInStartOnGameStart=function()TppMain.DisableBlackLoading()local n
if mvars.seq_isHelicopterStart then
TppSound.SetHelicopterStartSceneBGM()n=Tpp.GetHelicopterStartExceptGameStatus()else
if TppMission.IsMissionStart()and(not TppMission.IsFreeMission(vars.missionCode))then
n={AnnounceLog=false}end
end
e.SetMissionGameStartSequence()TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeInOnGameStart",nil,{exceptGameStatus=n})end,SkipTextureLoadingWait=function()if mvars.seq_skipTextureLoadingWait then
return true
end
end,DEBUG_TextPrint=function(e)local n=DebugText.NewContext()DebugText.Print(n,{.5,.5,1},e)end,OnUpdate=function(n)if(mvars.seq_missionPrepareState<e.MISSION_PREPARE_STATE.END_TEXTURE_LOADING)then
TppUI.ShowAccessIconContinue()end
TppMission.ExecuteSystemCallback"OnUpdateWhileMissionPrepare"local r=30
local o=.35
local t=false
local i=false
local a=Mission.GetTextureLoadedRate()local S=TppMission.CanStart()local T=TppMotherBaseManagement.IsEndedSyncControl()if n.SkipTextureLoadingWait()then
a=1
end
local p=0
local i=r
local l=Time.GetRawElapsedTimeSinceStartUp()local c=l-mvars.seq_canMissionStartWaitStartTime
if DebugText then
if mvars.seq_nowWaitingStartMissionTelopFadeOut then
n.DEBUG_TextPrint"Now waiting start mission telop fade out message"end
if mvars.seq_nowWaitingPushEndLoadingTips then
n.DEBUG_TextPrint"Now waiting PushEndLoadingTips message."end
end
if(S==false)and(c>d)then
if not mvars.seq_doneDumpCanMissionStartRefrainIds then
mvars.seq_doneDumpCanMissionStartRefrainIds=true
if DebugMenu then
DebugMenu.SetDebugMenuValue("Mission","ViewStartRefrain",true)end
end
end
if not T then
if DebugText then
n.DEBUG_TextPrint"Now wait isEnded TppMotherBaseManagementSyncControl"end
return
end
if(not TppMission.IsDefiniteMissionClear())then
TppTerminal.VarSaveMbMissionStartSyncEnd()TppSave.DoReservedSaveOnMissionStart()end
if TppMission.IsFOBMission(vars.missionCode)==true then
if TppNetworkUtil.IsRequestFobServerParameterBusy()then
if DebugText then
n.DEBUG_TextPrint"Now wait for FobServerParameter sync to finish"end
return
end
end
if S then
if(mvars.seq_missionPrepareState<e.MISSION_PREPARE_STATE.WAIT_TEXTURE_LOADING)then
mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.WAIT_TEXTURE_LOADING
TppMain.OnTextureLoadingWaitStart()mvars.seq_textureLoadWaitStartTime=l
end
p=Time.GetRawElapsedTimeSinceStartUp()-mvars.seq_textureLoadWaitStartTime
i=r-p
if(a>o)or(i<0)then
t=true
end
if mvars.seq_forceStopWhileNotPressedPad then
t=DebugPad.IsScannedAorB()if t then
mvars.seq_forceStopWhileNotPressedPad=false
end
end
else
if DebugText then
n.DEBUG_TextPrint(string.format("033.0 > [MissionPrepare] Waiting Mission.CanStart() is true. canMissionStartWaitingTime =  %02.2f[s] : TIMEOUT = %02.2f[s]",c,d))end
end
if not t then
if DebugText then
n.DEBUG_TextPrint(string.format("034.0 > [MissionPrepare] Waiting texture loading. TimeOutRemain = %02.2f[s], textureLoadRatio = %03.2f /.%03.2f",i,a*100,o*100))if mvars.seq_forceStopWhileNotPressedPad then
n.DEBUG_TextPrint"034.0 > Force stop while not pressed pad. If you want proceed, you push A or B."else
if DebugPad and DebugPad.IsScannedAorB then
n.DEBUG_TextPrint"034.0 > If you want skip texture load for debug, you push A or B."end
end
end
return
end
if(mvars.seq_missionPrepareState<e.MISSION_PREPARE_STATE.END_TEXTURE_LOADING)then
mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.WAIT_SAVING_FILE
TppMain.OnMissionStartSaving()end
if(mvars.seq_missionPrepareState<e.MISSION_PREPARE_STATE.END_SAVING_FILE)then
mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.END_SAVING_FILE
if i<0 then
end
TppMain.OnMissionCanStart()if TppUiCommand.IsEndLoadingTips()then
TppUI.FinishLoadingTips()s("Timer_WaitStartingGame",u)else
if gvars.waitLoadingTipsEnd then
mvars.seq_nowWaitingPushEndLoadingTips=true
TppUiCommand.PermitEndLoadingTips()else
TppUI.FinishLoadingTips()s("Timer_WaitStartingGame",u)end
end
end
end}function e.IsMissionPrepareFinished()if mvars.seq_missionPrepareState then
if mvars.seq_missionPrepareState>=e.MISSION_PREPARE_STATE.FINISH then
return true
end
end
return false
end
function e.IsEndSaving()if mvars.seq_missionPrepareState then
if mvars.seq_missionPrepareState>=e.MISSION_PREPARE_STATE.END_SAVING_FILE then
return true
end
end
return false
end
function e.SaveMissionStartSequence()local e=e.SYS_SEQUENCE_LENGTH+1
mvars.seq_isHelicopterStart=false
mvars.seq_missionStartSequence=e
if(Tpp.IsQARelease()or nil)and(svars.dbg_seq_sequenceName~=0)then
local e
for s,n in pairs(mvars.seq_sequenceNames)do
if S(n)==svars.dbg_seq_sequenceName then
e=s
break
end
end
if e then
mvars.seq_missionStartSequence=e
svars.dbg_seq_sequenceName=0
return
end
end
if svars.seq_sequence>e then
mvars.seq_missionStartSequence=svars.seq_sequence
end
if TppMission.IsHelicopterSpace(vars.missionCode)then
return
end
if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
mvars.seq_isHelicopterStart=true
if(mvars.seq_missionStartSequence<=e)then
mvars.seq_missionStartSequence=mvars.seq_heliStartSequence
else
mvars.seq_noMissionTelopOnHelicopter=true
end
end
end
function e.SetMissionGameStartSequence()mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.FINISH
svars.seq_sequence=mvars.seq_missionStartSequence
if Tpp.IsQARelease()or nil then
local e=e.GetSequenceNameWithIndex(mvars.seq_missionStartSequence)Mission.SetMiniText(0,e)end
end
function e.SetOnEndMissionPrepareFunction(e)mvars.seq_onEndMissionPrepareFunction=e
end
function e.DoOnEndMissionPrepareFunction()if mvars.seq_onEndMissionPrepareFunction then
mvars.seq_onEndMissionPrepareFunction()end
end
function e.IsHelicopterStart()return mvars.seq_isHelicopterStart
end
function e.IsFirstLandStart()if((not mvars.seq_demoSequneceList[mvars.seq_missionStartSequence])and(not mvars.seq_isHelicopterStart))and(mvars.seq_missionStartSequence==(e.SYS_SEQUENCE_LENGTH+1))then
return true
else
return false
end
end
function e.IsLandContinue()if((not mvars.seq_demoSequneceList[mvars.seq_missionStartSequence])and(not mvars.seq_isHelicopterStart))and(e.GetContinueCount()>0)then
return true
else
return false
end
end
function e.CanHandleSignInUserChangedException()if mvars==nil then
return true
end
if mvars.seq_currentSequence==nil then
return true
end
local e=mvars.seq_sequenceTable[mvars.seq_currentSequence]if e==nil then
return true
end
if e.ignoreSignInUserChanged then
return false
else
return true
end
end
function e.IncrementContinueCount()local e=svars.seq_sequence
local n=svars.seq_sequenceContinueCount[e]+1
local s=255
if n<=s then
svars.seq_sequenceContinueCount[e]=n
end
end
function e.DeclareSVars()return{{name="seq_sequence",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,notify=true,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="seq_sequenceContinueCount",arraySize=l,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="dbg_seq_sequenceName",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},nil}end
function e.DEBUG_Init()end
function e.Init(n)e.MakeSequenceMessageExecTable()svars.seq_sequence=e.GetSequenceIndex"Seq_Mission_Prepare"if n.sequence then
if n.sequence.SKIP_TEXTURE_LOADING_WAIT then
mvars.seq_skipTextureLoadingWait=true
end
if n.sequence.FORCE_STOP_MISSION_PREPARE_WHILE_NOT_PRESSED_PAD then
mvars.seq_forceStopWhileNotPressedPad=true
end
if n.sequence.NO_MISSION_TELOP_ON_START_HELICOPTER then
mvars.seq_noMissionTelopOnHelicopter=true
end
end
end
function e.OnReload()e.MakeSequenceMessageExecTable()end
function e.MakeSequenceMessageExecTable()if not mvars.seq_sequenceTable then
return
end
for n,e in pairs(mvars.seq_sequenceTable)do
if e.Messages and m(e.Messages)then
local e=e.Messages(e)mvars.seq_sequenceTable[n]._messageExecTable=Tpp.MakeMessageExecTable(e)end
end
end
function e.OnChangeSVars(n,s)if n=="seq_sequence"then
local n=_(svars.seq_sequence)if n==nil then
return
end
local s=mvars.seq_sequenceTable[mvars.seq_currentSequence]if s and s.OnLeave then
s.OnLeave(s,e.GetSequenceNameWithIndex(svars.seq_sequence))end
mvars.seq_currentSequence=mvars.seq_sequenceNames[svars.seq_sequence]if n.OnEnter then
local e
n.OnEnter(n)end
end
end
function e.OnMessage(n,r,o,a,t,s,i)if mvars.seq_sequenceTable==nil then
return
end
local e=mvars.seq_sequenceTable[mvars.seq_currentSequence]if e==nil then
return
end
local e=e._messageExecTable
Tpp.DoMessage(e,TppMission.CheckMessageOption,n,r,o,a,t,s,i)end
function e.Update()local e=mvars
local n=svars
if e.seq_currentSequence==nil then
return
end
local e=e.seq_sequenceTable[e.seq_currentSequence]if e==nil then
return
end
local n=e.OnUpdate
if n then
n(e)end
end
function e.DebugUpdate()local e=mvars
local s=svars
local n=DebugText.NewContext()if e.debug.showCurrentSequence or e.debug.showSequenceHistory then
if e.debug.showCurrentSequence then
DebugText.Print(n,{.5,.5,1},"LuaSystem SEQ.showCurrSequence")DebugText.Print(n," current_sequence = "..tostring(r(s.seq_sequence)))end
if e.debug.showSequenceHistory then
DebugText.Print(n,{.5,.5,1},"LuaSystem SEQ.showSeqHistory")for s,e in ipairs(e.debug.seq_sequenceHistory)do
DebugText.Print(n," seq["..(tostring(s)..("] = "..tostring(e))))end
end
end
end
return e