local e={}local o=GameObject.GetGameObjectId
local a=GameObject.GetTypeIndex
local n=GameObject.SendCommand
local i=GameObject.NULL_ID
function e._Random(n,E)local t=gvars.rev_revengeRandomValue
if n>E then
local e=n
n=E
E=e
end
local E=(E-n)+1
return(t%E)+n
end
e.NO_REVENGE_MISSION_LIST={[10010]=true,[10030]=true,[10050]=true,[11050]=true,[10120]=true,[10140]=true,[11140]=true,[10151]=true,[10230]=true,[10240]=true,[10280]=true,[30050]=true,[40010]=true,[40020]=true,[40050]=true,[50050]=true}e.NO_STEALTH_COMBAT_REVENGE_MISSION_LIST={[30010]=true,[30020]=true,[30050]=true,[30150]=true}e.USE_SUPER_REINFORCE_VEHICLE_MISSION={[10036]=true,[11036]=true,[10093]=true}e.CANNOT_USE_ALL_WEAPON_MISSION={[10030]=true,[10070]=true,[10080]=true,[11080]=true,[10090]=true,[11090]=true,[10151]=true,[11151]=true,[10211]=true,[11211]=true,[30050]=true}e.REVENGE_TYPE_NAME={"STEALTH","NIGHT_S","COMBAT","NIGHT_C","LONG_RANGE","VEHICLE","HEAD_SHOT","TRANQ","FULTON","SMOKE","M_STEALTH","M_COMBAT","DUMMY","DUMMY2","DUMMY3","DUMMY4","MAX"}e.REVENGE_TYPE=TppDefine.Enum(e.REVENGE_TYPE_NAME)e.REVENGE_LV_LIMIT_RANK_MAX=6
e.REVENGE_LV_MAX={[e.REVENGE_TYPE.STEALTH]={0,1,2,3,4,5},[e.REVENGE_TYPE.NIGHT_S]={0,1,1,2,3,3},[e.REVENGE_TYPE.COMBAT]={0,1,2,3,4,5},[e.REVENGE_TYPE.NIGHT_C]={0,1,1,1,1,1},[e.REVENGE_TYPE.LONG_RANGE]={0,1,1,2,2,2},[e.REVENGE_TYPE.VEHICLE]={0,1,1,2,3,3},[e.REVENGE_TYPE.HEAD_SHOT]={0,1,2,3,5,7},[e.REVENGE_TYPE.TRANQ]={0,1,1,1,1,1},[e.REVENGE_TYPE.FULTON]={0,1,2,2,3,3},[e.REVENGE_TYPE.SMOKE]={0,1,1,2,3,3},[e.REVENGE_TYPE.M_STEALTH]={9,9,9,9,9,9},[e.REVENGE_TYPE.M_COMBAT]={9,9,9,9,9,9}}e.REVENGE_POINT_OVER_MARGINE=100-1
e.REVENGE_POINT_PER_LV=100
e.REDUCE_REVENGE_POINT=10
e.REDUCE_TENDENCY_POINT_TABLE={[e.REVENGE_TYPE.STEALTH]={-20,-20,-20,-20,-25,-50},[e.REVENGE_TYPE.COMBAT]={-20,-20,-20,-20,-25,-50}}e.REDUCE_POINT_TABLE={[e.REVENGE_TYPE.NIGHT_S]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},[e.REVENGE_TYPE.NIGHT_C]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},[e.REVENGE_TYPE.SMOKE]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},[e.REVENGE_TYPE.LONG_RANGE]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},[e.REVENGE_TYPE.VEHICLE]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50}}e.REVENGE_TRIGGER_TYPE={HEAD_SHOT=1,ELIMINATED_IN_STEALTH=2,ELIMINATED_IN_COMBAT=3,FULTON=4,SMOKE=5,KILLED_BY_HELI=6,ANNIHILATED_IN_STEALTH=7,ANNIHILATED_IN_COMBAT=8,WAKE_A_COMRADE=9,DISCOVERY_AT_NIGHT=10,ELIMINATED_AT_NIGHT=11,SNIPED=12,KILLED_BY_VEHICLE=13,WATCH_SMOKE=14}e.BLOCKED_TYPE={GAS_MASK=0,HELMET=1,CAMERA=2,DECOY=3,MINE=4,NVG=5,SHOTGUN=6,MG=7,SOFT_ARMOR=8,SHIELD=9,ARMOR=10,GUN_LIGHT=11,SNIPER=12,MISSILE=13,MAX=14}e.BLOCKED_FOR_MISSION_COUNT=3
e.DEPLOY_REVENGE_MISSION_BLOCKED_LIST={[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_SMOKE]=e.BLOCKED_TYPE.GAS_MASK,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_HEAD_SHOT]=e.BLOCKED_TYPE.HELMET,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH1]=e.BLOCKED_TYPE.CAMERA,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH2]=e.BLOCKED_TYPE.DECOY,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH3]=e.BLOCKED_TYPE.MINE,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_STEALTH]=e.BLOCKED_TYPE.NVG,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT1]=e.BLOCKED_TYPE.SHOTGUN,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT2]=e.BLOCKED_TYPE.MG,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT3]=e.BLOCKED_TYPE.SOFT_ARMOR,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT4]=e.BLOCKED_TYPE.SHIELD,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT5]=e.BLOCKED_TYPE.ARMOR,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_COMBAT]=e.BLOCKED_TYPE.GUN_LIGHT,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_LONG_RANGE]=e.BLOCKED_TYPE.SNIPER,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_VEHICLE]=e.BLOCKED_TYPE.MISSILE}e.DEPLOY_REVENGE_MISSION_CONDITION_LIST={[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_SMOKE]={revengeType=e.REVENGE_TYPE.SMOKE,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_HEAD_SHOT]={revengeType=e.REVENGE_TYPE.HEAD_SHOT,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH1]={revengeType=e.REVENGE_TYPE.STEALTH,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH2]={revengeType=e.REVENGE_TYPE.STEALTH,lv=2},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH3]={revengeType=e.REVENGE_TYPE.STEALTH,lv=3},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_STEALTH]={revengeType=e.REVENGE_TYPE.NIGHT_S,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT1]={revengeType=e.REVENGE_TYPE.COMBAT,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT2]={revengeType=e.REVENGE_TYPE.COMBAT,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT3]={revengeType=e.REVENGE_TYPE.COMBAT,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT4]={revengeType=e.REVENGE_TYPE.COMBAT,lv=2},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT5]={revengeType=e.REVENGE_TYPE.COMBAT,lv=3},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_COMBAT]={revengeType=e.REVENGE_TYPE.NIGHT_C,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_LONG_RANGE]={revengeType=e.REVENGE_TYPE.LONG_RANGE,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_VEHICLE]={revengeType=e.REVENGE_TYPE.VEHICLE,lv=1}}e.REVENGE_POINT_TABLE={[e.REVENGE_TRIGGER_TYPE.HEAD_SHOT]={[e.REVENGE_TYPE.HEAD_SHOT]=5},[e.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_STEALTH]={[e.REVENGE_TYPE.M_STEALTH]=5},[e.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_COMBAT]={[e.REVENGE_TYPE.M_COMBAT]=5},[e.REVENGE_TRIGGER_TYPE.FULTON]={[e.REVENGE_TYPE.FULTON]=15},[e.REVENGE_TRIGGER_TYPE.SMOKE]={[e.REVENGE_TYPE.SMOKE]=15},[e.REVENGE_TRIGGER_TYPE.WATCH_SMOKE]={[e.REVENGE_TYPE.SMOKE]=15},[e.REVENGE_TRIGGER_TYPE.KILLED_BY_HELI]={[e.REVENGE_TYPE.VEHICLE]=10},[e.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_STEALTH]={[e.REVENGE_TYPE.M_STEALTH]=15},[e.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_COMBAT]={[e.REVENGE_TYPE.M_COMBAT]=15},[e.REVENGE_TRIGGER_TYPE.WAKE_A_COMRADE]={[e.REVENGE_TYPE.TRANQ]=5},[e.REVENGE_TRIGGER_TYPE.DISCOVERY_AT_NIGHT]={[e.REVENGE_TYPE.NIGHT_S]=15},[e.REVENGE_TRIGGER_TYPE.ELIMINATED_AT_NIGHT]={[e.REVENGE_TYPE.NIGHT_C]=10},[e.REVENGE_TRIGGER_TYPE.SNIPED]={[e.REVENGE_TYPE.LONG_RANGE]=30},[e.REVENGE_TRIGGER_TYPE.KILLED_BY_VEHICLE]={[e.REVENGE_TYPE.VEHICLE]=10}}e.MISSION_TENDENCY_POINT_TABLE={STEALTH={STEALTH={25,25,25,25,50,50},COMBAT={0,0,-5,-10,-50,-50}},DRAW={STEALTH={20,20,20,0,-25,-10},COMBAT={20,20,20,0,-25,-10}},COMBAT={STEALTH={0,0,-5,-10,-50,-50},COMBAT={25,25,25,25,50,50}}}e.revengeDefine={HARD_MISSION={IGNORE_BLOCKED=true},_ENABLE_CAMERA_LV=1,_ENABLE_DECOY_LV=2,_ENABLE_MINE_LV=3,STEALTH_0={STEALTH_LOW=true,HOLDUP_LOW=true},STEALTH_1={CAMERA="100%",HOLDUP_LOW=true},STEALTH_2={DECOY="100%",CAMERA="100%"},STEALTH_3={DECOY="100%",MINE="100%",CAMERA="100%",STEALTH_HIGH=true},STEALTH_4={DECOY="100%",MINE="100%",CAMERA="100%",STEALTH_HIGH=true,HOLDUP_HIGH=true,ACTIVE_DECOY=true,GUN_CAMERA=true},STEALTH_5={DECOY="100%",MINE="100%",CAMERA="100%",STEALTH_SPECIAL=true,HOLDUP_HIGH=true,ACTIVE_DECOY=true,GUN_CAMERA=true},NIGHT_S_1={NVG="25%"},NIGHT_S_2={NVG="50%"},NIGHT_S_3={NVG="75%"},_ENABLE_SOFT_ARMOR_LV=1,_ENABLE_SHOTGUN_LV=1,_ENABLE_MG_LV=1,_ENABLE_SHIELD_LV=2,_ENABLE_ARMOR_LV=3,COMBAT_0={COMBAT_LOW=true},COMBAT_1={{SOFT_ARMOR="25%",SHOTGUN=2},{SOFT_ARMOR="25%",MG=2}},COMBAT_2={{SOFT_ARMOR="50%",SHOTGUN=2,SHIELD=1},{SOFT_ARMOR="50%",MG=2,SHIELD=1}},COMBAT_3={{SOFT_ARMOR="75%",SHOTGUN=2,SHIELD=1,ARMOR=1,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true},{SOFT_ARMOR="75%",MG=2,SHIELD=1,ARMOR=1,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true}},COMBAT_4={{SOFT_ARMOR="100%",SHOTGUN=4,SHIELD=2,ARMOR=2,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true,REINFORCE_COUNT=2},{SOFT_ARMOR="100%",MG=4,SHIELD=2,ARMOR=2,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true,REINFORCE_COUNT=2}},COMBAT_5={{SOFT_ARMOR="100%",SHOTGUN=4,SHIELD=4,ARMOR=4,STRONG_WEAPON=true,COMBAT_SPECIAL=true,SUPER_REINFORCE=true,BLACK_SUPER_REINFORCE=true,REINFORCE_COUNT=3},{SOFT_ARMOR="100%",MG=4,SHIELD=4,ARMOR=4,STRONG_WEAPON=true,COMBAT_SPECIAL=true,SUPER_REINFORCE=true,BLACK_SUPER_REINFORCE=true,REINFORCE_COUNT=3}},NIGHT_C_1={GUN_LIGHT="75%"},LONG_RANGE_1={SNIPER=2},LONG_RANGE_2={SNIPER=2,STRONG_SNIPER=true},VEHICLE_1={MISSILE=2},VEHICLE_2={MISSILE=2,STRONG_MISSILE=true},VEHICLE_3={MISSILE=4,STRONG_MISSILE=true},HEAD_SHOT_1={HELMET="10%"},HEAD_SHOT_2={HELMET="20%"},HEAD_SHOT_3={HELMET="30%"},HEAD_SHOT_4={HELMET="40%"},HEAD_SHOT_5={HELMET="50%"},HEAD_SHOT_6={HELMET="60%"},HEAD_SHOT_7={HELMET="70%"},HEAD_SHOT_8={HELMET="80%"},HEAD_SHOT_9={HELMET="90%"},HEAD_SHOT_10={HELMET="100%"},TRANQ_1={STRONG_NOTICE_TRANQ=true},FULTON_0={FULTON_LOW=true},FULTON_1={},FULTON_2={FULTON_HIGH=true},FULTON_3={FULTON_SPECIAL=true},SMOKE_1={GAS_MASK="25%"},SMOKE_2={GAS_MASK="50%"},SMOKE_3={GAS_MASK="75%"},FOB_NoKill={NO_KILL_WEAPON=true},FOB_EquipGrade_1={EQUIP_GRADE_LIMIT=1},FOB_EquipGrade_2={EQUIP_GRADE_LIMIT=2},FOB_EquipGrade_3={EQUIP_GRADE_LIMIT=3},FOB_EquipGrade_4={EQUIP_GRADE_LIMIT=4},FOB_EquipGrade_5={EQUIP_GRADE_LIMIT=5},FOB_EquipGrade_6={EQUIP_GRADE_LIMIT=6},FOB_EquipGrade_7={EQUIP_GRADE_LIMIT=7},FOB_EquipGrade_8={EQUIP_GRADE_LIMIT=8},FOB_EquipGrade_9={EQUIP_GRADE_LIMIT=9},FOB_EquipGrade_10={EQUIP_GRADE_LIMIT=10},FOB_ShortRange={SHOTGUN="30%",SHIELD="60%",SMG="100%"},FOB_MiddleRange={MG="40%",MISSILE="15%"},FOB_LongRange={SNIPER="50%"},FOB_ShortRange_1={},FOB_ShortRange_2={SHOTGUN="10%"},FOB_ShortRange_3={SHOTGUN="10%"},FOB_ShortRange_4={SMG="10%",SHOTGUN="10%",SHIELD="10%"},FOB_ShortRange_5={SMG="10%",SHOTGUN="10%",SHIELD="10%"},FOB_ShortRange_6={SMG="20%",SHOTGUN="10%",SHIELD="20%"},FOB_ShortRange_7={SMG="20%",SHOTGUN="20%",SHIELD="20%"},FOB_ShortRange_8={STRONG_WEAPON=true,SMG="20%",SHOTGUN="20%",SHIELD="20%"},FOB_ShortRange_9={STRONG_WEAPON=true,SMG="20%",SHOTGUN="25%",SHIELD="20%"},FOB_ShortRange_10={STRONG_WEAPON=true,SMG="30%",SHOTGUN="30%",SHIELD="30%"},FOB_MiddleRange_1={},FOB_MiddleRange_2={MG="10%"},FOB_MiddleRange_3={MG="10%"},FOB_MiddleRange_4={MG="20%"},FOB_MiddleRange_5={MG="20%"},FOB_MiddleRange_6={STRONG_WEAPON=true,MG="20%"},FOB_MiddleRange_7={STRONG_WEAPON=true,MG="30%"},FOB_MiddleRange_8={STRONG_WEAPON=true,MG="30%",SHOTGUN="10%"},FOB_MiddleRange_9={STRONG_WEAPON=true,MG="30%",SHOTGUN="10%",MISSILE="10%"},FOB_MiddleRange_10={STRONG_WEAPON=true,MG="40%",SHOTGUN="10%",SNIPER="10%",MISSILE="10%"},FOB_LongRange_1={},FOB_LongRange_2={SNIPER="10%"},FOB_LongRange_3={SNIPER="10%"},FOB_LongRange_4={SNIPER="15%"},FOB_LongRange_5={STRONG_SNIPER=true,SNIPER="15%"},FOB_LongRange_6={STRONG_SNIPER=true,SNIPER="20%",MISSILE="10%"},FOB_LongRange_7={STRONG_SNIPER=true,SNIPER="20%",MISSILE="10%"},FOB_LongRange_8={STRONG_WEAPON=true,STRONG_SNIPER=true,STRONG_MISSILE=true,SNIPER="20%",MISSILE="10%"},FOB_LongRange_9={STRONG_WEAPON=true,STRONG_SNIPER=true,STRONG_MISSILE=true,SNIPER="25%",MISSILE="10%"},FOB_LongRange_10={STRONG_WEAPON=true,STRONG_SNIPER=true,STRONG_MISSILE=true,SNIPER="30%",MISSILE="20%",MG="10%"}}function e.SelectRevengeType()local n=TppMission.GetMissionID()if e.IsNoRevengeMission(n)or n==10115 then
return{}end
local r=TppMission.IsHardMission(n)local t={}for E=0,e.REVENGE_TYPE.MAX-1 do
local n
if r then
n=e.GetRevengeLvMax(E,REVENGE_LV_LIMIT_RANK_MAX)else
n=e.GetRevengeLv(E)end
if n>=0 then
local n=e.REVENGE_TYPE_NAME[E+1]..("_"..tostring(n))local e=e.revengeDefine[n]if e then
table.insert(t,n)end
end
end
if r then
table.insert(t,"HARD_MISSION")end
return t
end
function e.SetForceRevengeType(e)if not Tpp.IsTypeTable(e)then
e={e}end
mvars.revenge_forceRevengeType=e
end
function e.IsNoRevengeMission(n)if n==nil then
return false
end
local e=e.NO_REVENGE_MISSION_LIST[n]if e==nil then
return false
end
return e
end
function e.IsNoStealthCombatRevengeMission(n)if n==nil then
return false
end
local e=e.NO_STEALTH_COMBAT_REVENGE_MISSION_LIST[n]if e==nil then
return false
end
return e
end
function e.GetEquipGradeLimit()return mvars.revenge_revengeConfig.EQUIP_GRADE_LIMIT
end
function e.IsUsingNoKillWeapon()return mvars.revenge_revengeConfig.NO_KILL_WEAPON
end
function e.IsUsingStrongWeapon()return mvars.revenge_revengeConfig.STRONG_WEAPON
end
function e.IsUsingStrongMissile()return mvars.revenge_revengeConfig.STRONG_MISSILE
end
function e.IsUsingStrongSniper()return mvars.revenge_revengeConfig.STRONG_SNIPER
end
function e.IsUsingSuperReinforce()if not mvars.revenge_isEnabledSuperReinforce then
return false
end
return mvars.revenge_revengeConfig.SUPER_REINFORCE
end
function e.IsUsingBlackSuperReinforce()return mvars.revenge_revengeConfig.BLACK_SUPER_REINFORCE
end
function e.GetReinforceCount()local e=mvars.revenge_revengeConfig.REINFORCE_COUNT
if e then
return e+0
end
return 1
end
function e.CanUseArmor(n)if TppEneFova==nil then
return false
end
local e=TppMission.GetMissionID()if TppEneFova.IsNotRequiredArmorSoldier(e)then
return false
end
if n then
return TppEneFova.CanUseArmorType(e,n)end
return true
end
local n=function(e)if e==nil then
return 0
end
return(e:sub(1,-2)+0)/100
end
function e.GetMineRate()return n(mvars.revenge_revengeConfig.MINE)end
function e.GetDecoyRate()return n(mvars.revenge_revengeConfig.DECOY)end
function e.IsUsingActiveDecoy()return mvars.revenge_revengeConfig.ACTIVE_DECOY
end
function e.GetCameraRate()return n(mvars.revenge_revengeConfig.CAMERA)end
function e.IsUsingGunCamera()return mvars.revenge_revengeConfig.GUN_CAMERA
end
function e.GetPatrolRate()if mvars.revenge_revengeConfig.STRONG_PATROL then
return 1
else
return 0
end
end
function e.IsIgnoreBlocked()return mvars.revenge_revengeConfig.IGNORE_BLOCKED
end
function e.IsBlocked(e)if e==nil then
return false
end
return gvars.rev_revengeBlockedCount[e]>0
end
function e.SetEnabledSuperReinforce(e)mvars.revenge_isEnabledSuperReinforce=e
end
function e.SetHelmetAll()mvars.revenge_revengeConfig.HELMET="100%"end
function e.RegisterMineList(n,E)if not mvars.rev_usingBase then
return
end
mvars.rev_mineBaseTable={}for n,e in ipairs(n)do
if mvars.rev_usingBase[e]then
mvars.rev_mineBaseTable[e]=n-1
end
end
mvars.rev_mineBaseList=n
mvars.rev_mineBaseCountMax=#n
e.RegisterCommonMineList(E)end
function e.RegisterCommonMineList(n)mvars.rev_mineTrapTable={}for e,n in pairs(n)do
if mvars.rev_usingBase[e]then
for E,n in ipairs(n)do
local n=n.trapName
local e={areaIndex=E,trapName=n,baseName=e}mvars.rev_mineTrapTable[Fox.StrCode32(n)]=e
end
end
end
mvars.rev_revengeMineList={}for n,E in pairs(n)do
if mvars.rev_usingBase[n]then
mvars.rev_revengeMineList[n]={}if Tpp.IsTypeTable(E)then
if next(E)then
for E,t in ipairs(E)do
mvars.rev_revengeMineList[n][E]={}e._CopyRevengeMineArea(mvars.rev_revengeMineList[n][E],t,n,E)end
local e=E.decoyLocatorList
if e then
mvars.rev_revengeMineList[n].decoyLocatorList={}for E,e in ipairs(e)do
table.insert(mvars.rev_revengeMineList[n].decoyLocatorList,e)end
end
end
end
end
end
end
function e.RegisterMissionMineList(n)for E,n in pairs(n)do
e.AddBaseMissionMineList(E,n)end
end
function e.AddBaseMissionMineList(e,E)local t=mvars.rev_revengeMineList[e]if not t then
return
end
if not Tpp.IsTypeTable(E)then
return
end
local n=E.decoyLocatorList
if n then
local E=mvars.rev_revengeMineList[e].decoyLocatorList
mvars.rev_revengeMineList[e].decoyLocatorList=mvars.rev_revengeMineList[e].decoyLocatorList or{}for E,n in ipairs(n)do
table.insert(mvars.rev_revengeMineList[e].decoyLocatorList,n)end
end
for E,r in pairs(E)do
local e=mvars.rev_mineTrapTable[Fox.StrCode32(E)]if e then
local e=e.areaIndex
local e=t[e]local E=r.mineLocatorList
if E then
e.mineLocatorList=e.mineLocatorList or{}for E,n in ipairs(E)do
table.insert(e.mineLocatorList,n)end
end
if not n then
local n=r.decoyLocatorList
if n then
e.decoyLocatorList=e.decoyLocatorList or{}for E,n in ipairs(n)do
table.insert(e.decoyLocatorList,n)end
end
end
else
if E~="decoyLocatorList"then
end
end
end
end
function e._CopyRevengeMineArea(e,n,E,E)local E=n.trapName
if E then
e.trapName=E
else
return
end
local E=n.mineLocatorList
if E then
e.mineLocatorList={}for E,n in ipairs(E)do
e.mineLocatorList[E]=n
end
end
local n=n.decoyLocatorList
if n then
e.decoyLocatorList={}for n,E in ipairs(n)do
e.decoyLocatorList[n]=E
end
end
end
function e.OnEnterRevengeMineTrap(n)if not mvars.rev_mineTrapTable then
return
end
local n=mvars.rev_mineTrapTable[n]if not n then
return
end
local t,E,n=n.areaIndex,n.baseName,n.trapName
e.UpdateLastVisitedMineArea(E,t,n)end
function e.ClearLastRevengeMineBaseName()gvars.rev_lastUpdatedBaseName=0
end
function e.UpdateLastVisitedMineArea(E,t,e)local n=mvars.rev_LastVisitedMineAreaVarsName
if not n then
return
end
local e=Fox.StrCode32(E)if gvars.rev_lastUpdatedBaseName==e then
return
else
gvars.rev_lastUpdatedBaseName=e
end
local e=mvars.rev_mineBaseTable[E]gvars[n][e]=t
end
function e.SaveMissionStartMineArea()local n,E=mvars.rev_missionStartMineAreaVarsName,mvars.rev_LastVisitedMineAreaVarsName
if not n then
return
end
for e=0,(TppDefine.REVENGE_MINE_BASE_MAX-1)do
gvars[n][e]=gvars[E][e]end
end
function e.SetUpRevengeMine()if TppMission.IsMissionStart()then
e._SetUpRevengeMine()end
end
function e._SetUpRevengeMine()local r=mvars.rev_missionStartMineAreaVarsName
if not r then
return
end
if not mvars.rev_mineBaseTable then
return
end
local a,E=false,false
if e.GetMineRate()>.5 then
a=true
else
a=false
end
if e.GetDecoyRate()>.5 then
E=true
else
E=false
end
for o,_ in pairs(mvars.rev_mineBaseTable)do
local t=mvars.rev_revengeMineList[o]local n=gvars[r][_]if n==0 and#t>0 then
n=math.random(1,#t)gvars[r][_]=n
end
local T=t.decoyLocatorList
local r=false
for i,_ in ipairs(t)do
local t=_.mineLocatorList
if t then
local e=a and(i==n)if e then
r=false
end
for E,n in ipairs(t)do
TppPlaced.SetEnableByLocatorName(n,e)end
end
local t=_.decoyLocatorList
if T then
e._EnableDecoy(o,T,E)if E then
r=false
end
end
if t then
local n=E and(i==n)e._EnableDecoy(o,t,n)if n then
r=false
end
end
end
if r then
end
end
end
function e._GetDecoyType(e)local n={PF_A=1,PF_B=2,PF_C=3}local e=o(e)local e=TppEnemy.GetCpSubType(e)return n[e]end
function e._EnableDecoy(n,r,t)local n=n.."_cp"local n=e._GetDecoyType(n)local E=e.IsUsingActiveDecoy()for r,e in ipairs(r)do
if n then
TppPlaced.SetCorrelationValueByLocatorName(e,n)end
if E then
TppPlaced.ChangeEquipIdByLocatorName(e,TppEquip.EQP_SWP_ActiveDecoy)end
TppPlaced.SetEnableByLocatorName(e,t)end
end
function e._SetupCamera()if not GameObject.DoesGameObjectExistWithTypeName"TppSecurityCamera2"then
return
end
if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
return
end
local n=false
if e.GetCameraRate()>.5 then
n=true
else
n=false
end
GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetEnabled",enabled=n})if e.IsUsingGunCamera()then
GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetGunCamera"})else
GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetNormalCamera"})end
end
function e.OnAllocate(n)mvars.revenge_isEnabledSuperReinforce=true
e.SetUpMineAreaVarsName()if n.sequence then
local e=n.sequence.baseList
if e then
local n=TppLocation.GetLocationName()mvars.rev_usingBase={}for E,e in ipairs(e)do
local e=n..("_"..e)mvars.rev_usingBase[e]=true
end
end
end
end
function e.SetUpMineAreaVarsName()if TppLocation.IsAfghan()then
mvars.rev_missionStartMineAreaVarsName="rev_baseMissionStartMineAreaAfgh"mvars.rev_LastVisitedMineAreaVarsName="rev_baseLastVisitedMineAreaAfgh"elseif TppLocation.IsMiddleAfrica()then
mvars.rev_missionStartMineAreaVarsName="rev_baseMissionStartMineAreaMafr"mvars.rev_LastVisitedMineAreaVarsName="rev_baseLastVisitedMineAreaMafr"else
return
end
end
function e.DecideRevenge(n)e._SetUiParameters()mvars.revenge_revengeConfig=mvars.revenge_revengeConfig or{}mvars.revenge_revengeType=mvars.revenge_forceRevengeType
if mvars.revenge_revengeType==nil then
mvars.revenge_revengeType=e.SelectRevengeType()end
mvars.revenge_revengeConfig=e._CreateRevengeConfig(mvars.revenge_revengeType)if(n.enemy and n.enemy.soldierDefine)or vars.missionCode>6e4 then
e._AllocateResources(mvars.revenge_revengeConfig)end
end
function e.SetUpEnemy()if mvars.ene_soldierDefine==nil then
return
end
if mvars.ene_soldierIDList==nil then
return
end
e._SetMbInterrogate()local n=e.GetReinforceCount()GameObject.SendCommand({type="TppCommandPost2"},{id="SetReinforceCount",count=n})if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
TppEnemy.SetUpDDParameter()end
e._SetupCamera()for n,E in pairs(mvars.ene_soldierDefine)do
local n=o(n)if n==i then
else
if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
for E=0,3 do
e._ApplyRevengeToCp(n,mvars.revenge_revengeConfig,E)end
else
e._ApplyRevengeToCp(n,mvars.revenge_revengeConfig)end
end
end
end
function e.GetRevengeLvLimitRank()if(Tpp.IsQARelease()or nil)and mvars.qaDebug then
if mvars.qaDebug.revengeIgnoreLvLimitRank then
if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
gvars.str_storySequence=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
end
end
end
local e=gvars.str_storySequence
if e<TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
return 1
elseif e<TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
return 2
elseif e<TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_POWS then
return 3
elseif e<TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA then
return 4
elseif e<TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
return 5
else
return 6
end
return 6
end
function e.GetRevengeLv(e)return gvars.rev_revengeLv[e]end
function e.GetRevengeLvMax(E,n)local n=n or e.GetRevengeLvLimitRank()local e=e.REVENGE_LV_MAX[E]if Tpp.IsTypeTable(e)then
local e=e[n]return e or 0
end
return 0
end
function e.GetRevengePoint(e)return gvars.rev_revengePoint[e]end
function e.AddRevengePoint(n,E)e.SetRevengePoint(n,gvars.rev_revengePoint[n]+E)end
function e.GetRevengeTriggerName(E)for n,e in pairs(e.REVENGE_TRIGGER_TYPE)do
if e==E then
return n
end
end
return""end
function e.AddRevengePointByTriggerType(E)local n=TppMission.GetMissionID()if e.IsNoRevengeMission(n)then
return
end
local t="###REVENGE### "..(tostring(n)..(" / AddRevengePointBy ["..(e.GetRevengeTriggerName(E).."] : ")))local n=e.REVENGE_POINT_TABLE[E]for n,E in pairs(n)do
n=n+0
E=E+0
local r=gvars.rev_revengePoint[n]e.SetRevengePoint(n,gvars.rev_revengePoint[n]+E)local E=gvars.rev_revengePoint[n]t=t..(e.REVENGE_TYPE_NAME[n+1]..(":"..(tostring(r)..("->"..(tostring(E).." ")))))end
end
function e.SetRevengePoint(E,n)local t=e.GetRevengeLvMax(E)local t=t*e.REVENGE_POINT_PER_LV+e.REVENGE_POINT_OVER_MARGINE
if n<0 then
n=0
end
if n>t then
n=t
end
gvars.rev_revengePoint[E]=n
if(Tpp.IsQARelease()or nil)then
if mvars.qaDebug then
local e="Point_"..e.REVENGE_TYPE_NAME[E+1]mvars.qaDebug[e]=gvars.rev_revengePoint[E]end
end
end
function e.ResetRevenge()for n=0,e.REVENGE_TYPE.MAX-1 do
e.SetRevengePoint(n,0)end
e.UpdateRevengeLv()end
if(Tpp.IsQARelease()or nil)then
function e.QARELEASE_DEBUG_SetMaxRevenge()for n=0,e.REVENGE_TYPE.MAX-1 do
e.SetRevengePoint(n,9999)end
e.SetRevengePoint(e.REVENGE_TYPE.M_STEALTH,0)e.SetRevengePoint(e.REVENGE_TYPE.M_COMBAT,0)e.UpdateRevengeLv()end
end
function e.UpdateRevengeLv(n)if n==nil then
n=TppMission.GetMissionID()end
for n=0,e.REVENGE_TYPE.MAX-1 do
local E=e.GetRevengeLvMax(n)local e=e.GetRevengePoint(n)local e=math.floor(e/100)if e>E then
e=E
end
gvars.rev_revengeLv[n]=e
end
e._SetEnmityLv()end
function e._GetUiParameterValue(E)local t=4
local r=5
local n=e.GetRevengeLv(E)if n>=e.GetRevengeLvMax(E,r)then
return 3
elseif n>=e.GetRevengeLvMax(E,t)then
return 2
elseif n>=1 then
return 1
end
return 0
end
function e._SetUiParameters()local n=e._GetUiParameterValue(e.REVENGE_TYPE.FULTON)local E=e._GetUiParameterValue(e.REVENGE_TYPE.HEAD_SHOT)local r=e._GetUiParameterValue(e.REVENGE_TYPE.STEALTH)local t=e._GetUiParameterValue(e.REVENGE_TYPE.COMBAT)local a=math.min(3,math.max(e.GetRevengeLv(e.REVENGE_TYPE.NIGHT_S),e.GetRevengeLv(e.REVENGE_TYPE.NIGHT_C)))local e=e._GetUiParameterValue(e.REVENGE_TYPE.LONG_RANGE)TppUiCommand.RegisterEnemyRevengeParameters{fulton=n,headShot=E,stealth=r,combat=t,night=a,longRange=e}end
function e._SetMbInterrogate()if not GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
return
end
local E=0
local n={{MbInterrogate.FULUTON,e.REVENGE_TYPE.FULTON,1},{MbInterrogate.GAS,e.REVENGE_TYPE.SMOKE,1,e.BLOCKED_TYPE.GAS_MASK},{MbInterrogate.MET,e.REVENGE_TYPE.HEAD_SHOT,1,e.BLOCKED_TYPE.HELMET},{MbInterrogate.FLASH,e.REVENGE_TYPE.NIGHT_C,1,e.BLOCKED_TYPE.GUN_LIGHT},{MbInterrogate.SNIPER,e.REVENGE_TYPE.LONG_RANGE,1,e.BLOCKED_TYPE.SNIPER},{MbInterrogate.MISSILE,e.REVENGE_TYPE.VEHICLE,1,e.BLOCKED_TYPE.MISSILE},{MbInterrogate.NIGHT,e.REVENGE_TYPE.NIGHT_S,1,e.BLOCKED_TYPE.NVG},{MbInterrogate.CAMERA,e.REVENGE_TYPE.STEALTH,e.revengeDefine._ENABLE_CAMERA_LV,e.BLOCKED_TYPE.CAMERA},{MbInterrogate.DECOY,e.REVENGE_TYPE.STEALTH,e.revengeDefine._ENABLE_DECOY_LV,e.BLOCKED_TYPE.DECOY},{MbInterrogate.MINE,e.REVENGE_TYPE.STEALTH,e.revengeDefine._ENABLE_MINE_LV,e.BLOCKED_TYPE.MINE},{MbInterrogate.SHOTGUN,e.REVENGE_TYPE.COMBAT,e.revengeDefine._ENABLE_SHOTGUN_LV,e.BLOCKED_TYPE.SHOTGUN},{MbInterrogate.MACHINEGUN,e.REVENGE_TYPE.COMBAT,e.revengeDefine._ENABLE_MG_LV,e.BLOCKED_TYPE.MG},{MbInterrogate.BODY,e.REVENGE_TYPE.COMBAT,e.revengeDefine._ENABLE_SOFT_ARMOR_LV,e.BLOCKED_TYPE.SOFT_ARMOR},{MbInterrogate.SHIELD,e.REVENGE_TYPE.COMBAT,e.revengeDefine._ENABLE_SHIELD_LV,e.BLOCKED_TYPE.SHIELD},{MbInterrogate.ARMOR,e.REVENGE_TYPE.COMBAT,e.revengeDefine._ENABLE_ARMOR_LV,e.BLOCKED_TYPE.ARMOR}}for t,n in ipairs(n)do
local r=n[1]local t=n[2]local a=n[3]local n=n[4]if n and e.IsBlocked(n)then
elseif e.GetRevengeLv(t)>=a then
E=bit.bor(E,r)end
end
GameObject.SendCommand({type="TppSoldier2"},{id="SetMbInterrogate",enableMask=E})end
function e._SetEnmityLv()local n=e.GetRevengePoint(e.REVENGE_TYPE.STEALTH)local e=e.GetRevengePoint(e.REVENGE_TYPE.COMBAT)local t=math.max(n,e)local n={TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_NONE,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_10,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_20,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_30,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_40,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_50,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_60,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_70,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_80,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_90,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_100}local e=500
local E=#n
local e=math.floor((t*(E-1))/e)+1
if e>=E then
e=#n
end
local e=n[e]TppMotherBaseManagement.SetStaffInitEnmityLv{lv=e}end
function e.OnMissionClearOrAbort(n)gvars.rev_revengeRandomValue=math.random(0,2147483647)e.ApplyMissionTendency(n)e._ReduceRevengePointByChickenCap(n)e._ReduceBlockedCount(n)e._ReceiveClearedDeployRevengeMission()e.UpdateRevengeLv(n)e._AddDeployRevengeMission()end
function e._ReduceBlockedCount(n)if not TppMission.IsHelicopterSpace(n)then
return
end
for e=0,e.BLOCKED_TYPE.MAX-1 do
local n=gvars.rev_revengeBlockedCount[e]if n>0 then
gvars.rev_revengeBlockedCount[e]=n-1
end
end
end
function e._GetBlockedName(E)for n,e in pairs(e.BLOCKED_TYPE)do
if e==E then
return n
end
end
return"unknown"end
function e._ReceiveClearedDeployRevengeMission()if not TppMotherBaseManagement.GetClearedDeployRevengeMissionFlag then
return
end
for n,E in pairs(e.DEPLOY_REVENGE_MISSION_BLOCKED_LIST)do
local t=TppMotherBaseManagement.GetClearedDeployRevengeMissionFlag{deployMissionId=n}if t then
gvars.rev_revengeBlockedCount[E]=e.BLOCKED_FOR_MISSION_COUNT
TppMotherBaseManagement.UnsetClearedDeployRevengeMissionFlag{deployMissionId=n}end
end
end
function e._AddDeployRevengeMission()for n,E in pairs(e.DEPLOY_REVENGE_MISSION_CONDITION_LIST)do
local t=e.DEPLOY_REVENGE_MISSION_BLOCKED_LIST[n]if not e.IsBlocked(t)and e.GetRevengeLv(E.revengeType)>=E.lv then
local e=TppMotherBaseManagement.RequestAddDeployRevengeMission{deployMissionId=n}else
if not TppMotherBaseManagement.RequestDeleteDeployRevengeMission then
return
end
TppMotherBaseManagement.RequestDeleteDeployRevengeMission{deployMissionId=n}end
end
end
function e._ReduceRevengePointStealthCombat()for n,t in pairs(e.REDUCE_TENDENCY_POINT_TABLE)do
local E=e.GetRevengePoint(n)local r=e.GetRevengeLv(n)local t=t[r+1]e.SetRevengePoint(n,(E+t))end
end
function e._ReduceRevengePointOther()local a={[e.REVENGE_TYPE.STEALTH]=true,[e.REVENGE_TYPE.COMBAT]=true,[e.REVENGE_TYPE.M_STEALTH]=true,[e.REVENGE_TYPE.M_COMBAT]=true}for E=0,e.REVENGE_TYPE.MAX-1 do
local r=e.GetRevengePoint(E)local t=e.GetRevengeLv(E)local n=0
if a[E]then
n=0
elseif bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
n=100
elseif e.REDUCE_POINT_TABLE[E]then
n=e.REDUCE_POINT_TABLE[E][t+1]if n==nil then
n=50
else
n=-n
end
else
n=e.REDUCE_REVENGE_POINT*(t+1)if n>50 then
n=50
end
end
e.SetRevengePoint(E,r-n)end
end
function e.ReduceRevengePointOnMissionClear(n)if n==nil then
n=TppMission.GetMissionID()end
if e.IsNoRevengeMission(n)then
return
end
if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
return
end
e._ReduceRevengePointOther()end
function e._ReduceRevengePointByChickenCap(n)if n==nil then
n=TppMission.GetMissionID()end
if e.IsNoRevengeMission(n)then
return
end
if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
e._ReduceRevengePointStealthCombat()e._ReduceRevengePointOther()end
end
function e.ReduceRevengePointOnAbort(e)end
function e._GetMissionTendency(n)local n=e.GetRevengePoint(e.REVENGE_TYPE.M_STEALTH)local e=e.GetRevengePoint(e.REVENGE_TYPE.M_COMBAT)if n==0 and e==0 then
return"STEALTH"end
if e==0 then
return"STEALTH"end
if n==0 then
return"COMBAT"end
local E=n-e
local r=.3
local t=10
local e=(n+e)*r
if e<t then
e=t
end
local n="DRAW"if E>=e then
n="STEALTH"elseif E<=-e then
n="COMBAT"end
return n
end
function e.ApplyMissionTendency(n)if n==nil then
n=TppMission.GetMissionID()end
if(not e.IsNoRevengeMission(n)and not e.IsNoStealthCombatRevengeMission(n))and bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)~=PlayerPlayFlag.USE_CHICKEN_CAP then
local n=e._GetMissionTendency(n)local n=e.MISSION_TENDENCY_POINT_TABLE[n]if n then
local t=e.GetRevengeLv(e.REVENGE_TYPE.STEALTH)+1
local E=e.GetRevengeLv(e.REVENGE_TYPE.COMBAT)+1
if t>#n.STEALTH then
t=#n.STEALTH
end
if E>#n.COMBAT then
E=#n.COMBAT
end
e.AddRevengePoint(e.REVENGE_TYPE.STEALTH,n.STEALTH[t])e.AddRevengePoint(e.REVENGE_TYPE.COMBAT,n.COMBAT[E])end
end
e.SetRevengePoint(e.REVENGE_TYPE.M_STEALTH,0)e.SetRevengePoint(e.REVENGE_TYPE.M_COMBAT,0)end
function e.CanUseReinforceVehicle()local n=TppMission.GetMissionID()return e.USE_SUPER_REINFORCE_VEHICLE_MISSION[n]end
function e.CanUseReinforceHeli()return not GameObject.DoesGameObjectExistWithTypeName"TppEnemyHeli"end
function e.SelectReinforceType()if mvars.reinforce_reinforceType==TppReinforceBlock.REINFORCE_TYPE.HELI then
return TppReinforceBlock.REINFORCE_TYPE.HELI
end
if not e.IsUsingSuperReinforce()then
return TppReinforceBlock.REINFORCE_TYPE.NONE
end
local n={}local E=e.CanUseReinforceVehicle()local t=e.CanUseReinforceHeli()if E then
local e={AFGH={TppReinforceBlock.REINFORCE_TYPE.EAST_WAV,TppReinforceBlock.REINFORCE_TYPE.EAST_TANK},MAFR={TppReinforceBlock.REINFORCE_TYPE.WEST_WAV,TppReinforceBlock.REINFORCE_TYPE.WEST_WAV_CANNON,TppReinforceBlock.REINFORCE_TYPE.WEST_TANK}}if TppLocation.IsAfghan()then
n=e.AFGH
elseif TppLocation.IsMiddleAfrica()then
n=e.MAFR
end
end
if t then
table.insert(n,TppReinforceBlock.REINFORCE_TYPE.HELI)end
if#n==0 then
return TppReinforceBlock.REINFORCE_TYPE.NONE
end
local e=math.random(1,#n)return n[e]end
function e.ApplyPowerSettingsForReinforce(r)for n,e in ipairs(r)do
GameObject.SendCommand(e,{id="RegenerateStaffIdForReinforce"})end
local n={}do
local E=e.GetRevengeLv(e.REVENGE_TYPE.HEAD_SHOT)local E=E/10
if math.random()<E and(e.IsIgnoreBlocked()or not e.IsBlocked(e.BLOCKED_TYPE.HELMET))then
table.insert(n,"HELMET")end
end
if e.IsUsingStrongWeapon()then
table.insert(n,"STRONG_WEAPON")end
if e.IsUsingNoKillWeapon()then
table.insert(n,"NO_KILL_WEAPON")end
do
local E=0
local t=e.GetRevengeLv(e.REVENGE_TYPE.COMBAT)if t>=4 then
E=99
elseif t>=3 then
E=.75
elseif t>=1 then
E=.5
end
if math.random()<E and(e.IsIgnoreBlocked()or not e.IsBlocked(e.BLOCKED_TYPE.SOFT_ARMOR))then
table.insert(n,"SOFT_ARMOR")end
if math.random()<E then
if mvars.revenge_loadedEquip.SHOTGUN and(e.IsIgnoreBlocked()or not e.IsBlocked(e.BLOCKED_TYPE.SHOTGUN))then
table.insert(n,"SHOTGUN")elseif mvars.revenge_loadedEquip.MG and(e.IsIgnoreBlocked()or not e.IsBlocked(e.BLOCKED_TYPE.MG))then
table.insert(n,"MG")end
end
end
for E,e in ipairs(r)do
TppEnemy.ApplyPowerSetting(e,n)end
end
function e._CreateRevengeConfig(E)local n={}local t=mvars.ene_disablePowerSettings
do
local e=mvars.ene_missionRequiresPowerSettings
local n={MISSILE={"SHIELD"},SHIELD={"MISSILE"},SHOTGUN={"MG"},MG={"SHOTGUN"}}for e,E in pairs(e)do
local e=n[e]if e then
for n,e in ipairs(e)do
if not mvars.ene_missionRequiresPowerSettings[e]then
t[e]=true
end
end
end
end
end
for r,E in ipairs(E)do
local E=e.revengeDefine[E]if E~=nil then
if E[1]~=nil then
local e=e._Random(1,#E)E=E[e]end
for e,E in pairs(E)do
if t[e]then
else
n[e]=E
end
end
end
end
if not n.IGNORE_BLOCKED then
for E,t in pairs(n)do
if e.IsBlocked(e.BLOCKED_TYPE[E])then
n[E]=nil
end
end
end
if Tpp.IsTypeNumber(n.ARMOR)and not e.CanUseArmor()then
if not t.SHIELD then
local e=n.SHIELD or 0
if Tpp.IsTypeNumber(e)then
n.SHIELD=e+n.ARMOR
end
end
n.ARMOR=nil
end
local e={NO_KILL_WEAPON={"MG"}}if not mvars.ene_missionRequiresPowerSettings.SHIELD then
e.MISSILE={"SHIELD"}end
if not mvars.ene_missionRequiresPowerSettings.MG then
e.SHOTGUN={"MG"}end
local E={}for e,t in pairs(e)do
if n[e]and not E[e]then
for n,e in ipairs(t)do
E[e]=true
end
end
end
for e,E in pairs(E)do
n[e]=nil
end
local e=TppMission.GetMissionID()if TppMission.IsFOBMission(e)then
local e=TppEnemy.weaponIdTable.DD
if n.NO_KILL_WEAPON and e then
local e=e.NORMAL
if e and e.IS_NOKILL then
if not e.IS_NOKILL.SHOTGUN then
n.SHOTGUN=nil
end
if not e.IS_NOKILL.MISSILE then
n.MISSILE=nil
end
if not e.IS_NOKILL.SNIPER then
n.SNIPER=nil
end
if not e.IS_NOKILL.SMG then
n.SHIELD=nil
n.MISSILE=nil
end
end
end
end
return n
end
function e._AllocateResources(o)mvars.revenge_loadedEquip={}local r=mvars.ene_missionRequiresPowerSettings
local a={}local n=i
local s=TppEnemy.GetSoldierType(n)local n=TppEnemy.GetSoldierSubType(n)local n=TppEnemy.GetWeaponIdTable(s,n)if n==nil then
TppEnemy.weaponIdTable.DD={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_010,ASSAULT=TppEquip.EQP_WP_West_ar_040}}n=TppEnemy.weaponIdTable.DD
end
local E=mvars.ene_disablePowerSettings
local _=TppMission.GetMissionID()local T=true
if e.CANNOT_USE_ALL_WEAPON_MISSION[_]then
T=false
end
local t={}if not T then
if not o.SHIELD or o.MISSILE then
if not r.SHIELD then
t.SHIELD=true
E.SHIELD=true
end
else
if not r.MISSILE then
t.MISSILE=true
E.MISSILE=true
end
end
if s~=EnemyType.TYPE_DD then
if o.SHOTGUN then
if not r.MG then
t.MG=true
E.MG=true
end
else
if not r.SHOTGUN then
t.SHOTGUN=true
E.SHOTGUN=true
end
end
end
end
for e,n in pairs(r)do
t[e]=nil
E[e]=nil
end
do
local o={HANDGUN=true,SMG=true,ASSAULT=true,SHOTGUN=true,MG=true,SHIELD=true}local r=n.NORMAL
if e.IsUsingStrongWeapon()and n.STRONG then
r=n.STRONG
end
if Tpp.IsTypeTable(r)then
for e,n in pairs(r)do
if not o[e]then
elseif E[e]then
elseif t[e]then
else
a[n]=true
mvars.revenge_loadedEquip[e]=n
end
end
end
end
if not E.MISSILE and not t.MISSILE then
local E={}if e.IsUsingStrongMissile()and n.STRONG then
E=n.STRONG
else
E=n.NORMAL
end
local e=E.MISSILE
if e then
a[e]=true
mvars.revenge_loadedEquip.MISSILE=e
end
end
if not E.SNIPER and not t.SNIPER then
local E={}if e.IsUsingStrongSniper()and n.STRONG then
E=n.STRONG
else
E=n.NORMAL
end
local e=E.SNIPER
if e then
a[e]=true
mvars.revenge_loadedEquip.SNIPER=e
end
end
do
local e,E,n=TppEnemy.GetWeaponId(i,{})TppSoldier2.SetDefaultSoldierWeapon{primary=e,secondary=E,tertiary=n}end
local e={}for n,E in pairs(a)do
table.insert(e,n)end
if _==10080 or _==11080 then
table.insert(e,TppEquip.EQP_WP_Wood_ar_010)end
if TppEquip.RequestLoadToEquipMissionBlock then
TppEquip.RequestLoadToEquipMissionBlock(e)end
end
function e._GetSettingSoldierCount(t,n,E)local e={NO_KILL_WEAPON=true,STRONG_WEAPON=true,STRONG_PATROL=true,STRONG_NOTICE_TRANQ=true,STEALTH_SPECIAL=true,STEALTH_HIGH=true,STEALTH_LOW=true,COMBAT_SPECIAL=true,COMBAT_HIGH=true,COMBAT_LOW=true,FULTON_SPECIAL=true,FULTON_HIGH=true,FULTON_LOW=true,HOLDUP_SPECIAL=true,HOLDUP_HIGH=true,HOLDUP_LOW=true}if e[t]then
return E
end
local e=0
if Tpp.IsTypeNumber(n)then
e=n
elseif Tpp.IsTypeString(n)then
if n:sub(-1)=="%"then
local n=n:sub(1,-2)+0
e=math.ceil(E*(n/100))end
end
if e>E then
e=E
end
do
local n={ARMOR=4}local n=n[t]if n and e>n then
e=n
end
end
return e
end
function e._ApplyRevengeToCp(t,s,r)local E=mvars.ene_soldierIDList[t]local _={}local n=0
if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
local a=0
local e=mvars.ene_cpList[t]if(mtbs_enemy and mtbs_enemy.cpNameToClsterIdList~=nil)and mvars.mbSoldier_enableSoldierLocatorList~=nil then
local e=mtbs_enemy.cpNameToClsterIdList[e]if e then
E={}local e=mvars.mbSoldier_enableSoldierLocatorList[e]for n,e in ipairs(e)do
local n=tonumber(string.sub(e,-6,-6))if n~=nil and n==r then
local e=GameObject.GetGameObjectId("TppSoldier2",e)E[e]=a
end
end
end
end
end
if E==nil then
return
end
local T={}for e,n in pairs(mvars.ene_missionSoldierPowerSettings)do
local e=o("TppSoldier2",e)T[e]=n
end
local i={}for n,e in pairs(mvars.ene_missionSoldierPersonalAbilitySettings)do
local n=o("TppSoldier2",n)i[n]=e
end
local r=mvars.ene_outerBaseCpList[t]local a={}local o={}for e,E in pairs(E)do
table.insert(_,e)n=n+1
if T[e]then
a[n]=true
elseif mvars.ene_eliminateTargetList[e]then
a[n]=true
elseif TppEnemy.GetSoldierType(e)==EnemyType.TYPE_CHILD then
a[n]=true
elseif r then
o[n]=true
elseif mvars.ene_lrrpTravelPlan[t]then
o[n]=true
end
end
local E={}for e=1,n do
if r then
E[e]={OB=true}else
E[e]={}end
end
local l={ARMOR={"SOFT_ARMOR","HELMET","GAS_MASK","NVG","SNIPER","SHIELD","MISSILE"},SOFT_ARMOR={"ARMOR"},SNIPER={"SHOTGUN","MG","MISSILE","GUN_LIGHT","ARMOR","SHIELD","SMG"},SHOTGUN={"SNIPER","MG","MISSILE","SHIELD","SMG"},MG={"SNIPER","SHOTGUN","MISSILE","GUN_LIGHT","SHIELD","SMG"},SMG={"SNIPER","SHOTGUN","MG"},MISSILE={"ARMOR","SHIELD","SNIPER","SHOTGUN","MG"},SHIELD={"ARMOR","SNIPER","MISSILE","SHOTGUN","MG"},HELMET={"ARMOR","GAS_MASK","NVG"},GAS_MASK={"ARMOR","HELMET","NVG"},NVG={"ARMOR","HELMET","GAS_MASK"},GUN_LIGHT={"SNIPER","MG"}}local T={STEALTH_LOW=true,STEALTH_HIGH=true,STEALTH_SPECIAL=true,COMBAT_LOW=true,COMBAT_HIGH=true,COMBAT_SPECIAL=true,HOLDUP_LOW=true,HOLDUP_HIGH=true,HOLDUP_SPECIAL=true,FULTON_LOW=true,FULTON_HIGH=true,FULTON_SPECIAL=true}for r,t in ipairs(TppEnemy.POWER_SETTING)do
local r=s[t]if r then
local r=e._GetSettingSoldierCount(t,r,n)local _=l[t]or{}local r=r
for n=1,n do
local i=a[n]local a=(not T[t])and o[n]if(not i and not a)and r>0 then
local a=true
if E[n][t]then
r=r-1
a=false
end
if a then
for t,e in ipairs(_)do
if E[n][e]then
a=false
end
end
end
if a then
r=r-1
E[n][t]=true
if t=="MISSILE"and e.IsUsingStrongMissile()then
E[n].STRONG_MISSILE=true
end
if t=="SNIPER"and e.IsUsingStrongSniper()then
E[n].STRONG_SNIPER=true
end
end
end
end
end
end
for n,e in ipairs(E)do
local t=_[n]TppEnemy.ApplyPowerSetting(t,e)if i[t]==nil then
local n={}do
local E
if e.STEALTH_SPECIAL then
E="sp"elseif e.STEALTH_HIGH then
E="high"elseif e.STEALTH_LOW then
E="low"end
n.notice=E
n.cure=E
n.reflex=E
end
do
local E
if e.COMBAT_SPECIAL then
E="sp"elseif e.COMBAT_HIGH then
E="high"elseif e.COMBAT_LOW then
E="low"end
n.shot=E
n.grenade=E
n.reload=E
n.hp=E
end
do
local E
if e.STEALTH_SPECIAL or e.COMBAT_SPECIAL then
E="sp"elseif e.STEALTH_HIGH or e.COMBAT_HIGH then
E="high"elseif e.STEALTH_LOW or e.COMBAT_LOW then
E="low"end
n.speed=E
end
do
local E
if e.FULTON_SPECIAL then
E="sp"elseif e.FULTON_HIGH then
E="high"elseif e.FULTON_LOW then
E="low"end
n.fulton=E
end
do
local E
if e.HOLDUP_SPECIAL then
E="sp"elseif e.HOLDUP_HIGH then
E="high"elseif e.HOLDUP_LOW then
E="low"end
n.holdup=E
end
TppEnemy.ApplyPersonalAbilitySettings(t,n)end
end
end
function e.Messages()return Tpp.StrCode32Table{GameObject={{msg="HeadShot",func=e._OnHeadShot},{msg="Dead",func=e._OnDead},{msg="Unconscious",func=e._OnUnconscious},{msg="ComradeFultonDiscovered",func=e._OnComradeFultonDiscovered},{msg="CommandPostAnnihilated",func=e._OnAnnihilated},{msg="ChangePhase",func=e._OnChangePhase},{msg="Damage",func=e._OnDamage},{msg="AntiSniperNoticed",func=e._OnAntiSniperNoticed},{msg="SleepingComradeRecoverd",func=e._OnSleepingComradeRecoverd},{msg="SmokeDiscovered",func=e._OnSmokeDiscovered},{msg="ReinforceRespawn",func=e._OnReinforceRespawn}},Trap={{msg="Enter",func=e._OnEnterTrap}}}end
function e.Init(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
function e.OnReload(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
function e.OnMessage(_,o,a,E,n,r,t)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,_,o,a,E,n,r,t)end
local r=function(e)if(((((((((((((attackid==TppDamage.ATK_VehicleHit or e==TppDamage.ATK_Tankgun_20mmAutoCannon)or e==TppDamage.ATK_Tankgun_30mmAutoCannon)or e==TppDamage.ATK_Tankgun_105mmRifledBoreGun)or e==TppDamage.ATK_Tankgun_120mmSmoothBoreGun)or e==TppDamage.ATK_Tankgun_125mmSmoothBoreGun)or e==TppDamage.ATK_Tankgun_82mmRocketPoweredProjectile)or e==TppDamage.ATK_Tankgun_30mmAutoCannon)or e==TppDamage.ATK_Wav1)or e==TppDamage.ATK_WavCannon)or e==TppDamage.ATK_TankCannon)or e==TppDamage.ATK_WavRocket)or e==TppDamage.ATK_HeliMiniGun)or e==TppDamage.ATK_HeliChainGun)or attackid==TppDamage.ATK_WalkerGear_BodyAttack then
return true
end
return false
end
function e._OnReinforceRespawn(n)if TppMission.IsFOBMission(vars.missionCode)then
TppEnemy.AddPowerSetting(n,{})o50050_enemy.AssignAndSetupRespawnSoldier(n)else
e.ApplyPowerSettingsForReinforce{n}end
end
function e._OnHeadShot(n,t,t,E)if a(n)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
return
end
if bit.band(E,HeadshotMessageFlag.IS_JUST_UNCONSCIOUS)==0 then
return
end
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.HEAD_SHOT)end
local E=function(n)if n==nil then
n=vars.playerPhase
end
if n~=TppGameObject.PHASE_SNEAK or vars.playerPhase~=TppGameObject.PHASE_SNEAK then
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_COMBAT)else
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_STEALTH)end
if TppClock.GetTimeOfDay()=="night"then
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.ELIMINATED_AT_NIGHT)end
end
function e._OnDead(t,n,o)if a(t)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
return
end
local i=(Tpp.IsVehicle(vars.playerVehicleGameObjectId)or Tpp.IsEnemyWalkerGear(vars.playerVehicleGameObjectId))or Tpp.IsPlayerWalkerGear(vars.playerVehicleGameObjectId)local _=r(attackId)local t=Tpp.IsEnemyWalkerGear(n)or Tpp.IsPlayerWalkerGear(n)local r=(n==GameObject.GetGameObjectIdByIndex("TppPlayer2",PlayerInfo.GetLocalPlayerIndex()))if(t or _)or(r and i)then
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.KILLED_BY_VEHICLE)end
E(o)if a(n)==TppGameObject.GAME_OBJECT_TYPE_HELI2 then
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.KILLED_BY_HELI)end
end
function e._OnUnconscious(e,t,n)if a(e)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
return
end
local e=GameObject.SendCommand(e,{id="GetLifeStatus"})if e==TppGameObject.NPC_LIFE_STATE_DYING or e==TppGameObject.NPC_LIFE_STATE_DEAD then
return
end
E(n)end
function e._OnAnnihilated(E,n,t)if t==0 then
if TppEnemy.IsBaseCp(E)or TppEnemy.IsOuterBaseCp(E)then
if n==nil then
n=vars.playerPhase
end
if n~=TppGameObject.PHASE_SNEAK or vars.playerPhase~=TppGameObject.PHASE_SNEAK then
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_COMBAT)else
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_STEALTH)end
end
end
end
function e._OnChangePhase(E,n)if n~=TppGameObject.PHASE_ALERT then
return
end
if TppClock.GetTimeOfDay()=="night"then
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.DISCOVERY_AT_NIGHT)end
end
function e._OnComradeFultonDiscovered(n,n)e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.FULTON)end
local n=function(e)if((((((((((((e==TppDamage.ATK_Smoke or e==TppDamage.ATK_SmokeOccurred)or e==TppDamage.ATK_SleepGus)or e==TppDamage.ATK_SleepGusOccurred)or e==TppDamage.ATK_SupportHeliFlareGrenade)or e==TppDamage.ATK_SupplyFlareGrenade)or e==TppDamage.ATK_SleepingGusGrenade)or e==TppDamage.ATK_SleepingGusGrenade_G1)or e==TppDamage.ATK_SleepingGusGrenade_G2)or e==TppDamage.ATK_SmokeAssist)or e==TppDamage.ATK_SleepGusAssist)or e==TppDamage.ATK_Grenader_Smoke)or e==TppDamage.ATK_Grenader_Sleep)or e==TppDamage.ATK_SmokeGrenade then
return true
end
return false
end
function e._OnDamage(E,t,r)if a(E)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
return
end
if n(t)then
e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.SMOKE)end
end
function e._OnSmokeDiscovered(n)e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.WATCH_SMOKE)end
function e._OnAntiSniperNoticed(n)e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.SNIPED)end
function e._OnSleepingComradeRecoverd(n)e.AddRevengePointByTriggerType(e.REVENGE_TRIGGER_TYPE.WAKE_A_COMRADE)end
function e._OnEnterTrap(n)e.OnEnterRevengeMineTrap(n)end
if(Tpp.IsQARelease()or nil)then
function e.QARELEASE_DEBUG_Init()local n
if DebugMenu then
n=DebugMenu
else
return
end
do
mvars.qaDebug.showRevenge=false
n.AddDebugMenu("LuaRevenge","showRevengeInfo","bool",mvars.qaDebug,"showRevenge")mvars.qaDebug.revengeIgnoreLvLimitRank=false
n.AddDebugMenu("LuaRevenge","IgnoreLvLimit","bool",mvars.qaDebug,"revengeIgnoreLvLimitRank")mvars.qaDebug.revengeForceMaxLv=false
n.AddDebugMenu("LuaRevenge","ForceMaxLv","bool",mvars.qaDebug,"revengeForceMaxLv")mvars.qaDebug.revengeForceMinLv=false
n.AddDebugMenu("LuaRevenge","ForceMinLv","bool",mvars.qaDebug,"revengeForceMinLv")mvars.qaDebug.revengeUpdateFirst=true
local E=e.REVENGE_TYPE.DUMMY-1
for E=0,E do
local e="Point_"..e.REVENGE_TYPE_NAME[E+1]n.AddDebugMenu("LuaRevenge",e,"int32",mvars.qaDebug,e)end
end
end
function e.QARELEASE_DEBUG_InitDebugMenuRevengePoint()mvars.qaDebug.revengeUpdateFirst=true
end
function e.QAReleaseDebugUpdate()local E=DebugText.Print
local n=DebugText.NewContext()if mvars.qaDebug.showRevenge then
DebugText.Print(n,{.5,.5,1},"TppRevenge: showRevenge")do
local e="mvars.revenge_revengeType: "local t=0
for a,r in pairs(mvars.revenge_revengeType)do
e=e..(r.." ")t=t+1
if t>8 then
E(n,{.5,1,.5},e)t=0
e="  "end
end
E(n,{.5,1,.5},e)end
do
local e=string.format("storySequence:%d LV_LIMIT_RANK:%d",gvars.str_storySequence,e.GetRevengeLvLimitRank())E(n,{.5,1,.5},e)end
do
local t="isBlocked: "local r=0
for a=0,e.BLOCKED_TYPE.MAX-1 do
if e.IsBlocked(a)then
local o=e._GetBlockedName(a)local a=gvars.rev_revengeBlockedCount[a]t=t..(o..("/"..(a.." ")))r=r+1
if r>10 then
if e.IsIgnoreBlocked()then
E(n,{.5,0,0},t)else
E(n,{.5,1,.5},t)end
r=0
t="  "end
end
end
if e.IsIgnoreBlocked()then
E(n,{.5,0,0},t)else
E(n,{.5,1,.5},t)end
end
for t=0,e.REVENGE_TYPE.MAX-1 do
if t<e.REVENGE_TYPE.DUMMY then
local o=e.GetRevengeLv(t)local a=e.GetRevengeLvMax(t)local r=e.GetRevengePoint(t)local r=string.format("[%-10s] LV:%2d POINT:%4d MAXLV:%2d",e.REVENGE_TYPE_NAME[t+1],o,r,a)if t==e.REVENGE_TYPE.STEALTH then
E(n,{1,1,.6},r)elseif t==e.REVENGE_TYPE.COMBAT then
E(n,{1,1,.6},r)else
E(n,{1,1,1},r)end
end
end
end
do
if mvars.qaDebug.revengeUpdateFirst then
local n=e.REVENGE_TYPE.DUMMY-1
for n=0,n do
local e="Point_"..e.REVENGE_TYPE_NAME[n+1]mvars.qaDebug[e]=gvars.rev_revengePoint[n]end
mvars.qaDebug.revengeUpdateFirst=false
end
local t=false
if mvars.qaDebug.revengeForceMaxLv then
e.QARELEASE_DEBUG_SetMaxRevenge()mvars.qaDebug.revengeForceMaxLv=false
end
if mvars.qaDebug.revengeForceMinLv then
e.ResetRevenge()mvars.qaDebug.revengeForceMinLv=false
end
local n=e.REVENGE_TYPE.DUMMY-1
for n=0,n do
local E="Point_"..e.REVENGE_TYPE_NAME[n+1]if mvars.qaDebug[E]~=gvars.rev_revengePoint[n]then
e.SetRevengePoint(n,mvars.qaDebug[E])t=true
end
end
if t then
e.UpdateRevengeLv()end
end
end
end
return e