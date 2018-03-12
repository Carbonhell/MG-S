local e={}local n=Fox.StrCode32
local r=GameObject.GetTypeIndex
local o=GameObject.GetGameObjectId
local a=GameObject.NULL_ID
local t=Tpp.IsTypeTable
e.MissionCollectionTable={}e.GIMMICK_TYPE={NONE=0,ANTN=1,MCHN=2,CMMN=3,GUN=4,MORTAR=5,GNRT=6,CNTN=7,ANTIAIR=8,AACR=9,LIGHT=10,TOWER=11,TLET=12,TRSH=13,CSET=14,SWTC=15,FLOWSTATION_TANK001=100,FLOWSTATION_TANK002=101,FACTORY_WALL=102,FACTORY_FRAME=103,FACTORY_WTTR=104,FACTORY_TNNL=105,LAB_BRDG=106,FACTORY_TANK=107,FACTORY_WTNK=108,FACTORY_WSST=109,FLOWSTATION_PDOR=110,FACTORY_CRTN=111,FLOWSTATION_COPS=112,MAX=255}local s={[e.GIMMICK_TYPE.AACR]="destroyRadar"}e.COLLECTION_REPOP_COUNT_DECREMENT_TABLE={[TppCollection.TYPE_DIAMOND_LARGE]=60,[TppCollection.TYPE_DIAMOND_SMALL]=100,[TppCollection.TYPE_MATERIAL_CM_0]=100,[TppCollection.TYPE_MATERIAL_CM_1]=100,[TppCollection.TYPE_MATERIAL_CM_2]=100,[TppCollection.TYPE_MATERIAL_CM_3]=100,[TppCollection.TYPE_MATERIAL_CM_4]=100,[TppCollection.TYPE_MATERIAL_CM_5]=100,[TppCollection.TYPE_MATERIAL_CM_6]=100,[TppCollection.TYPE_MATERIAL_CM_7]=100,[TppCollection.TYPE_MATERIAL_MM_0]=100,[TppCollection.TYPE_MATERIAL_MM_1]=100,[TppCollection.TYPE_MATERIAL_MM_2]=100,[TppCollection.TYPE_MATERIAL_MM_3]=100,[TppCollection.TYPE_MATERIAL_MM_4]=100,[TppCollection.TYPE_MATERIAL_MM_5]=100,[TppCollection.TYPE_MATERIAL_MM_6]=100,[TppCollection.TYPE_MATERIAL_MM_7]=100,[TppCollection.TYPE_MATERIAL_PM_0]=100,[TppCollection.TYPE_MATERIAL_PM_1]=100,[TppCollection.TYPE_MATERIAL_PM_2]=100,[TppCollection.TYPE_MATERIAL_PM_3]=100,[TppCollection.TYPE_MATERIAL_PM_4]=100,[TppCollection.TYPE_MATERIAL_PM_5]=100,[TppCollection.TYPE_MATERIAL_PM_6]=100,[TppCollection.TYPE_MATERIAL_PM_7]=100,[TppCollection.TYPE_MATERIAL_FR_0]=100,[TppCollection.TYPE_MATERIAL_FR_1]=100,[TppCollection.TYPE_MATERIAL_FR_2]=100,[TppCollection.TYPE_MATERIAL_FR_3]=100,[TppCollection.TYPE_MATERIAL_FR_4]=100,[TppCollection.TYPE_MATERIAL_FR_5]=100,[TppCollection.TYPE_MATERIAL_FR_6]=100,[TppCollection.TYPE_MATERIAL_FR_7]=100,[TppCollection.TYPE_MATERIAL_BR_0]=100,[TppCollection.TYPE_MATERIAL_BR_1]=100,[TppCollection.TYPE_MATERIAL_BR_2]=100,[TppCollection.TYPE_MATERIAL_BR_3]=100,[TppCollection.TYPE_MATERIAL_BR_4]=100,[TppCollection.TYPE_MATERIAL_BR_5]=100,[TppCollection.TYPE_MATERIAL_BR_6]=100,[TppCollection.TYPE_MATERIAL_BR_7]=100,[TppCollection.TYPE_HERB_G_CRESCENT]=100,[TppCollection.TYPE_HERB_A_PEACH]=100,[TppCollection.TYPE_HERB_DIGITALIS_P]=100,[TppCollection.TYPE_HERB_DIGITALIS_R]=100,[TppCollection.TYPE_HERB_B_CARROT]=100,[TppCollection.TYPE_HERB_WORM_WOOD]=100,[TppCollection.TYPE_HERB_TARRAGON]=100,[TppCollection.TYPE_HERB_HAOMA]=100,[TppCollection.TYPE_HERB_0]=100,[TppCollection.TYPE_HERB_1]=100}e.baseImportantGimmickList={afgh={{gimmickId="GIM_P_AI",locatorName="com_ai001_gim_n0000|srt_aip0_main0_def",datasetName="/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2"},{gimmickId="GIM_P_AI_Skill",locatorName="com_ai002_gim_n0000|srt_pup0_main0_ssd_v00",datasetName="/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2"},{gimmickId="GIM_P_AI_Building",locatorName="com_ai003_gim_n0000|srt_ssde_swtc001",datasetName="/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2"},{gimmickId="GIM_P_Digger",locatorName="whm0_gim_n0000|srt_whm0_main0_def_v00",datasetName="/Assets/ssd/level/location/afgh/block_common/afgh_common_asset.fox2"}},mafr={{gimmickId="GIM_P_AI",locatorName="com_ai001_gim_n0000|srt_aip0_main0_def",datasetName="/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2"},{gimmickId="GIM_P_AI_Skill",locatorName="com_ai002_gim_n0000|srt_pup0_main0_ssd_v00",datasetName="/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2"}}}e.AFGH_BASE_AI_POSITION=Vector3(-450.433,286.854,2240.017)if Mission.RegisterBaseDiggerInfo then
local e={name="whm0_gim_n0000|srt_whm0_main0_def_v00",dataSetName="/Assets/ssd/level/location/afgh/block_common/afgh_common_asset.fox2",position=Vector3(-445.8298034668,289.92861938477,2246.2578125)}Mission.RegisterBaseDiggerInfo(e)end
function e.Messages()return Tpp.StrCode32Table{Radio={{msg="Finish",sender="f1000_rtrg2020",func=function()TppUI.ShowAnnounceLog"unlockLz"end}},UI={{msg="EndFadeIn",sender="FadeInOnGameStart",func=function()e.OnMissionGameStart()end,option={isExecMissionPrepare=true,isExecMissionClear=true}}},nil}end
function e.IsBroken(e)if not t(e)then
return
end
local i,t
i=e.gimmickId
t=e.searchFromSaveData
if not i then
return
end
if not mvars.gim_identifierParamTable then
return
end
local e=mvars.gim_identifierParamTable[i]if Gimmick.IsBrokenGimmick and e then
if t then
return Gimmick.IsBrokenGimmick(e.type,e.locatorName,e.dataSetName)else
return Gimmick.IsBrokenGimmick(e.type,e.locatorName,e.dataSetName,1)end
end
end
function e.ResetGimmick(i)if not t(i)then
return
end
if not e.IsBroken(i)then
return
end
local e
e=i.gimmickId
if not e then
return
end
local e=mvars.gim_identifierParamTable[e]if Gimmick.ResetGimmick and e then
Gimmick.ResetGimmick(e.type,e.locatorName,e.dataSetName)end
end
function e.EnableMarkerGimmick(e)local e=mvars.gim_identifierParamTable[e]if not Gimmick.BreakGimmick then
return
end
Gimmick.EnableMarkerGimmick(e.type,e.locatorName,e.dataSetName,true)end
function e.GetPosAndRotByGimmickIdentifier(e)local e=Gimmick.SsdGetGameObjectId(e)local e,i=Gimmick.SsdGetPosAndRot{gameObjectId=e}if not e then
return
end
return e,i
end
function e.GetPositionTableByGimmickIdentifier(i)local e=e.GetPosAndRotByGimmickIdentifier(i)if e then
return TppMath.Vector3toTable(e)end
end
function e.GetDiggerDefensePosition(i)if not t(i)then
return
end
if i.gimmickId~="GIM_P_Digger"then
return
end
local e=e.GetPosAndRotByGimmickIdentifier(i)if e then
return TppMath.Vector3toTable(e-Vector3(0,2.7,0))end
end
function e.OnAllocate(i)if TppLocation.IsAfghan()then
TppCollection.SetScriptDeclVars("col_daimondStatus_afgh","col_markerStatus_afgh","col_isRegisteredInDb_afgh")elseif TppLocation.IsMiddleAfrica()then
TppCollection.SetScriptDeclVars("col_daimondStatus_mafr","col_markerStatus_mafr","col_isRegisteredInDb_mafr")end
e.SetAfghBaseDiggerLevel()end
function e.Init(i)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())if TppMission.IsFreeMission(vars.missionCode)then
Gimmick.EspionageBoxOnGround(false)else
Gimmick.EspionageBoxOnGround(true)end
if TppMission.IsFreeMission(vars.missionCode)then
mvars.gim_shownEspionageBox=true
Gimmick.EspionageBoxAllInvisible(false)elseif not TppMission.IsMissionStart()then
mvars.gim_shownEspionageBox=false
Gimmick.EspionageBoxAllInvisible(true)else
mvars.gim_shownEspionageBox=true
Gimmick.EspionageBoxAllInvisible(false)end
TppTerminal.InitializeBluePrintLocatorIdTable()if TppMission.IsMissionStart()then
for t,n in pairs(e.MissionCollectionTable)do
local i=(vars.missionCode==t)if i==false then
if TppMission.IsHardMission(vars.missionCode)then
local e=TppMission.GetNormalMissionCodeFromHardMission(vars.missionCode)i=(e==t)end
end
e.EnableCollectionTable(n,i,true)end
else
e.RepopMissionTaskCollection()end
local i={"col_develop_BullpupAR","col_develop_LongtubeShotgun","col_develop_RevolverGrenade0001","col_develop_RevolverGrenade0002","col_develop_RevolverGrenade0003","col_develop_RevolverGrenade0004","col_develop_EuropeSMG0001","col_develop_EuropeSMG0002","col_develop_EuropeSMG0003","col_develop_EuropeSMG0004","col_develop_Stungrenade"}e.EnableCollectionTable(i,true)e.InitQuest()e.InitializeBaseImportantGimmick()end
function e.InitializeBaseImportantGimmick()local i=TppLocation.GetLocationName()if not i then
return
end
local e=e.baseImportantGimmickList[i]if not e then
return
end
mvars.gim_baseImportantGimmickList=e
mvars.gim_isBaseImportantGimmick={}for i,e in ipairs(mvars.gim_baseImportantGimmickList)do
local e=Gimmick.SsdGetGameObjectId{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName}if e then
mvars.gim_isBaseImportantGimmick[e]=true
end
end
end
function e.RepopMissionTaskCollection()local i=vars.missionCode
local e=e.MissionCollectionTable[i]if not e then
return
end
for t,i in pairs(e)do
if TppCollection.IsExistLocator(i)and(TppCollection.RepopCountOperation("GetAt",i)>0)then
local e=false
local t=missionTaskTable[t]if t=="first"then
if not svars.isCompleteFirstBonus then
e=true
end
else
if(svars.mis_objectiveEnable[t]==false)then
e=true
end
end
if e then
TppCollection.RepopCountOperation("SetAt",i,0)end
end
end
end
function e.OnReload()e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
function e.OnMessage(i,a,m,r,n,o,t)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,i,a,m,r,n,o,t)end
function e.OnMissionGameStart()if not TppMission.IsFreeMission(vars.missionCode)then
if mvars.gim_shownEspionageBox then
Gimmick.EspionageBoxFadeout()end
end
end
function e.DecrementCollectionRepopCount()for i,e in pairs(e.COLLECTION_REPOP_COUNT_DECREMENT_TABLE)do
TppCollection.RepopCountOperation("DecByType",i,e)end
end
function e.MafrRiverPrimSetting()if not TppEffectUtility.UpdatePrimRiver then
return
end
if vars.missionCode==10080 or vars.missionCode==11080 then
e.SetMafrRiverPrimVisibility(false)else
e.SetMafrRiverPrimVisibility(true)end
end
function e.SetMafrRiverPrimVisibility(a)local e={"cleanRiver","dirtyRiver","oilMud_open","dirtyFlow"}local t={true,false,false,false}for i,n in ipairs(e)do
local e
if a then
e=t[i]else
e=not t[i]end
TppEffectUtility.SetPrimRiverVisibility(n,e)end
TppEffectUtility.UpdatePrimRiver()end
function e.GetStoryDiggerFinCount()local e=3
local i={{TppDefine.STORY_SEQUENCE.BEFORE_k40077,1},{TppDefine.STORY_SEQUENCE.CLEARED_k40077,2},{TppDefine.STORY_SEQUENCE.CLEARED_k40140,3}}local n=TppStory.GetCurrentStorySequence()for t,i in ipairs(i)do
local t,i=i[1],i[2]if(n>=t)then
e=i
end
end
return e
end
function e.SetStoryDiggerFinCount()local i=e.GetStoryDiggerFinCount()e.SetAfghBaseDiggerFinCount(i)end
function e.SetAfghBaseDiggerFinCount(i)local e=e.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetFinCount",param1=i}end
function e.SetAfghBaseDiggerTargetToReturnWormhole()local i,t=Tpp.GetLocatorByTransform("DataIdentifier_afgh_common_base","ReturnWormholePosition")local e=e.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetTargetPos",position=i}end
function e.ResetAfghBaseDiggerTarget()local e=e.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="ResetTargetPos"}Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="ResetSupplyMode"}end
function e.OpenAfghBaseDigger()local e=e.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Open",param1=1}Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetSupplyMode"}end
function e.CloseAfghBaseDigger()local e=e.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Close",param1=1}end
function e.RegisterAfghBaseDiggerName()local e=e.baseImportantGimmickList.afgh[4]Gimmick.RegisterBaseDiggerName{name=e.locatorName,dataSetName=e.datasetName}end
function e.SetAfghBaseDiggerLevel()if TppLocation.IsInit()then
return
end
local n=TppStory.GetMissionEnemyLevel()+1
local e=e.baseImportantGimmickList.afgh[4]local t,e,i=e.locatorName,e.datasetName,e.gimmickId
Gimmick.SetLevel{gimmickId=i,name=t,dataSetName=e,level=n}Gimmick.ResetGimmick(0,t,e,{gimmickId=i})end
function e.SetUpIdentifierTable(e)mvars.gim_identifierParamTable={}Tpp.MergeTable(mvars.gim_identifierParamTable,e)mvars.gim_identifierParamStrCode32Table={}mvars.gim_gimmackNameStrCode32Table={}for i,t in pairs(e)do
local e=n(i)mvars.gim_identifierParamStrCode32Table[e]=t
mvars.gim_gimmackNameStrCode32Table[e]=i
end
mvars.gim_identifierTable={}for a,t in pairs(e)do
local e=t.type
local i=t.locatorName
local t=t.dataSetName
mvars.gim_identifierTable[e]=mvars.gim_identifierTable[e]or{}local e=mvars.gim_identifierTable[e]e[n(i)]=e[n(i)]or{}local e=e[n(i)]e[Fox.PathFileNameCode32(t)]=a
end
end
function e.SetUpBreakConnectTable(e)mvars.gim_breakConnectTable={}for e,i in pairs(e)do
mvars.gim_breakConnectTable[e]=i
mvars.gim_breakConnectTable[i]=e
end
end
function e.SetUpCheckBrokenAndBreakConnectTable(i)mvars.gim_checkBrokenAndBreakConnectTable={}for i,t in pairs(i)do
e._SetUpCheckBrokenAndBreakConnectTable(i,t)end
end
function e._SetUpCheckBrokenAndBreakConnectTable(n,e)if not mvars.gim_identifierParamTable[n]then
return
end
local t=e.breakGimmickId
local i=e.checkBrokenGimmickId
if not t then
return
end
if not i then
return
end
if not mvars.gim_identifierParamTable[t]then
return
end
if not mvars.gim_identifierParamTable[i]then
return
end
mvars.gim_checkBrokenAndBreakConnectTable[n]=e
mvars.gim_checkBrokenAndBreakConnectTable[i]={checkBrokenGimmickId=n,breakGimmickId=t}end
function e.SetUpUseGimmickRouteTable(e)mvars.gim_routeGimmickConnectTable={}for e,i in pairs(e)do
mvars.gim_routeGimmickConnectTable[n(e)]=i.gimmickId
end
Tpp.DEBUG_DumpTable(mvars.gim_routeGimmickConnectTable)end
function e.GetRouteConnectedGimmickId(e)if not mvars.gim_routeGimmickConnectTable then
return
end
return mvars.gim_routeGimmickConnectTable[e]end
function e.SetUpConnectLandingZoneTable(e)mvars.gim_connectLandingZoneTable={}for e,i in pairs(e)do
mvars.gim_connectLandingZoneTable[e]=i.aprLandingZoneName
end
end
function e.SetUpConnectPowerCutTable(e)mvars.gim_connectPowerCutAreaTable={}mvars.gim_connectPowerCutCpTable={}for i,e in pairs(e)do
local t=e.powerCutAreaName
local e=e.cpName
mvars.gim_connectPowerCutAreaTable[i]=t
if e then
local n=o(e)if n~=a then
mvars.gim_connectPowerCutCpTable[i]=n
local n={type="TppCommandPost2"}local i=mvars.gim_identifierParamTable[i]local e={id="SetPowerSourceGimmick",cpName=e,gimmicks=i,areaName=t}GameObject.SendCommand(n,e)end
end
end
end
function e.SetUpConnectVisibilityTable(e)mvars.gim_connectVisibilityTable={}for e,i in pairs(e)do
mvars.gim_connectVisibilityTable[e]=i
end
end
function e.SetCommunicateGimmick(e)if not t(e)then
return
end
mvars.gim_gimmickIdToCpTable=mvars.gim_gimmickIdToCpTable or{}local r={type="TppCommandPost2"}for t,e in pairs(e)do
local i={}for e,m in ipairs(e)do
local e=mvars.gim_identifierParamTable[m]if e then
table.insert(i,e)end
local e=o(t)if e~=a then
mvars.gim_gimmickIdToCpTable[n(m)]=e
end
end
local n=e.isCommunicateBase
local e=e.groupName
local e={id="SetCommunicateGimmick",cpName=t,isCommunicateBase=n,gimmicks=i,groupName=e}GameObject.SendCommand(r,e)end
end
function e.BreakGimmick(o,t,i,n)local i=e.GetGimmickID(o,t,i)if not i then
return
end
e.BreakConnectedGimmick(i)e.CheckBrokenAndBreakConnectedGimmick(i)e.HideAsset(i)e.ShowAnnounceLog(i)local t=false
if(n==a)then
t=true
end
e.PowerCut(i,true,t)end
function e.GetGimmickID(e,n,i)local t=r(e)local e=mvars.gim_identifierTable
if not e then
return
end
local e=e[t]if not e then
return
end
local e=e[n]if not e then
return
end
local i=e[i]if not e then
return
end
return i
end
function e.GetGameObjectId(e)local e=mvars.gim_identifierParamTable[e]if not e then
return
end
return Gimmick.GetGameObjectId(e.type,e.locatorName,e.dataSetName)end
function e.BreakConnectedGimmick(e)local e=mvars.gim_breakConnectTable[e]if not e then
return
end
local e=mvars.gim_identifierParamTable[e]Gimmick.BreakGimmick(e.type,e.locatorName,e.dataSetName,false)end
function e.CheckBrokenAndBreakConnectedGimmick(i)if not mvars.gim_checkBrokenAndBreakConnectTable then
return
end
local i=mvars.gim_checkBrokenAndBreakConnectTable[i]if not i then
return
end
local t=i.checkBrokenGimmickId
local i=i.breakGimmickId
if e.IsBroken{gimmickId=t}then
local e=mvars.gim_identifierParamTable[i]if e then
Gimmick.BreakGimmick(e.type,e.locatorName,e.dataSetName,false)end
end
end
function e.HideAsset(e)local e=mvars.gim_connectVisibilityTable[e]if not e then
return
end
for t,i in pairs(e.invisibilityList)do
TppDataUtility.SetVisibleDataFromIdentifier(e.identifierName,i,false,true)end
end
function e.Show(i)local e=e.SetVisibility(i,false)end
function e.Hide(i)e.SetVisibility(i,true)end
function e.SetVisibility(e,i)local e=mvars.gim_identifierParamTable[e]if not e then
return
end
Gimmick.InvisibleGimmick(e.type,e.locatorName,e.dataSetName,i)return true
end
function e.ShowAnnounceLog(t)local i=mvars.gim_identifierParamTable[t].gimmickType
if not i then
return
end
local i=s[i]if i then
TppUI.ShowAnnounceLog(i)end
e._ShowCommCutOffAnnounceLog(t)end
function e._ShowCommCutOffAnnounceLog(e)if not mvars.gim_gimmickIdToCpTable then
return
end
local e=mvars.gim_gimmickIdToCpTable[n(e)]if not e then
return
end
GameObject.SendCommand(e,{id="SetCommunicateAnnounce"})end
function e.SwitchGimmick(i,t,n,a)local i=e.GetGimmickID(i,t,n)if not i then
return
end
local t=false
if(a==0)then
t=true
end
e.PowerCut(i,t,false)end
function e.PowerCut(e,i,t)local e=mvars.gim_connectPowerCutAreaTable[e]if e then
if i then
Gimmick.PowerCutOn(e,t)else
Gimmick.PowerCutOff(e)end
end
end
function e.EnableCollectionTable(e,t,n)local i=0
if not t then
i=1
end
local function t(e)return false
end
for a,e in pairs(e)do
if TppCollection.IsExistLocator(e)then
if not t(e)or n then
TppCollection.RepopCountOperation("SetAt",e,i)end
end
end
end
function e.DEBUG_DumpIdentiferParam(i,e)if e then
end
end
function e.InitQuest()mvars.gim_questTargetList={}mvars.gim_isQuestSetup=false
mvars.gim_isquestMarkStart=false
mvars.gim_questMarkStartName=nil
mvars.gim_questMarkStartLocator=nil
mvars.gim_questMarkStartData=nil
mvars.gim_questMarkSetIndex=0
mvars.gim_questMarkCount=0
mvars.gim_questMarkTotalCount=0
end
function e.OnAllocateQuest(e)if e==nil then
return
end
if mvars.gim_isQuestSetup==false then
end
end
function e.OnActivateQuest(i)if i==nil then
return
end
if mvars.gim_isQuestSetup==false then
e.InitQuest()end
local t=false
if mvars.gim_isQuestSetup==false then
if(i.targetGimmicklList and Tpp.IsTypeTable(i.targetGimmicklList))and next(i.targetGimmicklList)then
for i,e in pairs(i.targetGimmicklList)do
local i={gimmickId=e,messageId="None",idType="Gimmick"}table.insert(mvars.gim_questTargetList,i)TppMarker.SetQuestMarkerGimmick(e)end
t=true
end
if(i.targetDevelopList and Tpp.IsTypeTable(i.targetDevelopList))and next(i.targetDevelopList)then
for i,e in pairs(i.targetDevelopList)do
local e={developId=e,messageId="None",idType="Develop"}table.insert(mvars.gim_questTargetList,e)end
t=true
end
if(i.gimmickMarkList and Tpp.IsTypeTable(i.gimmickMarkList))and next(i.gimmickMarkList)then
for i,e in pairs(i.gimmickMarkList)do
if e.isStartGimmick==true then
mvars.gim_questMarkStartName=n(e.locatorName)mvars.gim_questMarkStartLocator=e.locatorName
mvars.gim_questMarkStartData=e.dataSetName
Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,mvars.gim_questMarkStartLocator,mvars.gim_questMarkStartData,true)else
local e={locatorName=e.locatorName,dataSetName=e.dataSetName,messageId="None",setIndex=e.setIndex}table.insert(mvars.gim_questTargetList,e)t=true
mvars.gim_questMarkTotalCount=mvars.gim_questMarkTotalCount+1
end
end
t=true
e.SetQuestInvisibleGimmick(0,true,true)end
if i.gimmickTimerList then
mvars.gim_questDisplayTimeSec=i.gimmickTimerList.displayTimeSec
mvars.gim_questCautionTimeSec=i.gimmickTimerList.cautionTimeSec
t=true
end
if i.gimmickOffsetType then
local e,i=mtbs_cluster.GetDemoCenter(i.gimmickOffsetType,"plnt0")Gimmick.SetOffsetPosition(e,i)if mvars.gim_questMarkStartName then
Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,mvars.gim_questMarkStartLocator,mvars.gim_questMarkStartData,false)end
t=true
end
if(i.containerList and Tpp.IsTypeTable(i.containerList))and next(i.containerList)then
for i,e in pairs(i.containerList)do
local i=e.locatorName
local e=e.dataSetName
Gimmick.SetFultonableContainerForMission(i,e,0,false)end
t=true
end
end
if t==true then
mvars.gim_isQuestSetup=true
end
end
function e.OnDeactivateQuest(i)if mvars.gim_isQuestSetup==true then
local i=e.CheckQuestAllTarget(i.questType,nil,true)TppQuest.ClearWithSave(i)e.SetQuestInvisibleGimmick(0,true,true)end
end
function e.OnTerminateQuest(i)if mvars.gim_isQuestSetup==true then
e.InitQuest()end
end
function e.CheckQuestAllTarget(i,t,o)local n=TppDefine.QUEST_CLEAR_TYPE.NONE
local m=o or false
local o=false
local o=TppQuest.GetCurrentQuestName()if TppQuest.IsEnd(o)then
return n
end
if m==false then
if i==TppDefine.QUEST_TYPE.DEVELOP_RECOVERED then
for i,e in pairs(mvars.gim_questTargetList)do
if e.idType=="Develop"then
if t==TppCollection.GetUniqueIdByLocatorName(e.developId)then
e.messageId="Recovered"end
end
end
elseif i==TppDefine.QUEST_TYPE.GIMMICK_RECOVERED then
if Tpp.IsFultonContainer(t)then
for n,i in pairs(mvars.gim_questTargetList)do
if i.idType=="Gimmick"then
local n,e=e.GetGameObjectId(i.gimmickId)if e==a then
else
if t==e then
i.messageId="Recovered"end
end
end
end
end
end
end
if i==TppDefine.QUEST_TYPE.DEVELOP_RECOVERED or i==TppDefine.QUEST_TYPE.GIMMICK_RECOVERED then
local i=0
local e=0
for n,t in pairs(mvars.gim_questTargetList)do
if t.messageId=="Recovered"then
i=i+1
end
e=e+1
end
if e>0 then
if i>=e then
n=TppDefine.QUEST_CLEAR_TYPE.CLEAR
end
end
end
return n
end
function e.IsQuestTarget(t)if mvars.gim_isQuestSetup==false then
return false
end
if not next(mvars.gim_questTargetList)then
return false
end
for n,i in pairs(mvars.gim_questTargetList)do
if i.idType=="Gimmick"then
local i,e=e.GetGameObjectId(i.gimmickId)if e==t then
return true
end
end
end
return false
end
function e.SetQuestInvisibleGimmick(i,t,e)local n=e or false
for a,e in pairs(mvars.gim_questTargetList)do
if i==mvars.gim_questMarkSetIndex or n==true then
Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,e.locatorName,e.dataSetName,t)end
end
end
function e.SetUpMineQuest(e)if mvars.gim_isQuestSetup==false then
mvars.gim_questmineCount=0
mvars.gim_questmineTotalCount=e
mvars.gim_isQuestSetup=true
end
end
function e.OnTerminateMineQuest()if mvars.gim_isQuestSetup==true then
mvars.gim_questmineCount=0
mvars.gim_questmineTotalCount=0
mvars.gim_isQuestSetup=false
end
end
function e.CheckQuestPlaced(t,i)if e.CheckQuestMine(t,i)then
mvars.gim_questmineCount=mvars.gim_questmineCount+1
TppUI.ShowAnnounceLog("mine_quest_log",mvars.gim_questmineCount,mvars.gim_questmineTotalCount)end
if mvars.gim_questmineCount>=mvars.gim_questmineTotalCount then
return true
else
return false
end
end
function e.CheckQuestMine(t,e)for n,i in pairs(TppDefine.QUEST_MINE_TYPE_LIST)do
if t==i then
if TppPlaced.IsQuestBlock(e)then
return true
else
return false
end
end
end
return false
end
function e.GetCurrentLocationAiGameObjectId()local e
if TppLocation.IsAfghan()then
e="/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2"elseif TppLocation.IsMiddleAfrica()then
e="/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2"end
if not e then
return
end
local i
i=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_AI",name="com_ai001_gim_n0000|srt_aip0_main0_def",dataSetName=e}return i
end
function e.GetCurrentLocationDiggerGameObjectId()local e
if TppLocation.IsAfghan()then
e="/Assets/ssd/level/location/afgh/block_common/afgh_common_asset.fox2"else
return
end
if not e then
return
end
local i
i=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name="whm0_gim_n0000|srt_whm0_main0_def_v00",dataSetName=e}return i
end
function e.GetCurrentLocationDiggerPosition()local e=e.GetCurrentLocationDiggerGameObjectId()if not e then
return
end
local e,i=Gimmick.SsdGetPosAndRot{gameObjectId=e}if not e then
return
end
return TppMath.Vector3toTable(e)end
function e.IsBaseImportantGimmick(e)if not mvars.gim_isBaseImportantGimmick then
return
end
return mvars.gim_isBaseImportantGimmick[e]end
function e.GetBaseImportantGimmickList()if not mvars.gim_baseImportantGimmickList then
return
end
local e={}for i,t in pairs(mvars.gim_baseImportantGimmickList)do
e[i]={}for t,n in pairs(t)do
e[i][t]=n
end
end
return e
end
function e.GetAfghBaseDiggerIdentifier()local e=e.baseImportantGimmickList.afgh[4]local e={gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName}return e
end
function e.MakeDefenseTargetListFromWaveProperty(i)if not t(i)then
return
end
if Tpp.IsTypeString(i.fastTravelPoint)then
e.MakeFastTravelPointDefenseTargetIdentifier(i)end
if not t(i.identificationTable)then
return
end
local e=i.identificationTable
if not next(e)then
return
end
if e.needAlert then
return
end
if e.alertRadius then
return
end
local n={}local t=i.alertParameters or{needAlert=true,alertRadius=30}for a,e in pairs(e)do
local i={}if(e.gimmickId and e.dataSetName)and e.name then
for t,e in pairs(e)do
i[t]=e
end
if t[a]then
for t,e in pairs(t[a])do
i[t]=e
end
else
for e,t in pairs(t)do
i[e]=t
end
end
table.insert(n,i)end
end
Tpp.DEBUG_DumpTable(n)return n
end
function e.MakeFastTravelPointDefenseTargetIdentifier(e)local i=SsdFastTravel.GetFastTravelPointGimmickIdentifier(e.fastTravelPoint)if i then
i.level=e.fastTravelPointLevel
e.identificationTable={fastTravelPoint=i}end
end
function e.SetDefenseTargetLevel(i)for t,i in pairs(i)do
e.SetDefenseTargetLevelByWaveProperty(i)end
end
function e.SetDefenseTargetLevelByWaveProperty(i)local n=TppStory.GetMissionEnemyLevel()+1
local i=i.defenseTargetGimmickProperty
if t(i)then
if Tpp.IsTypeString(i.fastTravelPoint)then
e.MakeFastTravelPointDefenseTargetIdentifier(i)end
local e=i.identificationTable
if t(e)then
for i,e in pairs(e)do
local n=e.level or n
local e,i,t=e.name,e.dataSetName,e.gimmickId
Gimmick.SetLevel{gimmickId=t,name=e,dataSetName=i,level=n}Gimmick.ResetGimmick(0,e,i,{gimmickId=t})end
end
end
end
function e.SetDefenseTargetWithList(e,i)for t,e in ipairs(e)do
e.isActiveTarget=i
Gimmick.SetDefenseTarget(e)end
end
function e.RegisterActivatedDefenseTargetList(e)mvars.gim_activatedDefenseTargetList=e
end
function e.DeactivateRegisterdDefenseTarget()if not mvars.gim_activatedDefenseTargetList then
return
end
e.SetDefenseTargetWithList(mvars.gim_activatedDefenseTargetList,false)mvars.gim_activatedDefenseTargetList=nil
end
local i="/Assets/ssd/level/mission/story/s10060/s10060_blade_gim.fox2"e.ARCHAEAL_BLADE_TABLE={[i]={"dnw0_gim_n0000|srt_dnw0_main0_def_v00","dnw0_gim_n0001|srt_dnw0_main0_def_v00","dnw0_gim_n0002|srt_dnw0_main0_def_v00","dnw0_gim_n0003|srt_dnw0_main0_def_v00"}}e.CHECK_ARCHAEAL_BLADE_TABLE={}for t,i in ipairs(e.ARCHAEAL_BLADE_TABLE[i])do
e.CHECK_ARCHAEAL_BLADE_TABLE[n(i)]=true
end
function e.SetArchaealBladeVisibility(t)for i,e in pairs(e.ARCHAEAL_BLADE_TABLE)do
for n,e in pairs(e)do
Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,e,i,(not t))end
end
end
function e.IsArchaealBlade(i)if e.CHECK_ARCHAEAL_BLADE_TABLE[i]then
return true
else
return false
end
end
function e.AddUnitInterferer(a,e,i,m,o)local n
if t(e)then
n=Gimmick.SsdGetGameObjectId{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName}elseif Tpp.IsTypeNumber(e)then
n=e
else
return
end
local e,t=Gimmick.SsdGetPosAndRot{gameObjectId=n}e=e-m
if o then
Gimmick.RemoveUnitInterferer{key=a}end
Gimmick.AddUnitInterferer{base=e,size=Vector3(i,i,i),key=a}end
function e.AddMemoryBoardUnitInterferer(t,i)local n,e="flagMission",4
local i,t=Tpp.GetLocatorByTransform(t,i)Gimmick.AddUnitInterferer{base=i+t:Rotate(Vector3(0,0,1)),size=Vector3(e,e,e),key=n}end
function e.AreaBreakOnSwitchDemo(i,e)local i,e=(i+e:Rotate(Vector3(0,0,1.5))),2.5
Gimmick.AreaBreak{pos=i,radius=e,onlyEquip=true,silentBreak=true}end
return e