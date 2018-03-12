local e={}local s=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local l=Tpp.IsTypeString
local a=Fox.StrCode32
local r=GkEventTimerManager.Start
local p=GkEventTimerManager.Stop
local n=GameObject.GetTypeIndex
local i=GameObject.GetGameObjectId
local d=GameObject.GetTypeIndexWithTypeName
local n=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local n=GameObject.NULL_ID
local o=GameObject.SendCommand
e.MISSION_CLEAR_CAMERA_FADE_DELAY_TIME=3
e.MISSION_CLEAR_CAMERA_DELAY_TIME=0
e.PLAYER_FALL_DEAD_DELAY_TIME=.2
e.DisableAbilityList={Stand="DIS_ACT_STAND",Squat="DIS_ACT_SQUAT",Crawl="DIS_ACT_CRAWL",Dash="DIS_ACT_DASH"}e.ControlModeList={LockPadMode="All",LockMBTerminalOpenCloseMode="MB_Disable",MBTerminalOnlyMode="MB_OnlyMode"}e.CageRandomTableG1={{1,20},{0,80}}e.CageRandomTableG2={{2,15},{1,20},{0,65}}e.CageRandomTableG3={{4,5},{3,10},{2,15},{1,20},{0,50}}e.RareLevelList={"N","NR","R","SR","SSR"}function e.RegisterCallbacks(e)if s(e.OnFultonIconDying)then
mvars.ply_OnFultonIconDying=e.OnFultonIconDying
end
end
function e.SetStartStatus(e)if(e>TppDefine.INITIAL_PLAYER_STATE.MIN)and(e<TppDefine.INITIAL_PLAYER_STATE.MAX)then
gvars.ply_initialPlayerState=e
end
end
function e.SetStartStatusRideOnHelicopter()e.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)e.ResetInitialPosition()e.ResetMissionStartPosition()end
function e.ResetDisableAction()vars.playerDisableActionFlag=PlayerDisableAction.NONE
end
function e.GetPosition()return{vars.playerPosX,vars.playerPosY,vars.playerPosZ}end
function e.GetRotation()return vars.playerRotY
end
function e.Warp(e)if not t(e)then
return
end
local n=e.pos
if not t(n)or(#n~=3)then
return
end
local t=foxmath.NormalizeRadian(foxmath.DegreeToRadian(e.rotY or 0))local a
if e.fobRespawn==true then
a={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}else
a={type="TppPlayer2",index=0}end
local e={id="WarpAndWaitBlock",pos=n,rotY=t}GameObject.SendCommand(a,e)end
function e.SetForceFultonPercent(a,e)if not Tpp.IsTypeNumber(a)then
return
end
if not Tpp.IsTypeNumber(e)then
return
end
if(a<0)or(a>=n)then
return
end
if(e<0)or(e>100)then
return
end
mvars.ply_forceFultonPercent=mvars.ply_forceFultonPercent or{}mvars.ply_forceFultonPercent[a]=e
end
function e.ForceChangePlayerToSnake(e)vars.playerType=PlayerType.SNAKE
if e then
vars.playerPartsType=PlayerPartsType.NORMAL
vars.playerCamoType=PlayerCamoType.OLIVEDRAB
vars.playerFaceEquipId=0
else
vars.playerPartsType=vars.sortiePrepPlayerSnakePartsType
vars.playerCamoType=vars.sortiePrepPlayerSnakeCamoType
vars.playerFaceEquipId=vars.sortiePrepPlayerSnakeFaceEquipId
end
Player.SetItemLevel(TppEquip.EQP_SUIT,vars.sortiePrepPlayerSnakeSuitLevel)end
function e.CheckRotationSetting(a)if not t(a)then
return
end
local e=mvars
e.ply_checkDirectionList={}e.ply_checkRotationResult={}local function n(a,t,e)if e>=-180 and e<180 then
a[t]=e
end
end
for t,a in pairs(a)do
if s(a.func)then
e.ply_checkDirectionList[t]={}e.ply_checkDirectionList[t].func=a.func
local o=a.directionX or 0
local i=a.directionY or 0
local r=a.directionRangeX or 0
local a=a.directionRangeY or 0
n(e.ply_checkDirectionList[t],"directionX",o)n(e.ply_checkDirectionList[t],"directionY",i)n(e.ply_checkDirectionList[t],"directionRangeX",r)n(e.ply_checkDirectionList[t],"directionRangeY",a)else
return
end
end
end
function e.CheckRotation()local a=mvars
if a.ply_checkDirectionList==nil then
return
end
for n,t in pairs(a.ply_checkDirectionList)do
local e=e._CheckRotation(t.directionX,t.directionRangeX,t.directionY,t.directionRangeY,n)if e~=a.ply_checkRotationResult[n]then
a.ply_checkRotationResult[n]=e
a.ply_checkDirectionList[n].func(e)end
end
end
function e.IsDeliveryWarping()if mvars.ply_deliveryWarpState then
return true
else
return false
end
end
function e.GetStationUniqueId(e)if not l(e)then
return
end
local e="col_stat_"..e
return TppCollection.GetUniqueIdByLocatorName(e)end
function e.SetMissionStartPositionToCurrentPosition()gvars.ply_useMissionStartPos=true
gvars.ply_missionStartPos[0]=vars.playerPosX
gvars.ply_missionStartPos[1]=vars.playerPosY+.5
gvars.ply_missionStartPos[2]=vars.playerPosZ
gvars.ply_missionStartRot=vars.playerRotY
gvars.mis_orderBoxName=0
e.SetInitialPositionFromMissionStartPosition()end
function e.SetNoOrderBoxMissionStartPosition(e,a)gvars.ply_useMissionStartPosForNoOrderBox=true
gvars.ply_missionStartPosForNoOrderBox[0]=e[1]gvars.ply_missionStartPosForNoOrderBox[1]=e[2]gvars.ply_missionStartPosForNoOrderBox[2]=e[3]gvars.ply_missionStartRotForNoOrderBox=a
end
function e.SetNoOrderBoxMissionStartPositionToCurrentPosition()gvars.ply_useMissionStartPosForNoOrderBox=true
gvars.ply_missionStartPosForNoOrderBox[0]=vars.playerPosX
gvars.ply_missionStartPosForNoOrderBox[1]=vars.playerPosY+.5
gvars.ply_missionStartPosForNoOrderBox[2]=vars.playerPosZ
gvars.ply_missionStartRotForNoOrderBox=vars.playerRotY
end
function e.SetMissionStartPosition(e,a)gvars.ply_useMissionStartPos=true
gvars.ply_missionStartPos[0]=e[1]gvars.ply_missionStartPos[1]=e[2]gvars.ply_missionStartPos[2]=e[3]gvars.ply_missionStartRot=a
end
function e.ResetMissionStartPosition()gvars.ply_useMissionStartPos=false
gvars.ply_missionStartPos[0]=0
gvars.ply_missionStartPos[1]=0
gvars.ply_missionStartPos[2]=0
gvars.ply_missionStartRot=0
end
function e.ResetNoOrderBoxMissionStartPosition()gvars.ply_useMissionStartPosForNoOrderBox=false
gvars.ply_missionStartPosForNoOrderBox[0]=0
gvars.ply_missionStartPosForNoOrderBox[1]=0
gvars.ply_missionStartPosForNoOrderBox[2]=0
gvars.ply_missionStartRotForNoOrderBox=0
end
function e.SetMissionStartPositionFromNoOrderBoxPosition()if gvars.ply_useMissionStartPosForNoOrderBox then
gvars.ply_useMissionStartPos=true
gvars.ply_missionStartPos[0]=gvars.ply_missionStartPosForNoOrderBox[0]gvars.ply_missionStartPos[1]=gvars.ply_missionStartPosForNoOrderBox[1]gvars.ply_missionStartPos[2]=gvars.ply_missionStartPosForNoOrderBox[2]gvars.ply_missionStartRot=gvars.ply_missionStartRotForNoOrderBox
e.ResetNoOrderBoxMissionStartPosition()end
end
function e.DEBUG_CheckNearMissionStartPositionToRealizePosition()if gvars.ply_useMissionStartPos then
local e
if TppLocation.IsMotherBase()then
e=1e3*1e3
else
e=64*64
end
local a=gvars.ply_missionStartPos[0]-vars.playerPosX
local t=gvars.ply_missionStartPos[2]-vars.playerPosZ
local a=(a*a)+(t*t)if(a>e)then
return true
else
return false
end
else
return false
end
end
function e.SetInitialPositionToCurrentPosition()vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
vars.initialPlayerPosX=vars.playerPosX
vars.initialPlayerPosY=vars.playerPosY+.5
vars.initialPlayerPosZ=vars.playerPosZ
vars.initialPlayerRotY=vars.playerRotY
end
function e.SetInitialPosition(e,a)vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
vars.initialPlayerPosX=e[1]vars.initialPlayerPosY=e[2]vars.initialPlayerPosZ=e[3]vars.initialPlayerRotY=a
end
function e.SetInitialPositionFromMissionStartPosition()if gvars.ply_useMissionStartPos then
vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
vars.initialPlayerPosX=gvars.ply_missionStartPos[0]vars.initialPlayerPosY=gvars.ply_missionStartPos[1]vars.initialPlayerPosZ=gvars.ply_missionStartPos[2]vars.initialPlayerRotY=gvars.ply_missionStartRot
vars.playerCameraRotation[0]=0
vars.playerCameraRotation[1]=gvars.ply_missionStartRot
end
end
function e.ResetInitialPosition()vars.initialPlayerFlag=0
vars.initialPlayerPosX=0
vars.initialPlayerPosY=0
vars.initialPlayerPosZ=0
vars.initialPlayerRotY=0
end
function e.FailSafeInitialPositionForFreePlay()if not((vars.missionCode==30010)or(vars.missionCode==30020))then
return
end
if vars.initialPlayerFlag~=PlayerFlag.USE_VARS_FOR_INITIAL_POS then
return
end
if(((vars.initialPlayerPosX>3500)or(vars.initialPlayerPosX<-3500))or(vars.initialPlayerPosZ>3500))or(vars.initialPlayerPosZ<-3500)then
local e={[30010]={1448.61,337.787,1466.4},[30020]={-510.73,5.09,1183.02}}local e=e[vars.missionCode]vars.initialPlayerPosX,vars.initialPlayerPosY,vars.initialPlayerPosZ=e[1],e[2],e[3]end
end
function e.RegisterTemporaryPlayerType(e)if not t(e)then
return
end
mvars.ply_isExistTempPlayerType=true
local a=e.camoType
local t=e.partsType
local r=e.playerType
local n=e.handEquip
local e=e.faceEquipId
if t then
mvars.ply_tempPartsType=t
end
if a then
mvars.ply_tempCamoType=a
end
if r then
mvars.ply_tempPlayerType=r
end
if n then
mvars.ply_tempPlayerHandEquip=n
end
if e then
mvars.ply_tempPlayerFaceEquipId=e
end
end
function e.SaveCurrentPlayerType()if not gvars.ply_isUsingTempPlayerType then
if DebugMenu then
if vars.playerCamoType==PlayerCamoType.HOSPITAL then
TppGameSequence.GetPauseMenu():DebugPause()end
end
gvars.ply_lastPlayerPartsTypeUsingTemp=vars.playerPartsType
gvars.ply_lastPlayerCamoTypeUsingTemp=vars.playerCamoType
gvars.ply_lastPlayerHandTypeUsingTemp=vars.handEquip
gvars.ply_lastPlayerTypeUsingTemp=vars.playerType
gvars.ply_lastPlayerFaceIdUsingTemp=vars.playerFaceId
gvars.ply_lastPlayerFaceEquipIdUsingTemp=vars.playerFaceEquipId
end
gvars.ply_isUsingTempPlayerType=true
end
function e.ApplyTemporaryPlayerType()if mvars.ply_tempPartsType then
vars.playerPartsType=mvars.ply_tempPartsType
end
if mvars.ply_tempCamoType then
vars.playerCamoType=mvars.ply_tempCamoType
end
if mvars.ply_tempPlayerType then
vars.playerType=mvars.ply_tempPlayerType
end
if mvars.ply_tempPlayerHandEquip then
vars.handEquip=mvars.ply_tempPlayerHandEquip
end
if mvars.ply_tempPlayerFaceEquipId then
vars.playerFaceEquipId=mvars.ply_tempPlayerFaceEquipId
end
end
function e.RestoreTemporaryPlayerType()if gvars.ply_isUsingTempPlayerType then
if DebugMenu then
if gvars.ply_lastPlayerCamoTypeUsingTemp==PlayerCamoType.HOSPITAL then
TppGameSequence.GetPauseMenu():DebugPause()end
end
vars.playerPartsType=gvars.ply_lastPlayerPartsTypeUsingTemp
vars.playerCamoType=gvars.ply_lastPlayerCamoTypeUsingTemp
vars.playerType=gvars.ply_lastPlayerTypeUsingTemp
vars.playerFaceId=gvars.ply_lastPlayerFaceIdUsingTemp
vars.playerFaceEquipId=gvars.ply_lastPlayerFaceEquipIdUsingTemp
vars.handEquip=gvars.ply_lastPlayerHandTypeUsingTemp
gvars.ply_lastPlayerPartsTypeUsingTemp=PlayerPartsType.NORMAL_SCARF
gvars.ply_lastPlayerCamoTypeUsingTemp=PlayerCamoType.OLIVEDRAB
gvars.ply_lastPlayerTypeUsingTemp=PlayerType.SNAKE
gvars.ply_lastPlayerFaceIdUsingTemp=0
gvars.ply_lastPlayerFaceEquipIdUsingTemp=0
gvars.ply_isUsingTempPlayerType=false
gvars.ply_lastPlayerHandTypeUsingTemp=TppEquip.EQP_HAND_NORMAL
end
end
function e.SetWeapons(a)e._SetWeapons(a,"weapons")end
function e.SetInitWeapons(a)if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
e.SaveWeaponsToUsingTemp(a)end
e._SetWeapons(a,"initWeapons")end
function e._SetWeapons(l,m)if not t(l)then
return
end
local t=TppDefine.WEAPONSLOT.SUPPORT_0-1
local a,r,i,n,o
for s,l in pairs(l)do
a,t,r,i,n,o=e.GetWeaponSlotInfoFromWeaponSet(l,t)local r=TppEquip[r]if r==nil then
else
local p,c,l,s,d,T=TppEquip.GetAmmoInfo(r)if a then
vars[m][a]=r
local e,t
if i then
e=i*c
elseif n then
e=n
else
e=l
end
gvars.initAmmoStockIds[a]=p
gvars.initAmmoStockCounts[a]=e
gvars.initAmmoInWeapons[a]=c
if(s~=TppEquip.BL_None)then
if o then
t=o
else
t=T
end
gvars.initAmmoStockIds[a+TppDefine.WEAPONSLOT.MAX]=s
gvars.initAmmoStockCounts[a+TppDefine.WEAPONSLOT.MAX]=t
gvars.initAmmoSubInWeapons[a]=d
end
if m=="initWeapons"then
vars.isInitialWeapon[a]=1
end
elseif t>=TppDefine.WEAPONSLOT.SUPPORT_0 and t<=TppDefine.WEAPONSLOT.SUPPORT_7 then
local e=t-TppDefine.WEAPONSLOT.SUPPORT_0
vars.initSupportWeapons[e]=r
gvars.initAmmoStockIds[t]=p
local e
if n then
e=n
else
e=l
end
gvars.initAmmoStockCounts[t]=e
end
end
end
end
function e.GetWeaponSlotInfoFromWeaponSet(e,o)local r,t,n,a,i
if e.primaryHip then
r=TppDefine.WEAPONSLOT.PRIMARY_HIP
t=e.primaryHip
n=e.magazine
a=e.ammo
i=e.underBarrelAmmo
elseif e.primaryBack then
r=TppDefine.WEAPONSLOT.PRIMARY_BACK
t=e.primaryBack
n=e.magazine
a=e.ammo
elseif e.secondary then
r=TppDefine.WEAPONSLOT.SECONDARY
t=e.secondary
n=e.magazine
a=e.ammo
elseif e.support then
o=o+1
t=e.support
a=e.ammo
end
return r,o,t,n,a,i
end
function e.SaveWeaponsToUsingTemp(n)if gvars.ply_isUsingTempWeapons then
return
end
if not t(n)then
return
end
for e=0,11 do
gvars.ply_lastWeaponsUsingTemp[e]=TppEquip.EQP_None
end
local t
local a=TppDefine.WEAPONSLOT.SUPPORT_0-1
for r,n in pairs(n)do
t,a=e.GetWeaponSlotInfoFromWeaponSet(n,a)if t then
gvars.ply_lastWeaponsUsingTemp[t]=vars.initWeapons[t]elseif a>=TppDefine.WEAPONSLOT.SUPPORT_0 and a<=TppDefine.WEAPONSLOT.SUPPORT_7 then
local e=a-TppDefine.WEAPONSLOT.SUPPORT_0
gvars.ply_lastWeaponsUsingTemp[a]=vars.initSupportWeapons[e]end
end
gvars.ply_isUsingTempWeapons=true
end
function e.RestoreWeaponsFromUsingTemp()if not gvars.ply_isUsingTempWeapons then
return
end
for a=0,11 do
if gvars.ply_lastWeaponsUsingTemp[a]~=TppEquip.EQP_None then
if a>=TppDefine.WEAPONSLOT.SUPPORT_0 and a<=TppDefine.WEAPONSLOT.SUPPORT_7 then
local e=a-TppDefine.WEAPONSLOT.SUPPORT_0
vars.initSupportWeapons[e]=gvars.ply_lastWeaponsUsingTemp[a]else
vars.initWeapons[a]=gvars.ply_lastWeaponsUsingTemp[a]end
local i,l,r,o,n,t=TppEquip.GetAmmoInfo(gvars.ply_lastWeaponsUsingTemp[a])e.SupplyAmmoByBulletId(i,r)gvars.initAmmoInWeapons[a]=l
e.SupplyAmmoByBulletId(o,t)gvars.initAmmoSubInWeapons[a]=n
end
end
for e=0,11 do
gvars.ply_lastWeaponsUsingTemp[e]=TppEquip.EQP_None
end
gvars.ply_isUsingTempWeapons=false
return true
end
function e.SetItems(a)if not t(a)then
return
end
for t,a in ipairs(a)do
if TppEquip[a]==nil then
return
end
end
e._SetItems(a,"items")end
function e.SetInitItems(a)if not t(a)then
return
end
for a,e in ipairs(a)do
if TppEquip[e]==nil then
return
end
end
if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
e.SaveItemsToUsingTemp(a)end
e._SetItems(a,"initItems")end
function e._SetItems(a,e)vars[e][0]=TppEquip.EQP_None
for t,a in pairs(a)do
vars[e][t]=TppEquip[a]end
end
function e.SaveItemsToUsingTemp(a)if gvars.ply_isUsingTempItems then
return
end
for e=0,7 do
gvars.ply_lastItemsUsingTemp[e]=TppEquip.EQP_None
end
for e,a in pairs(a)do
if e<8 then
gvars.ply_lastItemsUsingTemp[e]=vars.initItems[e]end
end
gvars.ply_isUsingTempItems=true
end
function e.RestoreItemsFromUsingTemp()if not gvars.ply_isUsingTempItems then
return
end
for e=1,7 do
if gvars.ply_lastItemsUsingTemp[e]~=TppEquip.EQP_None then
vars.initItems[e]=gvars.ply_lastItemsUsingTemp[e]end
end
for e=0,7 do
gvars.ply_lastItemsUsingTemp[e]=TppEquip.EQP_None
end
gvars.ply_isUsingTempItems=false
end
function e.InitItemStockCount()if TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT==nil then
return
end
for e=AmmoStockIndex.ITEM,AmmoStockIndex.ITEM_END-1 do
vars.ammoStockIds[e]=0
vars.ammoStockCounts[e]=0
end
end
function e.GetBulletNum(e)for a=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
if(e~=nil and e==vars.ammoStockIds[a])then
return vars.ammoStockCounts[a]end
end
return 0
end
function e.SavePlayerCurrentWeapons()if not vars.initWeapons then
return
end
vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]if TppDefine.HONEY_BEE_EQUIP_ID~=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]then
vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]else
vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=TppEquip.EPQ_None
end
vars.initWeapons[TppDefine.WEAPONSLOT.SECONDARY]=vars.weapons[TppDefine.WEAPONSLOT.SECONDARY]vars.initHandEquip=vars.handEquip
for a=0,7 do
vars.initSupportWeapons[a]=vars.supportWeapons[a]end
e.SaveChimeraWeaponParameter()end
function e.RestorePlayerWeaponsOnMissionStart()if not vars.initWeapons then
return
end
vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]=vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]vars.weapons[TppDefine.WEAPONSLOT.SECONDARY]=vars.initWeapons[TppDefine.WEAPONSLOT.SECONDARY]vars.handEquip=vars.initHandEquip
for e=0,7 do
vars.supportWeapons[e]=vars.initSupportWeapons[e]end
end
function e.SaveChimeraWeaponParameter()if not vars.initCustomizedWeapon then
return
end
for e=0,2 do
vars.initCustomizedWeapon[e]=vars.customizedWeapon[e]end
for e=0,32 do
vars.initChimeraParts[e]=vars.chimeraParts[e]end
end
function e.RestoreChimeraWeaponParameter()if not vars.initCustomizedWeapon then
return
end
for e=0,2 do
vars.customizedWeapon[e]=vars.initCustomizedWeapon[e]end
for e=0,32 do
vars.chimeraParts[e]=vars.initChimeraParts[e]end
end
function e.SavePlayerCurrentItems()for e=0,7 do
vars.initItems[e]=vars.items[e]end
end
function e.RestorePlayerItemsOnMissionStart()for e=0,7 do
vars.items[e]=vars.initItems[e]end
end
function e.ForceSetAllInitialWeapon()vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_HIP]=1
vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_BACK]=1
vars.isInitialWeapon[TppDefine.WEAPONSLOT.SECONDARY]=1
end
function e.SupplyAllAmmoFullOnMissionFinalize()local a={TppDefine.WEAPONSLOT.PRIMARY_HIP,TppDefine.WEAPONSLOT.PRIMARY_BACK,TppDefine.WEAPONSLOT.SECONDARY}for t,a in ipairs(a)do
e.SupplyWeaponAmmoFull(a)end
for a=0,3 do
local a=vars.initSupportWeapons[a]if a~=TppEquip.EQP_None then
e.SupplySupportWeaponAmmoFull(a)end
end
end
function e.SupplyWeaponAmmoFull(a)local t=vars.initWeapons[a]if t==TppEquip.EQP_None then
return
end
local n,r,i,o,l,t=TppEquip.GetAmmoInfo(t)e.SupplyAmmoByBulletId(n,i)gvars.initAmmoInWeapons[a]=r
e.SupplyAmmoByBulletId(o,t)gvars.initAmmoSubInWeapons[a]=l
end
function e.SupplySupportWeaponAmmoFull(a)local t,n,a,n,n,n=TppEquip.GetAmmoInfo(a)e.SupplyAmmoByBulletId(t,a)end
function e.SupplyAmmoByBulletId(a,n)if a==TppEquip.BL_None then
return
end
local e
for t=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
if gvars.initAmmoStockIds[t]==a then
e=t
break
end
end
if not e then
for t=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
if gvars.initAmmoStockIds[t]==TppEquip.BL_None then
gvars.initAmmoStockIds[t]=a
e=t
break
end
end
end
if not e then
return
end
gvars.initAmmoStockCounts[e]=n
end
function e.SavePlayerCurrentAmmoCount()for e=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
gvars.initAmmoStockIds[e]=vars.ammoStockIds[e]gvars.initAmmoStockCounts[e]=vars.ammoStockCounts[e]end
local e={TppDefine.WEAPONSLOT.PRIMARY_HIP,TppDefine.WEAPONSLOT.PRIMARY_BACK,TppDefine.WEAPONSLOT.SECONDARY}for a,e in ipairs(e)do
gvars.initAmmoInWeapons[e]=vars.ammoInWeapons[e]gvars.initAmmoSubInWeapons[e]=vars.ammoSubInWeapons[e]end
end
function e.SetMissionStartAmmoCount()for e=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
vars.ammoStockIds[e]=gvars.initAmmoStockIds[e]vars.ammoStockCounts[e]=gvars.initAmmoStockCounts[e]end
local e={TppDefine.WEAPONSLOT.PRIMARY_HIP,TppDefine.WEAPONSLOT.PRIMARY_BACK,TppDefine.WEAPONSLOT.SECONDARY}for a,e in ipairs(e)do
vars.ammoInWeapons[e]=gvars.initAmmoInWeapons[e]vars.ammoSubInWeapons[e]=gvars.initAmmoSubInWeapons[e]end
end
function e.SetEquipMissionBlockGroupSize()local e=mvars.ply_equipMissionBlockGroupSize
if e>0 then
TppEquip.CreateEquipMissionBlockGroup{size=e}end
end
function e.SetMaxPickableLocatorCount()if mvars.ply_maxPickableLocatorCount>0 then
TppPickable.OnAllocate{locators=mvars.ply_maxPickableLocatorCount,svarsName="ply_pickableLocatorDisabled"}end
end
function e.SetMaxPlacedLocatorCount()if mvars.ply_maxPlacedLocatorCount>0 then
TppPlaced.OnAllocate{locators=mvars.ply_maxPlacedLocatorCount,svarsName="ply_placedLocatorDisabled"}end
end
function e.IsDecoy(e)local a=TppEquip.GetSupportWeaponTypeId(e)local e={[TppEquip.SWP_TYPE_Decoy]=true,[TppEquip.SWP_TYPE_ActiveDecoy]=true,[TppEquip.SWP_TYPE_ShockDecoy]=true}if e[a]then
return true
else
return false
end
end
function e.IsMine(e)local e=TppEquip.GetSupportWeaponTypeId(e)local a={[TppEquip.SWP_TYPE_DMine]=true,[TppEquip.SWP_TYPE_SleepingGusMine]=true,[TppEquip.SWP_TYPE_AntitankMine]=true,[TppEquip.SWP_TYPE_ElectromagneticNetMine]=true}if a[e]then
return true
else
return false
end
end
function e.AddTrapSettingForIntel(t)local n=t.trapName
local s=t.direction or 0
local p=t.directionRange or 60
local e=t.intelName
local m=t.autoIcon
local r=t.gotFlagName
local o=t.markerTrapName
local i=t.markerObjectiveName
local c=t.identifierName
local t=t.locatorName
if not l(n)then
return
end
mvars.ply_intelTrapInfo=mvars.ply_intelTrapInfo or{}if e then
mvars.ply_intelTrapInfo[e]={trapName=n}else
return
end
mvars.ply_intelNameReverse=mvars.ply_intelNameReverse or{}mvars.ply_intelNameReverse[a(e)]=e
mvars.ply_intelFlagInfo=mvars.ply_intelFlagInfo or{}if r then
mvars.ply_intelFlagInfo[e]=r
mvars.ply_intelFlagInfo[a(e)]=r
mvars.ply_intelTrapInfo[e].gotFlagName=r
end
mvars.ply_intelMarkerObjectiveName=mvars.ply_intelMarkerObjectiveName or{}if i then
mvars.ply_intelMarkerObjectiveName[e]=i
mvars.ply_intelMarkerObjectiveName[a(e)]=i
mvars.ply_intelTrapInfo[e].markerObjectiveName=i
end
mvars.ply_intelMarkerTrapList=mvars.ply_intelMarkerTrapList or{}mvars.ply_intelMarkerTrapInfo=mvars.ply_intelMarkerTrapInfo or{}if o then
table.insert(mvars.ply_intelMarkerTrapList,o)mvars.ply_intelMarkerTrapInfo[a(o)]=e
mvars.ply_intelTrapInfo[e].markerTrapName=o
end
mvars.ply_intelTrapList=mvars.ply_intelTrapList or{}if m then
table.insert(mvars.ply_intelTrapList,n)mvars.ply_intelTrapInfo[a(n)]=e
mvars.ply_intelTrapInfo[e].autoIcon=true
end
if c and t then
local a,e=Tpp.GetLocator(c,t)if a and e then
s=e
end
end
mvars.ply_intelTrapInfo[e].direction=s
mvars.ply_intelTrapInfo[e].directionRange=p
Player.AddTrapDetailCondition{trapName=n,condition=PlayerTrap.FINE,action=(PlayerTrap.NORMAL+PlayerTrap.BEHIND),stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=s,directionRange=p}end
function e.ShowIconForIntel(e,n)if not l(e)then
return
end
local t
if mvars.ply_intelTrapInfo and mvars.ply_intelTrapInfo[e]then
t=mvars.ply_intelTrapInfo[e].trapName
end
local a=mvars.ply_intelFlagInfo[e]if a then
if svars[a]~=nil then
n=svars[a]end
end
if not n then
if Tpp.IsNotAlert()then
Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL,message=Fox.StrCode32"GetIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=e}elseif t then
Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG,message=Fox.StrCode32"NGIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=e}if not TppRadio.IsPlayed(TppRadio.COMMON_RADIO_LIST[TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT])then
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT)end
end
end
end
function e.GotIntel(a)local e=mvars.ply_intelFlagInfo[a]if not e then
return
end
if svars[e]~=nil then
svars[e]=true
end
local e=mvars.ply_intelMarkerObjectiveName[a]if e then
local a=TppMission.GetParentObjectiveName(e)local e={}for a,t in pairs(a)do
table.insert(e,a)end
TppMission.UpdateObjective{objectives=e}end
end
function e.HideIconForIntel()Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL}Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG}end
function e.AddTrapSettingForQuest(e)local t=e.trapName
local n=e.direction or 0
local r=e.directionRange or 180
local e=e.questName
if not l(t)then
return
end
mvars.ply_questStartTrapInfo=mvars.ply_questStartTrapInfo or{}if e then
mvars.ply_questStartTrapInfo[e]={trapName=t}else
return
end
mvars.ply_questNameReverse=mvars.ply_questNameReverse or{}mvars.ply_questNameReverse[a(e)]=e
mvars.ply_questStartFlagInfo=mvars.ply_questStartFlagInfo or{}mvars.ply_questStartFlagInfo[e]=false
mvars.ply_questTrapList=mvars.ply_questTrapList or{}table.insert(mvars.ply_questTrapList,t)mvars.ply_questStartTrapInfo[a(t)]=e
Player.AddTrapDetailCondition{trapName=t,condition=PlayerTrap.FINE,action=PlayerTrap.NORMAL,stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=n,directionRange=r}end
function e.ShowIconForQuest(e,a)if not l(e)then
return
end
local t
if mvars.ply_questStartTrapInfo and mvars.ply_questStartTrapInfo[e]then
t=mvars.ply_questStartTrapInfo[e].trapName
end
if mvars.ply_questStartFlagInfo[e]~=nil then
a=mvars.ply_questStartFlagInfo[e]end
if not a then
Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING,message=Fox.StrCode32"QuestStarted",messageInDisplay=Fox.StrCode32"QuestIconInDisplay",messageArg=e}end
end
function e.QuestStarted(a)local a=mvars.ply_questNameReverse[a]if mvars.ply_questStartFlagInfo[a]~=nil then
mvars.ply_questStartFlagInfo[a]=true
end
e.HideIconForQuest()end
function e.HideIconForQuest()Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING}end
function e.ResetIconForQuest(e)mvars.ply_questStartFlagInfo.ShootingPractice=false
end
function e.AppearHorseOnMissionStart(a,e)local e,a=Tpp.GetLocator(a,e)if e then
vars.buddyType=BuddyType.HORSE
vars.initialBuddyPos[0]=e[1]vars.initialBuddyPos[1]=e[2]vars.initialBuddyPos[2]=e[3]end
end
function e.StartGameOverCamera(t,a,e)if mvars.ply_gameOverCameraGameObjectId~=nil then
return
end
mvars.ply_gameOverCameraGameObjectId=t
mvars.ply_gameOverCameraStartTimerName=a
mvars.ply_gameOverCameraAnnounceLog=e
TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")TppSound.PostJingleOnGameOver()TppSoundDaemon.PostEvent"sfx_s_force_camera_out"vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
r("Timer_StartGameOverCamera",.25)end
function e._StartGameOverCamera(e,e)TppUiStatusManager.ClearStatus"AnnounceLog"FadeFunction.SetFadeColor(64,0,0,255)TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,mvars.ply_gameOverCameraStartTimerName,nil,{exceptGameStatus={AnnounceLog=false}})Player.RequestToSetCameraFocalLengthAndDistance{focalLength=16,interpTime=TppUI.FADE_SPEED.FADE_HIGHSPEED}end
function e.PrepareStartGameOverCamera()FadeFunction.ResetFadeColor()local e={}for a,t in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
e[a]=false
end
for a,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
e[a]=false
end
e.S_DISABLE_NPC=nil
e.AnnounceLog=nil
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,nil,nil,{exceptGameStatus=e})Player.RequestToStopCameraAnimation{}if mvars.ply_gameOverCameraAnnounceLog then
TppUiStatusManager.ClearStatus"AnnounceLog"TppUI.ShowAnnounceLog(mvars.ply_gameOverCameraAnnounceLog)end
end
function e.FOBStartGameOverCamera(a,e,t)if mvars.ply_gameOverCameraGameObjectId~=nil then
return
end
mvars.ply_gameOverCameraGameObjectId=a
mvars.ply_gameOverCameraStartTimerName=e
mvars.ply_gameOverCameraAnnounceLog=t
TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
r("Timer_StartGameOverCamera",.25)end
function e.SetTargetDeadCamera(r)local o
local a
local l
if t(r)then
o=r.gameObjectName or""a=r.gameObjectId
l=r.announceLog or"target_extract_failed"end
a=a or i(o)if a==n then
return
end
e.StartGameOverCamera(a,"EndFadeOut_StartTargetDeadCamera",l)end
function e._SetTargetDeadCamera()e.PrepareStartGameOverCamera()Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},skeletonNames={"SKL_004_HEAD","SKL_011_LUARM","SKL_021_RUARM","SKL_032_LFOOT","SKL_042_RFOOT"},skeletonCenterOffsets={Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,-.3,0),Vector3(0,-.3,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.001,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=16}end
function e.SetTargetHeliCamera(r)local l
local a
local o
if t(r)then
l=r.gameObjectName or""a=r.gameObjectId
o=r.announceLog or"target_eliminate_failed"end
a=a or i(l)if a==n then
return
end
e.StartGameOverCamera(a,"EndFadeOut_StartTargetHeliCamera",o)end
function e._SetTargetHeliCamera()e.PrepareStartGameOverCamera()Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0}},skeletonNames={"SKL_011_RLWDOOR"},skeletonCenterOffsets={Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.01,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=999999}end
function e.SetTargetTruckCamera(r)local o
local a
local l
if t(r)then
o=r.gameObjectName or""a=r.gameObjectId
l=r.announceLog or"target_extract_failed"end
a=a or i(o)if a==n then
return
end
e.StartGameOverCamera(a,"EndFadeOut_StartTargetTruckCamera",l)end
function e._SetTargetTruckCamera(a)e.PrepareStartGameOverCamera()Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},skeletonNames={"SKL_005_WIPERC"},skeletonCenterOffsets={Vector3(0,-.75,-2)},skeletonBoundings={Vector3(1.5,2,4)},offsetPos=Vector3(2.5,3,7.5),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.01,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=999999}end
function e.SetPlayerKilledChildCamera()if mvars.mis_childGameObjectIdKilledPlayer then
local a=nil
if not TppEnemy.IsRescueTarget(mvars.mis_childGameObjectIdKilledPlayer)then
a="boy_died"end
e.SetTargetDeadCamera{gameObjectId=mvars.mis_childGameObjectIdKilledPlayer,announceLog=a}end
end
function e.SetPressStartCamera()local e=i"Player"if e==n then
return
end
Player.RequestToStopCameraAnimation{}Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,0)},skeletonBoundings={Vector3(.5,.45,.1)},offsetPos=Vector3(-.8,0,-1.4),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}end
function e.SetTitleCamera()local e=i"Player"if e==n then
return
end
Player.RequestToStopCameraAnimation{}Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,.1)},skeletonBoundings={Vector3(.5,.45,.9)},offsetPos=Vector3(-.8,0,-1.8),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}end
function e.SetSearchTarget(i,o,s,l,a,r,t,e)if(i==nil or o==nil)then
return
end
local o=d(o)if o==n then
return
end
if t==nil then
t=true
end
if a==nil then
a=Vector3(0,.25,0)end
if e==nil then
e=.03
end
local e={name=s,targetGameObjectTypeIndex=o,targetGameObjectName=i,offset=a,centerRange=.3,lookingTime=1,distance=200,doWideCheck=true,wideCheckRadius=.15,wideCheckRange=e,doDirectionCheck=false,directionCheckRange=100,doCollisionCheck=true}if(l~=nil)then
e.skeletonName=l
end
if(r~=nil)then
e.targetFox2Name=r
end
Player.AddSearchTarget(e)end
function e.IsSneakPlayerInFOB(e)if e==0 then
return true
else
return false
end
end
function e.PlayMissionClearCamera()local e=e.SetPlayerStatusForMissionEndCamera()if not e then
return
end
r("Timer_StartPlayMissionClearCameraStep1",.25)end
function e.SetPlayerStatusForMissionEndCamera()Player.SetPadMask{settingName="MissionClearCamera",except=true}vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
return true
end
function e.ResetMissionEndCamera()Player.ResetPadMask{settingName="MissionClearCamera"}Player.RequestToStopCameraAnimation{}end
function e.PlayCommonMissionEndCamera(o,s,l,i,t,n)local a
local e=vars.playerVehicleGameObjectId
if Tpp.IsHorse(e)then
GameObject.SendCommand(e,{id="HorseForceStop"})a=o(e,t,n)elseif Tpp.IsVehicle(e)then
local r=GameObject.SendCommand(e,{id="GetVehicleType"})GameObject.SendCommand(e,{id="ForceStop",enabled=true})local r=s[r]if r then
a=r(e,t,n)end
elseif(Tpp.IsPlayerWalkerGear(e)or Tpp.IsEnemyWalkerGear(e))then
GameObject.SendCommand(e,{id="ForceStop",enabled=true})a=l(e,t,n)elseif Tpp.IsHelicopter(e)then
else
a=i(t,n)end
if a then
local e="Timer_StartPlayMissionClearCameraStep"..tostring(t+1)r(e,a)end
end
function e._PlayMissionClearCamera(a,t)if a==1 then
TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_clear")end
e.PlayCommonMissionEndCamera(e.PlayMissionClearCameraOnRideHorse,e.VEHICLE_MISSION_CLEAR_CAMERA,e.PlayMissionClearCameraOnWalkerGear,e.PlayMissionClearCameraOnFoot,a,t)end
function e.RequestMissionClearMotion()Player.RequestToPlayDirectMotion{"missionClearMotion",{"/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_f_idl7.gani",false,"","","",false}}end
function e.PlayMissionClearCameraOnFoot(c,p)if PlayerInfo.AndCheckStatus{PlayerStatus.NORMAL_ACTION}then
if PlayerInfo.OrCheckStatus{PlayerStatus.STAND,PlayerStatus.SQUAT}then
if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
mvars.ply_requestedMissionClearCameraCarryOff=true
GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})else
e.RequestMissionClearMotion()end
end
end
local r={"SKL_004_HEAD","SKL_002_CHEST"}local e={Vector3(0,0,.05),Vector3(.15,0,0)}local a={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}local n=Vector3(0,0,-4.5)local t=.3
local o
local i=false
local l=20
local s=false
if c==1 then
r={"SKL_004_HEAD","SKL_002_CHEST"}e={Vector3(0,0,.05),Vector3(.15,0,0)}a={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}n=Vector3(0,0,-1.5)t=.3
o=1
i=true
elseif p then
r={"SKL_004_HEAD"}e={Vector3(0,0,.05)}a={Vector3(.1,.125,.1)}n=Vector3(0,-.5,-3.5)t=3
l=4
else
r={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}e={Vector3(0,0,.05),Vector3(.15,0,0),Vector3(-.15,0,0)}a={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}n=Vector3(0,0,-3.2)t=3
s=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{1,168},{1,-164}},skeletonNames=r,skeletonCenterOffsets=e,skeletonBoundings=a,offsetPos=n,focalLength=28,aperture=1.875,timeToSleep=l,interpTimeAtStart=t,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=i,useLastSelectedIndex=s}return o
end
function e.PlayMissionClearCameraOnRideHorse(e,c,p)local a={"SKL_004_HEAD","SKL_002_CHEST"}local e={Vector3(0,0,.05),Vector3(.15,0,0)}local n={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}local t=Vector3(0,0,-3.2)local r=.2
local o
local l=false
local i=20
local s=false
if p then
i=4
end
if c==1 then
a={"SKL_004_HEAD","SKL_002_CHEST"}e={Vector3(0,-.125,.05),Vector3(.15,-.125,0)}n={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}t=Vector3(0,0,-3.2)r=.2
o=1
l=true
else
a={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}e={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)}n={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}t=Vector3(0,0,-4.5)r=3
s=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{0,160},{0,-160}},skeletonNames=a,skeletonCenterOffsets={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},skeletonCenterOffsets=e,skeletonBoundings=n,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=i,interpTimeAtStart=r,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=l,useLastSelectedIndex=s}return o
end
function e.PlayMissionClearCameraOnRideLightVehicle(e,l,s)local a=Vector3(-.35,.6,.7)local e=Vector3(0,0,-2.25)local t=.2
local n
local r=false
local o=20
local i=false
if s then
o=4
end
if l==1 then
a=Vector3(-.35,.6,.7)e=Vector3(0,0,-2.25)t=.2
n=.5
r=true
else
a=Vector3(-.35,.4,.7)e=Vector3(0,0,-4)t=.75
i=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=a,offsetPos=e,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=t,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=i}return n
end
function e.PlayMissionClearCameraOnRideTruck(e,s,l)local t=Vector3(-.35,1.3,1)local a=Vector3(0,0,-2)local e=.2
local i
local r=false
local o=20
local n=false
if l then
o=4
end
if s==1 then
t=Vector3(-.35,1.3,1)a=Vector3(0,0,-3)e=.2
i=.5
r=true
else
t=Vector3(-.35,1,1)a=Vector3(0,0,-6)e=.75
n=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=t,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=n}return i
end
function e.PlayMissionClearCameraOnRideCommonArmoredVehicle(a,s,e,l)local a=Vector3(.05,-.5,-2.2)if e==1 then
a=Vector3(.05,-.5,-2.2)else
a=Vector3(-.05,-1,0)end
local t=Vector3(0,0,-7.5)local e=.2
local i
local o=false
local n=20
local r=false
if l then
n=4
end
if s==1 then
t=Vector3(0,0,-7.5)e=.2
i=.5
o=true
else
t=Vector3(0,0,-13.25)e=.75
r=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{8,165},{8,-165}},offsetTarget=a,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=n,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=o,useLastSelectedIndex=r}return i
end
function e.PlayMissionClearCameraOnRideEasternArmoredVehicle(t,r,n)local a
a=e.PlayMissionClearCameraOnRideCommonArmoredVehicle(t,r,1,n)return a
end
function e.PlayMissionClearCameraOnRideWesternArmoredVehicle(n,t)local a
a=e.PlayMissionClearCameraOnRideCommonArmoredVehicle(n,t,2,isQuest)return a
end
function e.PlayMissionClearCameraOnRideTank(e,l,i)local a=Vector3(0,0,-6.5)local e=.2
local t
local o=false
local r=20
local n=false
if i then
r=4
end
if l==1 then
a=Vector3(0,0,-6.5)e=.2
t=.5
o=true
else
a=Vector3(0,0,-9)e=.75
n=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{9,165},{9,-165}},offsetTarget=Vector3(0,-.85,3.25),offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=r,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=o,useLastSelectedIndex=n}return t
end
function e.PlayMissionClearCameraOnWalkerGear(a,p,s)local a=Vector3(0,.55,.35)local n=Vector3(0,0,-3.65)local t=.2
local o
local r=false
local i=20
local l=false
if s then
i=4
end
if p==1 then
a=Vector3(0,.55,.35)n=Vector3(0,0,-3.65)t=.2
o=1
r=true
else
a=Vector3(0,.4,.35)n=Vector3(0,0,-4.95)t=3
l=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,165},{7,-165}},offsetTarget=a,offsetPos=n,focalLength=28,aperture=1.875,timeToSleep=i,interpTimeAtStart=t,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=l}return o
end
e.VEHICLE_MISSION_CLEAR_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayMissionClearCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayMissionClearCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionClearCameraOnRideEasternArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayMissionClearCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayMissionClearCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionClearCameraOnRideWesternArmoredVehicle}function e.FOBPlayMissionClearCamera()local e=e.SetPlayerStatusForMissionEndCamera()if not e then
return
end
r("Timer_FOBStartPlayMissionClearCameraStep1",.25)end
function e._FOBPlayMissionClearCamera(a)e.FOBPlayCommonMissionEndCamera(e.FOBPlayMissionClearCameraOnFoot,a)end
function e.FOBPlayCommonMissionEndCamera(t,a)local e
e=t(a)if e then
local a="Timer_FOBStartPlayMissionClearCameraStep"..tostring(a+1)r(a,e)end
end
function e.FOBRequestMissionClearMotion()Player.RequestToPlayDirectMotion{"missionClearMotionFob",{"/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_win_idl.gani",false,"","","",false}}end
function e.FOBPlayMissionClearCameraOnFoot(l)Player.SetCurrentSlot{slotType=PlayerSlotType.ITEM,subIndex=0}if PlayerInfo.OrCheckStatus{PlayerStatus.STAND,PlayerStatus.SQUAT,PlayerStatus.CRAWL}then
if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
mvars.ply_requestedMissionClearCameraCarryOff=true
GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})elseif PlayerInfo.OrCheckStatus{PlayerStatus.SQUAT,PlayerStatus.CRAWL}then
Player.RequestToSetTargetStance(PlayerStance.STAND)r("Timer_FOBWaitStandStance",1)else
e.FOBRequestMissionClearMotion()end
end
local r={"SKL_004_HEAD","SKL_002_CHEST"}local t={Vector3(0,.1,0),Vector3(0,-.05,0)}local a={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}local n=Vector3(0,0,-4.5)local e=.3
local o
local i=false
if l==1 then
r={"SKL_004_HEAD","SKL_002_CHEST"}t={Vector3(0,.25,0),Vector3(0,-.05,0)}a={Vector3(.1,.125,.1),Vector3(.1,.125,.1)}n=Vector3(0,0,-1)e=.3
o=1
i=true
else
r={"SKL_004_HEAD","SKL_002_CHEST"}t={Vector3(0,.15,0),Vector3(0,-.05,0)}a={Vector3(.1,.125,.1),Vector3(.1,.125,.1)}n=Vector3(0,0,-1.5)e=3
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{-10,170},{-10,-170}},skeletonNames=r,skeletonCenterOffsets=t,skeletonBoundings=a,offsetPos=n,focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=i}return o
end
function e.PlayMissionAbortCamera()local e=e.SetPlayerStatusForMissionEndCamera()if not e then
return
end
r("Timer_StartPlayMissionAbortCamera",.25)end
function e._PlayMissionAbortCamera()TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_failed")e.PlayCommonMissionEndCamera(e.PlayMissionAbortCameraOnRideHorse,e.VEHICLE_MISSION_ABORT_CAMERA,e.PlayMissionAbortCameraOnWalkerGear,e.PlayMissionAbortCameraOnFoot)end
function e.PlayMissionAbortCameraOnFoot()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{6,10},{6,-10}},skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"},skeletonCenterOffsets={Vector3(0,.2,0),Vector3(-.15,0,0),Vector3(-.15,0,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},offsetPos=Vector3(0,0,-3),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}end
function e.PlayMissionAbortCameraOnRideHorse(e)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{6,20},{6,-20}},skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"},skeletonCenterOffsets={Vector3(0,.2,0),Vector3(-.15,0,0),Vector3(-.15,0,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},offsetPos=Vector3(0,0,-3),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}end
function e.PlayMissionAbortCameraOnRideLightVehicle(e)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{10,30},{10,-30}},offsetTarget=Vector3(-.35,.3,0),offsetPos=Vector3(0,0,-4),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}end
function e.PlayMissionAbortCameraOnRideTruck(e)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,75},{8,-55}},offsetTarget=Vector3(-.35,1,1),offsetPos=Vector3(0,0,-5),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}end
function e.PlayMissionAbortCameraOnRideCommonArmoredVehicle(e,a)local e=Vector3(.05,-.5,-2.2)if a==1 then
e=Vector3(.05,-.5,-2.2)else
e=Vector3(-.65,-1,0)end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,30},{8,-30}},offsetTarget=e,offsetPos=Vector3(0,0,-9),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}end
function e.PlayMissionAbortCameraOnRideEasternArmoredVehicle(a)e.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,1)end
function e.PlayMissionAbortCameraOnRideWesternArmoredVehicle(a)e.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,2)end
function e.PlayMissionAbortCameraOnRideTank(e)local e=Vector3(0,-.5,0)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,25},{8,-25}},offsetTarget=e,offsetPos=Vector3(0,0,-10),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}end
function e.PlayMissionAbortCameraOnWalkerGear(a)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,15},{7,-15}},offsetTarget=Vector3(0,.8,0),offsetPos=Vector3(0,.5,-3.5),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}end
e.VEHICLE_MISSION_ABORT_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayMissionAbortCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayMissionAbortCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayMissionAbortCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionAbortCameraOnRideEasternArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayMissionAbortCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayMissionAbortCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayMissionAbortCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionAbortCameraOnRideWesternArmoredVehicle}function e.PlayFallDeadCamera(a)mvars.ply_fallDeadCameraTimeToSleep=20
if a and Tpp.IsTypeNumber(a.timeToSleep)then
mvars.ply_fallDeadCameraTimeToSleep=a.timeToSleep
end
mvars.ply_fallDeadCameraTargetPlayerIndex=PlayerInfo.GetLocalPlayerIndex()HighSpeedCamera.RequestEvent{continueTime=.03,worldTimeRate=.1,localPlayerTimeRate=.1}e.PlayCommonMissionEndCamera(e.PlayFallDeadCameraOnRideHorse,e.VEHICLE_FALL_DEAD_CAMERA,e.PlayFallDeadCameraOnWalkerGear,e.PlayFallDeadCameraOnFoot)end
function e.SetLimitFallDeadCameraOffsetPosY(e)mvars.ply_fallDeadCameraPosYLimit=e
end
function e.ResetLimitFallDeadCameraOffsetPosY()mvars.ply_fallDeadCameraPosYLimit=nil
end
function e.GetFallDeadCameraOffsetPosY()local a=vars.playerPosY
local e=.5
if mvars.ply_fallDeadCameraPosYLimit then
local t=a+e
if t<mvars.ply_fallDeadCameraPosYLimit then
e=mvars.ply_fallDeadCameraPosYLimit-a
end
end
return e
end
function e.PlayFallDeadCameraOnFoot()local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}end
function e.PlayFallDeadCameraOnRideHorse(a)local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}end
function e.PlayFallDeadCameraOnRideLightVehicle(a)local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}end
function e.PlayFallDeadCameraOnRideTruck(a)local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}end
function e.PlayFallDeadCameraOnRideArmoredVehicle(a)local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}end
function e.PlayFallDeadCameraOnRideTank(a)local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}end
function e.PlayFallDeadCameraOnWalkerGear(a)local a=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(a+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}end
e.VEHICLE_FALL_DEAD_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayFallDeadCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayFallDeadCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayFallDeadCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayFallDeadCameraOnRideArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayFallDeadCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayFallDeadCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayFallDeadCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayFallDeadCameraOnRideArmoredVehicle}function e.Messages()local n=Tpp.StrCode32Table{Player={{msg="CalcFultonPercent",func=function(r,n,t,a,o)e.MakeFultonRecoverSucceedRatio(r,n,t,a,o,false)end},{msg="CalcDogFultonPercent",func=function(r,n,o,a,t)e.MakeFultonRecoverSucceedRatio(r,n,o,a,t,true)end},{msg="RideHelicopter",func=e.SetHelicopterInsideAction},{msg="PlayerFulton",func=e.OnPlayerFulton},{msg="OnPickUpCollection",func=e.OnPickUpCollection},{msg="OnPickUpPlaced",func=e.OnPickUpPlaced},{msg="OnPickUpWeapon",func=e.OnPickUpWeapon},{msg="WarpEnd",func=e.OnEndWarpByCboxDelivery},{msg="LandingFromHeli",func=function()e.UpdateCheckPointOnMissionStartDrop()end},{msg="EndCarryAction",func=function()if mvars.ply_requestedMissionClearCameraCarryOff then
if PlayerInfo.AndCheckStatus{PlayerStatus.STAND}then
e.RequestMissionClearMotion()end
end
end,option={isExecMissionClear=true}},{msg="IntelIconInDisplay",func=e.OnIntelIconDisplayContinue},{msg="QuestIconInDisplay",func=e.OnQuestIconDisplayContinue},{msg="PlayerShowerEnd",func=function()TppUI.ShowAnnounceLog"refresh"end}},GameObject={{msg="RideHeli",func=e.QuietRideHeli}},UI={{msg="EndFadeOut",sender="OnSelectCboxDelivery",func=e.WarpByCboxDelivery},{msg="EndFadeIn",sender="OnEndWarpByCboxDelivery",func=e.OnEndFadeInWarpByCboxDelivery},{msg="EndFadeOut",sender="EndFadeOut_StartTargetDeadCamera",func=e._SetTargetDeadCamera,option={isExecGameOver=true}},{msg="EndFadeOut",sender="EndFadeOut_StartTargetHeliCamera",func=e._SetTargetHeliCamera,option={isExecGameOver=true}},{msg="EndFadeOut",sender="EndFadeOut_StartTargetTruckCamera",func=e._SetTargetTruckCamera,option={isExecGameOver=true}}},Terminal={{msg="MbDvcActSelectCboxDelivery",func=e.OnSelectCboxDelivery}},Timer={{msg="Finish",sender="Timer_StartPlayMissionClearCameraStep1",func=function()e._PlayMissionClearCamera(1)end,option={isExecMissionClear=true}},{msg="Finish",sender="Timer_StartPlayMissionClearCameraStep2",func=function()e._PlayMissionClearCamera(2)end,option={isExecMissionClear=true}},{msg="Finish",sender="Timer_FOBStartPlayMissionClearCameraStep1",func=function()e._FOBPlayMissionClearCamera(1)end,option={isExecMissionClear=true}},{msg="Finish",sender="Timer_FOBStartPlayMissionClearCameraStep2",func=function()e._FOBPlayMissionClearCamera(2)end,option={isExecMissionClear=true}},{msg="Finish",sender="Timer_StartPlayMissionAbortCamera",func=e._PlayMissionAbortCamera,option={isExecGameOver=true}},{msg="Finish",sender="Timer_DeliveryWarpSoundCannotCancel",func=e.OnDeliveryWarpSoundCannotCancel},{msg="Finish",sender="Timer_StartGameOverCamera",func=e._StartGameOverCamera,option={isExecGameOver=true}},{msg="Finish",sender="Timer_FOBWaitStandStance",func=function()e.FOBRequestMissionClearMotion()end,option={isExecMissionClear=true}}},Trap={{msg="Enter",sender="trap_TppSandWind0000",func=function()TppEffectUtility.SetSandWindEnable(true)end,option={isExecMissionPrepare=true}},{msg="Exit",sender="trap_TppSandWind0000",func=function()TppEffectUtility.SetSandWindEnable(false)end,option={isExecMissionPrepare=true}},{msg="Enter",sender="fallDeath_camera",func=function()e.SetLimitFallDeadCameraOffsetPosY(-18)end,option={isExecMissionPrepare=true}},{msg="Exit",sender="fallDeath_camera",func=e.ResetLimitFallDeadCameraOffsetPosY,option={isExecMissionPrepare=true}}}}if t(mvars.ply_intelMarkerTrapList)and next(mvars.ply_intelMarkerTrapList)then
n[a"Trap"]=n[a"Trap"]or{}table.insert(n[a"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelMarkerTrapList,func=e.OnEnterIntelMarkerTrap,option={isExecMissionPrepare=true}})end
if t(mvars.ply_intelTrapList)and next(mvars.ply_intelTrapList)then
n[a"Trap"]=n[a"Trap"]or{}table.insert(n[a"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelTrapList,func=e.OnEnterIntelTrap})table.insert(n[a"Trap"],Tpp.StrCode32Table{msg="Exit",sender=mvars.ply_intelTrapList,func=e.OnExitIntelTrap})end
return n
end
function e.DeclareSVars()return{{name="ply_pickableLocatorDisabled",arraySize=mvars.ply_maxPickableLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ply_placedLocatorDisabled",arraySize=mvars.ply_maxPlacedLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ply_isUsedPlayerInitialAction",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}end
function e.OnAllocate(e)if(e and e.sequence)and e.sequence.EQUIP_MISSION_BLOCK_GROUP_SIZE then
mvars.ply_equipMissionBlockGroupSize=e.sequence.EQUIP_MISSION_BLOCK_GROUP_SIZE
else
mvars.ply_equipMissionBlockGroupSize=TppDefine.DEFAULT_EQUIP_MISSION_BLOCK_GROUP_SIZE
end
if(e and e.sequence)and e.sequence.MAX_PICKABLE_LOCATOR_COUNT then
mvars.ply_maxPickableLocatorCount=e.sequence.MAX_PICKABLE_LOCATOR_COUNT
else
mvars.ply_maxPickableLocatorCount=TppDefine.PICKABLE_MAX
end
if(e and e.sequence)and e.sequence.MAX_PLACED_LOCATOR_COUNT then
mvars.ply_maxPlacedLocatorCount=e.sequence.MAX_PLACED_LOCATOR_COUNT
else
mvars.ply_maxPlacedLocatorCount=TppDefine.PLACED_MAX
end
end
function e.SetInitialPlayerState(a)local t
if(a.sequence and a.sequence.missionStartPosition)and a.sequence.missionStartPosition.helicopterRouteList then
if not Tpp.IsTypeFunc(a.sequence.missionStartPosition.IsUseRoute)or a.sequence.missionStartPosition.IsUseRoute()then
t=a.sequence.missionStartPosition.helicopterRouteList
end
end
if t==nil then
if gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER then
end
e.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)end
end
function e.MissionStartPlayerTypeSetting()if not mvars.ply_isExistTempPlayerType then
e.RestoreTemporaryPlayerType()end
if TppStory.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
vars.playerType=PlayerType.SNAKE
vars.playerPartsType=PlayerPartsType.NORMAL_SCARF
vars.playerCamoType=PlayerCamoType.TIGERSTRIPE
vars.playerHandType=PlayerHandType.NORMAL
end
if mvars.ply_isExistTempPlayerType then
e.SaveCurrentPlayerType()e.ApplyTemporaryPlayerType()end
if(vars.missionCode~=10010)and(vars.missionCode~=10280)then
if vars.playerCamoType==PlayerCamoType.HOSPITAL then
vars.playerCamoType=PlayerCamoType.OLIVEDRAB
end
if vars.playerPartsType==PlayerPartsType.HOSPITAL then
vars.playerPartsType=PlayerPartsType.NORMAL
end
end
end
function e.Init(a)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())if gvars.ini_isTitleMode then
vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_HIP]=1
vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_BACK]=1
vars.isInitialWeapon[TppDefine.WEAPONSLOT.SECONDARY]=1
end
if a.sequence and a.sequence.ALLWAYS_100_PERCENT_FULTON then
mvars.ply_allways_100percent_fulton=true
end
if TppMission.IsMissionStart()then
local e
if a.sequence and a.sequence.INITIAL_HAND_EQUIP then
e=a.sequence.INITIAL_HAND_EQUIP
end
if e then
end
local e
if a.sequence and a.sequence.INITIAL_CAMERA_ROTATION then
e=a.sequence.INITIAL_CAMERA_ROTATION
end
if e then
vars.playerCameraRotation[0]=e[1]vars.playerCameraRotation[1]=e[2]end
end
if gvars.s10240_isPlayedFuneralDemo then
Player.SetUseBlackDiamondEmblem(true)else
Player.SetUseBlackDiamondEmblem(false)end
local e=0
if TppMission.IsHelicopterSpace(vars.missionCode)then
vars.currentItemIndex=e
vars.initialPlayerAction=PlayerInitialAction.HELI_SPACE
return
end
if TppMission.IsMissionStart()then
if((vars.missionCode==30010)or(vars.missionCode==30020))and(Player.IsVarsCurrentItemCBox())then
else
vars.currentItemIndex=e
end
end
if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
local e=i("TppHeli2","SupportHeli")if e~=n then
vars.initialPlayerAction=PlayerInitialAction.FROM_HELI_SPACE
vars.initialPlayerPairGameObjectId=e
end
else
if TppMission.IsMissionStart()then
local e
if a.sequence and a.sequence.MISSION_START_INITIAL_ACTION then
e=a.sequence.MISSION_START_INITIAL_ACTION
end
if e then
vars.initialPlayerAction=e
end
end
end
mvars.ply_locationStationTable={}mvars.ply_stationLocatorList={}local e=TppLocation.GetLocationName()if e=="afgh"or e=="mafr"then
local a=TppDefine.STATION_LIST[e]if a and TppCollection.GetUniqueIdByLocatorName then
for a,e in ipairs(a)do
local a="col_labl_"..e
local e="col_stat_"..e
local t=TppCollection.GetUniqueIdByLocatorName(a)mvars.ply_locationStationTable[t]=e
if TppCollection.RepopCountOperation("GetAt",a)>0 then
TppCollection.SetValidStation(e)end
end
end
local e=TppDefine.STATION_LIST[e]if e then
for a,e in ipairs(e)do
local e="col_labl_"..e
table.insert(mvars.ply_stationLocatorList,e)end
end
end
TppEffectUtility.SetSandWindEnable(false)end
function e.SetSelfSubsistenceOnHardMission()if TppMission.IsSubsistenceMission()then
e.SetInitWeapons(TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE)e.SetInitItems(TppDefine.CYPR_PLAYER_INITIAL_ITEM_TABLE)e.RegisterTemporaryPlayerType{partsType=PlayerPartsType.NORMAL,camoType=PlayerCamoType.OLIVEDRAB,handEquip=TppEquip.EQP_HAND_NORMAL,faceEquipId=0}end
end
function e.OnReload()e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
function e.OnMessage(n,a,o,i,r,t,l)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,n,a,o,i,r,t,l)end
function e.Update()e.UpdateDeliveryWarp()end
local c={[TppDefine.WEATHER.SUNNY]=0,[TppDefine.WEATHER.CLOUDY]=-10,[TppDefine.WEATHER.RAINY]=-30,[TppDefine.WEATHER.FOGGY]=-50,[TppDefine.WEATHER.SANDSTORM]=-70}function e.MakeFultonRecoverSucceedRatio(t,a,p,l,s,i)local r={[TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0}local t=a
local a=0
local o=100
local n=0
n=TppTerminal.DoFuncByFultonTypeSwitch(t,p,l,s,nil,nil,nil,e.GetSoldierFultonSucceedRatio,e.GetVolginFultonSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio)if n==nil then
n=100
end
local e=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}local r=r[e]or 0
local e=c[vars.weather]or 0
e=e+r
if e>0 then
e=0
end
a=(o+n)+e
if mvars.ply_allways_100percent_fulton then
a=100
end
if TppEnemy.IsRescueTarget(t)then
a=100
end
local e
if mvars.ply_forceFultonPercent then
e=mvars.ply_forceFultonPercent[t]end
if e then
a=e
end
if i then
Player.SetDogFultonIconPercentage{percentage=a,targetId=t}else
Player.SetFultonIconPercentage{percentage=a,targetId=t}end
end
function e.GetSoldierFultonSucceedRatio(a)local e=0
local n=0
local t=o(a,{id="GetLifeStatus"})local r=GameObject.SendCommand(a,{id="GetStateFlag"})if(bit.band(r,StateFlag.DYING_LIFE)~=0)then
e=-70
elseif(t==TppGameObject.NPC_LIFE_STATE_SLEEP)or(t==TppGameObject.NPC_LIFE_STATE_FAINT)then
e=0
if mvars.ply_OnFultonIconDying then
mvars.ply_OnFultonIconDying()end
elseif(t==TppGameObject.NPC_LIFE_STATE_DEAD)then
return
end
local t={[TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0}local r=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY}local t=t[r]or 0
e=e+t
if e>0 then
e=0
end
local a=o(a,{id="GetStatus"})if a==EnemyState.STAND_HOLDUP then
n=-10
end
return(e+n)end
function e.GetDefaultSucceedRatio(e)return 0
end
function e.GetVolginFultonSucceedRatio(e)return 100
end
function e.SetHelicopterInsideAction()Player.SetHeliToInsideParam{canClearMission=svars.mis_canMissionClear}end
function e.OnPlayerFulton(e,r)if e~=PlayerInfo.GetLocalPlayerIndex()then
return
end
local n=300
local a=1e4
local e=1e4
local t=5e3
local a={[TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2]=a,[TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2]=a,[TppGameObject.GAME_OBJECT_TYPE_BATTLEGEAR]=a,[TppGameObject.GAME_OBJECT_TYPE_VEHICLE]=e,[TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER]=e,[TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN]=e,[TppGameObject.GAME_OBJECT_TYPE_MORTAR]=t,[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN]=t}local e
local t=GameObject.GetTypeIndex(r)e=a[t]or n
TppTerminal.UpdateGMP{gmp=-e,gmpCostType=TppDefine.GMP_COST_TYPE.FULTON}svars.supportGmpCost=svars.supportGmpCost+e
end
function e.QuietRideHeli(e)if e==GameObject.GetGameObjectIdByIndex("TppBuddyQuiet2",0)then
Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=false,isFollowRot=false,followTime=1,followDelayTime=.1,candidateRots={{-4,45},{-4,-45},{-8,0}},offsetPos=Vector3(0,-.2,-2.5),offsetTarget=Vector3(0,2,0),focalLength=21,aperture=1.875,timeToSleep=2,enableOverride=true}end
end
function e.SetRetryFlag()vars.playerRetryFlag=PlayerRetryFlag.RETRY
end
function e.SetRetryFlagWithChickCap()vars.playerRetryFlag=PlayerRetryFlag.RETRY_WITH_CHICK_CAP
end
function e.UnsetRetryFlag()vars.playerRetryFlag=0
end
function e.ResetStealthAssistCount()vars.stealthAssistLeftCount=0
end
function e.OnPickUpCollection(r,t,a,i)local r=255
TppCollection.RepopCountOperation("SetAt",t,r)TppTerminal.AddPickedUpResourceToTempBuffer(a,i)local r={[TppCollection.TYPE_POSTER_SOL_AFGN]="key_poster_3500",[TppCollection.TYPE_POSTER_SOL_MAFR]="key_poster_3501",[TppCollection.TYPE_POSTER_GRAVURE_V]="key_poster_3502",[TppCollection.TYPE_POSTER_GRAVURE_H]="key_poster_3503",[TppCollection.TYPE_POSTER_MOE_V]="key_poster_3504",[TppCollection.TYPE_POSTER_MOE_H]="key_poster_3505"}local r=r[a]if r~=nil then
TppUI.ShowAnnounceLog("getPoster",r,TppTerminal.GMP_POSTER)end
local r
if TppTerminal.RESOURCE_INFORMATION_TABLE[a]and TppTerminal.RESOURCE_INFORMATION_TABLE[a].count then
r=TppTerminal.RESOURCE_INFORMATION_TABLE[a].count
end
if TppCollection.IsHerbByType(a)then
local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)if e~=n then
o(e,{id="GetPlant",uniqueId=t})end
end
if TppCollection.IsMaterialByType(a)then
TppUI.ShowAnnounceLog("find_processed_res",i,r)end
if a==TppCollection.TYPE_DIAMOND_SMALL then
TppUI.ShowAnnounceLog("find_diamond",TppDefine.SMALL_DIAMOND_GMP)end
if a==TppCollection.TYPE_DIAMOND_LARGE then
TppUI.ShowAnnounceLog("find_diamond",TppDefine.LARGE_DIAMOND_GMP)end
local a=mvars.ply_locationStationTable[t]if a then
TppUI.ShowAnnounceLog"get_invoice"TppUI.ShowAnnounceLog"add_delivery_point"TppCollection.SetValidStation(a)e.CheckAllStationPickedUp()end
TppTerminal.PickUpBluePrint(t)TppTerminal.PickUpEmblem(t)end
function e.CheckAllStationPickedUp()local e=true
for t,a in ipairs(mvars.ply_stationLocatorList)do
local a=TppCollection.RepopCountOperation("GetAt",a)if a then
if a<1 then
e=false
break
end
end
end
if e then
TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3011,isShowAnnounceLog=true}if TppLocation.IsAfghan()then
gvars.ply_isAllGotStation_Afgh=true
elseif TppLocation.IsMiddleAfrica()then
gvars.ply_isAllGotStation_Mafr=true
end
if gvars.ply_isAllGotStation_Afgh and gvars.ply_isAllGotStation_Mafr then
TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3012,isShowAnnounceLog=true}end
end
end
function e.OnPickUpPlaced(e,e,a)local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)if e~=n then
o(e,{id="GetPlacedItem",index=a})end
end
function e.OnPickUpWeapon(t,e,a)if e==TppEquip.EQP_IT_Cassette then
TppCassette.AcquireOnPickUp(a)end
end
function e.RestoreSupplyCbox()if e.IsExistSupplyCboxSystem()then
local e={type="TppSupplyCboxSystem"}o(e,{id="RestoreRequest"})end
end
function e.StoreSupplyCbox()if e.IsExistSupplyCboxSystem()then
local e={type="TppSupplyCboxSystem"}o(e,{id="StoreRequest"})end
end
function e.IsExistSupplyCboxSystem()if GameObject.GetGameObjectIdByIndex("TppSupplyCboxSystem",0)~=n then
return true
else
return false
end
end
function e.RestoreSupportAttack()if e.IsExistSupportAttackSystem()then
local e={type="TppSupportAttackSystem"}o(e,{id="RestoreRequest"})end
end
function e.StoreSupportAttack()if e.IsExistSupportAttackSystem()then
local e={type="TppSupportAttackSystem"}o(e,{id="StoreRequest"})end
end
function e.IsExistSupportAttackSystem()if GameObject.GetGameObjectIdByIndex("TppSupportAttackSystem",0)~=n then
return true
else
return false
end
end
function e.StorePlayerDecoyInfos()if e.IsExistDecoySystem()then
local e={type="TppDecoySystem"}o(e,{id="StorePlayerDecoyInfos"})end
end
function e.IsExistDecoySystem()if GameObject.GetGameObjectIdByIndex("TppDecoySystem",0)~=n then
return true
else
return false
end
end
local a=7.5
local t=3.5
e.DELIVERY_WARP_STATE=Tpp.Enum{"START_FADE_OUT","START_WARP","END_WARP","START_FADE_IN"}function e.OnSelectCboxDelivery(a)Player.SetPadMask{settingName="CboxDelivery",except=true}mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_FADE_OUT
mvars.ply_selectedCboxDeliveryUniqueId=a
mvars.ply_playingDeliveryWarpSoundHandle=TppSoundDaemon.PostEventAndGetHandle("Play_truck_transfer","Loading")TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"OnSelectCboxDelivery",nil,{setMute=true})end
function e.WarpByCboxDelivery()if not mvars.ply_selectedCboxDeliveryUniqueId then
return
end
TppGameStatus.Set("TppPlayer.WarpByCboxDelivery","S_IS_BLACK_LOADING")if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
TppQuest.DeactivateCurrentQuestBlock()TppQuest.ClearBlockStateRequest()end
mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_WARP
r("Timer_DeliveryWarpSoundCannotCancel",a)local a={type="TppPlayer2",index=0}local e={id="WarpToStation",stationId=mvars.ply_selectedCboxDeliveryUniqueId}GameObject.SendCommand(a,e)end
function e.OnEndWarpByCboxDelivery()if mvars.ply_deliveryWarpState==e.DELIVERY_WARP_STATE.START_WARP then
mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.END_WARP
end
end
function e.OnDeliveryWarpSoundCannotCancel()mvars.ply_deliveryWarpSoundCannotCancel=true
end
function e.UpdateDeliveryWarp()if not mvars.ply_deliveryWarpState then
return
end
if DebugText then
local a=DebugText.Print
local t=DebugText.NewContext()local n=e.DELIVERY_WARP_STATE[mvars.ply_deliveryWarpState]a(t,{.5,.5,1},"Now cbox delivering. STATE = "..tostring(n))a(t,{.5,.5,1},"Cbox deliver sound is playing? > "..tostring(mvars.ply_playingDeliveryWarpSoundHandle))if(mvars.ply_deliveryWarpState==e.DELIVERY_WARP_STATE.END_WARP)then
if not mvars.ply_deliveryWarpSoundCannotCancel then
a(t,{.5,.5,1},"Player warp end. If you want skip deliver sound, push PlayerPad.STANCE.")end
end
end
if(mvars.ply_deliveryWarpState==e.DELIVERY_WARP_STATE.START_WARP)then
TppUI.ShowAccessIconContinue()end
if(mvars.ply_deliveryWarpState~=e.DELIVERY_WARP_STATE.END_WARP)then
return
end
if not TppMission.CheckMissionState()then
mvars.ply_playingDeliveryWarpSoundHandle=nil
mvars.ply_selectedCboxDeliveryUniqueId=nil
mvars.ply_deliveryWarpState=nil
mvars.ply_deliveryWarpSoundCannotCancel=nil
TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")p"Timer_DeliveryWarpSoundCannotCancel"return
end
if mvars.ply_playingDeliveryWarpSoundHandle then
local e=TppSoundDaemon.IsEventPlaying("Play_truck_transfer",mvars.ply_playingDeliveryWarpSoundHandle)if(e==false)then
TppSoundDaemon.ResetMute"Loading"mvars.ply_playingDeliveryWarpSoundHandle=nil
else
TppUI.ShowAccessIconContinue()end
end
if(mvars.ply_playingDeliveryWarpSoundHandle and(not mvars.ply_deliveryWarpSoundCannotCancel))and(bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.STANCE)==PlayerPad.STANCE)then
mvars.ply_deliveryWarpSoundCannotCancel=true
TppSoundDaemon.ResetMute"Loading"TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")end
if(not mvars.ply_playingDeliveryWarpSoundHandle)then
mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_FADE_IN
TppSoundDaemon.ResetMute"Loading"TppGameStatus.Reset("TppPlayer.WarpByCboxDelivery","S_IS_BLACK_LOADING")if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
TppQuest.InitializeQuestLoad()TppQuest.InitializeQuestActiveStatus()end
TppMission.ExecuteSystemCallback("OnEndDeliveryWarp",mvars.ply_selectedCboxDeliveryUniqueId)TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMAL,"OnEndWarpByCboxDelivery")end
end
function e.OnEndFadeInWarpByCboxDelivery()mvars.ply_selectedCboxDeliveryUniqueId=nil
mvars.ply_deliveryWarpState=nil
mvars.ply_deliveryWarpSoundCannotCancel=nil
p"Timer_DeliveryWarpSoundCannotCancel"Player.ResetPadMask{settingName="CboxDelivery"}end
function e.OnEnterIntelMarkerTrap(e,a)local e=mvars.ply_intelMarkerTrapInfo[e]local a=mvars.ply_intelFlagInfo[e]if a then
if svars[a]then
return
end
else
return
end
local e=mvars.ply_intelMarkerObjectiveName[e]if e then
TppMission.UpdateObjective{objectives={e}}end
end
function e.OnEnterIntelTrap(a,t)local a=mvars.ply_intelTrapInfo[a]e.ShowIconForIntel(a)end
function e.OnExitIntelTrap(a,a)e.HideIconForIntel()end
function e.OnIntelIconDisplayContinue(a,t,t)local a=mvars.ply_intelNameReverse[a]e.ShowIconForIntel(a)end
function e.OnEnterQuestTrap(a,t)local a=mvars.ply_questStartTrapInfo[a]e.ShowIconForQuest(a)local e=mvars.ply_questStartFlagInfo[a]if e~=nil and e==false then
TppSoundDaemon.PostEvent"sfx_s_ifb_mbox_arrival"end
end
function e.OnExitQuestTrap(a,a)e.HideIconForQuest()end
function e.OnQuestIconDisplayContinue(a,t,t)local a=mvars.ply_questNameReverse[a]e.ShowIconForQuest(a)end
function e.UpdateCheckPointOnMissionStartDrop()if not TppSequence.IsHelicopterStart()then
return
end
if TppMission.IsEmergencyMission()then
return
end
if not mvars.ply_doneUpdateCheckPointOnMissionStartDrop then
TppMission.UpdateCheckPointAtCurrentPosition()mvars.ply_doneUpdateCheckPointOnMissionStartDrop=true
end
end
function e.IsAlreadyDropped()return mvars.ply_doneUpdateCheckPointOnMissionStartDrop
end
function e.SaveCaptureAnimal()if mvars.loc_locationAnimalSettingTable==nil then
return
end
local a=TppPlaced.GetCaptureCageInfo()for t,a in pairs(a)do
local a,e,t,t=e.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)if e~=0 then
CaptureCage.RegisterCaptureAnimal(e,a)end
end
TppPlaced.DeleteAllCaptureCage()end
function e.AggregateCaptureAnimal()local a=0
local e=0
local t=CaptureCage.GetCaptureAnimalList()for t,n in pairs(t)do
local t=n.animalId
local n=n.areaName
TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=t,areaNameHash=n,isNew=true}local n,r=TppMotherBaseManagement.GetAnimalHeroicPointAndGmp{dataBaseId=t}a=a+n
e=e+r
TppUiCommand.ShowBonusPopupAnimal(t,"regist")end
if a>0 or e>0 then
TppMotherBaseManagement.AddHeroicPointAndGmpByCageAnimal{heroicPoint=a,gmp=e,isAnnounce=true}end
end
function e.CheckCaptureCage(n,r)if mvars.loc_locationAnimalSettingTable==nil then
return
end
if n<2 or n>4 then
return
end
local a={}local t=5
local o=r/t
for r=1,o do
if n==2 then
Player.DEBUG_PlaceAround{radius=5,count=t,equipId=TppEquip.EQP_SWP_CaptureCage}elseif n==3 then
Player.DEBUG_PlaceAround{radius=5,count=t,equipId=TppEquip.EQP_SWP_CaptureCage_G01}elseif n==4 then
Player.DEBUG_PlaceAround{radius=5,count=t,equipId=TppEquip.EQP_SWP_CaptureCage_G02}end
for e=1,t do
coroutine.yield()end
local t=TppPlaced.GetCaptureCageInfo()for n,t in pairs(t)do
local n,t,r,e=e.EvaluateCaptureCage(t.x,t.z,t.grade,t.material)if t~=0 then
TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=t,areaName=n,isNew=true}if a[e]==nil then
a[e]=1
else
a[e]=a[e]+1
end
end
end
TppPlaced.DeleteAllCaptureCage()end
for a,e in pairs(a)do
local e=(e/r)*100
end
end
function e.GetCaptureAnimalSE(t)local e="sfx_s_captured_nom"local a=mvars.loc_locationAnimalSettingTable
if a==nil then
return e
end
local a=a.animalRareLevel
if a[t]==nil then
return e
end
local a=a[t]if a==TppMotherBaseManagementConst.ANIMAL_RARE_SR then
e="sfx_s_captured_super"elseif a==TppMotherBaseManagementConst.ANIMAL_RARE_R then
e="sfx_s_captured_rare"else
e="sfx_s_captured_nom"end
return e
end
function e._IsStartStatusValid(a)if(e.StartStatusList[a]==nil)then
return false
end
return true
end
function e._IsAbilityNameValid(a)if(e.DisableAbilityList[a]==nil)then
return false
end
return true
end
function e._IsControlModeValid(a)if(e.ControlModeList[a]==nil)then
return false
end
return true
end
function e._CheckRotation(e,t,a,n,r)local r=mvars
local r=vars.playerCameraRotation[0]local o=vars.playerCameraRotation[1]local e=foxmath.DegreeToRadian(r-e)e=foxmath.NormalizeRadian(e)local r=foxmath.RadianToDegree(e)local e=foxmath.DegreeToRadian(o-a)e=foxmath.NormalizeRadian(e)local e=foxmath.RadianToDegree(e)if(foxmath.Absf(r)<t)and(foxmath.Absf(e)<n)then
return true
else
return false
end
end
local function n(a)local n=math.random(0,99)local e=0
local t=-1
for r,a in pairs(a)do
e=e+a[2]if n<e then
t=a[1]break
end
end
return t
end
local function c(e,a)for t,e in pairs(e)do
if e==a then
return true
end
end
return false
end
function e.EvaluateCaptureCage(a,i,o,p)local t=mvars
local r=t.loc_locationAnimalSettingTable
local l=r.captureCageAnimalAreaSetting
local t="wholeArea"for n,e in pairs(l)do
if((a>=e.activeArea[1]and a<=e.activeArea[3])and i>=e.activeArea[2])and i<=e.activeArea[4]then
t=e.areaName
break
end
end
local a=0
if o==2 then
a=n(e.CageRandomTableG3)elseif o==1 then
a=n(e.CageRandomTableG2)else
a=n(e.CageRandomTableG1)end
local n=r.captureAnimalList
local l=r.animalRareLevel
local s=r.animalInfoList
local e={}if n[t]==nil then
t="wholeArea"end
local i=false
for n,t in pairs(n[t])do
local n=l[t]if n>=TppMotherBaseManagementConst.ANIMAL_RARE_SR and o==2 then
if not TppMotherBaseManagement.IsGotDataBase{dataBaseId=t}then
table.insert(e,t)a=n
i=true
break
end
end
end
if not i then
local r=a
while a>=0 do
for n,t in pairs(n[t])do
if l[t]==a then
table.insert(e,t)end
end
if table.maxn(e)>0 then
break
end
a=a-1
end
if a<0 then
a=r
t="wholeArea"while a>=0 do
for n,t in pairs(n[t])do
if l[t]==a then
table.insert(e,t)end
end
if table.maxn(e)>0 then
break
end
a=a-1
end
end
end
local i=r.animalMaterial
local r={}local o=a
if i~=nil then
while o>=0 do
for a,e in pairs(n.wholeArea)do
if i[e]==nil and l[e]==o then
table.insert(r,e)end
end
if table.maxn(r)>0 then
break
end
o=o-1
end
end
local n=0
local l=table.maxn(e)if l==1 then
n=e[1]elseif l>1 then
local a=math.random(1,l)n=e[a]end
if#r==0 then
local e=""return t,n,a,e
end
if i~=nil then
local e=i[n]if e~=nil then
if c(e,p)==false then
local e=math.random(1,#r)n=r[e]a=o
end
end
end
local e=""if s~=nil then
if n~=0 then
e=s[n].name
end
end
return t,n,a,e
end
function e.Refresh(e)if e then
Player.ResetDirtyEffect()end
vars.passageSecondsSinceOutMB=0
end
return e