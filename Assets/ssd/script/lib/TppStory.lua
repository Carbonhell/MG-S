local e={}local n=Tpp.IsTypeTable
local s=Tpp.IsTypeNumber
e.radioDemoTable={}e.eventPlayTimmingTable={blackTelephone={},clearSideOpsForceMBDemo={},clearSideOpsForceMBRadio={},forceMBDemo={},afterMBDemo={},clearSideOps={},freeHeliRadio={}}e.PLAY_DEMO_END_MISSION={}function e.GetCurrentStorySequence()return gvars.str_storySequence
end
function e.IncrementStorySequence()gvars.str_storySequence=gvars.str_storySequence+1
TppTrophy.UnlockByStorySequence()end
function e.PermitMissionOpen(e)local e=SsdMissionList.MISSION_ENUM[tostring(e)]if e then
gvars.str_missionOpenPermission[e]=true
end
end
function e.MissionOpen(n)e.SetMissionOpenFlag(n,true)e.EnableMissionNewOpenFlag(n)Mission.RequestOpenMissionToServer(n)end
function e.MissionClose(n)e.SetMissionOpenFlag(n,false)end
function e.SetMissionOpenFlag(e,i)local e=SsdMissionList.MISSION_ENUM[tostring(e)]if e then
local n=gvars.str_missionOpenPermission[e]if n then
gvars.str_missionOpenFlag[e]=i
end
end
end
function e.GetMissionEnemyLevel()local t=e.GetCurrentStorySequenceTable()if not t or not n(t)then
return 0,0
end
local i=t.baseEnemyLevel
local t=t.enemyLevelRandRange or 0
if not i then
i=0
local s=e.GetCurrentStorySequence()if s>0 then
for s=(s-1),0,-1 do
local e=e.GetStorySequenceTable(s)if n(e)and e.baseEnemyLevel then
if e.enemyLevelRandRange then
t=e.enemyLevelRandRange
end
i=e.baseEnemyLevel
break
end
end
end
end
return i,t
end
function e.GetRegionEnemyLevel()local i=e.GetCurrentStorySequence()if i<=0 then
return
end
for i=i,0,-1 do
local e=e.GetStorySequenceTable(i)if n(e)and(e.regionEnemyLevelSetting)then
return e.regionEnemyLevelSetting
end
end
end
function e.GetMissionGuideLine()local e=e.GetCurrentStorySequenceTable()if not e or not n(e)then
return
end
local e=e.guideLine
if not n(e)then
return
end
return e
end
function e.GetNextMissionInfo()local e=SsdStorySequenceList.sequenceAutoLoadMissionList[gvars.str_storySequence+1]if not n(e)then
return
end
return e
end
function e.GetObjectiveInfoAtAnotherLocation()local e=e.GetCurrentStorySequenceTable()if not e or not n(e)then
return
end
local e=e.objectiveInfoAtAnotherLocation
if not n(e)then
return
end
return e
end
function e.GetGuideLineInfoAtAnotherLocation()local e=e.GetCurrentStorySequenceTable()if not e or not n(e)then
return
end
local e=e.guideLineInfoAtAnotherLocation
if not n(e)then
return
end
return e
end
function e.GetMarkerInfoAtAnotherLocation()local e=e.GetCurrentStorySequenceTable()if not e or not n(e)then
return
end
local e=e.markerInfoAtAnotherLocation
if not n(e)then
return
end
return e
end
function e.IsMissionOpen(e)local e=SsdMissionList.MISSION_ENUM[tostring(e)]if e then
return gvars.str_missionOpenFlag[e]end
return false
end
function e.IsMissionCleard(e)local e=SsdMissionList.MISSION_ENUM[tostring(e)]if e then
return gvars.str_missionClearedFlag[e]end
return false
end
function e.CalcAllMissionClearedCount()local n=0
local e=0
for i,s in pairs(SsdMissionList.MISSION_ENUM)do
local t=TppDefine.MISSING_NUMBER_MISSION_ENUM[i]if not t then
local i=tonumber(i)if(gvars.str_missionClearedFlag[s])then
n=n+1
end
e=e+1
end
end
return n,e
end
function e.CalcAllMissionTaskCompletedCount()local n=0
local e=0
for i,t in pairs(SsdMissionList.MISSION_ENUM)do
local t=TppDefine.MISSING_NUMBER_MISSION_ENUM[i]if not t then
local i=tonumber(i)n=n+TppUI.GetTaskCompletedNumber(i)e=e+TppUI.GetMaxMissionTask(i)end
end
return n,e
end
function e.UpdateMissionCleardFlag(e)local e=SsdMissionList.MISSION_ENUM[tostring(e)]if e then
gvars.str_missionClearedFlag[e]=true
end
end
function e.GetStorySequenceName(e)return TppDefine.STORY_SEQUENCE_LIST[e+1]end
function e.GetStorySequenceTable(e)return SsdStorySequenceList.storySequenceTable[e+1]end
function e.GetCurrentStorySequenceTable()local n=e.GetCurrentStorySequence()local e=e.GetStorySequenceTable(n)return e
end
function e.IsMainMission()for n,e in pairs(SsdStorySequenceList.storySequenceTable)do
local n=0
if e.main then
n=TppMission.ParseMissionName(e.main)end
if n==vars.missionCode then
return true
end
end
return false
end
function e.GetOpenMissionCount(t)local i=0
if t==nil then
for e=0,TppDefine.MISSION_COUNT_MAX do
if gvars.str_missionOpenFlag[e]then
i=i+1
end
end
elseif s(t)then
for t=0,t do
local e=e.GetStorySequenceTable(t)if e==nil then
break
end
for s,t in ipairs{"story","coop","flag","onlyOpen"}do
local e=e[t]if n(e)then
i=i+#e
end
end
end
end
return i
end
function e.GetClearedMissionCount(i)local n=0
for t,s in ipairs(i)do
if e.IsMissionCleard(i[t])==true then
n=n+1
end
end
return n
end
function e.GetElapsedMissionEventName(e)return TppDefine.ELAPSED_MISSION_EVENT_LIST[e+1]end
function e.StartElapsedMissionEvent(i,n)if not e.GetElapsedMissionEventName(i)then
return
end
if not s(n)then
return
end
if n<1 or n>128 then
return
end
gvars.str_elapsedMissionCount[i]=n
end
function e.GetElapsedMissionCount(n)if not e.GetElapsedMissionEventName(n)then
return
end
local e=gvars.str_elapsedMissionCount[n]return e
end
function e.IsNowOccurringElapsedMission(n)if not e.GetElapsedMissionEventName(n)then
return
end
if gvars.str_elapsedMissionCount[n]==TppDefine.ELAPSED_MISSION_COUNT.NOW_OCCURRING then
return true
else
return false
end
end
function e.SetDoneElapsedMission(n)if not TppDefine.ELAPSED_MISSION_EVENT_LIST[n+1]then
return
end
if e.IsNowOccurringElapsedMission(n)then
gvars.str_elapsedMissionCount[n]=TppDefine.ELAPSED_MISSION_COUNT.DONE_EVENT
else
if gvars.str_elapsedMissionCount[n]>TppDefine.ELAPSED_MISSION_COUNT.NOW_OCCURRING then
end
end
end
function e.CanPlayMgo(e)return false
end
function e.CanPlayCoopMission()return Mission.IsCoopLobbyEnabled()end
function e.OnReload(n)e.SetUpStorySequenceTable()end
function e.SetUpStorySequenceTable()end
function e.Init(n)e.UpdateStorySequence{updateTiming="OnMissionStart"}end
e.SetUpStorySequenceTable()function e.UpdateStorySequence(i)if not n(i)then
return
end
local n
local t=i.updateTiming
local o=i.isInGame
local s=function()TppQuest.UpdateActiveQuest()end
if t=="OnMissionClear"then
local i=i.missionId
n=e.UpdateStorySequenceOnMissionClear(i)s()else
local i=e.GetCurrentStorySequenceTable()if(i and i.updateTiming)and i.updateTiming[t]then
n=e._UpdateStorySequence()s()end
end
if n and o then
TppMission.ExecuteSystemCallback("OnUpdateStorySequenceInGame",n)end
if n then
if next(n)then
gvars.mis_isExistOpenMissionFlag=true
end
local e=e.GetCurrentStorySequence()if TppDefine.CONTINUE_TIPS_TABLE[e]then
gvars.continueTipsCount=1
end
end
e.UpdateDisplayMissionList()return n
end
function e.UpdateDisplayMissionList()local i={}local n=TppLocation.GetLocationName()if not n then
return
end
local e=n
if e=="afgh"then
e="SSD_AFGH"else
e=string.upper(e)end
if not SsdMissionList.MISSION_LIST_FOR_LOCATION[e]then
return
end
for t,e in ipairs(SsdMissionList.MISSION_LIST_FOR_LOCATION[e])do
local t=SsdMissionList.MISSION_ENUM[e]if(t and gvars.str_missionOpenFlag[t])and not SsdMissionList.MISSION_LIST_FOR_IGNORE_MISSION_LIST_UI[e]then
if not TppMission.IsMultiPlayMission(e)then
table.insert(i,{e,n,t})end
end
end
if next(i)then
MissionInfoSystem.RegisterInfos(i)end
end
function e.UpdateStorySequenceOnMissionClear(n)for i,e in pairs(TppDefine.SYS_MISSION_ID)do
if(n==e)then
return
end
end
local i=SsdMissionList.MISSION_ENUM[tostring(n)]if not i then
if DebugMenu then
e.DEBUG_StoryVars()end
return
end
if gvars.str_missionOpenFlag[i]==false then
if DebugMenu then
e.DEBUG_StoryVars()end
return
end
e.UpdateMissionCleardFlag(n)e.DecreaseElapsedMissionClearCount()local e=e._UpdateStorySequence()return e
end
function e._UpdateStorySequence()local n=e.GetCurrentStorySequence()local t,s
local i
repeat
s=e.GetStorySequenceTable(n)if s==nil then
return
end
local s=e.CheckNeedProceedStorySequence(s)and n<TppDefine.STORY_SEQUENCE.STORY_FINISH
if not s then
break
end
t=e.ProceedStorySequence()n=e.GetCurrentStorySequence()if n<TppDefine.STORY_SEQUENCE.STORY_FINISH then
i=false
else
i=true
end
until(i or next(t))return t
end
function e.CheckNeedProceedStorySequence(n)local i={}local t=n.story
if t then
for t,n in pairs(t)do
local n=TppMission.ParseMissionName(n)table.insert(i,e.IsMissionCleard(n))end
end
local t=n.coop
if t then
for t,n in pairs(t)do
local n=TppMission.ParseMissionName(n)table.insert(i,e.IsMissionCleard(n))end
end
local e=n.flag
if e then
for n,e in pairs(e)do
table.insert(i,SsdFlagMission.IsCleared(e))end
end
local e=n.defense
if e then
for n,e in pairs(e)do
table.insert(i,SsdBaseDefense.IsCleared(e))end
end
local e=true
local t=0
for e=1,#i do
if i[e]then
t=t+1
end
end
local i=#i
if n.proceedCount then
i=n.proceedCount
end
if t<i then
e=false
end
if e and n.condition then
e=n.condition()end
return e
end
function e.ProceedStorySequence()e.IncrementStorySequence()local i=e.GetCurrentStorySequence()local i=e.GetStorySequenceTable(i)if i==nil then
return
end
local t={}local function s(n,i,o)local s=i or{}local i=TppMission.ParseMissionName(n)e.PermitMissionOpen(i)if not s[n]then
if o~="onlyOpen"then
table.insert(t,n)end
e.MissionOpen(i)end
end
for e,t in ipairs{"story","coop","flag","onlyOpen"}do
local e=i[t]if n(e)then
for n,e in ipairs(e)do
s(e,i.defaultClose,t)end
end
end
for e,e in pairs(t)do
end
return t
end
function e.CanPlayDemoOrRadio(n)local e=e.radioDemoTable[n]if e then
return e.storyCondition()and e.detailCondition()end
return false
end
function e.GetStoryRadioListFromIndex(n,i)local n=e.eventPlayTimmingTable[n]if not n then
return nil
end
local n=n[i][2]return e.radioDemoTable[n].radioList
end
function e._GetRadioList(e,n)if e.selectRadioFunction then
return e.selectRadioFunction(n)end
return e.radioList
end
function e.IsDoneEvent(e,n,i,i)if not n then
return false
end
if e.radioList then
for n,e in ipairs(e.radioList)do
if TppRadio.IsPlayed(e)then
return true
end
end
return false
end
return true
end
function e.DEBUG_GetUnclearedMissionCode()for i,e in pairs(SsdMissionList.MISSION_ENUM)do
local n=gvars.str_missionOpenFlag[e]local e=gvars.str_missionClearedFlag[e]if n and(not e)then
return tonumber(i)end
end
end
function e.DEBUG_TestStorySequence()e.DEBUG_SkipDemoRadio=true
TppScriptVars.InitForNewGame()TppGVars.AllInitialize()TppVarInit.InitializeOnNewGame()e.DEBUG_InitQuestFlagsForTest()local t
repeat
local i=""for t,n in ipairs(SsdMissionList.MISSION_LIST)do
if e.IsMissionCleard(n)then
i=i..(","..tostring(n))end
end
coroutine.yield()if DebugText then
local e=DebugText.NewContext()DebugText.Print(e,{.5,.5,1},"vars.missionCode = "..tostring(vars.missionCode))end
e.UpdateStorySequence{updateTiming="OnMissionClear",missionId=TppMission.GetMissionID()}repeat
coroutine.yield()TppQuest.UpdateActiveQuest{debugUpdate=true}until(not e.DEBUG_ClearQuestForTest(vars.missionCode))e.MissionOpen(10260)local n=e.DEBUG_GetUnclearedMissionCode()if mvars.str_DEBUG_needClearOneMission then
n=10036
mvars.str_DEBUG_needClearOneMission=false
end
if n==nil then
break
end
vars.missionCode=n
coroutine.yield()until(t or mvars.str_testBreak)e.DEBUG_SkipDemoRadio=nil
end
function e.DEBUG_InitQuestFlagsForTest()for n,e in ipairs(TppDefine.QUEST_INDEX)do
gvars.qst_questOpenFlag[e]=false
gvars.qst_questActiveFlag[e]=false
gvars.qst_questClearedFlag[e]=false
gvars.qst_questRepopFlag[e]=false
end
end
function e.DEBUG_ClearQuestForTest(e)for n,e in ipairs(TppDefine.QUEST_DEFINE)do
if TppQuest.IsOpen(e)and not TppQuest.IsCleard(e)then
TppQuest.Clear(e)return true
end
end
return false
end
function e.DEBUG_SetStorySequence(s,a)if Tpp.IsMaster()then
return
end
gvars.str_storySequence=s
for e=0,TppDefine.MISSION_COUNT_MAX do
gvars.str_missionOpenPermission[e]=false
gvars.str_missionOpenFlag[e]=false
gvars.str_missionClearedFlag[e]=false
gvars.str_missionNewOpenFlag[e]=false
end
local function r(i,r,o,t,n)local s=n or{}local n=TppMission.ParseMissionName(i)local t=(i==t)e.PermitMissionOpen(n)if(not s[i])or(t)then
e.MissionOpen(n)if(r<o)and(not t)then
e.DisableMissionNewOpenFlag(n)e.UpdateMissionCleardFlag(n)end
end
return t
end
local i
for t=0,s do
local e=e.GetStorySequenceTable(t)if e==nil then
break
end
for l,o in ipairs{"story","coop","flag","onlyOpen"}do
local o=e[o]if n(o)then
for o,n in ipairs(o)do
local e=r(n,t,s,a,e.defaultClose)i=i or e
end
end
end
if i then
gvars.str_storySequence=t
break
end
end
TppTerminal.OnEstablishMissionClear()TppRanking.UpdateOpenRanking()e.UpdateDisplayMissionList()if DebugMenu then
local n,i=e.GetMissionEnemyLevel()DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelBasic",(n+i))if not gvars.DEBUG_skipInitialEquip then
e.QARELEASE_DEBUG_SetStoryPacingProduct()end
end
end
function e.DecreaseElapsedMissionClearCount()for n=0,TppDefine.ELAPSED_MISSION_COUNT_MAX-1 do
if n~=TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE or(not e.PLAY_DEMO_END_MISSION[vars.missionCode])then
if gvars.str_elapsedMissionCount[n]>0 then
local e=gvars.str_elapsedMissionCount[n]-1
gvars.str_elapsedMissionCount[n]=e
end
end
end
end
function e.EnableMissionNewOpenFlag(n)e.SetMissionNewOpenFlag(n,true)end
function e.DisableMissionNewOpenFlag(n)e.SetMissionNewOpenFlag(n,false)end
function e.SetMissionNewOpenFlag(e,n)if TppMission.IsSysMissionId(e)then
return
end
local e=SsdMissionList.MISSION_ENUM[tostring(e)]if e then
gvars.str_missionNewOpenFlag[e]=n
end
end
if DebugMenu then
function e.QARELEASE_DEBUG_Init()mvars.qaDebug.setAfterStoryPacing=false
DebugMenu.AddDebugMenu(" Pacing","setAfterStoryPacing","bool",mvars.qaDebug,"setAfterStoryPacing")mvars.qaDebug.pacingStage=0
DebugMenu.AddDebugMenu(" Pacing","pacingStage","int32",mvars.qaDebug,"pacingStage")mvars.qaDebug.setStoryPacing=false
DebugMenu.AddDebugMenu(" Pacing","setStoryPacing","bool",mvars.qaDebug,"setStoryPacing")mvars.qaDebug.showStorySequence=false
DebugMenu.AddDebugMenu("LuaSystem","showStorySequnce","bool",mvars.qaDebug,"showStorySequence")mvars.qaDebug.showMissionOpenPermission=false
DebugMenu.AddDebugMenu("LuaSystem","showPermitOpen","bool",mvars.qaDebug,"showMissionOpenPermission")mvars.qaDebug.showOpenMission=false
DebugMenu.AddDebugMenu("LuaSystem","showOpenMission","bool",mvars.qaDebug,"showOpenMission")mvars.qaDebug.showCleardMission=false
DebugMenu.AddDebugMenu("LuaSystem","showClearedMission","bool",mvars.qaDebug,"showCleardMission")mvars.qaDebug.prepareMissionClear=false
DebugMenu.AddDebugMenu("LuaSystem","prepareMissionClear","bool",mvars.qaDebug,"prepareMissionClear")mvars.qaDebug.forceMissionClear=false
DebugMenu.AddDebugMenu("LuaSystem","forceMissionClear","bool",mvars.qaDebug,"forceMissionClear")mvars.qaDebug.openAllMission=false
DebugMenu.AddDebugMenu("LuaSystem","OpenAllMission","bool",mvars.qaDebug,"openAllMission")DebugMenu.AddDebugMenu(" Pacing","OpenAllMission","bool",mvars.qaDebug,"openAllMission")mvars.qaDebug.allMissionTaskClear=false
DebugMenu.AddDebugMenu("LuaSystem","AllMissionTaskClear","bool",mvars.qaDebug,"allMissionTaskClear")end
function e.QAReleaseDebugUpdate()local t=5
local n=svars
local n=mvars
local i=DebugText.NewContext()if gvars.DEBUG_reserveAddProductForPacing then
e.QARELEASE_DEBUG_AddProductForPacing()end
if n.qaDebug.showStorySequence then
DebugText.Print(i,"")DebugText.Print(i,{.5,.5,1},"LuaSystem showStorySequnce")DebugText.Print(i," Current story sequnce = "..tostring(e.GetStorySequenceName(gvars.str_storySequence)))end
if n.qaDebug.showMissionOpenPermission then
DebugText.Print(i,"")DebugText.Print(i,{.5,.5,1},"LuaSystem showPermitOpen")local n={}local s,e=0,1
for o,i in ipairs(SsdMissionList.MISSION_LIST)do
local o=o-1
if gvars.str_missionOpenPermission[o]then
e=math.floor(s/t)+1
if n[e]then
n[e]=n[e]..(", "..tostring(i))else
n[e]="  "..tostring(i)end
s=s+1
end
end
for e=1,e do
DebugText.Print(i,n[e])end
end
if n.qaDebug.showOpenMission then
DebugText.Print(i,"")DebugText.Print(i,{.5,.5,1},"LuaSystem showOpenMission")local n={}local s,e=0,1
for o,i in ipairs(SsdMissionList.MISSION_LIST)do
local o=o-1
if gvars.str_missionOpenFlag[o]then
e=math.floor(s/t)+1
if n[e]then
n[e]=n[e]..(", "..tostring(i))else
n[e]="  "..tostring(i)end
s=s+1
end
end
for e=1,e do
DebugText.Print(i,n[e])end
end
if n.qaDebug.showCleardMission then
DebugText.Print(i,"")DebugText.Print(i,{.5,.5,1},"LuaSystem showCleardMission")local n={}local s,e=0,1
for o,i in ipairs(SsdMissionList.MISSION_LIST)do
local o=o-1
if gvars.str_missionClearedFlag[o]then
e=math.floor(s/t)+1
if n[e]then
n[e]=n[e]..(", "..tostring(i))else
n[e]="  "..tostring(i)end
s=s+1
end
end
for e=1,e do
DebugText.Print(i,n[e])end
end
if n.qaDebug.prepareMissionClear then
if TppMission.CheckMissionState()then
local e=TppMission._CreateMissionName(vars.missionCode)local e=e.."_sequence"local e=_G[e]if e and e.DEBUG_PrepareMissionClear then
e.DEBUG_PrepareMissionClear()end
end
n.qaDebug.prepareMissionClear=false
end
if n.qaDebug.forceMissionClear then
if TppMission.CheckMissionState()then
local e=TppMission._CreateMissionName(vars.missionCode)local e=e.."_sequence"local e=_G[e]if e and e.ReserveMissionClear then
e.ReserveMissionClear()else
TppMission.ReserveMissionClearOnOutOfHotZone()end
end
end
if n.qaDebug.openAllMission then
n.qaDebug.openAllMission=false
Mission.DEBUG_DisableUpdateEffectveMission()for n,i in pairs(SsdMissionList.MISSION_ENUM)do
local i=TppDefine.MISSING_NUMBER_MISSION_ENUM[n]if not i then
local n=tonumber(n)e.PermitMissionOpen(n)e.MissionOpen(n)e.UpdateMissionCleardFlag(n)end
end
Mission.SetLocationReleaseState(Mission.LOCATION_RELEASE_STATE_AFGH_AND_MAFR)gvars.str_storySequence=TppDefine.STORY_SEQUENCE.STORY_FINISH
e.UpdateDisplayMissionList()end
if n.qaDebug.allMissionTaskClear then
n.qaDebug.allMissionTaskClear=false
end
if n.qaDebug.setStoryPacing then
n.qaDebug.setStoryPacing=false
e.QARELEASE_DEBUG_SetStoryPacingProduct()end
if n.qaDebug.pacingStage>7 then
n.qaDebug.pacingStage=7
end
if n.qaDebug.pacingStage<0 then
n.qaDebug.pacingStage=0
end
if n.qaDebug.setAfterStoryPacing then
n.qaDebug.setAfterStoryPacing=false
e.QARELEASE_DEBUG_afterStoryPacingSetting(n.qaDebug.pacingStage)n.qaDebug.pacingStage=0
end
end
function e.QARELEASE_DEBUG_SetStoryPacingProduct()if TppPause.IsPausedAny(TppPause.PAUSE_FLAG_GAME_SEQUENCE)then
if mvars.qaDebug then
mvars.qaDebug.setStoryPacing=true
end
return
end
DebugMenu.SetDebugMenuValue(" Craft&Inventory","ClearBaseStorage",true)gvars.DEBUG_reserveAddProductForPacing=true
end
function e.QARELEASE_DEBUG_AddProductForPacing()gvars.DEBUG_reserveAddProductForPacing=false
local function t(e)return SsdStorySequenceList.DEBUG_storySequenceTable[e+1]end
local n=e.GetCurrentStorySequence()for i=TppDefine.STORY_SEQUENCE.STORY_START,n do
local e=t(i)if e then
if e.Equip then
TppPlayer.DEBUG_ProductAndEquipWithTable(e.Equip)end
if e.Skill then
TppPlayer.DEBUG_GetSkills(e.Skill)end
if e.Resource then
TppPlayer.DEBUG_GetResource(e.Resource)end
if e.Exp then
SsdSbm.AddExperiencePoint(e.Exp)end
if e.FastTravel then
SsdFastTravel.RegisterFastTravelPoints()for n,e in ipairs(e.FastTravel)do
SsdFastTravel.UnlockFastTravelPoint(e)local e=SsdFastTravel.GetQuestName(e)if e then
local n=TppQuest.GetQuestIndex(e)if n then
TppQuest.UpdateClearFlag(n,true)end
Mission.RequestClearQuestToServer(TppQuestList.QUEST_DEFINE_IN_NUMBER[e])end
end
end
if e.overrideVarsFunction and(i==n)then
e.overrideVarsFunction()end
end
end
local e={"PRD_CURE_Bleeding","PRD_CURE_Sprain","PRD_CURE_Ruptura","PRD_CURE_Tiredness","PRD_CURE_Weakening","PRD_CURE_Poison_Normal","PRD_CURE_Poison_Deadly","PRD_CURE_Poison_Food","PRD_CURE_Poison_Water"}for n,e in ipairs(e)do
local n=SsdSbm.GetCountProduction{id=e,inInventory=true,inWarehoud=false}if n<5 then
SsdSbm.AddProduction{id=e,toInventory=true,count=(5-n)}end
end
end
function e.QARELEASE_DEBUG_afterStoryPacingSetting(e)if not Tpp.IsTypeNumber(e)then
return
end
if e<1 then
return
end
for e=1,e do
local e=SsdStorySequenceList.DEBUG_afterStoryPacingTable[e]if e then
if e.Recipe and next(e.Recipe)then
for n,e in ipairs(e.Recipe)do
if not SsdSbm.HasRecipe(e)then
SsdSbm.AddRecipe{id=e,count=1,toInventory=false}end
end
end
if e.Exp then
SsdSbm.AddExperiencePoint(e.Exp)end
if e.Skill then
TppPlayer.DEBUG_GetSkills(e.Skill)end
if e.PlayerBaseLevel then
DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelBasic",(e.PlayerBaseLevel))end
if e.PlayerLevelFighter then
DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelFighter",(e.PlayerLevelFighter))end
if e.PlayerLevelShooter then
DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelShooter",(e.PlayerLevelShooter))end
if e.PlayerLevelMedic then
DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelMedic",(e.PlayerLevelMedic))end
if e.PlayerLevelScout then
DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelScout",(e.PlayerLevelScout))end
if e.UniqueCrew then
for n,e in ipairs(e.UniqueCrew)do
local e=SsdCrewSystem.RegisterTempCrew{quest=e}SsdCrewSystem.EmployTempCrew{handle=e}end
end
end
end
end
end
if DebugMenu then
function e.DEBUG_AllMissionOpen()if TppGameSequence.IsMaster()then
return
end
e.DEBUG_SetStorySequence(TppDefine.STORY_SEQUENCE.STORY_FINISH)DebugMenu.SetDebugMenuValue("MotherBaseManagement","SetAll","Set")end
function e.DEBUG_StoryVars()for n,e in pairs(SsdMissionList.MISSION_ENUM)do
if gvars.str_missionOpenPermission[e]then
end
end
for n,e in pairs(SsdMissionList.MISSION_ENUM)do
if gvars.str_missionOpenFlag[e]then
end
end
for n,e in pairs(SsdMissionList.MISSION_ENUM)do
if gvars.str_missionClearedFlag[e]then
end
end
end
end
return e