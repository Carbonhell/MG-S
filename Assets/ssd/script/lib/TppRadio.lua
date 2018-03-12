local e={}local n=Fox.StrCode32
local s=GkEventTimerManager.Start
local t=Tpp.IsTypeFunc
local a=Tpp.IsTypeTable
local i=Tpp.IsTypeString
local l=Tpp.IsTypeNumber
e.GAME_OVER_RADIO_LIST={{radioGroup="f3000_rtrg3010",condition=function()return(TppStory.GetCurrentStorySequence()<=TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL)end},{radioGroup={"f3000_rtrg3020","f3000_rtrg3021"},condition=function()return(TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.BEFORE_k40040)and(TppStory.GetCurrentStorySequence()<=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST)end},{radioGroup="f3000_rtrg3030",condition=function()return(TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.BEFORE_BASE_DEFENSE_TUTORIAL)end}}function e.IGNORE_COMMON_RADIO()end
e.COMMON_RADIO_LIST={[TppDefine.COMMON_RADIO.ENEMY_RECOVERED]="f1000_rtrg0100",[TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED]="f1000_rtrg1550",[TppDefine.COMMON_RADIO.HOSTAGE_DEAD]="f1000_rtrg0110",[TppDefine.COMMON_RADIO.HOSTAGE_DAMAGED_FROM_PC]="f1000_rtrg0116",[TppDefine.COMMON_RADIO.PHASE_DOWN_OUTSIDE_HOTZONE]="f1000_rtrg8050",[TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA]="f1000_rtrg0010",[TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT]="f1000_rtrg8040",[TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_CHANGE_SNEAK]="f1000_rtrg8050",[TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE]="f1000_rtrg8030",[TppDefine.COMMON_RADIO.RETURN_HOTZONE]="f1000_rtrg8060",[TppDefine.COMMON_RADIO.ABORT_BY_HELI]="f1000_rtrg0030",[TppDefine.COMMON_RADIO.RECOMMEND_CURE]="f1000_rtrg0120",[TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN]="f1000_rtrg0130",[TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME]="f1000_rtrg0050",[TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME_HOT_ZONE]="f1000_rtrg0070",[TppDefine.COMMON_RADIO.CALL_HELI_SECOND_TIME]="f1000_rtrg0060",[TppDefine.COMMON_RADIO.RECOVERED_RUSSIAN_INTERPRETER]="f1000_rtrg0690",[TppDefine.COMMON_RADIO.RESULT_RANK_S]="f1000_rtrg9050",[TppDefine.COMMON_RADIO.RESULT_RANK_A]="f1000_rtrg9040",[TppDefine.COMMON_RADIO.RESULT_RANK_B]="f1000_rtrg9030",[TppDefine.COMMON_RADIO.RESULT_RANK_C]="f1000_rtrg9020",[TppDefine.COMMON_RADIO.RESULT_RANK_D]="f1000_rtrg9010",[TppDefine.COMMON_RADIO.RESULT_RANK_E]="f1000_rtrg9010",[TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED]="f1000_rtrg9020",[TppDefine.COMMON_RADIO.CALL_SUPPROT_BUDDY]="f1000_rtrg0060",[TppDefine.COMMON_RADIO.TARGET_MARKED]="f1000_rtrg2120",[TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED]="f1000_rtrg2171",[TppDefine.COMMON_RADIO.TARGET_RECOVERED]="f1000_rtrg1640",[TppDefine.COMMON_RADIO.TARGET_ELIMINATED]="f1000_rtrg1640",[TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT]="f1000_rtrg1680",[TppDefine.COMMON_RADIO.CALL_BUDDY_QUIET_WHILE_FORCE_HOSPITALIZE]="f1000_rtrg4440",[TppDefine.COMMON_RADIO.UNLOCK_LANDING_ZONE]="f1000_rtrg2020",[TppDefine.COMMON_RADIO.DISCOVERED_BY_SNIPER]="f1000_rtrg5020",[TppDefine.COMMON_RADIO.DISCOVERED_BY_ENEMY_HELI]="f1000_rtrg5021",[TppDefine.COMMON_RADIO.PLAYER_NEAR_ENEMY_HELI]="f1000_rtrg3780",[TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END]="f1000_rtrg0090",[TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END_ENEMY_ATTACK]="f1000_rtrg1940",[TppDefine.COMMON_RADIO.HELI_DAMAGE_FROM_PLAYER]="f1000_rtrg0080",[TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_RUSSIAN]="f1000_rtrg1050",[TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_AFRIKANS]="f1000_rtrg4520"}e.COMMON_RADIO_DELAY_LIST={[TppDefine.COMMON_RADIO.ENEMY_RECOVERED]="long",[TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED]="long",[TppDefine.COMMON_RADIO.RECOMMEND_CURE]="mid",[TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN]="mid",[TppDefine.COMMON_RADIO.RECOVERED_RUSSIAN_INTERPRETER]="long",[TppDefine.COMMON_RADIO.TARGET_MARKED]="mid",[TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED]="mid",[TppDefine.COMMON_RADIO.TARGET_RECOVERED]="long",[TppDefine.COMMON_RADIO.TARGET_ELIMINATED]="long",[TppDefine.COMMON_RADIO.UNLOCK_LANDING_ZONE]="long",[TppDefine.COMMON_RADIO.RECOVERED_RUSSIAN_INTERPRETER]=8}function e.Messages()return Tpp.StrCode32Table{Radio={{msg="EspionageRadioPlay",func=e.DEBUG_PlayIntelRadio},{msg="Finish",func=e.OnFinishResultRadio}},Timer={{msg="Finish",sender="debugRadioTimer",func=e._PlayDebugContinue},{msg="Finish",sender="debugRadioStartTimer",func=e._PlayDebugStart}},UI={{msg="GameOverFadeIn",func=e.PlayGameOverRadio,option={isExecGameOver=true}},{msg="BlackRadioClosed",func=e.OnBlackRadioClosed}},Terminal={{msg="MbDvcActSelectNonActiveMenu",func=e.PlaySelectBuddy}}}end
e.SFXList={RadioStart="Play_sfx_s_codec_NPC_begin",RadioEnd="Play_sfx_s_codec_NPC_end"}e.PRESET_DELAY_TIME={short=.5,mid=1.5,long=3}function e.Play(n,a)local a=a or{}local s=a.radioType or"realtime"local o=a.isEnqueue
local r=a.delayTime
local t=a.noiseType or"both"local l=a.priority
local d=a.playDebug
local p=a.isOverwriteProtectionForSamePrio
if i(r)then
r=e.PRESET_DELAY_TIME[r]if r==nil then
return
end
end
if d==nil then
local a=type(n)local e=nil
if a=="table"then
e=n[1]elseif a=="string"then
e=n
end
local e=mvars.rad_debugRadioLineTable[e]if e==nil then
d=false
else
d=true
end
end
if TppStory.DEBUG_SkipDemoRadio then
local a=type(n)if a=="table"then
for n,a in pairs(n)do
e.SetPlayedGlobalFlag(a)end
elseif a=="string"then
e.SetPlayedGlobalFlag(n)end
return
end
e.PlayCommon(n,s,o,p,r,t,l,d)end
function e.SetOptionalRadio(e)if not i(e)then
return
end
TppRadioCommand.RegisterRadioGroupSetOverwrite(e)end
function e.SetTutorialOptionalRadio(e)if not i(e)then
return
end
if TppRadioCommand.RegisterTutorialRadioGroupSet then
TppRadioCommand.RegisterTutorialRadioGroupSet(e)end
end
function e.SetOverwriteByPhaseOptionalRadio(e)if not i(e)then
return
end
if TppRadioCommand.RegisterOverwriteByPhaseRadioGroupSet then
TppRadioCommand.RegisterOverwriteByPhaseRadioGroupSet(e)end
end
function e.UnsetTutorialOptionalRadio()if TppRadioCommand.UnregisterTutorialRadioGroupSet then
TppRadioCommand.UnregisterTutorialRadioGroupSet()end
end
function e.UnsetOverwriteByPhaseOptionalRadio()if TppRadioCommand.UnregisterOverwriteByPhaseRadioGroupSet then
TppRadioCommand.UnregisterOverwriteByPhaseRadioGroupSet()end
end
function e.ChangeIntelRadio(e)if not a(e)then
return
end
TppRadioCommand.RegisterEspionageRadioTable(e)end
function e.RequestBlackTelephoneRadio(a)local a,i=e.GetRadioNameAndRadioIDs(a)SubtitlesCommand.SetIsEnabledUiPrioStrong(true)e.playingBlackTelInfo={radioGroups=i,radioName=a,[n(a)]=true}end
function e.SetBlackTelephoneDisplaySetting(e)if not e then
return
end
if not mvars.rad_blackTelephoneDisplaySetting then
return
end
local e=mvars.rad_blackTelephoneDisplaySetting[e]if e then
for a,e in ipairs(e)do
TppUiCommand.BlackRadioCommand(e[1],e[2],e[3],e[4])end
end
end
function e.DoEventOnRewardEndRadio()local e={}if(mvars.rad_rewardEndRadionList~=nil)then
if Tpp.IsTypeTable(mvars.rad_rewardEndRadionList)then
for n,a in ipairs(mvars.rad_rewardEndRadionList)do
table.insert(e,a)end
else
return
end
end
return e
end
function e.SaveRewardEndRadioList(e)mvars.rad_rewardEndRadionList=e
end
function e.IsPlayed(a)local a,n=e.GetRadioNameAndRadioIDs(a)local n
if mvars.rad_debugRadioLineTable then
n=mvars.rad_debugRadioLineTable[a]end
if n then
local e=e.DEBUG_GetRadioIndex(a)if e then
return svars.rad_debugPlayedFlag[e]end
else
return TppRadioCommand.IsRadioGroupMarkAsRead(a)end
end
function e.SetPlayedLocalFlag(e)TppRadioCommand.EnableFlagIsMarkAsRead(e)end
function e.UnsetPlayedLocalFlag(e)TppRadioCommand.DisableFlagIsMarkAsRead(e)end
function e.SetPlayedGlobalFlag(e)if TppRadioCommand.EnableFlagIsMarkAsReadAndSaveToScriptVars~=nil then
TppRadioCommand.EnableFlagIsMarkAsReadAndSaveToScriptVars(e)end
end
function e.UnsetPlayedGlobalFlag(e)if TppRadioCommand.DisableFlagIsMarkAsReadAndSaveToScriptVars~=nil then
TppRadioCommand.DisableFlagIsMarkAsReadAndSaveToScriptVars(e)end
end
function e.IsRadioPlayable()local e=true
if(SubtitlesCommand.IsPlayingSubtitles())then
e=false
end
return e
end
function e.Stop()TppRadioCommand.StopDirect()SubtitlesCommand.StopAll()if WaveControl then
WaveControl.StopWaveFile()end
end
function e.StopForException()TppRadioCommand.StopDirect()SubtitlesCommand.StopAll()if WaveControl then
WaveControl.StopWaveFile()end
TppPause.UnregisterPause"BlackRadio"end
function e.UnregisterRadioGroupSet()TppRadioCommand.UnregisterRadioGroupSetFromList()end
function e.EnableCommonOptionalRadio(n)local i=TppStory.GetCurrentStorySequence()local a={}local r={}if(n)then
for a,n in ipairs(a)do
if(i>=n)then
e.SetTutorialOptionalRadio(r[a])end
end
else
e.UnsetTutorialOptionalRadio()end
end
function e.GetEspionageRadioTypeIndex(e)local a=-1
if TppRadioCommand.GetEspionageRadioTypeIndex then
return TppRadioCommand.GetEspionageRadioTypeIndex(e)end
return-1
end
function e.PlayCommon(a,n,s,d,i,t,n,o)local r=mvars
if not r.rad_radioPlayOnceList then
return
end
local a,n=e.GetRadioNameAndRadioIDs(a)if r.rad_radioPlayOnceList[a]then
if TppRadioCommand.IsRadioGroupMarkAsRead(a)then
return
end
if r.rad_debugRadioLineTable[a]then
local e=e.DEBUG_GetRadioIndex(a)if e and svars.rad_debugPlayedFlag[e]then
return
end
end
end
if o then
e.PlayDebug(n,i)return
end
if s then
TppRadioCommand.PlayDirectGroupTableEnqueue{tableName=a,groupName=n,preDelayTime=i,noiseType=t,isOverwriteProtectionForSamePrio=d}else
TppRadioCommand.PlayDirectGroupTable{tableName=a,groupName=n,preDelayTime=i,noiseType=t,isOverwriteProtectionForSamePrio=d}end
end
function e.PlayDebug(n,a)local n,i=e.GetRadioNameAndRadioIDs(n)if(n==nil or mvars.rad_debugRadioLineTable[n]==nil)then
return
end
local n=TppPause.IsPaused"HelpTipsMenuOpened"if n then
if(mvars.rad_debugRadioStartTimer>0)then
return
end
if(mvars.rad_debugRadioTimer>0)then
return
end
mvars.rad_debugRadioGroupList=i
mvars.rad_debugRadioGroupCount=1
if a then
mvars.rad_debugUseHelpTipsTimer=true
mvars.rad_debugRadioStartTimer=a
else
e._PlayDebugStart()end
return
end
if(GkEventTimerManager.IsTimerActive"debugRadioTimer"==true)then
return
end
if(GkEventTimerManager.IsTimerActive"debugRadioStartTimer"==true)then
return
end
mvars.rad_debugRadioGroupList=i
mvars.rad_debugRadioGroupCount=1
if a then
s("debugRadioStartTimer",a)else
e._PlayDebugStart()end
end
function e.PlayCommonRadio(r,d)if not l(r)then
return
end
local n=e.GetPlayCommonTargetRadio(r)local r=e.GetCommonRadioDelay(r)or"short"local r={delayTime=r}if i(n)or a(n)then
if d then
if e.IsPlayed(n)then
return
end
end
e.Play(n,r)elseif n==nil then
end
end
function e.GetPlayCommonTargetRadio(e)local e=mvars.rad_commonRadioTable[e]local a=e
if t(e)then
a=e()end
return a
end
function e.GetCommonRadioDelay(e)return mvars.rad_commonRadioDelayTable[e]end
function e.CheckRadioGroupIsCommonRadio(n,a)local e=e.GetPlayCommonTargetRadio(TppDefine.COMMON_RADIO.CALL_SUPPROT_BUDDY)if not e then
return
end
local a
if Tpp.IsTypeTable(e)then
a=Fox.StrCode32(e[1])else
a=Fox.StrCode32(e)end
if n==a then
return true
else
return false
end
end
function e.DeclareSVars()return{{name="rad_debugPlayedFlag",arraySize=200,type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioReadFlagMissionScoped",arraySize=200,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_labelGroupReadFlagMissionScoped",arraySize=20,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioEspGmIdAssignInfoGmId",arraySize=260,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioEspGmIdAssignInfoGroupName",arraySize=260,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioEspEspTypeAssignInfoGroupName",arraySize=100,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioOptInsertInfoGroupSetName",arraySize=50,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioOptInsertInfoGroupName",arraySize=50,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioOptInsertInfoInsertIndex",arraySize=50,type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioOptCurrentSetGroupSetName",arraySize=1,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioOptCurrentTutorialGroupSetName",arraySize=1,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rad_radioOptCurrentOverwriteByPhaseGroupSetName",arraySize=1,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}end
function e.OnAllocate(n)mvars.rad_subScripts=n
mvars.rad_radioList={}mvars.rad_debugRadioLineTable={}mvars.rad_optionalRadioList={}mvars.rad_intelRadioList={}mvars.rad_commonRadioTable={}mvars.rad_commonRadioDelayTable={}for e,a in pairs(e.COMMON_RADIO_LIST)do
mvars.rad_commonRadioTable[e]=a
end
for e,a in pairs(e.COMMON_RADIO_DELAY_LIST)do
mvars.rad_commonRadioDelayTable[e]=a
end
local n=n.radio
if not n then
return
end
local r=n.debugRadioLineTable
if r then
for e,a in pairs(r)do
mvars.rad_debugRadioLineTable[e]=a
end
end
if a(n.radioList)then
e.RegisterRadioList(n.radioList)end
if a(n.optionalRadioList)then
e.RegisterOptionalRadioList(n.optionalRadioList)end
if a(n.intelRadioList)then
e.RegisterIntelRadioList(n.intelRadioList)end
if n.USE_RESULT_RADIO then
mvars.rad_useResultRadio=true
end
if mvars.rad_useResultRadio and n.resultRadioList then
if a(n.resultRadioList)or i(n.resultRadioList)then
mvars.rad_useIndivResultRadio=true
mvars.rad_indivResultRadioList=n.resultRadioList
end
end
local i=n.blackTelephoneDisplaySetting
if a(i)then
mvars.rad_blackTelephoneDisplaySetting={}for n,e in pairs(i)do
if not a(e.Japanese)then
end
if not a(e.English)then
end
if TppGameSequence.GetTargetArea()=="Japan"then
mvars.rad_blackTelephoneDisplaySetting[n]=e.Japanese
else
mvars.rad_blackTelephoneDisplaySetting[n]=e.English
end
end
end
local a=n.commonRadioTable
if a then
e.OverwriteCommonRadioTable(a)end
end
function e.Init()e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())TppTutorial.SetIntelRadio()if mvars.rad_intelRadioList then
TppRadioCommand.RegisterEspionageRadioTable(mvars.rad_intelRadioList)end
local a={[10010]=true,[10020]=true,[10030]=true,[10050]=true,[10115]=true,[10140]=true,[10151]=true,[10230]=true,[10240]=true,[10260]=true,[10280]=true,[30050]=true,[30150]=true,[30250]=true,[40010]=true,[40020]=true,[40050]=true,[50050]=true,[6e4]=true}local a=a[vars.missionCode]if a then
else
e.EnableCommonOptionalRadio(true)end
end
function e.OnReload(a)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())e.OnAllocate(a)local a=_G.TppRadio.playingBlackTelInfo
if a then
e.playingBlackTelInfo=a
end
end
function e.CommonMakeRadioList(e)local t={}local o={}for r,e in pairs(e)do
if type(r)=="number"then
local r
local d
if a(e)then
if not i(e[1])then
else
r=e[1]d=e.playOnce
end
elseif i(e)then
r=e
d=false
end
t[n(r)]=r
o[r]=d
end
end
return t,o
end
function e.RegisterRadioList(d)for e,n in pairs(d)do
if a(n)then
mvars.rad_radioList[e]={}for i,n in pairs(n)do
local r=type(i)if r=="number"then
mvars.rad_radioList[e]=n
elseif r=="string"and a(n)then
mvars.rad_debugRadioLineTable[i]=n
end
end
else
mvars.rad_radioList[e]=n
end
end
mvars.rad_radioInvList,mvars.rad_radioPlayOnceList=e.CommonMakeRadioList(d)end
function e.ResetCalledFlagForPlayOnceRadio()if not a(mvars.rad_radioPlayOnceList)then
return
end
if not next(mvars.rad_radioPlayOnceList)then
return
end
for e,a in pairs(mvars.rad_radioPlayOnceList)do
if i(e)then
TppRadioCommand.DisableFlagIsMarkAsRead(e)end
end
end
function e.AddDebugRadioLineTable(e)if not a(e)then
return
end
for a,e in pairs(e)do
mvars.rad_debugRadioLineTable[a]=e
end
end
function e.RegisterOptionalRadioList(a)for a,e in pairs(a)do
mvars.rad_optionalRadioList[a]=e
end
mvars.rad_optionalRadioInvList,mvars.rad_optionalRadioPlayOnceList=e.CommonMakeRadioList(a)end
function e.RegisterIntelRadioList(e)if next(e)==nil then
return
end
for e,a in pairs(e)do
mvars.rad_intelRadioList[e]=a
end
end
function e.OverwriteCommonRadioTable(e)if not a(e)then
return
end
for n,e in pairs(e)do
if(i(e)or a(e))or t(e)then
mvars.rad_commonRadioTable[n]=e
end
end
end
function e.OnMessage(d,o,n,r,t,i,a)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,d,o,n,r,t,i,a)end
function e.PlayGameOverRadio()if TppMission.IsMultiPlayMission(vars.missionCode)then
return
end
local n=TppMission.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.PLAYER_DEAD)local i=TppMission.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD)local r=TppMission.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.S10035_TOO_CLOSE_KAIJU)if(n or i)or r then
else
return
end
local n
for i,e in pairs(e.GAME_OVER_RADIO_LIST)do
if e.condition()then
if a(e.radioGroup)then
local a=math.random(1,#e.radioGroup)n=e.radioGroup[a]else
n=e.radioGroup
end
break
end
end
if not n then
return
end
SubtitlesCommand.SetIsEnabledUiPrioStrong(true)e.Play(n,{noiseType="none",delayTime="long"})end
local a={[TppDefine.MISSION_CLEAR_RANK.S]=TppDefine.COMMON_RADIO.RESULT_RANK_S,[TppDefine.MISSION_CLEAR_RANK.A]=TppDefine.COMMON_RADIO.RESULT_RANK_A,[TppDefine.MISSION_CLEAR_RANK.B]=TppDefine.COMMON_RADIO.RESULT_RANK_B,[TppDefine.MISSION_CLEAR_RANK.C]=TppDefine.COMMON_RADIO.RESULT_RANK_C,[TppDefine.MISSION_CLEAR_RANK.D]=TppDefine.COMMON_RADIO.RESULT_RANK_D,[TppDefine.MISSION_CLEAR_RANK.E]=TppDefine.COMMON_RADIO.RESULT_RANK_E,[TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED]=TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED}function e.PlayResultRadio(a)if t(a)then
mvars.rad_finishResultRadioCallback=a
end
if not mvars.rad_useResultRadio then
if mvars.rad_finishResultRadioCallback then
mvars.rad_finishResultRadioCallback()end
return
end
SubtitlesCommand.SetIsEnabledUiPrioStrong(true)if mvars.rad_useIndivResultRadio then
e.Play(mvars.rad_indivResultRadioList)else
if mvars.rad_finishResultRadioCallback then
mvars.rad_finishResultRadioCallback()end
end
end
function e.SetCommonResultRadioSetting()mvars.rad_useResultRadio=true
if mvars.rad_useIndivResultRadio then
end
mvars.rad_useIndivResultRadio=false
mvars.rad_indivResultRadioList=nil
mvars.rad_finishResultRadioCallback=nil
end
function e.SetIndivResultRadioSetting(e)mvars.rad_useResultRadio=true
if mvars.rad_useIndivResultRadio then
end
mvars.rad_useIndivResultRadio=true
mvars.rad_indivResultRadioList=e
mvars.rad_finishResultRadioCallback=nil
end
function e.ResetIndivResultRadioSetting()mvars.rad_useResultRadio=false
mvars.rad_useIndivResultRadio=false
mvars.rad_indivResultRadioList=nil
mvars.rad_finishResultRadioCallback=nil
end
function e.IsSetIndivResultRadioSetting()if(mvars.rad_useResultRadio and mvars.rad_useIndivResultRadio)and mvars.rad_indivResultRadioList then
return true
end
return false
end
function e.OnFinishResultRadio(a)if not e.IsSetIndivResultRadioSetting()then
return
end
local e,i=e.GetRadioNameAndRadioIDs(mvars.rad_indivResultRadioList)if n(e)==a then
if mvars.rad_finishResultRadioCallback then
mvars.rad_finishResultRadioCallback()end
mvars.rad_finishResultRadioCallback=nil
end
end
function e.DEBUG_PlayIntelRadio(a)local a=mvars.rad_radioInvList[a]if a==nil then
return
end
if mvars.rad_debugRadioLineTable[a]then
e.Play(a)end
end
function e.DEBUG_GetRadioIndex(e)if next(mvars.rad_radioList)==nil then
return
end
for n,a in pairs(mvars.rad_radioList)do
if e==a then
return n
end
end
end
function e.OnFinishRadioWhileLoading(a)if e.playingBlackTelInfo and e.playingBlackTelInfo[a]then
SubtitlesCommand.SetIsEnabledUiPrioStrong(false)e.playingBlackTelInfo=nil
TppMission.ExecuteSystemCallback"OnFinishBlackTelephoneRadio"else
e.OnFinishResultRadio(a)end
end
function e.StartBlackRadio()TppPause.RegisterPause("BlackRadio",TppPause.PAUSE_LEVEL_BLACK_RADIO)BlackRadio.Open()end
function e.OnBlackRadioClosed(e)TppPause.UnregisterPause"BlackRadio"end
function e.GetRadioNameAndRadioIDs(e)if type(e)=="string"then
return e,{e}else
return e[1],e
end
end
function e._PlayDebugStart()mvars.rad_debugRadioGroupLine=1
TppSoundDaemon.PostEvent(e.SFXList.RadioStart)e._PlayDebugContinue()end
function e._PlayDebugContinue()local a=mvars
if not a.rad_debugRadioGroupList then
return
end
if(a.rad_debugRadioGroupLine<=#a.rad_debugRadioLineTable[a.rad_debugRadioGroupList[a.rad_debugRadioGroupCount]])then
local i=a.rad_debugRadioLineTable[a.rad_debugRadioGroupList[a.rad_debugRadioGroupCount]][a.rad_debugRadioGroupLine]local n=math.ceil(string.len(i)*.333333333333333)*.2
n=math.max(n,.8)e._PlayDebugLine(i,n)local e=.2
local i=TppPause.IsPaused"HelpTipsMenuOpened"if i then
a.rad_debugUseHelpTipsTimer=true
a.rad_debugRadioTimer=n+e
else
s("debugRadioTimer",n+e)end
if a.rad_debugRadioGroupLine==1 then
if WaveControl then
local n="Z:/tpp/release/sound/ld_prepro_voice/"..(TppMission.GetMissionName().."/")local e=a.rad_debugRadioGroupList[a.rad_debugRadioGroupCount]..".wav"local e=n..e
if Asset~=nil and Asset.Exists(e)then
WaveControl.PlayWaveFile(e)end
end
end
a.rad_debugRadioGroupLine=a.rad_debugRadioGroupLine+1
elseif a.rad_debugRadioGroupCount<#a.rad_debugRadioGroupList then
a.rad_debugRadioGroupCount=a.rad_debugRadioGroupCount+1
a.rad_debugRadioGroupLine=1
e._PlayDebugContinue()else
if SoundCommand then
SoundCommand.PostEvent(e.SFXList.RadioEnd)end
local i=a.rad_debugRadioGroupList[1]a.rad_debugRadioGroupList=nil
a.rad_debugRadioGroupCount=1
local e=e.DEBUG_GetRadioIndex(i)if e then
svars.rad_debugPlayedFlag[e]=true
end
local e="sender:Radio messageId:Finish arg0:"..i
TppSequence.OnMessage(n"Radio",n"Finish",n(i),nil,nil,nil,e)TppMission.OnMessage(n"Radio",n"Finish",n(i),nil,nil,nil,e)for r,d in pairs(a.rad_subScripts)do
if a.rad_subScripts[r]._messageExecTable then
Tpp.DoMessage(a.rad_subScripts[r]._messageExecTable,TppMission.CheckMessageOption,n"Radio",n"Finish",n(i),nil,nil,nil,e)end
end
SsdFlagMission.OnMessage(n"Radio",n"Finish",n(i),nil,nil,nil,e)end
end
function e._PlayDebugLine(a,e)SubtitlesCommand.DisplayText(a,"Default",e*1e3)end
function e.PlaySelectBuddy(a)if TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_FORCE_HOSPITALIZE)then
if(a==Fox.StrCode32(TppTerminal.MBDVCMENU.MSN_BUDDY_QUIET_SCOUT)or a==Fox.StrCode32(TppTerminal.MBDVCMENU.MSN_BUDDY_QUIET_ATTACK))or a==Fox.StrCode32(TppTerminal.MBDVCMENU.MSN_BUDDY_QUIET_DISMISS)then
e.PlayCommonRadio(TppDefine.COMMON_RADIO.CALL_BUDDY_QUIET_WHILE_FORCE_HOSPITALIZE)end
end
end
function e.SetGameOverRadio(e,e)end
function e.QARELEASE_DEBUG_Init()mvars.rad_debugRadioStartTimer=0
mvars.rad_debugRadioTimer=0
mvars.rad_debugUseHelpTipsTimer=false
end
function e.QAReleaseDebugUpdate()if not mvars.rad_debugUseHelpTipsTimer then
return
end
local a=Time.GetFrameTime()if mvars.rad_debugRadioStartTimer>0 then
mvars.rad_debugRadioStartTimer=mvars.rad_debugRadioStartTimer-a
if mvars.rad_debugRadioStartTimer<0 then
mvars.rad_debugRadioStartTimer=0
e._PlayDebugStart()end
return
end
if mvars.rad_debugRadioTimer>0 then
mvars.rad_debugRadioTimer=mvars.rad_debugRadioTimer-a
if mvars.rad_debugRadioTimer<0 then
mvars.rad_debugRadioTimer=0
e._PlayDebugContinue()end
return
end
mvars.rad_debugUseHelpTipsTimer=false
end
return e