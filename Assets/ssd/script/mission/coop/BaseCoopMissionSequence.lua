local c={}local e=Fox.StrCode32
local a=Tpp.StrCode32Table
local T=20
local e=3
local t="Timer_Player_Dead_to_Revival"local u=60
local d=.05
local i=.0175
local m=60
local p=35
local l=10
local g=75
local _=30*60
local S=180
local v=300
local b=8
local e=3
local f=3
local e={PRD_BLD_WeaponPlant={"PRD_BLD_WeaponPlant_A","PRD_BLD_WeaponPlant_B"},PRD_BLD_GadgetPlant={"PRD_BLD_GadgetPlant_A","PRD_BLD_GadgetPlant_B"},PRD_BLD_MedicalPlant={"PRD_BLD_MedicalPlant_A","PRD_BLD_MedicalPlant_B"},PRD_BLD_Kitchen={"PRD_BLD_Kitchen_A","PRD_BLD_Kitchen_B","PRD_BLD_Kitchen_C"},PRD_BLD_AmmoBox={"PRD_BLD_AmmoBox"}}local r={}local s={}local o={}for a,e in pairs(e)do
for n,e in ipairs(e)do
r[e]=a
s[e]=n
o[Fox.StrCode32(e)]=e
end
end
function c.CreateInstance(n)local e={}e.MISSION_START_INITIAL_WEATHER=TppDefine.WEATHER.FOGGY
e.missionName=n
e.UNSET_PAUSE_MENU_SETTING={GamePauseMenu.RESTART_FROM_CHECK_POINT,GamePauseMenu.RESTART_FROM_MISSION_START}e.INITIAL_INFINIT_OXYGEN=true
e.sequenceList={"Seq_Demo_SyncGameStart","Seq_Demo_HostAlreadyCleared","Seq_Game_Ready","Seq_Game_Stealth","Seq_Game_WaitStartDigger","Seq_Game_DefenseWave","Seq_Game_DefenseBreak","Seq_Game_EstablishClear","Seq_Game_RequestCoopEndToServer","Seq_Game_Clear"}function e.OnLoad()TppSequence.RegisterSequences(e.sequenceList)TppSequence.RegisterSequenceTable(e.sequences)end
e.saveVarsList={waveCount=0}e.checkPointList={"CHK_DefenseWave",nil}e.baseList={nil}e.CounterList={}e.missionObjectiveDefine={marker_all_disable={},marker_target={gameObjectName="marker_target",visibleArea=0,randomRange=0,setNew=true,setImportant=true,goalType="moving",viewType="all"},marker_target_disable={}}e.missionObjectiveTree={marker_all_disable={marker_target_disable={marker_target={}}}}e.missionObjectiveEnumSource={"marker_all_disable","marker_target","marker_target_disable"}e.missionObjectiveEnum=Tpp.Enum(e.missionObjectiveEnumSource)function e.MissionPrepare()if TppMission.IsHostmigrationProcessing()then
e.HostMigration_OnEnter()end
local a={OnEstablishMissionClear=function(n)e.OnStartDropReward()end,OnDisappearGameEndAnnounceLog=function(e)Player.SetPause()TppMission.ShowMissionReward()end,OnEndMissionReward=function()e.OnMissionEnd()TppMission.SetNextMissionCodeForMissionClear(TppMission.GetCoopLobbyMissionCode())if IS_GC_2017_COOP then
TppMission.GameOverReturnToTitle()return
end
local e=TppMission.GetMissionClearType()TppMission.MissionFinalize{isNoFade=true}end,OnOutOfMissionArea=function()TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA)end,nil}TppMission.RegiserMissionSystemCallback(a)mvars.bcm_radioScript=_G[tostring(n).."_radio"]mvars.bcm_enemyScript=_G[tostring(n).."_enemy"]local n=_G[e.locationScriptName]or{}e.walkerGearNameList=e.walkerGearNameList or n.walkerGearNameList
e.wormholePointResourceTableList=e.wormholePointResourceTableList or n.wormholePointResourceTableList
e.startFogDensity=(e.startFogDensity or n.startFogDensity)or d
e.waveFogDensity=(e.waveFogDensity or n.waveFogDensity)or i
e.treasurePointTableList=e.treasurePointTableList or n.treasurePointTableList
e.treasureBoxTableList=e.treasureBoxTableList or n.treasureBoxTableList
e.ignoreLoadSmallBlocks=e.ignoreLoadSmallBlocks or n.ignoreLoadSmallBlocks
e.extraTargetGimmickTableListTable=e.extraTargetGimmickTableListTable or n.extraTargetGimmickTableListTable
e.craftGimmickTableTable=e.craftGimmickTableTable or n.craftGimmickTableTable
e.questGimmickTableListTable=e.questGimmickTableListTable or n.questGimmickTableListTable
e.stealthAreaNameTable=e.stealthAreaNameTable or n.stealthAreaNameTable
e.huntDownRouteNameTable=e.huntDownRouteNameTable or n.huntDownRouteNameTable
e.singularityEffectName=e.singularityEffectName or n.singularityEffectName
e.breakableGimmickTableList=e.breakableGimmickTableList or n.breakableGimmickTableList
e.impactAreaHeightOffset=e.impactAreaHeightOffset or n.impactAreaHeightOffset
FogWallController.SetEnabled(false)ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=true}local a=e.identifier
local n=e.defensePositionKey
if a and n then
local e=Tpp.GetLocator(a,n)mvars.bcm_defensePosition=e
end
SsdSbm.MakeInventoryTemporaryCopy()Mission.RequestCoopStartToServer()if not e.dynamicShockWaveRadius then
local e=e.waveFinishShockWaveRadius or p
Mission.SetDiggerShockWaveRadiusAtWaveFinish(e)else
mvars.waveFinishShockWaveRadiusMin=e.waveFinishShockWaveRadiusMin or l
mvars.waveFinishShockWaveRadiusMax=e.waveFinishShockWaveRadiusMax or g
mvars.currentShockWaveRadius=mvars.waveFinishShockWaveRadiusMin
local e=e.shockWaveRadiusEnlargementTime or _
mvars.shockWaveRadiusAdditionalValue=(mvars.waveFinishShockWaveRadiusMax-mvars.waveFinishShockWaveRadiusMin)/e
Mission.SetDiggerShockWaveRadiusAtWaveFinish(mvars.currentShockWaveRadius)end
local n=e.treasurePointTableList
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
Gimmick.SetTreasurePointResources(e)end
end
local n=e.treasureBoxTableList
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
Gimmick.SetTreasureBoxResources(e)end
end
local n=e.ignoreLoadSmallBlocks
if Tpp.IsTypeTable(n)then
Mission.SetIgnoreLoadSmallStageBlocks(n)end
local n=mvars.loc_locationWormhole
if Tpp.IsTypeTable(n)then
local e=n.wormholePointTable
if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=false}end
end
end
local n=e.wormholePointResourceTableList
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
Gimmick.SetWormholePointResources(e)Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=true}end
end
local n=e.defenseGameDataJsonFilePath
if Tpp.IsTypeString(n)then
Mission.LoadDefenseGameDataJson(n)else
Mission.LoadDefenseGameDataJson"/Assets/ssd/level_asset/defense_game/debug/debug_c20010_test.json"end
e.defenseGameVariationIndex=Mission.GetDefenseGameVariationIndex()or 0
e.questVariationCount=e.questVariationCount or f
e.waveVariationIndex=math.floor((e.defenseGameVariationIndex+e.questVariationCount)/e.questVariationCount)local e=e.AfterMissionPrepare
if Tpp.IsTypeFunc(e)then
e()end
end
function e.OnStartDropReward()if mvars.bcm_isCalledOnStartDropReward then
return
end
mvars.bcm_rewardOffsetTable={{-1,-1},{-1,-.5},{-1,0},{-1,.5},{-1,1},{-.5,1},{0,1},{.5,1},{1,1},{1,.5},{1,0},{1,-.5},{1,-1},{.5,-1},{0,-1}}GkEventTimerManager.Start("Timer_WaitStartCloseDigger",.5)TppGameStatus.Reset("TppMain.lua","S_DISABLE_PLAYER_PAD")Player.SetPadMask{settingName="BaseCoopMissionSequence",except=false,buttons=PlayerPad.SKILL}TppGameStatus.Reset("TppMain.lua","S_DISABLE_HUD")mvars.bcm_isCalledOnStartDropReward=true
end
function e.OnTerminate()FogWallController.SetEnabled(true)ScriptParam.ResetValueToDefault{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen"}ResultSystem.RequestClose()CoopRewardSystem.RequestClose()TppUiCommand.ErasePopup()MapInfoSystem.ClearVisibleEnemyRouteInfos()TppEffectUtility.RemoveEnemyRootView()StageBlockCurrentPositionSetter.SetEnable(false)local e=e.wormholePointResourceTableList
if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=false}end
end
if Mission.IsLocalPlayerFromAutoMatching()then
TppMission.DisconnectMatching(true)end
end
function e.OnGameOver()end
function e.OnBuddyBlockLoad()local n=e.time
if n then
TppClock.SetTime(n)end
local e=e.startFogDensity
TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,.1,{fogDensity=e})WeatherManager.ClearTag("ssd_ClearSky",5)end
function e.OnRestoreSVars()mvars.waveCount=svars.waveCount
if mvars.waveCount>0 then
mvars.continueFromDefenseBreak=true
end
local n=e.diggerLifeBreakSetting or{breakPoints={.875,.75,.625,.5,.375,.25,.125},radius=2}TppMission.SetDiggerLifeBreakSetting(n)local n=e.fastTravelPointNameList
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
SsdFastTravel.InvisibleFastTravelPointGimmick(e,true)end
end
mvars.currentExtraTargetList={}Player.RequestToAppearWithWormhole(0)if TppLocation.IsMiddleAfrica()then
local e=e.walkerGearNameList
if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
GameObject.SendCommand(GameObject.GetGameObjectId(e),{id="SetColoringType",type=2})end
end
end
local n=e.targetGimmickTable or{}if Tpp.IsTypeTable(n)then
local a=n.type
local e=n.locatorName
local n=n.datasetName
Gimmick.ResetGimmick(a,e,n)Gimmick.InvisibleGimmick(a,e,n,true)end
local n=e.extraTargetGimmickTableListTable
if Tpp.IsTypeTable(n)then
for n,e in pairs(n)do
if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
if Tpp.IsTypeTable(e)then
local a=e.locatorName
local n=e.datasetName
local e=e.type
Gimmick.InvisibleGimmick(e,a,n,true)end
end
end
end
end
local n=e.craftGimmickTableTable
if Tpp.IsTypeTable(n)then
for n,e in pairs(n)do
if not e.visible then
Gimmick.InvisibleGimmick(e.type,e.locatorName,e.datasetName,true)else
local n=o[n]if n then
local e=r[n]if e then
if not mvars.builtProductionIdListTable then
mvars.builtProductionIdListTable={}end
if not mvars.builtProductionIdListTable[e]then
mvars.builtProductionIdListTable[e]={}end
table.insert(mvars.builtProductionIdListTable[e],n)end
end
end
end
end
local n=e.questGimmickTableListTable
if Tpp.IsTypeTable(n)then
for n,e in pairs(n)do
if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
if Tpp.IsTypeTable(e)then
Gimmick.InvisibleGimmick(e.type,e.locatorName,e.datasetName,true)end
end
end
end
end
local n=e.impactAreaHeightOffset
if Tpp.IsTypeNumber(n)then
ImpactAreaSystem.SetOffsetHeight(n)end
local e=e.AfterOnRestoreSVars
if Tpp.IsTypeFunc(e)then
e()end
end
function e.OnEndMissionPrepareSequence()local n=e.targetGimmickTable or{}if Tpp.IsTypeTable(n)then
local a=n.type
local a=n.locatorName
local n=n.datasetName
local e=e.defenseAlertRange or T
Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=a,dataSetName=n,isActiveTarget=true,needAlert=true,alertRadius=e,label=nil}end
local n=e.extraTargetGimmickTableListTable
if Tpp.IsTypeTable(n)then
for n,e in pairs(n)do
if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
if Tpp.IsTypeTable(e)then
local a=e.locatorName
local n=e.datasetName
Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=a,dataSetName=n,noTransfering=true}local e=e.extraTargetRadius or 30
Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=a,dataSetName=n,isExtraTarget=true,extraTargetRadius=e}end
end
end
end
end
if e.fixedTime then
TppClock.Stop()end
local n=e.MISSION_WORLD_CENTER
if n then
StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.SetPosition(n:GetX(),n:GetZ())end
MapInfoSystem.SetupInfos()TppPlayer.SetInitialPositionToCurrentPosition()local n=e.walkerGearNameList
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
local e=GameObject.GetGameObjectId("TppCommonWalkerGear2",e)local n={id="SetEnabled",enabled=false}GameObject.SendCommand(e,n)end
end
for n,e in ipairs{TppDefine.ZOMBIE_TYPE_LIST,TppDefine.CREATURE_TYPE_LIST}do
for n,e in ipairs(e)do
if GameObject.DoesGameObjectExistWithTypeName(e)then
GameObject.SendCommand({type=e},{id="SetupCoopEXP"})end
end
end
if Tpp.IsTypeTable(e.stealthAreaNameTable)then
for e,n in pairs(e.stealthAreaNameTable)do
local e=SsdNpc.GetGameObjectIdFromNpcTypeCode32(e)if e~=GameObject.NULL_ID then
GameObject.SendCommand(e,{id="SetStealthArea",name=n})end
end
end
local n=e.huntDownRouteNameTable
if Tpp.IsTypeTable(n)then
local e=SsdNpc.GetGameObjectIdFromNpcTypeName"Aerial"if e~=GameObject.NULL_ID then
GameObject.SendCommand(e,{id="SetHuntDownRoute",routes=n})end
end
local n=e.AfterOnEndMissionPrepareSequence
if Tpp.IsTypeFunc(n)then
n()end
NamePlateMenu.SetBeginnerNamePlateIfTutorialUnfinied()end
e.GameStateToGameSequence={[Mission.DEFENSE_STATE_NONE]="Seq_Game_Ready",[Mission.DEFENSE_STATE_PREPARE]="Seq_Game_Ready",[Mission.DEFENSE_STATE_WAVE]="Seq_Game_DefenseWave",[Mission.DEFENSE_STATE_WAVE_INTERVAL]="Seq_Game_DefenseBreak",[Mission.DEFENSE_STATE_ESCAPE]="Seq_Game_EstablishClear",[Mission.DEFENSE_STATE_RESULT]="Seq_Game_Clear"}function e.GetGameSequenceFromDefenseGameState()local n=Mission.GetDefenseGameState()return e.GameStateToGameSequence[n]end
function e.StartWave(n)local e=e.GetDefensePosition()if e then
TppMission.SetDefensePosition(e)end
for a,n in ipairs{TppDefine.ZOMBIE_TYPE_LIST,TppDefine.CREATURE_TYPE_LIST}do
for a,n in ipairs(n)do
if GameObject.DoesGameObjectExistWithTypeName(n)then
local n={type=n}GameObject.SendCommand(n,{id="SetWaveAttacker",pos=e,radius=512})GameObject.SendCommand(n,{id="SetDefenseAi",active=true})end
end
end
Mission.StartWave()end
function e.GetDefensePosition()return mvars.bcm_defensePosition
end
function e.AddMissionObjective(e)if not mvars.missionObjectiveTableList then
mvars.missionObjectiveTableList={}end
table.insert(mvars.missionObjectiveTableList,{langId=e})MissionObjectiveInfoSystem.Open()MissionObjectiveInfoSystem.SetTable(mvars.missionObjectiveTableList)end
function e.CheckMissionObjective(e)if mvars.missionObjectiveTableList then
for n,a in ipairs(mvars.missionObjectiveTableList)do
if a.langId==e then
MissionObjectiveInfoSystem.Check{langId=e,checked=true}table.remove(mvars.missionObjectiveTableList,n)MissionObjectiveInfoSystem.Open()MissionObjectiveInfoSystem.SetTable(mvars.missionObjectiveTableList)break
end
end
end
end
function e.ClearMissionObjective()mvars.missionObjectiveTableList={}MissionObjectiveInfoSystem.Clear()end
function e.OnMissionEnd()if mvars.isCalledOnMissionEnd then
return
end
mvars.isCalledOnMissionEnd=true
SsdSbm.ClearResourcesInInventory()local n=e.fastTravelPointNameList
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
SsdFastTravel.InvisibleFastTravelPointGimmick(e,false)end
end
Player.ResetPadMask{settingName="BaseCoopMissionSequence"}TppMission.MissionGameEnd()end
e.messageTable={Player={{msg="Dead",func=function(e)if e==PlayerInfo.GetLocalPlayerIndex()then
if GkEventTimerManager.IsTimerActive(t)then
GkEventTimerManager.Stop(t)end
GkEventTimerManager.Start(t,u)end
end},{msg="WarpEnd",func=function()TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"RestartRevivePlayer")end}},GameObject={{msg="DiggerDrumRollStart",func=function()if TppSequence.GetCurrentSequenceName()=="Seq_Game_Clear"then
GkEventTimerManager.Start("Timer_OpenResult",26.709483)TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_out"end
end,option={isExecMissionClear=true}},{msg="ResortieCountDownEnd",func=function()TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"StartAutoRevivePlayer")end},{msg="BrokenMiningMachine",func=function(a,n)e.BrokenMiningMachine(a,n)end},{msg="DiggingStartEffectEnd",func=function()if TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
return
end
GkEventTimerManager.Start("Timer_Reward",9.2)if not GkEventTimerManager.IsTimerActive"Timer_OpenResult"then
GkEventTimerManager.Start("Timer_OpenResult",10)end
CoopScoreSystem.StartDiggerChargeEnagy{chargeTime=6}GkEventTimerManager.Start("Timer_Destroy_Reward_Singularity",5.5)end,option={isExecMissionClear=true}},{msg="BreakGimmick",func=function(n,a,n,n)local n=e.gimmickObjectiveMap
if Tpp.IsTypeTable(n)then
local e=TppSequence.GetCurrentSequenceName()if((e~="Seq_Game_Ready"and e~="Seq_Game_WaitStartDigger")and e~="Seq_Game_Clear")and e~="Seq_Game_EstablishClear"then
local e=n[a]if e then
Mission.AddEventScore(1e4)local e=e.."_disable"TppMission.UpdateObjective{objectives={e}}if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnGimmickBroken)then
mvars.bcm_radioScript.OnGimmickBroken()end
end
end
end
end},{msg="GameOverConfirm",func=function()e.GoToGameOver(false)end,option={isExecGameOver=true}},{msg="FinishDefenseGame",func=function(n,n,e)mvars.timeUp=true
if e==1 then
mvars.miningMachineBroken=true
end
end},{msg="VotingResult",func=function(a,n)if n==Mission.VOTING_ESCAPE and TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
if mvars.bcm_requestAbandon then
return
end
mvars.votingResult=true
if WavePopupSystem and Tpp.IsTypeFunc(WavePopupSystem.RequestOpen)then
WavePopupSystem.RequestOpen{type=WavePopupType.ABORT_DEFENSE}end
e.OnDefenseGameClear()end
end},{msg="SwitchGimmick",func=function(a,n,a,a)local e=e.craftGimmickTableTable
if Tpp.IsTypeTable(e)then
for a,e in pairs(e)do
local e=e.locatorName
if n==Fox.StrCode32(e)then
SsdSbm.ShowSettlementReport()end
end
end
end},{msg="DefenseChangeState",func=function(e,e)end},{msg="DefenseTotatlResult",func=function(n,e)if mvars.bcm_requestAbandon then
return
end
mvars.finalScore=e
TppSequence.SetNextSequence"Seq_Game_EstablishClear"end},{msg="ClearDefenseGame",func=function()if mvars.isHostMigration then
return
end
if mvars.waveCount==0 then
return
end
if TppSequence.GetCurrentSequenceIndex()>=TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
return
end
end},{msg="FinishPrepareTimer",func=function()if TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_WaitStartDigger"then
e.ResetDiggerGimmick()TppSequence.SetNextSequence"Seq_Game_WaitStartDigger"end
end},{msg="CompletedCoopTask",func=function(m,n,i)if n==TppDefine.COOP_TASK_REWARD_TYPE.IRI and Tpp.IsLocalPlayer(m)then
Mission.AddEventScore(i)elseif n==TppDefine.COOP_TASK_REWARD_TYPE.AMMO_BOX or n==TppDefine.COOP_TASK_REWARD_TYPE.BUILDING then
local t=e.craftGimmickTableTable
local m
if Tpp.IsTypeTable(t)then
local a=t[i]if Tpp.IsTypeTable(a)then
local n=o[i]if n then
local e=r[n]local i=s[n]if e and i then
local a=mvars.builtProductionIdListTable
if Tpp.IsTypeTable(a)then
local e=a[e]if Tpp.IsTypeTable(e)then
for r,a in ipairs(e)do
local n=s[a]if n<i then
local n=t[Fox.StrCode32(a)]if Tpp.IsTypeTable(n)then
Gimmick.SetVanish{productionId=a,name=n.locatorName,dataSetName=n.datasetName}table.remove(e,r)end
else
m=true
end
end
end
end
if not mvars.builtProductionIdListTable then
mvars.builtProductionIdListTable={}end
if not mvars.builtProductionIdListTable[e]then
mvars.builtProductionIdListTable[e]={}end
table.insert(mvars.builtProductionIdListTable[e],n)end
end
if not m then
Gimmick.ResetGimmick(a.type,a.locatorName,a.datasetName,{needSpawnEffect=true})end
end
end
elseif n==TppDefine.COOP_TASK_REWARD_TYPE.RECOVER_DIGGER_LIFE then
elseif n==TppDefine.COOP_TASK_REWARD_TYPE.WALKERGEAR then
end
if Tpp.IsLocalPlayer(m)then
for a,n in ipairs(mvars.missionObjectiveTableList)do
if n.langId=="mission_common_objective_bringBack_questItem"then
e.CheckMissionObjective"mission_common_objective_bringBack_questItem"break
end
end
end
end},{msg="GetCoopObjective",func=function(n,a)if Tpp.IsLocalPlayer(n)then
e.AddMissionObjective"mission_common_objective_bringBack_questItem"end
end},{msg="BuildingSpawnEffectEnd",func=function(i,n,n)local n=e.extraTargetGimmickTableListTable
if Tpp.IsTypeTable(n)then
local a=e.questVariationCount
local a=e.waveVariationIndex
local n=n[a]if Tpp.IsTypeTable(n)then
for s,n in ipairs(n)do
if Tpp.IsTypeTable(n)then
local t=n.locatorName
local a=n.datasetName
local r=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=t,dataSetName=a}if i==r then
local n=n.extraTargetRadius or 30
Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=t,dataSetName=a,isExtraTarget=true,extraTargetRadius=n}e.DisableAllExtraTargetMarker()if not Tpp.IsTypeTable(mvars.currentExtraTargetList)then
mvars.currentExtraTargetList={}end
mvars.currentExtraTargetList[s]=true
end
end
end
end
end
end},{msg="BuyCoopQuestShop",func=function(n)if n==Fox.StrCode32"SHOP_GIMMICK"then
local n=e.questGimmickTableListTable
if Tpp.IsTypeTable(n)then
local a=e.questVariationCount
local e=e.waveVariationIndex
local e=n[e]if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
if Tpp.IsTypeTable(e)then
Gimmick.ResetGimmick(e.type,e.locatorName,e.datasetName,{needSpawnEffect=true})end
end
end
end
elseif n==Fox.StrCode32"SHOP_AMMOBOX"then
local e=e.craftGimmickTableTable
if Tpp.IsTypeTable(e)then
local e=e[Fox.StrCode32"PRD_BLD_AmmoBox"]if Tpp.IsTypeTable(e)then
Gimmick.ResetGimmick(e.type,e.locatorName,e.datasetName,{needSpawnEffect=true})end
end
elseif n==Fox.StrCode32"SHOP_WALKERGEAR"then
elseif n==Fox.StrCode32"SHOP_METALGEAR_RAY"then
end
end}},Timer={{sender="Timer_WaitStartCloseDigger",msg="Finish",func=function()TopLeftDisplaySystem.RequestClose()e.SetActionDigger{action="SetRewardMode"}e.SetActionDigger{action="Open"}local n=e.GetDefensePosition()local n=Vector3(n[1],n[2]+12,n[3])e.SetActionDigger{action="SetTargetPos",position=n}end,option={isExecMissionClear=true}},{sender="Timer_Close_Digger",msg="Finish",func=function()e.SetActionDigger{action="StopRewardWormhole"}GkEventTimerManager.Start("Timer_StartVanishDigger",13)end,option={isExecMissionClear=true}},{sender="Timer_Destroy_Reward_Singularity",msg="Finish",func=function()local e=e.singularityEffectName
if e then
TppDataUtility.DestroyEffectFromGroupId(e)TppDataUtility.CreateEffectFromGroupId"destroy_singularity_reward"end
end,option={isExecMissionClear=true}},{sender="Timer_Reward",msg="Finish",func=function()if not mvars.announceLogSuspended then
TppUiStatusManager.UnsetStatus("AnnounceLog","SUSPEND_LOG")mvars.announceLogSuspended=true
end
local e=false
if mvars.finalScore then
if not mvars.currentRewardIndex then
mvars.currentRewardIndex=0
end
if mvars.currentRewardIndex<b then
e=Mission.DropCoopRewardBox(mvars.currentRewardIndex)table.remove(mvars.bcm_rewardOffsetTable,index)mvars.finalRewardDropped=true
mvars.currentRewardIndex=mvars.currentRewardIndex+1
end
end
if e then
GkEventTimerManager.Start("Timer_Reward",.1)end
end,option={isExecMissionClear=true}},{sender="Timer_OpenResult",msg="Finish",func=function()ResultSystem.OpenCoopResult()GkEventTimerManager.Start("Timer_Close_Digger",2)end,option={isExecMissionClear=true}},{sender="Timer_StartVanishDigger",msg="Finish",func=function()local e=e.targetGimmickTable
Gimmick.SetVanish{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName}Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}end,option={isExecMissionClear=true}},{sender="WaitCameraMoveEnd",msg="Finish",func=function()TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"RestartRevivePlayer")end},{sender="Timer_TickShockWave",msg="Finish",func=function()if TppSequence.GetCurrentSequenceName()~="Seq_Game_DefenseWave"then
GkEventTimerManager.Start("Timer_TickShockWave",1)return
end
if Tpp.IsTypeNumber(mvars.currentShockWaveRadius)and Tpp.IsTypeNumber(mvars.shockWaveRadiusAdditionalValue)then
mvars.currentShockWaveRadius=mvars.currentShockWaveRadius+mvars.shockWaveRadiusAdditionalValue
if mvars.currentShockWaveRadius>mvars.waveFinishShockWaveRadiusMax then
mvars.currentShockWaveRadius=mvars.waveFinishShockWaveRadiusMax
else
GkEventTimerManager.Start("Timer_TickShockWave",1)end
Mission.SetDiggerShockWaveRadiusAtWaveFinish(mvars.currentShockWaveRadius)end
end}},UI={{msg="MiningMachineMenuRequestPulloutSelected",func=function()if TppSequence.GetSequenceIndex"Seq_Game_Stealth"<TppSequence.GetCurrentSequenceIndex()then
Mission.VoteEscape()mvars.isVotingResultEscape=true
end
end},{msg="MiningMachineMenuCancelPulloutSelected",func=function()end},{msg="CoopMissionResultClosed",option={isExecMissionClear=true},func=function()e.OnCloseResult()end},{msg="CoopRewardClosed",option={isExecMissionClear=true},func=function()e.OnMissionEnd()end},{msg="EndFadeOut",sender="StartAutoRevivePlayer",func=function()local n={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}local e={id="Revive",revivalType="Respawn"}GameObject.SendCommand(n,e)end},{msg="AbandonFromPauseMenu",func=function()mvars.bcm_requestAbandon=true
TppUI.FadeOut(TppUI.FADE_SPEED.MOMENT)if Mission.IsJoinedCoopRoom()then
TppMission.DisconnectMatching(true)else
TppMission.AbandonMission()end
end},{msg="TimeOutSyncCoopReward",option={isExecMissionClear=true},func=function()e.OnStartDropReward()end},{msg="TimeOutCoopResult",option={isExecMissionClear=true},func=function()e.OnCloseResult()end},{msg="TimeOutCoopReward",option={isExecMissionClear=true},func=function()e.OnMissionEnd()end},{msg="GameOverMenuAutomaticallyClosed",option={isExecMissionClear=true},func=function()if IS_GC_2017_COOP then
if TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
local n={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}local e={id="Revive",revivalType="Respawn"}GameObject.SendCommand(n,e)else
TppUI.FadeIn()end
end
end},{msg="PopupClose",func=function(e)if e==5210 then
TppMain.EnableAllGameStatus()TppMain.DisablePause()TppException.OnSessionDisconnectFromHost()end
end}},Network={{msg="StartHostMigration",func=function()e.HostMigration_OnEnter()end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},{msg="FinishHostMigration",func=function(n)if n==0 then
e.HostMigration_Failed()else
e.HostMigration_OnLeave()end
end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},{msg="SuccessedLeaveRoomAndSession",func=function()if mvars.bcm_requestAbandon then
TppSequence.SetNextSequence"Seq_Game_EstablishClear"end
end}},Trap={{sender="trap_collection",msg="Enter",func=function(n,e)if Tpp.IsLocalPlayer(e)then
SsdSbm.ShowSettlementReport()end
end}}}function e.Messages()if Tpp.IsTypeTable(e.messageTable)then
return a(e.messageTable)else
return{}end
end
function e.OnCloseResult()if mvars.bcm_isCalledOnClseResult then
return
end
mvars.bcm_isCalledOnClseResult=true
CoopRewardSystem.RequestOpen()TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_none"TppUI.FadeOut()TppGameStatus.Set("TppMain.lua","S_DISABLE_PLAYER_PAD")end
function e.GoToGameOver(e)if mvars.bcm_requestAbandon then
return
end
if IS_GC_2017_COOP and(not e)then
mvars.e3_bcm_gameover_isShowGameOver=true
GameOverMenuSystem.SetType(GameOverType.Normal)GameOverMenuSystem.RequestOpen()return
end
mvars.bcm_requestGameOver=true
if e then
mvars.bcm_gameOverType=TppDefine.GAME_OVER_TYPE.DEFENSE_TARGET_WAS_DESTROYED
mvars.bmc_gameOverRadio=TppDefine.GAME_OVER_RADIO.TARGET_DEAD
else
mvars.bcm_gameOverType=TppDefine.GAME_OVER_TYPE.PLAYER_DEAD
mvars.bmc_gameOverRadio=TppDefine.GAME_OVER_RADIO.PLAYER_DEAD
end
TppSequence.SetNextSequence("Seq_Game_EstablishClear",{isExecGameOver=true})end
function e.SetWaveMistVisible(n,e)if e then
Mission.EnableWaveEffect()else
Mission.DisableWaveEffect()end
end
function e.ResetDiggerGimmick()local n=e.targetGimmickTable
if Tpp.IsTypeTable(n)then
if Gimmick.CanTransfering~=nil then
local e=Gimmick.CanTransfering{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName}if not e then
return
end
end
Gimmick.ResetGimmick(n.type,n.locatorName,n.datasetName,{needSpawnEffect=true})mvars.bcm_isAlreadySetupDigger=true
end
e.CheckMissionObjective"mission_common_objective_putDigger"e.AddMissionObjective"mission_common_objective_bootDigger"end
function e.BrokenMiningMachine(a,n)local n=e.targetGimmickTable
if Tpp.IsTypeTable(n)then
local t=n.locatorName
local n=n.datasetName
local n=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=t,dataSetName=n}if a==n then
e.DoBrokenMainDigger()else
local n=e.extraTargetGimmickTableListTable
if Tpp.IsTypeTable(n)then
local t=e.questVariationCount
local e=e.waveVariationIndex
local e=n[e]if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
if Tpp.IsTypeTable(e)then
local n=e.locatorName
local e=e.datasetName
local t=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=n,dataSetName=e}if a==t then
Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=n,dataSetName=e,isExtraTarget=true,isActiveTarget=false}end
end
end
end
end
end
end
end
function e.DoBrokenMainDigger()mvars.miningMachineBroken=true
if mvars.waveCount and mvars.waveCount>0 then
e.OnDefenseGameClear()else
local n,a=Gimmick.SsdGetPosAndRot{gameObjectId=gameObjectId}if n then
local e=TppPlayer.GetDefenseTargetBrokenCameraInfo(n,a,locatorName,upperLocatorName)TppPlayer.ReserveDefenseTargetBrokenCamera(e)end
e.GoToGameOver(true)end
end
function e.EnableExtraTargetMarker(n)local a=e.extraTargetGimmickTableListTable
if Tpp.IsTypeTable(a)then
local t=e.questVariationCount
local e=e.waveVariationIndex
local e=a[e]if Tpp.IsTypeTable(e)then
for i,e in ipairs(e)do
if Tpp.IsTypeTable(e)then
local a=e.markerName
local t=e.wave
if(Tpp.IsTypeString(a)and((not Tpp.IsTypeTable(t)or not Tpp.IsTypeNumber(n))or t[n]))and not mvars.currentExtraTargetList[i]then
TppMarker.Enable(a,0,"moving","all",0,true,false)Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=false}local e=e.floatingSingularityEffectName
if e then
TppDataUtility.CreateEffectFromGroupId(e)end
end
end
end
end
end
end
function e.DisableAllExtraTargetMarker(a)local n=e.extraTargetGimmickTableListTable
if Tpp.IsTypeTable(n)then
local t=e.questVariationCount
local e=e.waveVariationIndex
local e=n[e]if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
if Tpp.IsTypeTable(e)then
local n=e.markerName
if Tpp.IsTypeString(n)then
TppMarker.Disable(n)Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}end
if a then
local e=e.floatingSingularityEffectName
if e then
TppDataUtility.DestroyEffectFromGroupId(e)end
end
end
end
end
end
end
function e.OnDefenseGameClear()if mvars.bcm_requestAbandon then
return
end
TppMission.StopDefenseTotalTime()end
e.sequences={}e.sequences.Seq_Demo_SyncGameStart={messageTable={Timer={{sender="Timer_SyncStart",msg="Finish",func=function()e.SetStartMissionSequence()end}}},Messages=function(e)local e=e.messageTable
if Tpp.IsTypeTable(e)then
return a(e)end
end,OnEnter=function(e)GkEventTimerManager.Start("Timer_SyncStart",m)mvars.bcs_syncStartTime=Time.GetRawElapsedTimeSinceStartUp()end,DEBUG_TextPrint=function(e)local n=DebugText.NewContext()DebugText.Print(n,{.5,.5,1},e)end,OnUpdate=function(a)local n=Time.GetRawElapsedTimeSinceStartUp()-mvars.bcs_syncStartTime
if DebugText then
a.DEBUG_TextPrint(string.format("[Seq_Demo_SyncGameStart] Waiting coop member loading. : coop member wait time = %02.2f[s] : TIMEOUT = %02.2f[s]",n,m))end
if not mvars.bcs_isReadyLocal and not Mission.IsCoopRequestBusy()then
mvars.bcs_isReadyLocal=true
Mission.SetIsReadyCoopMission(true)end
if Mission.IsReadyCoopMissionAllMembers()then
e.SetStartMissionSequence()end
TppUI.ShowAccessIconContinue()end,OnLeave=function()Mission.HostMigration_SetActive(true)end}function e.SetStartMissionSequence()TppMission.EnableInGameFlag()if Mission.CanJoinSession()then
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"StartMainGame")TppSequence.SetNextSequence(e.GetGameSequenceFromDefenseGameState())else
TppSequence.SetNextSequence"Seq_Demo_HostAlreadyCleared"end
end
e.sequences.Seq_Demo_HostAlreadyCleared={OnEnter=function()TppMission.EnableInGameFlag()TppMission.DisconnectMatching(true)svars.mis_isDefiniteMissionClear=false
mvars.mis_isReserveMissionClear=false
TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST,Popup.TYPE_ONE_BUTTON)end,OnUpdate=function()if not TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST)then
TppMission.AbandonMission()end
end}e.sequences.Seq_Game_Ready={messageTable={Timer={{sender="Timer_Start",msg="Finish",func=function()TppSequence.SetNextSequence"Seq_Game_Stealth"end}}},Messages=function(e)local e=e.messageTable
if Tpp.IsTypeTable(e)then
return a(e)end
end,OnEnter=function()if TppMission.IsCoopMission(vars.missionCode)then
if not(Mission.IsReadyCoopMissionHostMember()or mvars.isHostMigration)then
TppMission.AbandonMission()return
end
end
TppUiStatusManager.UnsetStatus("AnnounceLog","SUSPEND_LOG")if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnSequenceStarted)then
mvars.bcm_radioScript.OnSequenceStarted()end
GkEventTimerManager.Start("Timer_Start",5)local n=e.extraTargetGimmickTableListTable
if Tpp.IsTypeTable(n)then
local a=e.questVariationCount
local e=e.waveVariationIndex
local e=n[e]if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}end
end
end
end}function e.OnBuildingSpawnEffectEnd(a,n,n)local n=e.targetGimmickTable
if Tpp.IsTypeTable(n)then
local n=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName}if a==n and not mvars.bcm_isAlreadySetupDigger then
local n=e.GetDefensePosition()if n then
Mission.SetDefensePosition{pos=n}end
mvars.bcm_isAlreadySetupDigger=true
if not mvars.waveEffectVisibility then
Mission.SetPlacedDigger()e.SetWaveMistVisible(1,true)mvars.waveEffectVisibility=true
end
e.CheckMissionObjective"mission_common_objective_putDigger"e.AddMissionObjective"mission_common_objective_bootDigger"e.EnableExtraTargetMarker(1)end
end
end
e.sequences.Seq_Game_Stealth={messageTable={GameObject={{msg="DefenseChangeState",func=function(n,e)if e==TppDefine.DEFENSE_GAME_STATE.WAVE then
TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
end},{msg="BuildingSpawnEffectEnd",func=e.OnBuildingSpawnEffectEnd}},UI={{msg="MiningMachineMenuRestartMachineSelected",func=function()local e=e.targetGimmickTable
Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}Mission.StopDefenseGamePrepare()end}}},Messages=function(e)local e=e.messageTable
if Tpp.IsTypeTable(e)then
return a(e)end
end,OnEnter=function()TppMission.UpdateObjective{objectives={"marker_target"}}local n=e.gimmickObjectiveMap
if Tpp.IsTypeTable(n)then
for n,e in pairs(n)do
TppMission.UpdateObjective{objectives={e}}end
end
local n=e.prepareTime or v
TppMission.StartDefenseGame(n)if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnSequenceStarted)then
mvars.bcm_radioScript.OnSequenceStarted()end
e.AddMissionObjective"mission_common_objective_putDigger"end,OnLeave=function()TppMission.UpdateObjective{objectives={"marker_target_disable"}}end}e.sequences.Seq_Game_WaitStartDigger={Messages=function(n)return a{GameObject={{msg="DefenseChangeState",func=function(n,e)if e==TppDefine.DEFENSE_GAME_STATE.WAVE then
TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
end},{msg="DiggingStartEffectEndCoop",func=function()n.isStartDigger=true
TppSequence.SetNextSequence"Seq_Game_DefenseWave"end},{msg="FinishWaveInterval",func=function()end},{msg="DiggerShootEffect",func=function(n,e)if e~=1 then
return
end
GkEventTimerManager.Start("Timer_DestroySingularityEffect",.9)end},{msg="BuildingSpawnEffectEnd",func=e.OnBuildingSpawnEffectEnd}},Timer={{msg="Finish",sender="Timer_DestroySingularityEffect",func=function()local n=e.singularityEffectName
if n then
TppDataUtility.DestroyEffectFromGroupId(n)TppDataUtility.CreateEffectFromGroupId"destroy_singularity"TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,1,{fogDensity=e.waveFogDensity})end
end}}}end,OnEnter=function(t)local a=Mission.GetRestWaveInterval()>.1
local n=e.targetGimmickTable
Gimmick.SetAction{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName,action="Open",offsetPosition=Vector3(0,12,0)}if not a then
TopLeftDisplaySystem.RequestClose()end
local e=e.targetGimmickTable
Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}t.isStartDigger=false
end,OnLeave=function(n)local e=e.targetGimmickTable
Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=false}if not GkEventTimerManager.IsTimerActive"Timer_TickShockWave"then
GkEventTimerManager.Start("Timer_TickShockWave",1)end
end}e.sequences.Seq_Game_DefenseWave={messageTable={GameObject={{msg="FinishWave",func=function(a,n)if n>=Mission.GetTotalWaveCount()then
e.OnDefenseGameClear()else
TppSequence.SetNextSequence"Seq_Game_DefenseBreak"end
end},{msg="DefenseChangeState",func=function(n,e)if e==TppDefine.DEFENSE_GAME_STATE.WAVE_INTERVAL then
TppSequence.SetNextSequence"Seq_Game_DefenseBreak"end
end}},nil},Messages=function(e)local n=e.messageTable
if Tpp.IsTypeTable(n)then
return a(e.messageTable)end
end,OnEnter=function(n)mvars.waveCount=mvars.waveCount+1
e.StartWave(mvars.waveCount)if not mvars.waveEffectVisibility then
e.SetWaveMistVisible(mvars.waveCount,true)end
mvars.waveEffectVisibility=nil
if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnSequenceStarted)then
mvars.bcm_radioScript.OnSequenceStarted()end
GkEventTimerManager.Start("Timer_Tick",30)if WavePopupSystem and Tpp.IsTypeFunc(WavePopupSystem.RequestOpen)then
WavePopupSystem.RequestOpen{type=WavePopupType.START,waveCount=mvars.waveCount}end
if mvars.waveCount==1 then
e.CheckMissionObjective"mission_common_objective_bootDigger"e.AddMissionObjective"mission_common_objective_defendDigger_coop"TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,1,{fogDensity=e.waveFogDensity})end
e.DisableAllExtraTargetMarker(true)local e=n.AfterOnEnter
if Tpp.IsTypeFunc(e)then
e(n)end
end,OnLeave=function(n)if mvars.bcm_requestGameOver or mvars.bcm_requestAbandon then
return
end
GameObject.SendCommand({type="TppCommandPost2"},{id="EndWave"})e.SetWaveMistVisible(mvars.waveCount,false)GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=false})Mission.DiggerShockWave{type=TppDefine.DIGGER_SHOCK_WAVE_TYPE.FINISH_WAVE}TppSoundDaemon.PostEvent"sfx_s_waveend_plasma"GameObject.SendCommand({type="TppCommandPost2"},{id="KillWaveEnemy"})if not mvars.bcm_requestGameOver and not mvars.votingResult then
if TppSequence.GetCurrentSequenceName()=="Seq_Game_EstablishClear"then
if mvars.miningMachineBroken then
if WavePopupSystem and Tpp.IsTypeFunc(WavePopupSystem.RequestOpen)then
WavePopupSystem.RequestOpen{type=WavePopupType.DEFENSE_FAILURE}end
else
ResultSystem.OpenPopupResult()end
elseif WavePopupSystem and Tpp.IsTypeFunc(WavePopupSystem.RequestOpen)then
WavePopupSystem.RequestOpen{type=WavePopupType.FINISH,waveCount=mvars.waveCount}end
end
local n=e.singularityEffectName
if n then
TppDataUtility.CreateEffectFromGroupId(n)end
local n=e.extraTargetGimmickTableListTable
if Tpp.IsTypeTable(n)then
local a=e.questVariationCount
local e=e.waveVariationIndex
local e=n[e]local n=mvars.currentExtraTargetList
if Tpp.IsTypeTable(n)and Tpp.IsTypeTable(e)then
for n,a in pairs(n)do
local e=e[n]if Tpp.IsTypeTable(e)then
Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,isExtraTarget=true,isActiveTarget=false}Gimmick.SetVanish{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName}end
end
end
end
if mvars.waveCount==1 then
local e=e.breakableGimmickTableList
if Tpp.IsTypeTable(e)then
for n,e in ipairs(e)do
if Tpp.IsTypeTable(e)then
Gimmick.BreakGimmick(-1,e.locatorName,e.datasetName)end
end
end
end
end}e.sequences.Seq_Game_DefenseBreak={messageTable={GameObject={{msg="FinishWaveInterval",func=function()TppSequence.SetNextSequence"Seq_Game_WaitStartDigger"end},{msg="DefenseChangeState",func=function(n,e)if e==TppDefine.DEFENSE_GAME_STATE.WAVE then
TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
end},{msg="StartRebootDigger",func=function()TppSequence.SetNextSequence"Seq_Game_WaitStartDigger"end}},Timer={{sender="Timer_WaitSync",msg="Finish",func=function()TppPlayer.EnableSwitchIcon()if not mvars.waveEffectVisibility then
e.SetWaveMistVisible(mvars.waveCount+1,true)mvars.waveEffectVisibility=true
end
end}},UI={{msg="MiningMachineMenuRestartMachineSelected",func=function()local e=e.targetGimmickTable
Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}TppMission.StopWaveInterval()if mvars.continueFromDefenseBreak then
TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
end}}},Messages=function(e)local e=e.messageTable
if Tpp.IsTypeTable(e)then
return a(e)end
end,OnEnter=function()if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnSequenceStarted)then
mvars.bcm_radioScript.OnSequenceStarted()end
GkEventTimerManager.Start("Timer_WaitSync",10)TppPlayer.DisableSwitchIcon()if not mvars.continueFromDefenseBreak then
local n=S
local e=e.intervalTimeTable
if Tpp.IsTypeTable(e)then
local e=e[mvars.waveCount]if Tpp.IsTypeNumber(e)then
n=e
end
end
TppMission.StartWaveInterval(n)end
e.EnableExtraTargetMarker(mvars.waveCount+1)end,OnLeave=function()TppPlayer.EnableSwitchIcon()end}e.sequences.Seq_Game_EstablishClear={OnEnter=function(n)if IS_GC_2017_COOP and mvars.e3_bcm_gameover_isShowGameOver then
GameOverMenuSystem.RequestClose()end
TppUiStatusManager.SetStatus("PauseMenu","INVALID")if not(mvars.bcm_requestGameOver or mvars.bcm_requestAbandon)then
Mission.UpdateCoopMissionResult()end
SsdSbm.RemoveWithoutTemporaryCopy()SsdSbm.StoreToSVars()n.SetClearType()if not(mvars.bcm_requestGameOver or mvars.bcm_requestAbandon)then
if PlayerInfo.OrCheckStatus{PlayerStatus.DEAD,PL_F_NEAR_DEATH,PL_F_NEAR_DEAD}then
TppPlayer.Revive()end
GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=false})TppMission.UpdateObjective{objectives={"marker_all_disable"}}GameObject.SendCommand({type="TppCommandPost2"},{id="KillWaveEnemy",target="AllWithoutBoss"})local e=e.targetGimmickTable
Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_on"end
GkEventTimerManager.Start("Timer_WaitRewardAllMember",90)GkEventTimerManager.Start("Timer_WaitUpdateFinalScore",.1)e.ClearMissionObjective()Gimmick.SetAllSwitchInvalid(true)SsdUiSystem.RequestForceCloseForMissionClear()TppException.SetSkipDisconnectFromHost()Mission.AddFinalizer(function()TppException.ResetSkipDisconnectFromHost()end)end,Messages=function(e)return a{Timer={{sender="Timer_WaitRewardAllMember",msg="Finish",func=function()TppSequence.SetNextSequence("Seq_Game_RequestCoopEndToServer",{isExecGameOver=true,isExecMissionClear=true})end,option={isExecGameOver=true,isExecMissionClear=true}},{sender="Timer_WaitUpdateFinalScore",msg="Finish",func=function()Mission.RequestCoopRewardToServer()end,option={isExecGameOver=true,isExecMissionClear=true}}}}end,OnUpdate=function()if not Mission.IsEndSynRewardAllMembers()then
return
end
if mvars.bcm_requestAbandon then
TppMission.AbandonMission()mvars.bcm_requestAbandon=false
else
TppSequence.SetNextSequence("Seq_Game_RequestCoopEndToServer",{isExecGameOver=true,isExecMissionClear=true})end
end,SetClearType=function()if mvars.bcm_requestAbandon then
gvars.mis_coopClearType=TppDefine.COOP_CLEAR_TYPE.ABORT
elseif mvars.bcm_requestGameOver then
gvars.mis_coopClearType=TppDefine.COOP_CLEAR_TYPE.FAILURE
else
gvars.mis_coopClearType=TppDefine.COOP_CLEAR_TYPE.CLEAR
end
end,OnLeave=function()end}e.sequences.Seq_Game_RequestCoopEndToServer={OnEnter=function(e)Mission.RequestCoopEndToServer()e.isRequestedGameOver=false
end,OnUpdate=function(e)if Mission.IsCoopRequestBusy()then
return
end
if mvars.bcm_requestGameOver then
if not e.isRequestedGameOver then
TppMission.ReserveGameOver(mvars.bcm_gameOverType,mvars.bmc_gameOverRadio)e.isRequestedGameOver=true
end
else
TppSequence.SetNextSequence("Seq_Game_Clear",{isExecMissionClear=true,isExecMissionClear=true})end
end,OnLeave=function()end}e.sequences.Seq_Game_Clear={OnEnter=function(e)TppMission.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppMission.GetCoopLobbyMissionCode()}MissionObjectiveInfoSystem.Clear()end}function e.SetActionDigger(n)local e=e.targetGimmickTable
Gimmick.SetAction{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,action=n.action,param1=n.param1,position=n.position,offsetPosition=n.offsetPosition}end
function e.HostMigration_OnEnter()TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)TppMain.DisableGameStatus()TppMain.EnablePause()mvars.isHostMigration=true
TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"TppUiCommand.ShowErrorPopup(5209)if TppException.CanExceptionHandlingForFromHost()then
if gvars.exc_processingExecptionType==TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST then
TppException.FinishProcess()end
end
TppUI.ShowAccessIcon()end
function e.HostMigration_OnLeave()TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED)TppMain.EnableAllGameStatus()TppMain.DisablePause()if TppUiCommand.IsShowPopup(5209)then
TppUiCommand.ErasePopup()end
mvars.isHostMigration=false
TppUI.HideAccessIcon()local n=e.targetGimmickTable
if Gimmick.IsBrokenGimmick(n.type,n.locatorName,n.datasetName,1)then
e.DoBrokenMainDigger()end
end
function e.HostMigration_Failed()if TppUiCommand.IsShowPopup(5209)then
TppUiCommand.ErasePopup()end
TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON"TppUiCommand.ShowErrorPopup(5210)end
return e
end
return c