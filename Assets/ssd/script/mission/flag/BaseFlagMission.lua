local e={}local T=Fox.StrCode32
local g=Tpp.StrCode32Table
local h=GameObject.NULL_ID
local S=GameObject.GetGameObjectId
local v=GameObject.SendCommand
local n=Tpp.IsTypeTable
local t=Tpp.IsTypeString
local d=Tpp.IsTypeFunc
local u=Tpp.IsTypeNumber
local a="p01_000010"local C="_isPlayedEnterMissionAreaRadio"e.CLEAR_JINGLE_TYPE=Tpp.Enum{"CRAFT","BATTLE","NONE"}e.CLEAR_JINGLE_NAME=Tpp.Enum{"Play_SSD_Jingle_msn_comp_lt","Play_SSD_Jingle_msn_comp_hd",""}local _=function(i,a)if d(a.IsActive)and not a.IsActive(a)then
return
end
local e=a.markerList
if t(e)then
e={e}end
if e then
for a,e in ipairs(e)do
if n(e)then
TppMarker.Enable(e.name,e.visibleArea,e.goalType,e.viewType,e.randomRange,e.setImportant,e.setNew,e.mapTextId,e.guidelinesId)elseif t(e)then
TppMarker.Enable(e,0,"moving","all",0,true,true)end
end
end
local e=a.gimmickMarkerTableList
if n(e)then
for n,e in ipairs(e)do
local a,n=Gimmick.GetGameObjectId(e.type,e.locatorName,e.datasetName)if not Gimmick.IsBrokenGimmick(e.type,e.locatorName,e.datasetName)then
TppMarker.Enable(n,0,"moving","all",0,true,true)end
end
end
if d(a.OnEnter)then
a.OnEnter()end
if a.onEnterRadio and i~="trap_base"then
TppRadio.Play(a.onEnterRadio)end
end
local b=function(o,a)local i=a.markerList
if t(i)then
i={i}elseif i==nil then
i={}end
if not d(a.IsActive)or a.IsActive(a)then
for a,e in ipairs(i)do
if n(e)then
TppMarker.Enable(e.name,e.visibleArea,e.goalType,e.viewType,e.randomRange,e.setImportant,e.setNew,e.mapTextId,e.guidelinesId)elseif t(e)then
TppMarker.Enable(e,0,"moving","all",0,true,true)end
end
else
for n,e in ipairs(i)do
TppMarker.Disable(e)end
end
local e=a.gimmickMarkerTableList
if n(e)then
for n,e in ipairs(e)do
local n,e=Gimmick.GetGameObjectId(e.type,e.locatorName,e.datasetName)TppMarker.Disable(e,nil,true)end
end
if d(a.IsActive)and not a.IsActive(a)then
return
end
if d(a.OnExit)then
a.OnExit()end
if a.onExitRadio and o~="trap_base"then
TppRadio.Play(a.onExitRadio)end
end
local l=function(a)if t(a)then
return{a}elseif n(a)then
if t(a.name)then
return{a}else
return a
end
end
return{}end
e.baseStep={OnEnter=function(a)local s=mvars.currentFlagMissionName
local r=a.stepName
if n(mvars.markerTrapMessageTable)then
for e,n in pairs(mvars.markerTrapMessageTable)do
if d(n.IsActive)and not n.IsActive(n)then
local e=n.markerList
if t(e)then
e={e}elseif e==nil then
e={}end
for n,e in ipairs(e)do
TppMarker.Disable(e,nil,true)end
local e=n.gimmickMarkerTableList
if t(e)then
e={e}end
if e then
for n,e in ipairs(e)do
local n,e=Gimmick.GetGameObjectId(e.type,e.locatorName,e.datasetName)TppMarker.Disable(e,nil,true)end
end
end
end
end
mvars.bfm_stepNameIfOutOfDefenseArea=nil
local i=a.options
if n(i)then
if i.stepNameIfOutOfDefenseArea then
e.SetUpWaveSettings()mvars.bfm_stepNameIfOutOfDefenseArea=i.stepNameIfOutOfDefenseArea
end
local r,s,o=i.radio,i.continueRadio,i.continueRadioConditionVarsName
if r or s then
local function d(e)if not e then
return true
end
return(not fvars[e])end
local function l(a)if not a then
return
end
local i,t=true,nil
if n(a)then
if n(a.options)and a.options.isOnce then
t=a.name
if mvars.bfm_playedRadioList[t]then
i=false
end
end
end
if i then
e.PlayRadio(a)if t then
mvars.bfm_playedRadioList[t]=true
end
end
end
if d(o)then
l(r)if o then
fvars[o]=true
end
else
l(s)end
end
local o=l(i.marker)for a,e in ipairs(o)do
if n(e)then
local s=e.name
local o=e.goalType or"moving"local i=e.viewType or"all"local t=e.randomRange or 0
local l=e.setImportant or true
local r=e.setNew or true
local n=e.areaName or mvars.fms_defaltMissionAreaName
local a=true
local d=e.mapTextId
local c=e.guideLinesId
if mvars.fms_missionAreaMarkerList and mvars.fms_missionAreaMarkerList[n]then
local e=mvars.fms_missionAreaMarkerList[n]local n=T(e)a=(not TppGameStatus.IsSetBy(e,"S_IN_MISSION_AREA"))or mvars.fms_missionAreaInvalidList[n]end
TppMarker.RegisterMissionMarker(s,n,0,o,i,t,l,r,a,d,c)elseif t(e)then
local n=true
if(mvars.fms_missionAreaMarkerList and mvars.fms_defaltMissionAreaName)and mvars.fms_missionAreaMarkerList[mvars.fms_defaltMissionAreaName]then
local e=mvars.fms_missionAreaMarkerList[mvars.fms_defaltMissionAreaName]local a=T(e)n=(not TppGameStatus.IsSetBy(e,"S_IN_MISSION_AREA"))or mvars.fms_missionAreaInvalidList[a]end
TppMarker.RegisterMissionMarker(e,mvars.fms_defaltMissionAreaName,0,"moving","all",0,true,true,n)end
end
local o=i.recipe
if t(o)then
o={o}end
if n(o)then
for n,e in ipairs(o)do
if not SsdSbm.HasRecipe(e)then
SsdSbm.AddRecipe(e)end
end
end
local o=i.archive
if o then
a.GetArchiveCheck=true
end
local o=i.route
if n(o)then
for n,e in ipairs(o)do
if((((not e.enemyType or e.enemyType=="SsdZombie")or e.enemyType=="SsdZombieBom")or e.enemyType=="SsdZombieDash")or e.enemyType=="SsdZombieShell")or e.enemyType=="SsdZombieArmor"then
TppEnemy.SetZombieSneakRoute(e.enemyName,e.enemyType,e.routeName)else
TppEnemy.SetInsectSneakRoute(e.enemyName,e.enemyType,e.routeName)end
end
end
local o=i.breakBody
if n(o)then
for n,e in ipairs(o)do
TppEnemy.SetBreakBody(e.enemyName,e.enemyType,e.armR,e.armL,e.legR,e.legL)end
end
local o=i.waveWalkSpeed
if n(o)then
for n,e in ipairs(o)do
TppEnemy.SetZombieWaveWalkSpeed(e.enemyName,e.enemyType,e.speed)end
end
local o=i.objective
if t(o)then
o={o}end
if n(o)then
MissionObjectiveInfoSystem.Open()local a={}for i,e in ipairs(o)do
if t(e)then
MissionObjectiveInfoSystem.SetParam{index=i-1,langId=e}elseif n(e)then
table.insert(a,{langId=e.langId,facilityType=e.facilityType,facilityMenuType=e.facilityMenuType,productionIdCode=e.productionIdCode})end
end
if next(a)then
MissionObjectiveInfoSystem.SetTable(a)end
for e=#o+1,5 do
MissionObjectiveInfoSystem.SetParam{index=e-1}end
end
local o=i.fastTravelPoint
if o then
SsdFastTravel.UnlockFastTravelPoint(o)end
local o=i.enableEnemy
if t(o)then
o={o}end
if n(o)then
for a,e in ipairs(o)do
local e=e
local a="SsdZombie"if n(e)and t(e.name)then
e=e.name
a=e.type
end
if t(e)then
TppEnemy.SetEnablePermanent(e,a)end
end
end
local o=i.disableEnemy
if t(o)then
o={o}end
if n(o)then
for a,e in ipairs(o)do
local e=e
local a="SsdZombie"if n(e)and t(e.name)then
e=e.name
a=e.type
end
if t(e)then
TppEnemy.SetDisablePermanent(e,a)end
end
end
if i.diggerReward then
GkEventTimerManager.Start("Timer_OpenRewardWhormhole",5)end
local t=i.vanishDigger
if n(t)then
mvars.bfm_diggerReward=t
GkEventTimerManager.Start("Timer_CloseRewardWhormhole",5)end
if i.setUpWaveSettings then
e.SetUpWaveSettings()end
local e=i.OnEnter
if d(e)then
e(a)end
end
local i=a.clearConditionTable
if n(i)then
local o=i.demo
if o then
local n,t,a=e.GetDemoParameter(o,a.demoOnEndFunctionTable)if n then
e.LoadRegisteredMissionDemoBlock()TppDemo.AddDemo(n,n)TppDemo.Play(n,a,t)end
end
local o=i.searchDemo
if n(o)then
local e=a.demoOnEndFunctionTable.commonSearchDemo
TppDemo.PlayCommonSearchDemo({onEnd=e},o.identifier,o.key,{useDemoBlock=true,finishFadeOut=true},true)end
local o=i.kill
if n(o)then
local n,t,r,i,o=e.GetStepAnnihilationParams(r)if n then
e.InitializeStepAnnihilationTarget(t,r,i,o)a.needGoToNextStepCheck=true
a.needGoToNextStepConditionVarsName=t
if DebugText then
mvars.bfm_DEBUG_stepAnnihilationTable=n
end
end
end
local o=i.wave
if n(o)then
local n=o.waveName
if n then
e.SetUpWaveSettings()local e=o.maxWaveCount
if Tpp.IsTypeNumber(e)then
Mission.SetWaveCount(e)end
local e=TppMission.GetWaveProperty(n)if e and e.defenseGameType==TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE then
local e=e.defenseTargetGimmickProperty.identificationTable.digger
Gimmick.SetAction{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName,action="Open"}mvars.bfm_diggerBooting=true
else
TppMission.StartInitialWave(n)end
end
end
local o=i.tips
if n(o)then
if not d(o.endFunction)then
function o.endFunction()a.GoToNextStepIfConditionCleared(a)end
end
TppTutorial.StartHelpTipsMenu(o)end
local o=i.completeCraft
if n(o)then
local n=tostring(s)..("_"..(tostring(r).."_completeCraft"))mvars.bfm_checkCraftStepCoroutine=e.CreateCheckCraftStepCoroutine(o,n)end
local o=i.collect
if n(o)then
for t,n in ipairs(o)do
if e.IsClearCollectCondition(n)then
local e=n.conditionVarsName
fvars[e]=true
a.GoToNextStepIfConditionCleared(e)end
end
end
local o=i.switch
if n(o)then
for a,n in pairs(o)do
local o=n.gimmickId
local a=n.locatorName
local i=n.datasetName
local d=n.isPowerOn or false
local l=n.isAlertLockType or false
local r=e.getSwitchConditionVarsName(s,r,a)if(t(o)and t(a))and t(i)then
if d==true then
local e=false
if fvars[r]then
e=true
end
Gimmick.SetSsdPowerOff{gimmickId=o,name=a,dataSetName=i,powerOff=e}end
if l==true then
Gimmick.SetAlertLockType{gimmickId=o,name=a,dataSetName=i,isAlertLockType=true}end
end
local e=n.memoryBoardDemo
if e then
TppGimmick.AddMemoryBoardUnitInterferer(e.identifier,e.key)end
end
end
local n=i.home
if n then
if TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")then
local e=tostring(s)..("_"..(tostring(r).."_home"))fvars[e]=true
a.needGoToNextStepCheck=true
a.needGoToNextStepConditionVarsName=e
end
end
local n=i.blackRadio
if n then
if a.blackRadioWork then
a.blackRadioWork.StartBlackRadioStep()if a.blackRadioWork.PlayBlackRadioStartRadio then
a.blackRadioWork.PlayBlackRadioStartRadio()else
a.blackRadioWork.StartBlackRadioFadeOut()end
end
end
local n=i.carry
if n then
for n,e in ipairs(n)do
local e=e.locatorName
local n=mvars.fms_rescueTargetUniqueCrewTable[e]if n then
if SsdCrewSystem.IsUniqueCrewExist{uniqueType=n}then
local e=tostring(s)..("_"..(tostring(r)..("_carry_"..tostring(e))))fvars[e]=true
a.needGoToNextStepCheck=true
a.needGoToNextStepConditionVarsName=e
end
end
end
end
local n=i.rescue
if n then
for n,e in ipairs(n)do
local n=e.locatorName
local e=mvars.fms_rescueTargetUniqueCrewTable[n]if e then
if SsdCrewSystem.IsUniqueCrewExist{uniqueType=e}then
local e=tostring(s)..("_"..(tostring(r)..("_rescue_"..tostring(n))))fvars[e]=true
a.needGoToNextStepCheck=true
a.needGoToNextStepConditionVarsName=e
end
end
end
end
local n=i.clearStage
if n then
TppGameStatus.Set("FmsMissionClear","S_DISABLE_PLAYER_PAD")e.OnStartClearSequence(n)end
end
e.RestoreCheckRegisteredStepMissionObjective(a.stepMissionObjectiveTable)end,OnLeave=function(a)if a.blackRadioWork then
a.blackRadioWork.FinishBlackRadioStep()end
local i=a.clearConditionTable
if n(i)then
local o=i.wave
if n(o)then
TppMission.OnClearDefenseGame()TppMission.StopDefenseGame()TppQuest.UpdateTerminalDisplayQuest(true)end
local o=i.kill
if n(o)then
local t,i,n,a,i=e.GetStepAnnihilationParams(a.stepName)if t then
e.FinalizeStepAnnihilationTarget(n,a)if DebugText then
mvars.bfm_DEBUG_stepAnnihilationTable=nil
end
end
end
local e=i.switch
if n(e)then
for n,e in pairs(e)do
local n=e.gimmickId
local a=e.locatorName
local i=e.datasetName
local o=e.isPowerOn or false
local e=e.isAlertLockType or false
if(t(n)and t(a))and t(i)then
if o==true then
Gimmick.SetSsdPowerOff{gimmickId=n,name=a,dataSetName=i,powerOff=true}end
if e==true then
Gimmick.SetAlertLockType{gimmickId=n,name=a,dataSetName=i,isAlertLockType=false}end
end
end
end
end
local t=a.options
if n(t)then
local i=t.onLeaveRadio
if i then
e.PlayRadio(i)end
local e=l(t.marker)for a,e in ipairs(e)do
local a
if n(e)then
a=e.name
else
a=e
end
local n=mvars.fms_defaltMissionAreaName
if e.areaName then
n=e.areaName
end
TppMarker.UnregisterMissionMarker(a,n)end
local e=t.OnLeave
if d(e)then
e(a)end
end
end}function e.AddMessage(e,n)if not e then
e={}end
for n,a in pairs(n)do
if not e[n]then
e[n]={}end
for t,a in ipairs(a)do
table.insert(e[n],a)end
end
return e
end
function e.AddSaveVarsList(e,a)if not n(e.saveVarsList)then
e.saveVarsList={}end
for a,n in ipairs(a)do
table.insert(e.saveVarsList,n)end
end
function e.RegisterStepMissionObjective(i,a,e)if not n(e)then
return
end
local e=e.checkObjective
if not e then
return
end
if t(e)then
objective={e}elseif not n(e)then
return
end
i[a]=e
end
function e.RestoreCheckRegisteredStepMissionObjective(n)for a,n in pairs(n)do
if fvars[a]then
e.CheckObjective(n)end
end
end
function e.CheckRegisteredStepMissionObjective(a,n)if not n then
return
end
local a=a[n]if not a then
return
end
if fvars[n]then
e.CheckObjective(a)end
end
function e.OnStartClearSequence(a)if mvars.bfm_finishedClearSequence then
return
end
if n(a)then
mvars.bfm_clearStageTable=a
else
mvars.bfm_clearStageTable={}end
mvars.bfm_clearSequenceCoroutine=coroutine.create(e.ClearSequenceCoroutine)mvars.bfm_finishedClearSequence=true
end
function e.ClearSequenceCoroutine()local function t(e)if DebugText then
DebugText.Print(DebugText.NewContext(),tostring(e))end
end
local i=false
if TppPlayer.IsFastTravelingAndWarpEnd()then
i=true
TppPlayer.AddFastTravelOption{noFadeIn=true}while TppPlayer.IsFastTravelingAndWarpEnd()do
t"BaseFlagMission.ClearSequenceCoroutine: Now waiting fast travel fadeIn."coroutine.yield()end
end
while TppDemo.IsPlayingRescueDemo()do
i=true
t"BaseFlagMission.ClearSequenceCoroutine: Now waiting fininish rescue demo."coroutine.yield()end
local n,a,o
if mvars.bfm_clearStageTable.demo then
local function t()mvars.bfm_isPlayingClearStageDemo=nil
end
n,a,o=e.GetDemoParameter(mvars.bfm_clearStageTable.demo,t)end
if n then
e.LoadRegisteredMissionDemoBlock()if not i then
local n=mvars.bfm_clearStageTable.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
TppUI.FadeOut(n,"BfmClearStageDemoFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM)local a=Time.GetRawElapsedTimeSinceStartUp()local e=0
while(e<n)do
t("BaseFlagMission.ClearSequenceCoroutine: waiting fade out. remainfadeOutWaitTime = "..tostring(e))coroutine.yield()e=Time.GetRawElapsedTimeSinceStartUp()-a
end
end
mvars.bfm_isPlayingClearStageDemo=n
SsdBuildingMenuSystem.CloseBuildingMenu()SsdUiSystem.RequestForceCloseForMissionClear()if not TppLocation.IsAfghan()and n=="p01_000010"then
local e,a=Tpp.GetLocatorByTransform("DataIdentifier_f30020_sequence","openingDemoPosition")DemoDaemon.SetDemoTransform(n,a,e)end
if not TppLocation.IsAfghan()and n=="p01_000020"then
local e,a=Tpp.GetLocatorByTransform("DataIdentifier_f30020_sequence","aiDemoPosition")DemoDaemon.SetDemoTransform(n,a,e)end
TppDemo.AddDemo(n,n)a.finishFadeOut=true
a.waitBlockLoadEndOnDemoSkip=false
TppDemo.Play(n,o,a)while mvars.bfm_isPlayingClearStageDemo do
t("BaseFlagMission.ClearSequenceCoroutine: Now waiting fininish clear stage demo. demoId = "..tostring(mvars.bfm_isPlayingClearStageDemo))coroutine.yield()end
end
return true
end
function e.OnUpdateClearSequenceCoroutine()if mvars.bfm_clearSequenceCoroutine then
local n,a=coroutine.resume(mvars.bfm_clearSequenceCoroutine)if not n then
e.OnClearSequenceFinished()return
end
if(coroutine.status(mvars.bfm_clearSequenceCoroutine)=="dead")then
e.OnClearSequenceFinished()end
end
end
function e.OnClearSequenceFinished()mvars.bfm_clearSequenceCoroutine=nil
mvars.bfm_clearStageTable=nil
Player.ResetPadMask{settingName="OnFlagMissionClear"}SsdBuildingMenuSystem.CloseBuildingMenu()SsdUiSystem.RequestForceCloseForMissionClear()SsdFlagMission.ClearWithSave(TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR,mvars.currentFlagMissionName)mvars.currentFlagMissionName=nil
end
function e.CheckObjective(e)if t(e)then
e={e}end
if n(e)then
for n,e in ipairs(e)do
MissionObjectiveInfoSystem.Check{langId=e,checked=true}end
end
end
function e.GetNameFromStringOrTable(e)if t(e)then
return e
end
if n(e)and t(e.name)then
return e.name
end
end
function e.GetLocatorName(e)if n(e)and t(e.locatorName)then
return e.locatorName
end
end
function e.getSwitchConditionVarsName(a,n,t)return tostring(a)..("_"..(tostring(n)..("_switch_"..tostring(t))))end
e.NEED_SET_DEMOTRANSFORM={p01_000030=true}function e.GetDemoParameter(a,r)local o,l,i=nil,{isSnakeOnly=true},nil
local function s(t,a)if not a then
return
end
local e
if n(a)then
e=a[t]else
e=a
end
if not d(e)then
return
end
return{onEnd=e}end
if t(a)then
o=a
i=s(o,r)elseif n(a)then
if not t(a.demoName)then
return
end
o=a.demoName
if n(a.options)then
for n,e in pairs(a.options)do
l[n]=e
end
end
i=s(o,r)local e=e.NEED_SET_DEMOTRANSFORM[o]if i then
if n(a.funcs)then
if e then
if not d(a.funcs.SetDemoTransform)then
return
end
local e=a.funcs.SetDemoTransform
local n=a.funcs.onInit
local function i()local e,t=e()if(e==nil)then
e=TppGimmick.AFGH_BASE_AI_POSITION
end
DemoDaemon.SetDemoTransform(o,t,e)if n then
n()end
end
a.funcs.onInit=i
end
for n,e in pairs(a.funcs)do
if not d(e)then
return
end
if(n=="onEnd")then
local a=i.onEnd
local n=e
local function e()n()a()end
i.onEnd=e
else
i[n]=e
end
end
end
end
else
return
end
return o,l,i
end
function e.AddStepWithTable(a)if not n(a)then
return
end
local i,t,o,r,n
i=a.flagMissionInstance
t=a.addStepName
o=a.nextStepName
r=a.clearConditionTable
n=a.options or{}n.OnEnter=a.OnEnter
n.OnLeave=a.OnLeave
n.AddOnUpdate=a.AddOnUpdate
n.previousStep=a.previousStep
return e.AddStep(i,t,o,r,n)end
function e.AddStep(o,a,b,r,m)if not n(o)then
return
end
local s=o.missionName
local l
if t(a)then
if o.flagStep[a]then
end
if not n(o.stepList)then
o.stepList={}end
table.insert(o.stepList,a)else
return
end
local f={}local c={}local T={}local h={}local u={}local p={}local i
local v
local S
if n(r)then
local d=r.demo
if d then
local t=e.GetDemoParameter(d)if t then
local n=tostring(s)..("_"..(tostring(a)..("_demo_"..tostring(t))))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)u[t]=function()fvars[n]=true
l:GoToNextStepIfConditionCleared(n)end
end
end
local d=r.searchDemo
if n(d)then
local n=tostring(s)..("_"..(tostring(a).."_searchDemo"))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)function u.commonSearchDemo()fvars[n]=true
l:GoToNextStepIfConditionCleared(n)end
e.RegisterStepMissionObjective(p,n,d)end
local d=r.trap
if t(d)or n(d)then
local n,i
if t(d)then
n=d
i=d
else
n=d[1]i=d
end
local n=tostring(s)..("_"..(tostring(a)..("_trap_"..tostring(n))))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)e.AddMessage(f,{Trap={{sender=i,msg="Enter",func=function(a,e)if Tpp.IsPlayer(e)then
fvars[n]=true
l:GoToNextStepIfConditionCleared(n)end
end,option={isExecFastTravel=true}}}})end
local d=r.exitTrap
if n(d)then
if n(d.trapList)then
local t=d.messageOptions or{isExecFastTravel=true}local n,i=d.trapList[1],d.trapList
local n=tostring(s)..("_"..(tostring(a)..("_exitTrap_"..tostring(n))))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)e.AddMessage(f,{Trap={{sender=i,msg="Exit",func=function(a,e)if Tpp.IsPlayer(e)then
fvars[n]=true
l:GoToNextStepIfConditionCleared(n)end
end,option=t}}})end
end
local d=r.home
if d then
local n=tostring(s)..("_"..(tostring(a).."_home"))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)e.RegisterStepMissionObjective(p,n,d)local function e()l:GoToNextStepIfConditionCleared(n)end
local function t()fvars[n]=true
l:GoToNextStepIfConditionCleared(n)local e={}if l.isNextClear then
e.isDefiniteFlagMissionClear=true
end
return e
end
BaseMissionSequence.RegisterEnterBaseCheckPointCallback(a,t)end
local d=r.kill
if n(d)then
local n=tostring(s)..("_"..(tostring(a).."_kill_remain_count"))local i,t=e.InitializeStepAnnihilationTable(a,d,n)if i then
e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_UINT32,value=t,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)e.AddMessage(f,{GameObject={{msg="Dead",func=function(t)e.OnDeadCheckMissionTargetAnnihilation(t,l,a,mvars.defenseFlagMission,n)end}}})end
end
local d=r.putDigger
mvars.bfm_putDiggerConditionVarsName=nil
if n(d)then
local a=tostring(s)..("_"..(tostring(a).."_putDigger"))e.AddSaveVarsList(o,{{name=a,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,a)e.RegisterStepMissionObjective(p,a,d)d.conditionVarsName=a
local function t(i,t,t)local t=Gimmick.SsdGetGameObjectId(d)if(i==t)then
fvars[a]=true
l:GoToNextStepIfConditionCleared(a)local e=o.waveSettings
if n(e)then
TppMission.ShowPrepareInitWaveUI(e.waveList[1])end
end
end
e.AddMessage(f,{GameObject={{msg="BuildingEnd",func=t,option={isExecFastTravel=true}}}})end
local d=r.switch
if n(d)then
local function r(i)if not n(i)then
return
end
local n=i.locatorName
if not t(n)then
return
end
local n=e.getSwitchConditionVarsName(s,a,n)e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)e.RegisterStepMissionObjective(p,n,i)end
for n,e in pairs(d)do
r(e)end
local function c(i,a)local function t(a,t,e)if not n(e)then
return
end
local e=Gimmick.SsdGetGameObjectId{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName}if a==e then
return true
else
return false
end
end
for n,e in ipairs(d)do
if t(i,a,e)then
return true,e
end
end
end
local function r(e)if not n(e)then
return
end
if(e.isPowerOn==true)then
Gimmick.SetSsdPowerOff{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,powerOff=true}end
end
local function i(n)local e=e.getSwitchConditionVarsName(s,a,n.locatorName)r(n)fvars[e]=true
l:GoToNextStepIfConditionCleared(e)end
local t
local function o(e,n)Gimmick.InvisibleModel{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,isInvisible=(not n)}end
local function s(e,a,o,o)local a,e=c(e,a)if a then
local a=e.memoryBoardDemo
if n(a)then
t=e
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"OnSwitchGimmickMemoryBoardDemoFadeOut")else
i(e)end
end
end
local function l(a,a)local a=t
if not n(a)then
return
end
local n=a.memoryBoardDemo
local function s()i(a)t=nil
end
r(a)o(a,false)e.PlayGetMemoryBoardDemo(n,s,n.afterDemoFunc)end
e.AddMessage(f,{GameObject={{msg="SwitchGimmick",func=s}},UI={{msg="EndFadeOut",sender="OnSwitchGimmickMemoryBoardDemoFadeOut",func=l}},Demo={{msg="p01_000040_gameModelOn",func=function()local e=t
if not n(e)then
return
end
o(e,true)end,option={isExecDemoPlaying=true}}}})end
if n(r.wave)then
local t=tostring(s)..("_"..(tostring(a).."_wave"))e.AddSaveVarsList(o,{{name=t,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,t)e.RegisterStepMissionObjective(p,t,r.wave)local a=r.wave.waveName
S=a
local i=r.wave.onClearRadio
local function o()TppMission.OnClearDefenseGame()local n=TppMission.GetWaveProperty(a)if i then
e.PlayRadio(i)end
local e=n.endEffectName or"explosion"TppEnemy.KillWaveEnemy{effectName=e,soundName="sfx_s_waveend_plasma"}fvars[t]=true
if n.defenseGameType==Mission.DEFENSE_TYPE_ENEMY_BASE then
TppMission.StopDefenseGame()else
TppMission.StopDefenseTotalTime()end
TppMusicManager.PostJingleEvent2("SingleShot","DefenseResult")l:GoToNextStepIfConditionCleared(t)end
local function d()local e=TppMission.GetCurrentWaveName()if not e then
return
end
local e=TppMission.GetWaveProperty(e)if e.isTerminal then
o()else
TppMission.StartWaveInterval{useWaveProperty=true}end
end
local function l()local e=TppMission.GetWaveProperty(a)local e=e.defenseTargetGimmickProperty.identificationTable.digger
Gimmick.SetAction{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName,action="Open"}mvars.bfm_diggerBooting=true
end
local function i()local e=TppMission.GetWaveProperty(a)if e.defenseGameType~=TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE then
return
end
if not TppMission.GetCurrentWaveName()then
TppMission.StartInitialWave(a)else
TppMission.StartNextWave()end
end
local function s()TppDataUtility.DestroyEffectFromGroupId"singularity"TppDataUtility.CreateEffectFromGroupId"destroy_singularity"end
local t=r.wave.defenseGameArea
if n(t)then
TppMission.RegisterDefenseGameArea(t.areaTrapName,t.alertTrapName,a)end
e.AddMessage(f,{GameObject={{msg="FinishWave",func=d},{msg="StartRebootDigger",func=l},{msg="DiggingStartEffectEnd",func=i},{msg="FinishDefenseGame",func=o},{msg="DiggerShootEffect",func=function()GkEventTimerManager.Start("Timer_DestroySingularityEffect",.9)end}},Timer={{msg="Finish",sender="Timer_DestroySingularityEffect",func=s}}})mvars.defenseFlagMission=true
end
local d=r.carry
if n(d)then
local i={}for n,t in ipairs(d)do
local n=e.GetLocatorName(t)table.insert(i,n)local n=tostring(s)..("_"..(tostring(a)..("_carry_"..tostring(n))))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)e.RegisterStepMissionObjective(p,n,t)end
e.AddMessage(f,{GameObject={{msg="Carried",func=function(n,t)for i,t in ipairs(d)do
local e=e.GetLocatorName(t)if n==GameObject.GetGameObjectId(e)then
local e=tostring(s)..("_"..(tostring(a)..("_carry_"..tostring(e))))fvars[e]=true
TppUI.ShowAnnounceLog"recoverTarget"l:GoToNextStepIfConditionCleared(e)end
end
end}}})end
local d=r.rescue
if n(d)then
local r={}for i,t in ipairs(d)do
local i=e.GetLocatorName(t)table.insert(r,i)local a=tostring(s)..("_"..(tostring(a)..("_rescue_"..tostring(i))))e.AddSaveVarsList(o,{{name=a,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,a)e.RegisterStepMissionObjective(p,a,t)if t.rescueDemo and not n(t.rescueDemo)then
end
end
local function r()for t,n in ipairs(d)do
local t=e.GetLocatorName(n)if TppEnemy.GetStatus(t)==TppGameObject.NPC_STATE_CARRIED then
local a=tostring(s)..("_"..(tostring(a)..("_rescue_"..tostring(t))))fvars[a]=true
local function o()if n and n.checkObjective then
e.CheckObjective(n.checkObjective)end
end
local function i()l:GoToNextStepIfConditionCleared(a)end
local n=n.rescueDemo
local a,e,i=e.GetDemoParameter(n,i)TppDemo.PlayRescueDemo(a,t,o,i,e,n.rescueDemoOptions)local e={}if l.isNextClear then
e.isDefiniteFlagMissionClear=true
end
return e
end
end
end
BaseMissionSequence.RegisterEnterBaseCheckPointCallback(a,r)mvars.bfm_needCrewRegister=true
end
local d=r.completeCraft
if n(d)then
local n=tostring(s)..("_"..(tostring(a).."_completeCraft"))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)mvars.bfm_clearJingleType=e.CLEAR_JINGLE_TYPE.CRAFT
end
local d=r.collect
if n(d)then
local n=function(e)return tostring(s)..("_"..(tostring(a)..("_collect_"..tostring(e))))end
local r=function(e)return tostring(s)..("_"..(tostring(a)..("_collect_craftReadyRadio_"..tostring(e))))end
local i=function(e)return tostring(s)..("_"..(tostring(a)..("_collect_afterCraftRadio_"..tostring(e))))end
for a,t in ipairs(d)do
local n=n(a)local r=r(a)local a=i(a)e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name=r,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name=a,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)e.RegisterStepMissionObjective(p,n,t)t.conditionVarsName=n
end
local n=function()local a=false
for o,n in ipairs(d)do
if e.IsClearCollectCondition(n)then
local e=n.conditionVarsName
fvars[e]=true
a=l:GoToNextStepIfConditionCleared(e)if a then
return
end
local e=i(o)if t(n.afterCollectionRadio)and not fvars[e]then
TppRadio.Play(n.afterCollectionRadio,{isEnqueue=true})fvars[e]=true
end
end
end
for n,e in ipairs(d)do
local n=r(n)if((t(e.craftReadyRadio)and(not fvars[n]))and t(e.recipe))and SsdSbm.CheckCostToPay(e.recipe)then
TppRadio.Play(e.craftReadyRadio,{isEnqueue=true})fvars[n]=true
end
end
end
e.AddMessage(f,{Sbm={{msg="OnGetItem",func=n}}})mvars.bfm_clearJingleType=e.CLEAR_JINGLE_TYPE.CRAFT
end
local t=r.blackRadio
if t then
i=e.CheckBlackRadioParameter(t)if i then
local n=tostring(s)..("_"..(tostring(a).."_blackRadio"))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(c,n)e.RegisterStepMissionObjective(p,n,t)i.conditionVarsName=n
local n="Timer_BlackRadioStartGuaranteeTimer"function i.StartBlackRadioStep()TppUiStatusManager.SetStatus("PauseMenu","INVALID")Player.SetPadMask{settingName="BfmBlackRadioStep",except=true,buttons=(PlayerPad.RELOAD+PlayerPad.HOLD)+PlayerPad.FIRE,sticks=PlayerPad.STICK_L+PlayerPad.STICK_R}vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA+PlayerDisableAction.BASE_FACILITY
TppUI.SetDefenseGameMenu()i.currentBlackRadioIndex=1
i.ReadCurrentBlackRadioJsonParameter()i.isFinishFadeOut=nil
i.isPlayedStartRadio=nil
TppSoundDaemon.SetKeepBlackRadioEnable(true)end
function i.FinishBlackRadioStep()Player.ResetPadMask{settingName="BfmBlackRadioStep"}TppPlayer.ResetDisableAction()TppUI.UnsetDefenseGameMenu()TppSoundDaemon.SetKeepBlackRadioEnable(false)end
function i.StartBlackRadioFadeOut()if i.isFinishFadeOut then
return
end
if GkEventTimerManager.IsTimerActive(n)then
GkEventTimerManager.Stop(n)end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"StartBlackRadioFadeOut")i.isFinishFadeOut=true
end
function i.ReadCurrentBlackRadioJsonParameter()local n=i.blackRadioList[i.currentBlackRadioIndex]if n then
BlackRadio.ReadJsonParameter(n)end
end
e.AddMessage(f,{UI={{msg="EndFadeOut",sender="StartBlackRadioFadeOut",func=function()TppRadio.StartBlackRadio()end},{msg="BlackRadioClosed",func=function()if(i.currentBlackRadioIndex>=#i.blackRadioList)then
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"FinishBlackRadioFadeIn")else
i.currentBlackRadioIndex=i.currentBlackRadioIndex+1
i.ReadCurrentBlackRadioJsonParameter()GkEventTimerManager.Start("Timer_WaitReadJsonParameter",2)end
end},{msg="EndFadeIn",sender="FinishBlackRadioFadeIn",func=function()local e=i.conditionVarsName
fvars[e]=true
l:GoToNextStepIfConditionCleared(e)end}},Timer={{msg="Finish",sender="Timer_WaitReadJsonParameter",func=function()TppRadio.StartBlackRadio()end}}})if i.startRadio then
function i.PlayBlackRadioStartRadio()if i.isPlayedStartRadio then
return
end
e.PlayRadio(i.startRadio)if GkEventTimerManager.IsTimerActive(n)then
GkEventTimerManager.Stop(n)end
GkEventTimerManager.Start(n,i.startGuaranteeTimerSec)i.isPlayedStartRadio=true
end
e.AddMessage(f,{Radio={{msg="Finish",sender=i.startRadio,func=function(e)i.StartBlackRadioFadeOut()end,option={isExecFastTravel=true}}},Timer={{msg="Finish",sender=n,func=function()i.StartBlackRadioFadeOut()end,option={isExecFastTravel=true}}}})end
end
end
end
if mvars.bfm_playedRadioList==nil then
mvars.bfm_playedRadioList={}end
if n(m)then
if n(m.previousStep)then
local e=m.previousStep
e.nextStepName=a
if n(r)and r.clearStage then
e.isNextClear=true
end
end
local function i(e)if(n(e)and n(e.options))and e.options.isOnce then
local e=e.name
mvars.bfm_playedRadioList[e]=false
end
end
i(m.radio)if m.continueRadio then
local n=m.continueRadio
i(n)local n=tostring(s)..("_"..(tostring(a).."_isContinued"))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(T,n)m.continueRadioConditionVarsName=n
end
local i=m.trap
if n(i)then
for i,r in ipairs(i)do
local i=r.name
if t(i)then
i={i}end
if n(i)and t(i[1])then
local n=tostring(s)..("_"..(tostring(a)..("_option_trap_"..tostring(i[1]))))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(T,n)e.AddMessage(f,{Trap={{sender=i,msg="Enter",func=function()if not fvars[n]then
local a=r.radio
if a then
TppRadio.Play(a)end
e.CheckObjective(r.objective)fvars[n]=true
end
end,option={isExecFastTravel=true}}}})end
end
end
local t=m.repopResourceIfMateialInsufficient
if n(t)then
local e=false
if((n(t.checkMaterialList)and(#t.checkMaterialList>0))and n(t.repopSettingList))and(#t.repopSettingList>0)then
e=true
for a,n in ipairs(t.checkMaterialList)do
if not n.id then
e=false
break
end
if not n.count then
e=false
break
end
end
for a,n in ipairs(t.repopSettingList)do
if not n.gimmickId then
e=false
break
end
if not n.locatorName then
e=false
break
end
if not n.datasetName then
e=false
break
end
end
end
if e then
local function i()local e=true
for a,n in ipairs(t.checkMaterialList)do
local a=SsdSbm.GetCountResource{id=n.id,inInventory=true,inWarehouse=true,inLostCbox=true}e=e and(a<n.count)if not e then
break
end
end
if e and d(t.checkFunction)then
e=t.checkFunction()end
if e then
for n,e in ipairs(t.repopSettingList)do
local n=e.gimmickId
local a=e.locatorName
local e=e.datasetName
Gimmick.ResetGimmick(0,a,e,{gimmickId=n})end
end
end
BaseMissionSequence.RegisterEnterBaseCheckPointCallback(a,i)end
elseif t then
end
local t=m.nextStepDelay
if n(t)then
for d,t in ipairs(t)do
if n(t)then
local n=t.type
local r,t,i
if(n=="Delay")then
r,t="Timer","Finish"i="Timer_nextStepDelay_"..(tostring(a)..("_"..tostring(d)))elseif(n=="FadeOut")then
r,t="UI","EndFadeOut"i="EndFadeOut_nextStepDelay_"..(tostring(a)..("_"..tostring(d)))else
break
end
local n=tostring((s)..("_"..(tostring(a)..("_nextStepDelay_"..(tostring(n)..tostring(d))))))e.AddSaveVarsList(o,{{name=n,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})table.insert(h,n)e.AddMessage(f,{[r]={{sender=i,msg=t,func=function()if not fvars[n]then
fvars[n]=true
l:GoToNextStepIfConditionCleared(n)end
end,option={isExecFastTravel=true}}}})end
end
end
local a=m.diggerReward
if n(a)then
local n=function()local n=TppMission.GetWaveProperty(a.waveName)local e=n.defenseTargetGimmickProperty.identificationTable.digger
Gimmick.SetAction{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName,action="SetRewardMode"}local n=Vector3(n.defensePosition[1],a.rewardPos:GetY(),n.defensePosition[3])Gimmick.SetAction{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName,action="SetTargetPos",position=n}Gimmick.SetAction{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName,action="Open"}mvars.bfm_diggerBooting=true
end
local a=function()mvars.bfm_diggerReward=a
GkEventTimerManager.Start("Timer_CloseRewardWhormhole",5)end
e.AddMessage(f,{GameObject={{msg="DiggingStartEffectEnd",func=a}},Timer={{msg="Finish",sender="Timer_OpenRewardWhormhole",func=n}}})end
if d(m.AddOnUpdate)then
v=m.AddOnUpdate
end
end
l={stepName=a,nextStepName=b,clearConditionTable=r,clearedConditionCount=0,commonMessageTable=f,conditionVarsNameList=c,optionConditionVarsNameList=T,nextStepDelayVarsNameList=h,demoOnEndFunctionTable=u,stepMissionObjectiveTable=p,AddOnUpdate=v,waveName=S,blackRadioWork=i,options=m,Messages=function(e)if e.messageTable then
return g(e.messageTable)end
end,GetCommonMessageTable=function(e)if e.commonMessageTable then
return g(e.commonMessageTable)end
end,GoToNextStepIfConditionCleared=function(a,s)if not n(a.conditionVarsNameList)then
return
end
e.CheckRegisteredStepMissionObjective(a.stepMissionObjectiveTable,s)local i,o=e.CheckStepClearCondition(r.orCheck,a.conditionVarsNameList)if a.options then
local n=a.options
if i and n.checkObjectiveIfCleared then
e.CheckObjective(a.options.checkObjectiveIfCleared)end
if n.OnChangeClearCondition then
if a.clearedConditionCount~=o then
a.clearedConditionCount=o
n.OnChangeClearCondition(s)end
end
end
local o=true
if i then
for e,n in ipairs(a.nextStepDelayVarsNameList)do
local n=fvars[n]if(n==nil)or(n==false)then
o=false
local n=a.options.nextStepDelay
if(not n)or(not n[e])then
return
end
local n=n[e]local i=n.type
local o,o,t
if(i=="Delay")then
local n=n.delayTimeSec or 2
t="Timer_nextStepDelay_"..(tostring(a.stepName)..("_"..tostring(e)))GkEventTimerManager.Start(t,n)elseif(i=="FadeOut")then
t="EndFadeOut_nextStepDelay_"..(tostring(a.stepName)..("_"..tostring(e)))local e=n.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
local n=n.fadeOptions
TppUI.FadeOut(e,t,nil,n)end
break
end
end
end
if(i and o)and t(a.nextStepName)then
SsdFlagMission.SetNextStep(a.nextStepName)return true
end
end,OnUpdate=function(a)if a.needGoToNextStepCheck then
a.needGoToNextStepCheck=nil
local e=a.needGoToNextStepConditionVarsName
a.needGoToNextStepConditionVarsName=nil
local e=a:GoToNextStepIfConditionCleared(e)if e then
return
end
end
if a.GetArchiveCheck then
a.GetArchiveCheck=nil
local e=a.options.archive
if n(e)then
SsdSbm.AddArchive{id=e}end
end
if mvars.bfm_stepNameIfOutOfDefenseArea then
if TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")then
local n
for a,e in pairs(o.flagStep)do
if e.waveName then
n=e.waveName
break
end
end
if n then
e.RevertStepOnOutOfDefenseArea(o,n)end
end
end
e.OnUpdateCheckCraftStepCoroutine(l)e.OnUpdateClearSequenceCoroutine()if a.AddOnUpdate then
a.AddOnUpdate(a)end
if DebugText then
if mvars.bfm_DEBUG_stepAnnihilationTable and mvars.qaDebug.bfmShowKillCount then
local e=mvars.bfm_DEBUG_stepAnnihilationTable.conditionVarsName
local n=fvars[e]local e=mvars.bfm_DEBUG_stepAnnihilationTable.targetMaxCount
DebugText.Print(DebugText.NewContext(),{.5,.5,1},string.format("Now annihilation checking. %03d / %03d ( targetRemainCount / targetMaxCount )",n,e))end
end
end,OnEnter=e.baseStep.OnEnter,OnLeave=e.baseStep.OnLeave}o.flagStep[a]=l
return l
end
function e.CreateInstance(i)local a={}a.flagStep={}a.missionName=i
a.missionAreas={}function a.OnAllocate()mvars.fms_defaltMissionAreaName=nil
mvars.fms_missionAreaMarkerList={}mvars.fms_missionAreaTrapList={}mvars.fms_missionAreaInvalidList={}mvars.fms_rescueTargetUniqueCrewTable={}mvars.bfm_finishedClearSequence=false
mvars.ply_unexecFastTravelByMenu=false
a.commonMessageTable={}a.commonMessageTable=e.AddMessage(a.commonMessageTable,{Timer={{msg="Finish",sender="Timer_CloseRewardWhormhole",func=function()local e=TppMission.GetWaveProperty(mvars.bfm_diggerReward.waveName)local e=e.defenseTargetGimmickProperty.identificationTable.digger
Gimmick.SetAction{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName,action="Close"}GkEventTimerManager.Start("Timer_StartVanishDigger",15)end},{msg="Finish",sender="Timer_StartVanishDigger",func=function()local e=TppMission.GetWaveProperty(mvars.bfm_diggerReward.waveName)local e=e.defenseTargetGimmickProperty.identificationTable.digger
Gimmick.SetVanish{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName}Gimmick.SetNoTransfering{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName,noTransfering=true}mvars.bfm_diggerReward=nil
end}},GameObject={{msg="DiggingStartEffectEnd",func=function()mvars.bfm_diggerBooting=false
end},{msg="BreakGimmick",func=function(t,i,o,e)if n(a.importantGimmickList)then
for n,e in pairs(a.importantGimmickList)do
local n
if(e.gimmickId and e.locatorName)and e.datasetName then
if e.locatorName and Fox.StrCode32(e.locatorName)==i then
n=Gimmick.SsdGetGameObjectId{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName}if t==n then
local e,n=Gimmick.SsdGetPosAndRot{gameObjectId=t}if e then
local e=TppPlayer.GetDefenseTargetBrokenCameraInfo(e,n,i,o)TppPlayer.ReserveDefenseTargetBrokenCamera(e)end
TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.DEFENSE_TARGET_WAS_DESTROYED,TppDefine.GAME_OVER_RADIO.DEFENSE_TARGET_WAS_DESTROYED)break
end
end
end
end
end
end}}})if a.BeforeOnAllocate then
a.BeforeOnAllocate()end
SsdFlagMission.RegisterStepList(a.stepList)SsdFlagMission.RegisterStepTable(a.flagStep)SsdFlagMission.RegisterSystemCallbacks{OnActivate=function()mvars.currentFlagMissionName=i
local i=a.disableEnemy
if n(i)then
for a,e in ipairs(i)do
local a
local i
if n(e)then
a=e.enemyName
i=e.enemyType or"SsdZombie"elseif t(e)then
a=e
i="SsdZombie"end
if t(a)then
local n=e.sequenceName
if not n or SsdFlagMission.GetCurrentStepIndex()<SsdFlagMission.GetStepIndex(e.sequenceName)then
TppEnemy.SetDisablePermanent(a,i)end
end
end
end
local i=a.enemyRouteTable
if n(i)then
for n,e in ipairs(i)do
if(((not e.enemyType or e.enemyType=="SsdZombie")or e.enemyType=="SsdZombieBom")or e.enemyType=="SsdZombieDash")or e.enemyType=="SsdZombieShell"then
TppEnemy.SetZombieSneakRoute(e.enemyName,e.enemyType,e.routeName)else
TppEnemy.SetInsectSneakRoute(e.enemyName,e.enemyType,e.routeName)end
end
end
local i=a.enemyLevelSettingTable
if n(i)then
for a,e in ipairs(TppDefine.ENEMY_TYPE_LIST)do
if GameObject.DoesGameObjectExistWithTypeName(e)then
local a={type=e}local e=i.areaSettingTableList
if n(e)then
for n,e in ipairs(e)do
local n=e.areaName
local i=e.level
local e=e.randomRange
if t(n)and u(i)then
local e={id="SetAreaLv",areaName=n,level=i,randVal=e}GameObject.SendCommand(a,e)end
end
end
local e={id="ReloadLevel"}GameObject.SendCommand(a,e)end
end
end
mvars.ply_unexecFastTravelByMenu=a.unexecFastTravel
local t={}for a,e in ipairs(a.missionAreas)do
if n(e)then
local n=e.name
local a=e.trapName
local s=e.visibleArea or 3
local d=e.goalType or"moving"local m=e.viewType or"map"local c=e.randomRange or 0
local r=e.setImportant or true
local l=e.setNew or true
local o=e.hide or false
local i=e.mapTextId
local e=e.guideLinesId
TppMarker.Enable(n,s,d,m,c,r,l,i,e)if o then
TppMarker.Disable(n)end
table.insert(t,n)if not mvars.fms_defaltMissionAreaName then
mvars.fms_defaltMissionAreaName=n
end
mvars.fms_missionAreaMarkerList[n]=a
local e=T(a)mvars.fms_missionAreaTrapList[e]=n
mvars.fms_missionAreaInvalidList[e]=false
end
end
TppMarker.RegisterMissionMarkerParent(t)mvars.fms_guideLineIdTable={}local n=a.guideLineIdTable
if n then
a.DisplayGuideLine(n)end
local n=a.missionDemoBlock
if n then
mvars.fms_missionmissionDemoBlock=n
e.LoadMissionDemoBlock(n)end
for e,n in pairs(mvars.fms_rescueTargetUniqueCrewTable)do
local e=S(e)if e~=h then
if SsdCrewSystem.IsUniqueCrewExist{uniqueType=n}then
v(e,{id="SetEnabled",enabled=false})end
end
end
for a,n in pairs(a.flagStep)do
if n.clearConditionTable and n.clearConditionTable.putDigger then
e.InitializePutDiggerVisibility(n.clearConditionTable.putDigger)end
end
local n=a.showDiggerPlanedPlace
if n then
e.ShowDiggerPlanedPlace(a,n)end
mvars.fms_waveSettings=nil
if a.waveSettings then
mvars.fms_waveSettings=a.waveSettings
end
TppRadio.ResetCalledFlagForPlayOnceRadio()if d(a.OnActivate)then
a.OnActivate()end
end,OnDeactivate=function()end,OnOutOfAcitveArea=function()end,OnTerminate=function()local i=a.disableEnemy
if n(i)then
for a,e in ipairs(i)do
local a
local i
if n(e)then
a=e.enemyName
i=e.enemyType or"SsdZombie"elseif t(e)then
a=e
i="SsdZombie"end
if t(a)then
TppEnemy.SetEnablePermanent(a,i)end
end
end
a.SetMissionGimmickResourceValidity(false)if mvars.defenseFlagMission then
end
mvars.defenseFlagMission=nil
mvars.fms_defaltMissionAreaName=nil
mvars.fms_missionAreaMarkerList={}mvars.fms_missionAreaTrapList={}mvars.fms_missionAreaInvalidList={}mvars.fms_missionmissionDemoBlock=nil
mvars.fms_rescueTargetUniqueCrewTable=nil
mvars.ply_unexecFastTravelByMenu=false
mvars.fms_waveSettings=nil
e.FinalizeStepAnnihilationTable()BaseMissionSequence.EnableBaseCheckPoint()BaseMissionSequence.UnregisterEnterBaseCheckPointCallback()if d(a.AddOnTerminate)then
a.AddOnTerminate()end
end,OnOutOfDefenseGameArea=function(n)if Mission.GetDefenseGameState()==TppDefine.DEFENSE_GAME_STATE.NONE and(not mvars.bfm_diggerBooting)then
e.RevertStepOnOutOfDefenseArea(a,n)else
if SsdFlagMission.IsCurrentStepWaveName(n)then
if a.importantGimmickList then
local e=a.foreceBreakImportantGimmickListIndex or 1
local e=a.importantGimmickList[e]Gimmick.BreakGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,e.locatorName,e.datasetName,false)else
TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUT_OF_DEFENSE_GAME_AREA)end
end
end
end,OnAlertOutOfDefenseGameArea=function(e)if SsdFlagMission.IsCurrentStepWaveName(e)then
TppRadio.Play"f3000_rtrg0114"end
end}if a.enterMissionAreaRadio then
e.AddSaveVarsList(a,{{name=tostring((i)..C),type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}})end
if a.saveVarsList then
SsdFlagMission.DeclareFVars(a.saveVarsList)end
if a.registerRescueTargetUniqueCrew then
local n=e.RegisterRescueTargetUniqueCrew(a.registerRescueTargetUniqueCrew)if n then
a.commonMessageTable=e.AddMessage(a.commonMessageTable,{GameObject={{msg="Dead",func=function(e)local n=S(a.registerRescueTargetUniqueCrew.locatorName)if(e==n)then
TppPlayer.ReserveTargetDeadCameraGameObjectId(e)TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.TARGET_DEAD)end
end,option={isExecFastTravel=true,isExecDemoPlaying=true}}}})end
end
if Fox.GetDebugLevel()>=Fox.DEBUG_LEVEL_QA_RELEASE and a.debugRadioLineTable then
TppRadio.AddDebugRadioLineTable(a.debugRadioLineTable)end
mvars.markerTrapMessageTable=a.markerTrapMessageTable
a.SetMissionGimmickResourceValidity(true)if d(a.Initialize)then
a.Initialize()end
end
function a.OnInitialize()if mvars.bfm_needCrewRegister then
end
SsdFlagMission.OnInitialize(a)end
function a.OnUpdate()end
function a.OnTerminate()TppMarker.DisableAll()Player.ResetPadMask{settingName="OnFlagMissionClear"}TppGameStatus.Reset("FmsMissionClear","S_DISABLE_PLAYER_PAD")MissionObjectiveInfoSystem.Clear()if a.showDiggerPlanedPlace then
e.ClearDiggerPlanedPlace(a,a.showDiggerPlanedPlace)end
SsdFlagMission.OnTerminate(a)end
function a.DisplayMissionArea(n)local e
if t(n)then
e=S(n)elseif u(n)then
e=n
end
if not e or e==h then
return
end
SsdMarker.Enable{gameObjectId=e,enable=true}local e=mvars.fms_missionAreaMarkerList[n]if e then
local e=T(e)if mvars.fms_missionAreaInvalidList[e]then
mvars.fms_missionAreaInvalidList[e]=false
end
end
end
function a.DisableMissionArea(e)local a=n(e)local n=t(e)if not a and not n then
return
end
local n=function(e)TppMarker.Disable(e)local e=mvars.fms_missionAreaMarkerList[e]if e then
local e=T(e)mvars.fms_missionAreaInvalidList[e]=true
TppMarker.DisableMissionMarker(mvars.fms_missionAreaTrapList[e])end
end
if a then
for a,e in ipairs(e)do
n(e)end
else
n(e)end
end
function a.DisplayGuideLine(e)local n=n(e)if not n then
return
end
mvars.fms_guideLineIdTable=e
SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{guidelineIDs=mvars.fms_guideLineIdTable}end
function a.AddDisplayGuideLine(a)local e=n(a)if not e then
return
end
if next(mvars.fms_guideLineIdTable)then
local e=1
for n=1,3 do
if mvars.fms_guideLineIdTable[n]==nil then
if a[e]~=nil then
if t(a[e])then
mvars.fms_guideLineIdTable[n]=a[e]e=e+1
end
end
end
end
else
mvars.fms_guideLineIdTable=a
end
SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{guidelineIDs=mvars.fms_guideLineIdTable}end
function a.DisableGuideLine(e)if e==nil then
mvars.fms_guideLineIdTable={}else
local n=n(e)if not n then
return
end
if next(mvars.fms_guideLineIdTable)then
local n=1
for n=1,3 do
for a,e in ipairs(e)do
if mvars.fms_guideLineIdTable[n]==e then
mvars.fms_guideLineIdTable[n]=nil
end
end
end
local e={}for a,n in pairs(mvars.fms_guideLineIdTable)do
if t(n)then
table.insert(e,n)end
end
mvars.fms_guideLineIdTable=e
end
end
SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{guidelineIDs=mvars.fms_guideLineIdTable}end
function a.SetMissionGimmickResourceValidity(a)if not n(mvars.loc_locationTreasureMission)then
return
end
local e=mvars.loc_locationTreasureMission.treasureTableList
if not n(e)then
return
end
local e=e[i]if not e then
return
end
local t=e.treasureBoxResourceTable
if n(t)then
for n,e in ipairs(t)do
local e={name=e.name,dataSetName=e.dataSetName,validity=a}Gimmick.SetResourceValidity(e)end
end
local e=e.treasurePointResourceTable
if n(e)then
for n,e in ipairs(e)do
local e={name=e.name,dataSetName=e.dataSetName,validity=a}Gimmick.SetResourceValidity(e)end
end
end
function a.AddMarkerTrapMessage(t)if not n(t)then
return
end
a.markerTrapMessageTable=t
local n={Trap={}}for t,e in pairs(t)do
table.insert(n.Trap,{sender=t,msg="Enter",func=function(n,a)if Tpp.IsPlayer(a)then
_(n,e)end
end,option={isExecFastTravel=true}})table.insert(n.Trap,{sender=t,msg="Exit",func=function(a,n)if Tpp.IsPlayer(n)then
b(a,e)end
end,option={isExecFastTravel=true}})if e.defaultActive then
if not a.defaultMarkerTableList then
a.defaultMarkerTableList={}end
table.insert(a.defaultMarkerTableList,{trapName=t,trapMessageTableUnit=e})end
end
if a.defaultMarkerTableList then
if not n.GameObject then
n.GameObject={}end
table.insert(n.GameObject,{msg="ChangeFogAreaState",func=function()if TppGameStatus.IsSet("","S_NO_FOG_AREA")then
for n,e in ipairs(a.defaultMarkerTableList)do
_("trap_base",e.trapMessageTableUnit)end
elseif TppGameStatus.IsSet("","S_FOG_AREA")then
for n,e in ipairs(a.defaultMarkerTableList)do
b("trap_base",e.trapMessageTableUnit)end
end
end,option={isExecFastTravel=true}})end
a.commonMessageTable=e.AddMessage(a.commonMessageTable,n)end
function a.AddMissionAreaTrapMessage()if a.missionAreas then
local n={Trap={}}if a.commonMessageTable and a.commonMessageTable.Trap then
n=a.commonMessageTable
end
for o,t in pairs(a.missionAreas)do
table.insert(n.Trap,{sender=t.trapName,msg="Enter",func=function(n,t)if mvars.fms_missionAreaInvalidList[n]then
return
end
if a.enterMissionAreaRadio then
e.PlayEnterMissionAreaRadio(i,a.enterMissionAreaRadio)end
TppMarker.EnableMissionMarker(mvars.fms_missionAreaTrapList[n])end,option={isExecFastTravel=true}})table.insert(n.Trap,{sender=t.trapName,msg="Exit",func=function(e,n)if mvars.fms_missionAreaInvalidList[e]then
return
end
TppMarker.DisableMissionMarker(mvars.fms_missionAreaTrapList[e])end,option={isExecFastTravel=true}})end
a.commonMessageTable=e.AddMessage(a.commonMessageTable,n)end
end
function a.Messages()if a.messageTable then
return g(a.messageTable)end
end
function a.GetCommonMessageTable()a.AddMissionAreaTrapMessage()if a.commonMessageTable then
return g(a.commonMessageTable)end
end
mvars.bfm_instanceClearJingleType=a.clearJingleType
mvars.bfm_clearJingleType=e.CLEAR_JINGLE_TYPE.BATTLE
return a
end
function e.InitializePutDiggerVisibility(e)local n=TppGimmick.GetStoryDiggerFinCount()Gimmick.SetAction{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName,action="SetFinCount",param1=n}local n
if fvars[e.conditionVarsName]then
n=true
else
n=false
end
Gimmick.InvisibleGimmick(0,e.name,e.dataSetName,(not n),{gimmickId=e.gimmickId})end
function e.ShowDiggerPlanedPlace(e,n)if not e.importantGimmickList then
return
end
local e=e.importantGimmickList[n]if not e then
return
end
local e=Gimmick.SsdGetGameObjectId{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName}if(e==h)then
return
end
MiningMachinePlacementSystem.Start()MiningMachinePlacementSystem.Register(e)end
function e.ClearDiggerPlanedPlace(e,n)if not e.importantGimmickList then
return
end
local e=e.importantGimmickList[n]if not e then
return
end
local e=Gimmick.SsdGetGameObjectId{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName}if(e==h)then
return
end
MiningMachinePlacementSystem.Unregister(e)end
function e.PlayRadio(e)if n(e)and e.name then
TppRadio.Play(e.name,e.options)elseif e then
TppRadio.Play(e)end
end
function e.PlayGetMemoryBoardDemo(e,n,a)TppDemo.PlayGetMemoryBoardDemo({onEnd=n,onFinalize=a},e.identifier,e.key,{useDemoBlock=false,waitBlockLoadEndOnDemoSkip=false})end
function e.LoadRegisteredMissionDemoBlock()local n=mvars.fms_missionmissionDemoBlock
if n then
e.LoadMissionDemoBlock(n)end
end
function e.LoadMissionDemoBlock(e)if not n(e)then
return
end
local e=e.demoBlockName
if not t(e)then
return
end
TppScriptBlock.LoadDemoBlock(e,true)end
function e.CheckStepClearCondition(i,n)local t=0
local e
if i then
e=false
else
e=true
end
for n,a in ipairs(n)do
local n
local a=fvars[a]if(a==false)or(u(a)and a>0)then
n=false
else
if(a==nil)then
end
n=true
end
if n then
t=t+1
end
if i then
e=e or n
else
e=e and n
end
end
return e,t
end
function e.RegisterRescueTargetUniqueCrew(e)if not n(e)then
return
end
local n=e.locatorName
if not t(n)then
return
end
local a=e.uniqueType
if not u(e.uniqueType)then
return
end
mvars.fms_rescueTargetUniqueCrewTable[n]=a
return true
end
function e.InitializeStepAnnihilationTable(i,e,o)if not t(o)then
return
end
local a=e.targetList
if not n(a)then
return
end
if(#a==0)then
return
end
local t=e.missionTargetRange or{50}if not n(t)then
return
end
if not u(t[1])then
return
end
if t[1]<=0 then
return
end
mvars.bfm_annihilationTable=mvars.bfm_annihilationTable or{}mvars.bfm_annihilationTable[i]={}local e=mvars.bfm_annihilationTable[i]e.targetList=a
e.targetMaxCount=#a
e.missionTargetRange=t
e.conditionVarsName=o
return true,e.targetMaxCount
end
function e.OnDeadCheckMissionTargetAnnihilation(r,s,n,o,a)local i,n,t,a=e.GetStepAnnihilationParams(n)if not i then
return
end
if e.IsAnnihilationTarget(r,t,a)then
e.DecrimentAnnihilationRemainCount(n)if o then
TppMission.AddDefenseGameTargetKillCount()end
end
s:GoToNextStepIfConditionCleared(n)end
function e.IsAnnihilationTarget(a,n,e)for e=1,e do
local e=n[e]local e=S(e)if(e==a)then
return true
end
end
return false
end
function e.InitializeStepAnnihilationTarget(r,o,n,a)local i={id="GetLifeStatus"}local t=e.SetMissionTarget
for n=1,n do
local n=o[n]local a=a[n]or a[1]local n=t(n,true,a)if n then
if v(n,i)==TppGameObject.NPC_LIFE_STATE_DEAD then
e.DecrimentAnnihilationRemainCount(r)end
end
end
end
function e.SetUpWaveSettings()local e=mvars.fms_waveSettings
if n(e)then
local n=TppMission.GetFreePlayWaveSetting()if n then
Mission.LoadDefenseGameDataJson""TppMission.SetUpWaveSetting{n,{e.waveList,e.wavePropertyTable,e.waveTable,e.spawnPointDefine}}end
if e.wavePropertyTable then
TppGimmick.SetDefenseTargetLevel(e.wavePropertyTable)end
end
end
function e.FinalizeStepAnnihilationTarget(n,a)local e=e.SetMissionTarget
for a=1,a do
local n=n[a]e(n,false)end
end
function e.FinalizeStepAnnihilationTable()mvars.bfm_annihilationTable=nil
mvars.bfm_DEBUG_stepAnnihilationTable=nil
end
function e.DecrimentAnnihilationRemainCount(e)if fvars[e]>0 then
fvars[e]=fvars[e]-1
end
end
function e.GetStepAnnihilationParams(e)if not mvars.bfm_annihilationTable then
return
end
local e=mvars.bfm_annihilationTable[e]if not e then
return
end
return e,e.conditionVarsName,e.targetList,e.targetMaxCount,e.missionTargetRange
end
local a={id="SetMissionTarget"}function e.SetMissionTarget(e,t,n)local e=S(e)if(e==h)then
return
end
a.enabled=t
a.range=n
v(e,a)return e
end
function e.CreateCheckCraftStepCoroutine(n,a)if mvars.bfm_checkCraftStepCoroutine then
return
end
if(#n<2)then
return
end
mvars.bfm_craftStepList=n
mvars.bfm_craftStepFvarsName=a
if DebugText then
mvars.bfm_DEBUG_checkCraftStepCoroutine={}end
return coroutine.create(e.CheckCraftStepCoroutine)end
function e.DestroyCheckCraftStepCoroutine()mvars.bfm_checkCraftStepCoroutine=nil
mvars.bfm_craftStepList=nil
mvars.bfm_craftStepFvarsName=nil
if DebugText then
mvars.bfm_DEBUG_checkCraftStepCoroutine=nil
end
end
local a=TppGameStatus.IsSet
function e.OnUpdateCheckCraftStepCoroutine(n)if mvars.bfm_checkCraftStepCoroutine and a("","S_IN_BASE_CHECKPOINT")then
local a,t=coroutine.resume(mvars.bfm_checkCraftStepCoroutine)if not a then
e.DestroyCheckCraftStepCoroutine()return
end
if(coroutine.status(mvars.bfm_checkCraftStepCoroutine)=="dead")then
if(t==true)then
fvars[mvars.bfm_craftStepFvarsName]=true
n:GoToNextStepIfConditionCleared(mvars.bfm_craftStepFvarsName)end
e.DestroyCheckCraftStepCoroutine()end
if(DebugText and mvars.bfm_DEBUG_checkCraftStepCoroutine)and mvars.qaDebug.bfmShowCraftStep then
DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Checking craftStep.")DebugText.Print(DebugText.NewContext(),"currentCraftStep = "..tostring(mvars.bfm_DEBUG_checkCraftStepCoroutine.currentCraftStep))DebugText.Print(DebugText.NewContext(),"requiredProduction = "..tostring(mvars.bfm_DEBUG_checkCraftStepCoroutine.requiredProduction))DebugText.Print(DebugText.NewContext(),"requiredFacility = "..tostring(mvars.bfm_DEBUG_checkCraftStepCoroutine.requiredFacility))DebugText.Print(DebugText.NewContext(),"productionIdCode = "..tostring(mvars.bfm_DEBUG_checkCraftStepCoroutine.productionIdCode))end
end
end
function e.CheckCraftStepCoroutine()local o=SsdBuilding.GetItemCount
local i={facility="hoge"}local r={id="hoge"}local c=SsdSbm.GetCountProduction
local s={id="PRD_*",inInventory=true,inWarehouse=true}local p=MissionObjectiveInfoSystem.SetTable
local a=mvars.bfm_craftStepList
local l=#a
local t=0
local f=a[1].missionObjectiveInfoTable.langId
local function m(a,e)local n
for t=1,e do
local e
local a=a[t]local l=a.requiredFacility
local d=a.requiredProduction
local a=a.requiredBuilding
if l then
i.facility=l
e=o(i)elseif d then
s.id=d
e=c(s)elseif a then
r.id=a
e=o(r)end
if e and(e<=0)then
return n
end
n=t
end
return n
end
MissionObjectiveInfoSystem.Open()repeat
local n=m(a,l)if n~=t then
local e=a[n].missionObjectiveInfoTable
if e then
if DebugText then
mvars.bfm_DEBUG_checkCraftStepCoroutine.currentCraftStep=n
mvars.bfm_DEBUG_checkCraftStepCoroutine.requiredProduction=a[n].requiredProduction
mvars.bfm_DEBUG_checkCraftStepCoroutine.requiredFacility=a[n].requiredFacility
mvars.bfm_DEBUG_checkCraftStepCoroutine.productionIdCode=e.productionIdCode[1]end
p{e}end
end
t=n
coroutine.yield()until(t>=l)e.CheckObjective(f)return true
end
function e.PlayEnterMissionAreaRadio(n,a)local n=tostring((n)..C)if not fvars[n]then
e.PlayRadio(a)fvars[n]=true
end
end
local a={PRD_=SsdSbm.GetCountProduction,RES_=SsdSbm.GetCountResource}function e.GetCollectionCount(n)local e=string.sub(n,1,4)local e=a[e]if not e then
return
end
return e{id=n,inInventory=true,inWarehouse=true}end
function e.IsClearCollectCondition(n)local a=n.count
if not u(a)then
return
end
local n=e.GetNameFromStringOrTable(n)if not n then
return
end
local e=e.GetCollectionCount(n)if not e then
return
end
if e>=a then
return true
else
return false
end
end
function e.CheckBlackRadioParameter(e)local i,a,o
if t(e)then
a={e}elseif n(e)then
if n(e.blackRadioList)then
a=e.blackRadioList
else
return
end
if e.startRadio then
if t(e.startRadio)then
i=e.startRadio
o=e.startGuaranteeTimerSec or 10
else
return
end
end
else
return
end
local e={startRadio=i,startGuaranteeTimerSec=o,blackRadioList=a,currentBlackRadioIndex=0}return e
end
function e.RevertStepOnOutOfDefenseArea(a,n)local e=TppMission.GetWaveProperty(n)if e==nil then
return
end
if e.defenseGameType~=TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE then
return
end
if mvars.bfm_stepNameIfOutOfDefenseArea==nil then
return
end
local e=e.defenseTargetGimmickProperty.identificationTable.digger
Gimmick.SetVanish{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName}TppMission.DisablePrepareInitWaveUI(n)for n,e in pairs(a.flagStep)do
if e.clearConditionTable and e.clearConditionTable.putDigger then
fvars[e.clearConditionTable.putDigger.conditionVarsName]=false
end
end
SsdFlagMission.SetNextStep(mvars.bfm_stepNameIfOutOfDefenseArea)end
return e