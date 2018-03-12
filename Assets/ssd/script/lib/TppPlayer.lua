local e={}local p=Tpp.IsTypeFunc
local n=Tpp.IsTypeTable
local l=Tpp.IsTypeString
local t=Fox.StrCode32
local o=GkEventTimerManager.Start
local m=GkEventTimerManager.Stop
local a=GameObject.GetTypeIndex
local s=GameObject.GetGameObjectId
local T=GameObject.GetTypeIndexWithTypeName
local a=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local a=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local r=GameObject.NULL_ID
local i=GameObject.SendCommand
e.MISSION_CLEAR_CAMERA_FADE_DELAY_TIME=3
e.MISSION_CLEAR_CAMERA_DELAY_TIME=0
e.PLAYER_FALL_DEAD_DELAY_TIME=.2
e.DisableAbilityList={Stand="DIS_ACT_STAND",Squat="DIS_ACT_SQUAT",Crawl="DIS_ACT_CRAWL",Dash="DIS_ACT_DASH"}e.ControlModeList={LockPadMode="All",LockMBTerminalOpenCloseMode="MB_Disable",MBTerminalOnlyMode="MB_OnlyMode"}e.CageRandomTableG1={{1,20},{0,80}}e.CageRandomTableG2={{2,15},{1,20},{0,65}}e.CageRandomTableG3={{4,5},{3,10},{2,15},{1,20},{0,50}}e.RareLevelList={"N","NR","R","SR","SSR"}function e.RegisterCallbacks(e)if p(e.OnFultonIconDying)then
mvars.ply_OnFultonIconDying=e.OnFultonIconDying
end
end
function e.SetStartStatus(e)if(e>TppDefine.INITIAL_PLAYER_STATE.MIN)and(e<TppDefine.INITIAL_PLAYER_STATE.MAX)then
gvars.ply_initialPlayerState=e
end
end
function e.ResetDisableAction()vars.playerDisableActionFlag=PlayerDisableAction.NONE
end
function e.GetPosition()return{vars.playerPosX,vars.playerPosY,vars.playerPosZ}end
function e.GetRotation()return vars.playerRotY
end
function e.Warp(e)if not n(e)then
return
end
local a=e.pos
if not n(a)or(#a~=3)then
return
end
local n=foxmath.NormalizeRadian(foxmath.DegreeToRadian(e.rotY or 0))local t
if e.fobRespawn==true then
t={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}else
t={type="TppPlayer2",index=0}end
local e=e.unrealize
local e={id="WarpAndWaitBlock",pos=a,rotY=n,unrealize=e}GameObject.SendCommand(t,e)end
function e.ResetAroundCameraRotation(e)Player.RequestToSetCameraRotation{rotX=10,rotY=e or vars.playerRotY,interpTime=0}end
function e.ResetPlayerForReturnBaseCamp()if not TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")then
end
local a,t
if TppLocation.IsAfghan()then
a,t=Tpp.GetLocator("DataIdentifier_afgh_common_fasttravel","fast_afgh_basecamp")elseif TppLocation.IsMiddleAfrica()then
a,t=Tpp.GetLocator("DataIdentifier_mafr_common_fasttravel","fast_mafr_basecamp")end
if a then
a[2]=a[2]+.8
e.Warp{pos=a,rotY=t}end
e.ResetAroundCameraRotation(t)end
function e.OnEndWarp()if mvars.ply_requestedRevivePlayer then
mvars.ply_requestedRevivePlayer=false
if not TppMission.IsMultiPlayMission(vars.missionCode)then
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"EndRevivePlayer",TppUI.FADE_PRIORITY.SYSTEM)end
elseif mvars.ply_deliveryWarpState then
e.OnEndWarpByFastTravel()end
end
function e.Revive()mvars.ply_requestedRevivePlayer=true
GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="Revive",revivalType="Item"})end
function e.SetForceFultonPercent(a,e)if not Tpp.IsTypeNumber(a)then
return
end
if not Tpp.IsTypeNumber(e)then
return
end
if(a<0)or(a>=r)then
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
function e.CheckRotationSetting(a)if not n(a)then
return
end
local e=mvars
e.ply_checkDirectionList={}e.ply_checkRotationResult={}local function n(a,t,e)if e>=-180 and e<180 then
a[t]=e
end
end
for a,t in pairs(a)do
if p(t.func)then
e.ply_checkDirectionList[a]={}e.ply_checkDirectionList[a].func=t.func
local r=t.directionX or 0
local o=t.directionY or 0
local l=t.directionRangeX or 0
local t=t.directionRangeY or 0
n(e.ply_checkDirectionList[a],"directionX",r)n(e.ply_checkDirectionList[a],"directionY",o)n(e.ply_checkDirectionList[a],"directionRangeX",l)n(e.ply_checkDirectionList[a],"directionRangeY",t)else
return
end
end
end
function e.CheckRotation()local a=mvars
if a.ply_checkDirectionList==nil then
return
end
for t,n in pairs(a.ply_checkDirectionList)do
local e=e._CheckRotation(n.directionX,n.directionRangeX,n.directionY,n.directionRangeY,t)if e~=a.ply_checkRotationResult[t]then
a.ply_checkRotationResult[t]=e
a.ply_checkDirectionList[t].func(e)end
end
end
function e.IsFastTraveling()if mvars.ply_deliveryWarpState then
return true
else
return false
end
end
function e.IsFastTravelingAndWarpEnd()if mvars.ply_deliveryWarpState and mvars.ply_deliveryWarpState<e.DELIVERY_WARP_STATE.START_FADE_IN then
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
function e.SetMissionStartPositionToBaseFastTravelPoint()if TppLocation.IsAfghan()then
e.SetMissionStartPosition({-453.189,288.312,2231.18},62.5757)e.SetInitialPositionFromMissionStartPosition()elseif TppLocation.IsMiddleAfrica()then
e.SetMissionStartPosition({2865.74,102.611,-911.52},89.5129)e.SetInitialPositionFromMissionStartPosition()else
e.ResetMissionStartPosition()end
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
local t=gvars.ply_missionStartPos[0]-vars.playerPosX
local a=gvars.ply_missionStartPos[2]-vars.playerPosZ
local a=(t*t)+(a*a)if(a>e)then
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
function e.StoreTempInitialPosition()gvars.sav_continueForOutOfBaseArea=true
gvars.ply_startPosTempForBaseDefense[0]=vars.playerPosX
gvars.ply_startPosTempForBaseDefense[1]=vars.playerPosY
gvars.ply_startPosTempForBaseDefense[2]=vars.playerPosZ
gvars.ply_startPosTempForBaseDefense[3]=vars.playerRotY
end
function e.RestoreTempInitialPosition()vars.playerPosX=gvars.ply_startPosTempForBaseDefense[0]vars.playerPosY=gvars.ply_startPosTempForBaseDefense[1]vars.playerPosZ=gvars.ply_startPosTempForBaseDefense[2]vars.playerRotY=gvars.ply_startPosTempForBaseDefense[3]gvars.sav_continueForOutOfBaseArea=false
gvars.ply_startPosTempForBaseDefense[0]=0
gvars.ply_startPosTempForBaseDefense[1]=0
gvars.ply_startPosTempForBaseDefense[2]=0
gvars.ply_startPosTempForBaseDefense[3]=0
e.SetInitialPositionToCurrentPosition()end
function e.FailSafeInitialPositionForFreePlay()if not((vars.missionCode==30010)or(vars.missionCode==30020))then
return
end
if vars.initialPlayerFlag~=PlayerFlag.USE_VARS_FOR_INITIAL_POS then
return
end
if(((vars.initialPlayerPosX>3500)or(vars.initialPlayerPosX<-3500))or(vars.initialPlayerPosZ>3500))or(vars.initialPlayerPosZ<-3500)then
local e={[30010]={1448.61,337.787,1466.4},[30020]={-510.73,5.09,1183.02}}local e=e[vars.missionCode]vars.initialPlayerPosX,vars.initialPlayerPosY,vars.initialPlayerPosZ=e[1],e[2],e[3]end
end
function e.RegisterTemporaryPlayerType(e)if not n(e)then
return
end
mvars.ply_isExistTempPlayerType=true
local r=e.camoType
local n=e.partsType
local a=e.playerType
local t=e.handEquip
local e=e.faceEquipId
if n then
mvars.ply_tempPartsType=n
end
if r then
mvars.ply_tempCamoType=r
end
if a then
mvars.ply_tempPlayerType=a
end
if t then
mvars.ply_tempPlayerHandEquip=t
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
function e.SupplyAllAmmoFullOnMissionFinalize()end
function e.SupplyWeaponAmmoFull(e)end
function e.SupplySupportWeaponAmmoFull(e)end
function e.SupplyAmmoByBulletId(e,e)end
function e.SavePlayerCurrentAmmoCount()end
function e.SetMissionStartAmmoCount()end
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
function e.IsMine(e)local a=TppEquip.GetSupportWeaponTypeId(e)local e={[TppEquip.SWP_TYPE_DMine]=true,[TppEquip.SWP_TYPE_SleepingGusMine]=true,[TppEquip.SWP_TYPE_AntitankMine]=true,[TppEquip.SWP_TYPE_ElectromagneticNetMine]=true}if e[a]then
return true
else
return false
end
end
function e.AddTrapSettingForIntel(a)local n=a.trapName
local s=a.direction or 0
local p=a.directionRange or 60
local e=a.intelName
local d=a.autoIcon
local i=a.gotFlagName
local o=a.markerTrapName
local r=a.markerObjectiveName
local c=a.identifierName
local a=a.locatorName
if not l(n)then
return
end
mvars.ply_intelTrapInfo=mvars.ply_intelTrapInfo or{}if e then
mvars.ply_intelTrapInfo[e]={trapName=n}else
return
end
mvars.ply_intelNameReverse=mvars.ply_intelNameReverse or{}mvars.ply_intelNameReverse[t(e)]=e
mvars.ply_intelFlagInfo=mvars.ply_intelFlagInfo or{}if i then
mvars.ply_intelFlagInfo[e]=i
mvars.ply_intelFlagInfo[t(e)]=i
mvars.ply_intelTrapInfo[e].gotFlagName=i
end
mvars.ply_intelMarkerObjectiveName=mvars.ply_intelMarkerObjectiveName or{}if r then
mvars.ply_intelMarkerObjectiveName[e]=r
mvars.ply_intelMarkerObjectiveName[t(e)]=r
mvars.ply_intelTrapInfo[e].markerObjectiveName=r
end
mvars.ply_intelMarkerTrapList=mvars.ply_intelMarkerTrapList or{}mvars.ply_intelMarkerTrapInfo=mvars.ply_intelMarkerTrapInfo or{}if o then
table.insert(mvars.ply_intelMarkerTrapList,o)mvars.ply_intelMarkerTrapInfo[t(o)]=e
mvars.ply_intelTrapInfo[e].markerTrapName=o
end
mvars.ply_intelTrapList=mvars.ply_intelTrapList or{}if d then
table.insert(mvars.ply_intelTrapList,n)mvars.ply_intelTrapInfo[t(n)]=e
mvars.ply_intelTrapInfo[e].autoIcon=true
end
if c and a then
local a,e=Tpp.GetLocator(c,a)if a and e then
s=e
end
end
mvars.ply_intelTrapInfo[e].direction=s
mvars.ply_intelTrapInfo[e].directionRange=p
Player.AddTrapDetailCondition{trapName=n,condition=PlayerTrap.FINE,action=(PlayerTrap.NORMAL+PlayerTrap.BEHIND),stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=s,directionRange=p}end
function e.ShowIconForIntel(e,t)if not l(e)then
return
end
local n
if mvars.ply_intelTrapInfo and mvars.ply_intelTrapInfo[e]then
n=mvars.ply_intelTrapInfo[e].trapName
end
local a=mvars.ply_intelFlagInfo[e]if a then
if svars[a]~=nil then
t=svars[a]end
end
if not t then
if Tpp.IsNotAlert()then
Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL,message=Fox.StrCode32"GetIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=e}elseif n then
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
function e.DisableSwitchIcon()GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetDisableSearchSwitch",disable=true})end
function e.EnableSwitchIcon()GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetDisableSearchSwitch",disable=false})end
function e.AddTrapSettingForQuest(e)local a=e.trapName
local r=e.direction or 0
local n=e.directionRange or 180
local e=e.questName
if not l(a)then
return
end
mvars.ply_questStartTrapInfo=mvars.ply_questStartTrapInfo or{}if e then
mvars.ply_questStartTrapInfo[e]={trapName=a}else
return
end
mvars.ply_questNameReverse=mvars.ply_questNameReverse or{}mvars.ply_questNameReverse[t(e)]=e
mvars.ply_questStartFlagInfo=mvars.ply_questStartFlagInfo or{}mvars.ply_questStartFlagInfo[e]=false
mvars.ply_questTrapList=mvars.ply_questTrapList or{}table.insert(mvars.ply_questTrapList,a)mvars.ply_questStartTrapInfo[t(a)]=e
Player.AddTrapDetailCondition{trapName=a,condition=PlayerTrap.FINE,action=PlayerTrap.NORMAL,stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=r,directionRange=n}end
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
function e.AppearHorseOnMissionStart(e,a)local e,a=Tpp.GetLocator(e,a)if e then
vars.buddyType=BuddyType.HORSE
vars.initialBuddyPos[0]=e[1]vars.initialBuddyPos[1]=e[2]vars.initialBuddyPos[2]=e[3]end
end
function e.StartGameOverCamera(e,a,t,n)if mvars.ply_gameOverCameraGameObjectId~=nil then
return
end
mvars.ply_gameOverCameraGameObjectId=e
mvars.ply_gameOverCameraStartTimerName=a
mvars.ply_gameOverCameraAnnounceLog=t
mvars.ply_gameOverCameraFadeInName=n
TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")TppSound.PostJingleOnGameOver()TppSoundDaemon.PostEvent"sfx_s_force_camera_out"vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
o("Timer_StartGameOverCamera",.25)end
function e._StartGameOverCamera(e,e)TppUiStatusManager.ClearStatus"AnnounceLog"FadeFunction.SetFadeColor(64,0,0,255)TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,mvars.ply_gameOverCameraStartTimerName,TppUI.FADE_PRIORITY.DEMO,{exceptGameStatus={AnnounceLog=false}})Player.RequestToSetCameraFocalLengthAndDistance{focalLength=16,interpTime=TppUI.FADE_SPEED.FADE_HIGHSPEED}end
function e.PrepareStartGameOverCamera()FadeFunction.ResetFadeColor()local e={}for a,t in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
e[a]=false
end
for a,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
e[a]=false
end
e.S_DISABLE_NPC=nil
e.AnnounceLog=nil
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,mvars.ply_gameOverCameraFadeInName,TppUI.FADE_PRIORITY.DEMO,{exceptGameStatus=e})Player.RequestToStopCameraAnimation{}if mvars.ply_gameOverCameraAnnounceLog then
TppUiStatusManager.ClearStatus"AnnounceLog"TppUI.ShowAnnounceLog(mvars.ply_gameOverCameraAnnounceLog)end
end
function e.SetTargetDeadCamera(t)local o
local a
local l
if n(t)then
o=t.gameObjectName or""a=t.gameObjectId
l=t.announceLog or"target_extract_failed"end
a=a or s(o)if a==r then
return
end
e.StartGameOverCamera(a,"EndFadeOut_StartTargetDeadCamera",l,"EndFadeIn_StartTargetDeadCamera")end
function e._SetTargetDeadCamera()e.PrepareStartGameOverCamera()Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},skeletonNames={"SKL_004_HEAD","SKL_011_LUARM","SKL_021_RUARM","SKL_032_LFOOT","SKL_042_RFOOT"},skeletonCenterOffsets={Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,-.3,0),Vector3(0,-.3,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.001,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=16}end
function e.ReserveTargetDeadCameraGameObjectId(e)mvars.ply_reserveDeadTargetGameObjectId=e
end
function e.SetTargetDeadCameraIfReserved()if mvars.ply_reserveDeadTargetGameObjectId then
e.SetTargetDeadCamera{gameObjectId=mvars.ply_reserveDeadTargetGameObjectId}return true
end
end
function e.SetDefenseTargetBrokenCamera(a)local t
if not n(a)then
return
end
if not a.gimmickPosition then
return
end
if not a.cameraRotation then
return
end
if not a.cameraDistance then
return
end
if a.announceLog then
t=a.announceLog
end
mvars.ply_gameOverCameraGimmickInfo=a
e.StartGameOverCamera(r,"EndFadeOut_StartDefenseTargetBrokenCamera",t)end
function e._SetDefenseTargetBrokenCamera()if not mvars.ply_gameOverCameraGimmickInfo then
return
end
local a=mvars.ply_gameOverCameraGimmickInfo.gimmickPosition
local t=mvars.ply_gameOverCameraGimmickInfo.cameraRotation
local n=mvars.ply_gameOverCameraGimmickInfo.cameraDistance
e.PrepareStartGameOverCamera()local e=a+Vector3(0,1.7,0)local a=e+t:Rotate(Vector3(.064699664,.107832773,-.992061513)*n)Player.RequestToPlayCameraNonAnimation{isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,positionAndTargetMode=true,position=a,target=e,isCollisionCheck=false,focalLength=18,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.001,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=16}end
local a={[Fox.StrCode32"com_ai001_gim_n0000|srt_aip0_main0_def"]=4.2,[Fox.StrCode32"com_ai002_gim_n0000|srt_pup0_main0_ssd_v00"]=4.2,[Fox.StrCode32"com_ai003_gim_n0000|srt_ssde_swtc001"]=3.6,[Fox.StrCode32"whm0_gim_n0000|srt_whm0_main0_def_v00"]=8.5,[Fox.StrCode32"com_portal001_gim_n0000|srt_ftp0_main0_def_v00"]=8}local c={[Fox.StrCode32"whm0_gim_n0000|srt_whm0_main0_def_v00"]={foxmath.DegreeToRadian(300)},[Fox.StrCode32"com_portal001_gim_n0000|srt_ftp0_main0_def_v00"]={foxmath.DegreeToRadian(210),[Gimmick.GetDataSetCode"/Assets/ssd/level/location/afgh/block_extraLarge/south/afgh_south_gimmick.fox2"]=foxmath.DegreeToRadian(45)},[Fox.StrCode32"com_ai003_gim_n0000|srt_ssde_swtc001"]={foxmath.DegreeToRadian(215)}}local l={[Fox.StrCode32"whm0_gim_n0000|srt_whm0_main0_def_v00"]=Vector3(0,2,0),[Fox.StrCode32"com_portal001_gim_n0000|srt_ftp0_main0_def_v00"]=Vector3(0,10,0)}function e.GetDefenseTargetBrokenCameraInfo(r,o,e,t)local n=4.2
if e and a[e]then
n=a[e]end
local a=foxmath.DegreeToRadian(150)if c[e]then
local e=c[e]if e[t]then
a=e[t]else
a=e[1]end
if not a then
return
end
end
local t=o*Quat.RotationY(a)local a=Vector3(0,1,0)if l[e]then
a=l[e]end
local e=r-a
local e={gimmickPosition=e,cameraRotation=t,cameraDistance=n}return e
end
function e.ReserveDefenseTargetBrokenCamera(e)local a
if not n(e)then
return
end
if not e.gimmickPosition then
return
end
if not e.cameraRotation then
return
end
if not e.cameraDistance then
return
end
if e.announceLog then
a=e.announceLog
end
mvars.ply_reserveGameOverCameraGimmickInfo=e
end
function e.SetDefenseTargetBrokenCameraIfReserved()if mvars.ply_reserveGameOverCameraGimmickInfo then
e.SetDefenseTargetBrokenCamera(mvars.ply_reserveGameOverCameraGimmickInfo)return true
end
end
function e.SetPressStartCamera()local e=s"Player"if e==r then
return
end
Player.RequestToStopCameraAnimation{}Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,0)},skeletonBoundings={Vector3(.5,.45,.1)},offsetPos=Vector3(-.8,0,-1.4),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}end
function e.SetTitleCamera()local e=s"Player"if e==r then
return
end
Player.RequestToStopCameraAnimation{}Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,.1)},skeletonBoundings={Vector3(.5,.45,.9)},offsetPos=Vector3(-.8,0,-1.8),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}end
function e.SetSearchTarget(i,l,s,n,e,t,o,a)if(i==nil or l==nil)then
return
end
local l=T(l)if l==r then
return
end
if o==nil then
o=true
end
if e==nil then
e=Vector3(0,.25,0)end
if a==nil then
a=.03
end
local e={name=s,targetGameObjectTypeIndex=l,targetGameObjectName=i,offset=e,centerRange=.3,lookingTime=1,distance=200,doWideCheck=true,wideCheckRadius=.15,wideCheckRange=a,doDirectionCheck=false,directionCheckRange=100,doCollisionCheck=true}if(n~=nil)then
e.skeletonName=n
end
if(t~=nil)then
e.targetFox2Name=t
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
o("Timer_StartPlayMissionClearCameraStep1",.25)end
function e.SetPlayerStatusForMissionEndCamera()Player.SetPadMask{settingName="MissionClearCamera",except=true}vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
return true
end
function e.ResetMissionEndCamera()Player.ResetPadMask{settingName="MissionClearCamera"}Player.RequestToStopCameraAnimation{}end
function e.PlayCommonMissionEndCamera(r,s,i,l,t,n)local a
local e=vars.playerVehicleGameObjectId
if Tpp.IsHorse(e)then
GameObject.SendCommand(e,{id="HorseForceStop"})a=r(e,t,n)elseif Tpp.IsVehicle(e)then
local r=GameObject.SendCommand(e,{id="GetVehicleType"})GameObject.SendCommand(e,{id="ForceStop",enabled=true})local r=s[r]if r then
a=r(e,t,n)end
elseif(Tpp.IsPlayerWalkerGear(e)or Tpp.IsEnemyWalkerGear(e))then
GameObject.SendCommand(e,{id="ForceStop",enabled=true})a=i(e,t,n)elseif Tpp.IsHelicopter(e)then
else
a=l(t,n)end
if a then
local e="Timer_StartPlayMissionClearCameraStep"..tostring(t+1)o(e,a)end
end
function e._PlayMissionClearCamera(a,t)if a==1 then
TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_clear")end
e.PlayCommonMissionEndCamera(e.PlayMissionClearCameraOnRideHorse,e.VEHICLE_MISSION_CLEAR_CAMERA,e.PlayMissionClearCameraOnWalkerGear,e.PlayMissionClearCameraOnFoot,a,t)end
function e.RequestMissionClearMotion()Player.RequestToPlayDirectMotion{"missionClearMotion",{"/Assets/ssd/motion/SI_game/fani/bodies/snap/snapnon/snapnon_f_idl7.gani",false,"","","",false}}end
function e.PlayMissionClearCameraOnFoot(p,c)if PlayerInfo.AndCheckStatus{PlayerStatus.NORMAL_ACTION}then
if PlayerInfo.OrCheckStatus{PlayerStatus.STAND,PlayerStatus.SQUAT}then
if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
mvars.ply_requestedMissionClearCameraCarryOff=true
GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})else
e.RequestMissionClearMotion()end
end
end
local n={"SKL_004_HEAD","SKL_002_CHEST"}local r={Vector3(0,0,.05),Vector3(.15,0,0)}local t={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}local e=Vector3(0,0,-4.5)local a=.3
local l
local o=false
local i=20
local s=false
if p==1 then
n={"SKL_004_HEAD","SKL_002_CHEST"}r={Vector3(0,0,.05),Vector3(.15,0,0)}t={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}e=Vector3(0,0,-1.5)a=.3
l=1
o=true
elseif c then
n={"SKL_004_HEAD"}r={Vector3(0,0,.05)}t={Vector3(.1,.125,.1)}e=Vector3(0,-.5,-3.5)a=3
i=4
else
n={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}r={Vector3(0,0,.05),Vector3(.15,0,0),Vector3(-.15,0,0)}t={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}e=Vector3(0,0,-3.2)a=3
s=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{1,168},{1,-164}},skeletonNames=n,skeletonCenterOffsets=r,skeletonBoundings=t,offsetPos=e,focalLength=28,aperture=1.875,timeToSleep=i,interpTimeAtStart=a,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=o,useLastSelectedIndex=s}return l
end
function e.PlayMissionClearCameraOnRideHorse(e,c,p)local r={"SKL_004_HEAD","SKL_002_CHEST"}local n={Vector3(0,0,.05),Vector3(.15,0,0)}local a={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}local t=Vector3(0,0,-3.2)local e=.2
local i
local s=false
local l=20
local o=false
if p then
l=4
end
if c==1 then
r={"SKL_004_HEAD","SKL_002_CHEST"}n={Vector3(0,-.125,.05),Vector3(.15,-.125,0)}a={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}t=Vector3(0,0,-3.2)e=.2
i=1
s=true
else
r={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}n={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)}a={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}t=Vector3(0,0,-4.5)e=3
o=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{0,160},{0,-160}},skeletonNames=r,skeletonCenterOffsets={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},skeletonCenterOffsets=n,skeletonBoundings=a,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=l,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=s,useLastSelectedIndex=o}return i
end
function e.PlayMissionClearCameraOnRideLightVehicle(e,i,s)local e=Vector3(-.35,.6,.7)local a=Vector3(0,0,-2.25)local t=.2
local r
local n=false
local o=20
local l=false
if s then
o=4
end
if i==1 then
e=Vector3(-.35,.6,.7)a=Vector3(0,0,-2.25)t=.2
r=.5
n=true
else
e=Vector3(-.35,.4,.7)a=Vector3(0,0,-4)t=.75
l=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=e,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=t,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=n,useLastSelectedIndex=l}return r
end
function e.PlayMissionClearCameraOnRideTruck(e,i,s)local t=Vector3(-.35,1.3,1)local a=Vector3(0,0,-2)local e=.2
local n
local o=false
local l=20
local r=false
if s then
l=4
end
if i==1 then
t=Vector3(-.35,1.3,1)a=Vector3(0,0,-3)e=.2
n=.5
o=true
else
t=Vector3(-.35,1,1)a=Vector3(0,0,-6)e=.75
r=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=t,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=l,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=o,useLastSelectedIndex=r}return n
end
function e.PlayMissionClearCameraOnRideCommonArmoredVehicle(a,s,e,i)local a=Vector3(.05,-.5,-2.2)if e==1 then
a=Vector3(.05,-.5,-2.2)else
a=Vector3(-.05,-1,0)end
local t=Vector3(0,0,-7.5)local e=.2
local n
local r=false
local o=20
local l=false
if i then
o=4
end
if s==1 then
t=Vector3(0,0,-7.5)e=.2
n=.5
r=true
else
t=Vector3(0,0,-13.25)e=.75
l=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{8,165},{8,-165}},offsetTarget=a,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=l}return n
end
function e.PlayMissionClearCameraOnRideEasternArmoredVehicle(r,n,t)local a
a=e.PlayMissionClearCameraOnRideCommonArmoredVehicle(r,n,1,t)return a
end
function e.PlayMissionClearCameraOnRideWesternArmoredVehicle(t,n)local a
a=e.PlayMissionClearCameraOnRideCommonArmoredVehicle(t,n,2,isQuest)return a
end
function e.PlayMissionClearCameraOnRideTank(e,l,i)local a=Vector3(0,0,-6.5)local e=.2
local o
local r=false
local n=20
local t=false
if i then
n=4
end
if l==1 then
a=Vector3(0,0,-6.5)e=.2
o=.5
r=true
else
a=Vector3(0,0,-9)e=.75
t=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{9,165},{9,-165}},offsetTarget=Vector3(0,-.85,3.25),offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=n,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=t}return o
end
function e.PlayMissionClearCameraOnWalkerGear(a,s,p)local t=Vector3(0,.55,.35)local n=Vector3(0,0,-3.65)local a=.2
local r
local l=false
local o=20
local i=false
if p then
o=4
end
if s==1 then
t=Vector3(0,.55,.35)n=Vector3(0,0,-3.65)a=.2
r=1
l=true
else
t=Vector3(0,.4,.35)n=Vector3(0,0,-4.95)a=3
i=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,165},{7,-165}},offsetTarget=t,offsetPos=n,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=a,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=l,useLastSelectedIndex=i}return r
end
e.VEHICLE_MISSION_CLEAR_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayMissionClearCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayMissionClearCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionClearCameraOnRideEasternArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayMissionClearCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayMissionClearCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionClearCameraOnRideWesternArmoredVehicle}function e.PlayMissionAbortCamera()local e=e.SetPlayerStatusForMissionEndCamera()if not e then
return
end
o("Timer_StartPlayMissionAbortCamera",.25)end
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
e.VEHICLE_FALL_DEAD_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayFallDeadCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayFallDeadCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayFallDeadCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayFallDeadCameraOnRideArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayFallDeadCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayFallDeadCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayFallDeadCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayFallDeadCameraOnRideArmoredVehicle}if DebugMenu then
local o={OneHandSwing=true,TwoHandSwing=true}local r={OneHandSwing=1,TwoHandSwing=1,TwoHandHeavy=1,Thrust=1,Bow=1,Arrow=100,Gun=1,Item=4}local a={id="PRD_*",tryEquip=true}function e.DEBUG_ProductAndEquipWithTable(e)local t=false
for e,n in pairs(e)do
a.id=n
a.count=r[e]or 1
if e=="Item"then
a.toInventory=true
else
a.toInventory=nil
end
if o[e]then
if t then
a.tryEquip=nil
a.tryEquip2=true
else
a.tryEquip=true
a.tryEquip2=nil
end
t=not t
else
a.tryEquip=true
a.tryEquip2=nil
end
SsdSbm.AddProduction(a)end
end
function e.DEBUG_GetSkills(e)for a,e in pairs(e)do
if Tpp.IsTypeTable(e)then
SsdSbm.SetSkillLevel(e)end
end
end
local a={id="RES_*",count=1}function e.DEBUG_GetResource(e)for t,e in pairs(e)do
a.id=t
a.count=e
SsdSbm.AddResource(a)end
end
end
function e.Messages()local a=Tpp.StrCode32Table{GameObject={{msg="RevivePlayer",func=function()if TppMission.IsMultiPlayMission(vars.missionCode)then
e.Revive()else
local e={S_DISABLE_THROWING=false,S_DISABLE_PLACEMENT=false}TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"StartRevivePlayer",TppUI.FADE_PRIORITY.SYSTEM,{exceptGameStatus=e})end
end}},Player={{msg="CalcFultonPercent",func=function(a,n,t,r,o)e.MakeFultonRecoverSucceedRatio(a,n,t,r,o,false)end},{msg="CalcDogFultonPercent",func=function(o,r,t,n,a)e.MakeFultonRecoverSucceedRatio(o,r,t,n,a,true)end},{msg="PlayerFulton",func=e.OnPlayerFulton},{msg="OnPickUpCollection",func=e.OnPickUpCollection},{msg="OnPickUpPlaced",func=e.OnPickUpPlaced},{msg="WarpEnd",func=e.OnEndWarp,option={isExecFastTravel=true}},{msg="EndCarryAction",func=function()if mvars.ply_requestedMissionClearCameraCarryOff then
if PlayerInfo.AndCheckStatus{PlayerStatus.STAND}then
e.RequestMissionClearMotion()end
end
end,option={isExecMissionClear=true}},{msg="IntelIconInDisplay",func=e.OnIntelIconDisplayContinue},{msg="QuestIconInDisplay",func=e.OnQuestIconDisplayContinue},{msg="PlayerShowerEnd",func=function()TppUI.ShowAnnounceLog"refresh"end}},UI={{msg="BedMenuSleepSelected",func=e.OnSelectSleepInBed},{msg="FastTravelMenuPointSelected",func=e.OnSelectFastTravelByMenu},{msg="EndFadeOut",sender="OnSelectFastTravel",func=e.WarpByFastTravel,option={isExecFastTravel=true}},{msg="EndFadeIn",sender="OnEndWarpByFastTravel",func=e.OnEndFadeInWarpByFastTravel,option={isExecFastTravel=true}},{msg="EndFadeOut",sender="OnSelectSleepInBed",func=e.PassTimeBySleeping},{msg="EndFadeIn",sender="OnEndSleepInBed",func=e.OnEndFadeInSleepInBed},{msg="EndFadeOut",sender="EndFadeOut_StartTargetDeadCamera",func=e._SetTargetDeadCamera,option={isExecGameOver=true}},{msg="EndFadeOut",sender="EndFadeOut_StartDefenseTargetBrokenCamera",func=e._SetDefenseTargetBrokenCamera,option={isExecGameOver=true}},{msg="EndFadeOut",sender="StartRevivePlayer",func=function()e.Revive()end}},Timer={{msg="Finish",sender="Timer_StartPlayMissionClearCameraStep1",func=function()e._PlayMissionClearCamera(1)end,option={isExecMissionClear=true}},{msg="Finish",sender="Timer_StartPlayMissionAbortCamera",func=e._PlayMissionAbortCamera,option={isExecGameOver=true}},{msg="Finish",sender="Timer_DeliveryWarpSoundCannotCancel",func=e.OnDeliveryWarpSoundCannotCancel,option={isExecFastTravel=true}},{msg="Finish",sender="Timer_StartGameOverCamera",func=e._StartGameOverCamera,option={isExecGameOver=true}},{msg="Finish",sender="Timer_SleepInBed",func=function()TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMAL,"OnEndSleepInBed",TppUI.FADE_PRIORITY.MISSION)end}},Trap={{msg="Enter",sender="fallDeath_camera",func=function()e.SetLimitFallDeadCameraOffsetPosY(-18)end,option={isExecMissionPrepare=true}},{msg="Exit",sender="fallDeath_camera",func=e.ResetLimitFallDeadCameraOffsetPosY,option={isExecMissionPrepare=true}}}}if n(mvars.ply_intelMarkerTrapList)and next(mvars.ply_intelMarkerTrapList)then
a[t"Trap"]=a[t"Trap"]or{}table.insert(a[t"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelMarkerTrapList,func=e.OnEnterIntelMarkerTrap,option={isExecMissionPrepare=true}})end
if n(mvars.ply_intelTrapList)and next(mvars.ply_intelTrapList)then
a[t"Trap"]=a[t"Trap"]or{}table.insert(a[t"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelTrapList,func=e.OnEnterIntelTrap})table.insert(a[t"Trap"],Tpp.StrCode32Table{msg="Exit",sender=mvars.ply_intelTrapList,func=e.OnExitIntelTrap})end
return a
end
function e.DeclareSVars()return{{name="ply_pickableLocatorDisabled",arraySize=mvars.ply_maxPickableLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ply_placedLocatorDisabled",arraySize=mvars.ply_maxPlacedLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ply_isUsedPlayerInitialAction",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}end
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
Mission.SetRevivalDisabled(false)end
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
if mvars.ply_isExistTempPlayerType then
e.SaveCurrentPlayerType()e.ApplyTemporaryPlayerType()end
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
vars.playerCameraRotation[0]=e[1]vars.playerCameraRotation[1]=e[2]mvars.ply_setInitialCameraRotation=true
end
end
if a.sequence and a.sequence.INITIAL_INFINIT_OXYGEN then
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=a.sequence.INITIAL_INFINIT_OXYGEN}else
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=false}end
if a.sequence and a.sequence.INITIAL_IGNORE_HUNGER then
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreHunger",value=a.sequence.INITIAL_IGNORE_HUNGER}else
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreHunger",value=false}end
if a.sequence and a.sequence.INITIAL_IGNORE_THIRST then
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreThirst",value=a.sequence.INITIAL_IGNORE_THIRST}else
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreThirst",value=false}end
if a.sequence and a.sequence.INITIAL_IGNORE_FATIGUE then
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreFatigue",value=a.sequence.INITIAL_IGNORE_THIRST}else
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreFatigue",value=false}end
if a.sequence and a.sequence.INITIAL_INFINITE_STAMINA then
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteStamina",value=a.sequence.INITIAL_INFINITE_STAMINA}else
ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteStamina",value=false}end
Player.SetUseBlackDiamondEmblem(false)local e=0
if TppMission.IsMissionStart()then
vars.currentItemIndex=e
end
if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
local e=s("TppHeli2","SupportHeli")if e~=r then
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
mvars.ply_locationStationTable={}mvars.ply_stationLocatorList={}end
function e.OnReload()e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
function e.OnMissionCanStart()if not Player.IsInstanceValid()then
return
end
if mvars.ply_setInitialCameraRotation then
return
end
Player.RequestToSetCameraRotation{rotX=10,rotY=vars.playerRotY,interpTime=0}end
function e.OnMessage(r,n,o,i,l,t,a)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,r,n,o,i,l,t,a)end
function e.Update()e.UpdateFastTravelWarp()end
local c={[TppDefine.WEATHER.SUNNY]=0,[TppDefine.WEATHER.CLOUDY]=-10,[TppDefine.WEATHER.RAINY]=-30,[TppDefine.WEATHER.FOGGY]=-50,[TppDefine.WEATHER.SANDSTORM]=-70}function e.MakeFultonRecoverSucceedRatio(t,a,i,l,o,r)local p={[TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0}local t=a
local a=0
local s=100
local n=0
n=TppTerminal.DoFuncByFultonTypeSwitch(t,i,l,o,nil,nil,nil,e.GetSoldierFultonSucceedRatio,e.GetVolginFultonSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio)if n==nil then
n=100
end
local e=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}local o=p[e]or 0
local e=c[vars.weather]or 0
e=e+o
if e>0 then
e=0
end
a=(s+n)+e
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
if r then
Player.SetDogFultonIconPercentage{percentage=a,targetId=t}else
Player.SetFultonIconPercentage{percentage=a,targetId=t}end
end
function e.GetSoldierFultonSucceedRatio(t)local e=0
local n=0
local a=i(t,{id="GetLifeStatus"})local r=GameObject.SendCommand(t,{id="GetStateFlag"})if(bit.band(r,StateFlag.DYING_LIFE)~=0)then
e=-70
elseif(a==TppGameObject.NPC_LIFE_STATE_SLEEP)or(a==TppGameObject.NPC_LIFE_STATE_FAINT)then
e=0
if mvars.ply_OnFultonIconDying then
mvars.ply_OnFultonIconDying()end
elseif(a==TppGameObject.NPC_LIFE_STATE_DEAD)then
return
end
local r={[TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0}local a=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY}local a=r[a]or 0
e=e+a
if e>0 then
e=0
end
local a=i(t,{id="GetStatus"})if a==TppGameObject.NPC_STATE_STAND_HOLDUP then
n=-10
end
return(e+n)end
function e.GetDefaultSucceedRatio(e)return 0
end
function e.GetVolginFultonSucceedRatio(e)return 100
end
function e.OnPlayerFulton(e,e)end
function e.SetRetryFlag()vars.playerRetryFlag=PlayerRetryFlag.RETRY
end
function e.SetRetryFlagWithChickCap()vars.playerRetryFlag=PlayerRetryFlag.RETRY_WITH_CHICK_CAP
end
function e.UnsetRetryFlag()vars.playerRetryFlag=0
end
function e.ResetStealthAssistCount()vars.stealthAssistLeftCount=0
end
function e.OnPickUpCollection(t,a,e,n)local t=255
TppCollection.RepopCountOperation("SetAt",a,t)TppTerminal.AddPickedUpResourceToTempBuffer(e,n)local t={[TppCollection.TYPE_POSTER_SOL_AFGN]="key_poster_3500",[TppCollection.TYPE_POSTER_SOL_MAFR]="key_poster_3501",[TppCollection.TYPE_POSTER_GRAVURE_V]="key_poster_3502",[TppCollection.TYPE_POSTER_GRAVURE_H]="key_poster_3503",[TppCollection.TYPE_POSTER_MOE_V]="key_poster_3504",[TppCollection.TYPE_POSTER_MOE_H]="key_poster_3505"}local t=t[e]if t~=nil then
TppUI.ShowAnnounceLog("getPoster",t,TppTerminal.GMP_POSTER)end
local t
if TppTerminal.RESOURCE_INFORMATION_TABLE[e]and TppTerminal.RESOURCE_INFORMATION_TABLE[e].count then
t=TppTerminal.RESOURCE_INFORMATION_TABLE[e].count
end
if TppCollection.IsHerbByType(e)then
local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)if e~=r then
i(e,{id="GetPlant",uniqueId=a})end
end
if TppCollection.IsMaterialByType(e)then
TppUI.ShowAnnounceLog("find_processed_res",n,t)end
if e==TppCollection.TYPE_DIAMOND_SMALL then
TppUI.ShowAnnounceLog("find_diamond",TppDefine.SMALL_DIAMOND_GMP)end
if e==TppCollection.TYPE_DIAMOND_LARGE then
TppUI.ShowAnnounceLog("find_diamond",TppDefine.LARGE_DIAMOND_GMP)end
TppTerminal.PickUpBluePrint(a)end
function e.OnPickUpPlaced(e,e,a)local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)if e~=r then
i(e,{id="GetPlacedItem",index=a})end
end
function e.StorePlayerDecoyInfos()if e.IsExistDecoySystem()then
local e={type="TppDecoySystem"}i(e,{id="StorePlayerDecoyInfos"})end
end
function e.IsExistDecoySystem()if GameObject.GetGameObjectIdByIndex("TppDecoySystem",0)~=r then
return true
else
return false
end
end
local r=7.5
local a=3.5
e.DELIVERY_WARP_STATE=Tpp.Enum{"START_FADE_OUT","START_WARP","END_WARP","START_FADE_IN"}function e.OnSelectFastTravelByMenu(a,t)if mvars.ply_unexecFastTravelByMenu then
return
end
e.OnSelectFastTravel(a,t)end
function e.OnSelectFastTravel(t,a)if mvars.ply_requestedRevivePlayer then
return
end
mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_FADE_OUT
local e,a=SsdFastTravel.GetFastTravelPointName(a)if not e then
return
end
if not a then
return
end
Player.SetPadMask{settingName="FastTravel",except=true}local n=mvars.ply_fastTravelOption
local t=false
if n then
t=n.noSound
end
local e,n=Tpp.GetLocatorByTransform(e,a)if e then
e=e+Vector3(0,.8,0)end
mvars.ply_selectedFastTravelPointName=a
mvars.ply_selectedFastTravelPosition=e
mvars.ply_selectedFastTravelRotY=Tpp.GetRotationY(n)if not t then
mvars.ply_playingDeliveryWarpSoundHandle=TppSoundDaemon.PostEventAndGetHandle("Play_truck_transfer","Loading")else
mvars.ply_playingDeliveryWarpSoundHandle=nil
end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"OnSelectFastTravel",TppUI.FADE_PRIORITY.MISSION,{setMute=true})TppGameStatus.Set("TppPlayer.lua","S_IS_FAST_TRAVEL")TppGameStatus.Set("TppPlayer.lua","S_DISABLE_TARGET")end
function e.WarpByFastTravel()if mvars.ply_deliveryWarpState==e.DELIVERY_WARP_STATE.START_WARP then
return
end
TppGameStatus.Set("TppPlayer.WarpByFastTravel","S_IS_BLACK_LOADING")local a=mvars.ply_fastTravelOption
local t=false
if a then
if a.surviveBox then
SsdSbm.CreateSurviveCbox()end
if a.resetState then
t=a.resetState
end
end
TppRadio.Stop()mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_WARP
o("Timer_DeliveryWarpSoundCannotCancel",r)local e={type="TppPlayer2",index=0}local a={id="WarpAndWaitBlock",pos=mvars.ply_selectedFastTravelPosition,rotY=TppMath.DegreeToRadian(mvars.ply_selectedFastTravelRotY),resetState=t}GameObject.SendCommand(e,a)end
function e.OnEndWarpByFastTravel()TppGameStatus.Reset("TppPlayer.lua","S_DISABLE_TARGET")TppGameStatus.Reset("TppPlayer.lua","S_IS_FAST_TRAVEL")TppGameStatus.Reset("TppPlayer.WarpByFastTravel","S_IS_BLACK_LOADING")if mvars.ply_deliveryWarpState==e.DELIVERY_WARP_STATE.START_WARP then
mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.END_WARP
end
end
function e.UpdateFastTravelWarp()if not mvars.ply_deliveryWarpState then
return
end
if(mvars.ply_deliveryWarpState==e.DELIVERY_WARP_STATE.START_WARP)then
TppUI.ShowAccessIconContinue()end
if(mvars.ply_deliveryWarpState~=e.DELIVERY_WARP_STATE.END_WARP)then
return
end
if not TppMission.CheckMissionState(false,false,false,false,true)then
TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")e.OnEndFadeInWarpByFastTravel()return
end
if mvars.ply_playingDeliveryWarpSoundHandle then
local e=TppSoundDaemon.IsEventPlaying("Play_truck_transfer",mvars.ply_playingDeliveryWarpSoundHandle)if(e==false)then
mvars.ply_playingDeliveryWarpSoundHandle=nil
return
else
TppUI.ShowAccessIconContinue()end
end
if(mvars.ply_playingDeliveryWarpSoundHandle and(not mvars.ply_deliveryWarpSoundCannotCancel))and(bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.STANCE)==PlayerPad.STANCE)then
mvars.ply_deliveryWarpSoundCannotCancel=true
TppSoundDaemon.ResetMute"Loading"TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")end
if TppSave.IsSaving()then
return
end
if not mvars.ply_playingDeliveryWarpSoundHandle then
mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_FADE_IN
TppSoundDaemon.ResetMute"Loading"TppMission.ExecuteSystemCallback("OnEndDeliveryWarp",mvars.ply_selectedFastTravelPointName)Player.RequestToSetCameraRotation{rotX=10,rotY=mvars.ply_selectedFastTravelRotY}local a=mvars.ply_fastTravelOption
if a and a.noFadeIn then
e.OnEndFadeInWarpByFastTravel()else
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMAL,"OnEndWarpByFastTravel",TppUI.FADE_PRIORITY.DEMO)end
end
end
function e.OnEndFadeInWarpByFastTravel()mvars.ply_selectedFastTravelPointName=nil
mvars.ply_selectedFastTravelPosition=nil
mvars.ply_selectedFastTravelRotY=nil
mvars.ply_deliveryWarpState=nil
mvars.ply_deliveryWarpSoundCannotCancel=nil
mvars.ply_fastTravelOption=nil
if mvars.ply_endFastTravelCallback then
mvars.ply_endFastTravelCallback()end
mvars.ply_endFastTravelCallback=nil
m"Timer_DeliveryWarpSoundCannotCancel"Player.ResetPadMask{settingName="FastTravel"}end
function e.OnDeliveryWarpSoundCannotCancel()mvars.ply_deliveryWarpSoundCannotCancel=true
end
function e.StartFastTravel(o,r,t,a)mvars.ply_endFastTravelCallback=nil
mvars.ply_fastTravelOption=nil
if p(t)then
mvars.ply_endFastTravelCallback=t
end
if n(a)then
mvars.ply_fastTravelOption=a
end
e.OnSelectFastTravel(o,r)end
function e.StartFastTravelByReturnBase()local a="fast_afgh_basecamp"if TppLocation.IsMiddleAfrica()then
a="fast_mafr_basecamp"end
e.StartFastTravel(nil,t(a),nil,{surviveBox=true,resetState=true,noSound=true})end
function e.AddFastTravelOption(a)if not n(a)then
return
end
if not e.IsFastTraveling()then
return
end
mvars.ply_fastTravelOption=mvars.ply_fastTravelOption or{}for e,a in pairs(a)do
mvars.ply_fastTravelOption[e]=a
end
end
function e.OnEnterIntelMarkerTrap(e,a)local a=mvars.ply_intelMarkerTrapInfo[e]local e=mvars.ply_intelFlagInfo[a]if e then
if svars[e]then
return
end
else
return
end
local e=mvars.ply_intelMarkerObjectiveName[a]if e then
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
function e.SaveCaptureAnimal()if mvars.loc_locationAnimalSettingTable==nil then
return
end
local a=TppPlaced.GetCaptureCageInfo()for t,a in pairs(a)do
local a,e,t,t=e.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)if e~=0 then
CaptureCage.RegisterCaptureAnimal(e,a)end
end
TppPlaced.DeleteAllCaptureCage()end
function e.AggregateCaptureAnimal()local e=0
local a=0
local t=CaptureCage.GetCaptureAnimalList()for t,n in pairs(t)do
local t=n.animalId
local n=n.areaName
TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=t,areaNameHash=n,isNew=true}local n,r=TppMotherBaseManagement.GetAnimalHeroicPointAndGmp{dataBaseId=t}e=e+n
a=a+r
TppUiCommand.ShowBonusPopupAnimal(t,"regist")end
if e>0 or a>0 then
TppMotherBaseManagement.AddHeroicPointAndGmpByCageAnimal{heroicPoint=e,gmp=a,isAnnounce=true}end
end
function e.CheckCaptureCage(t,r)if mvars.loc_locationAnimalSettingTable==nil then
return
end
if t<2 or t>4 then
return
end
local n={}local a=5
local o=r/a
for r=1,o do
if t==2 then
Player.DEBUG_PlaceAround{radius=5,count=a,equipId=TppEquip.EQP_SWP_CaptureCage}elseif t==3 then
Player.DEBUG_PlaceAround{radius=5,count=a,equipId=TppEquip.EQP_SWP_CaptureCage_G01}elseif t==4 then
Player.DEBUG_PlaceAround{radius=5,count=a,equipId=TppEquip.EQP_SWP_CaptureCage_G02}end
for e=1,a do
coroutine.yield()end
local a=TppPlaced.GetCaptureCageInfo()for t,a in pairs(a)do
local t,a,r,e=e.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)if a~=0 then
TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=a,areaName=t,isNew=true}if n[e]==nil then
n[e]=1
else
n[e]=n[e]+1
end
end
end
TppPlaced.DeleteAllCaptureCage()end
for a,e in pairs(n)do
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
function e.OnSelectSleepInBed(e)Player.SetPadMask{settingName="SleepInBed",except=true}mvars.ply_sleepTimeHour=e
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"OnSelectSleepInBed",TppUI.FADE_PRIORITY.MISSION)end
function e.PassTimeBySleeping()WeatherManager.AddTimeToCurrentClock{hour=mvars.ply_sleepTimeHour}Player.OnSleepInBedLocal(mvars.ply_sleepTimeHour)o("Timer_SleepInBed",2)end
function e.OnEndFadeInSleepInBed()Player.ResetPadMask{settingName="SleepInBed"}mvars.ply_sleepTimeHour=nil
TppQuest.UpdateActiveQuest()TppMission.UpdateCheckPointAtCurrentPosition()end
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
function e._CheckRotation(e,t,n,r,a)local a=mvars
local a=vars.playerCameraRotation[0]local o=vars.playerCameraRotation[1]local e=foxmath.DegreeToRadian(a-e)e=foxmath.NormalizeRadian(e)local a=foxmath.RadianToDegree(e)local e=foxmath.DegreeToRadian(o-n)e=foxmath.NormalizeRadian(e)local e=foxmath.RadianToDegree(e)if(foxmath.Absf(a)<t)and(foxmath.Absf(e)<r)then
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
local function p(e,a)for t,e in pairs(e)do
if e==a then
return true
end
end
return false
end
function e.EvaluateCaptureCage(l,a,o,c)local t=mvars
local r=t.loc_locationAnimalSettingTable
local i=r.captureCageAnimalAreaSetting
local t="wholeArea"for n,e in pairs(i)do
if((l>=e.activeArea[1]and l<=e.activeArea[3])and a>=e.activeArea[2])and a<=e.activeArea[4]then
t=e.areaName
break
end
end
local a=0
if o==2 then
a=n(e.CageRandomTableG3)elseif o==1 then
a=n(e.CageRandomTableG2)else
a=n(e.CageRandomTableG1)end
local e=r.captureAnimalList
local i=r.animalRareLevel
local s=r.animalInfoList
local n={}if e[t]==nil then
t="wholeArea"end
local l=false
for t,e in pairs(e[t])do
local t=i[e]if t>=TppMotherBaseManagementConst.ANIMAL_RARE_SR and o==2 then
if not TppMotherBaseManagement.IsGotDataBase{dataBaseId=e}then
table.insert(n,e)a=t
l=true
break
end
end
end
if not l then
local r=a
while a>=0 do
for t,e in pairs(e[t])do
if i[e]==a then
table.insert(n,e)end
end
if table.maxn(n)>0 then
break
end
a=a-1
end
if a<0 then
a=r
t="wholeArea"while a>=0 do
for t,e in pairs(e[t])do
if i[e]==a then
table.insert(n,e)end
end
if table.maxn(n)>0 then
break
end
a=a-1
end
end
end
local l=r.animalMaterial
local r={}local o=a
if l~=nil then
while o>=0 do
for a,e in pairs(e.wholeArea)do
if l[e]==nil and i[e]==o then
table.insert(r,e)end
end
if table.maxn(r)>0 then
break
end
o=o-1
end
end
local e=0
local i=table.maxn(n)if i==1 then
e=n[1]elseif i>1 then
local a=math.random(1,i)e=n[a]end
if#r==0 then
local n=""return t,e,a,n
end
if l~=nil then
local t=l[e]if t~=nil then
if p(t,c)==false then
local t=math.random(1,#r)e=r[t]a=o
end
end
end
local n=""if s~=nil then
if e~=0 then
n=s[e].name
end
end
return t,e,a,n
end
function e.Refresh(e)if e then
Player.ResetDirtyEffect()end
vars.passageSecondsSinceOutMB=0
end
return e