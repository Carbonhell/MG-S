if Tpp.IsMaster()then
return{}end
local a={}function a.SetPlayLogEnabled(e)if TppPlayLog then
TppPlayLog.SetPlayLogEnabled(e)end
end
function a.RequestResetPlayLog()if TppPlayLog then
TppPlayLog.RequestResetPlayLog()end
end
function a.RequestUploadPlayLog()if TppPlayLog then
TppPlayLog.RequestUploadPlayLog()end
end
function a.ExportSavedPlayLog()if TppPlayLog and TppPlayLog.ExportSavedPlayLog then
TppPlayLog.ExportSavedPlayLog()end
end
a.PERF_CHECK_TYPE=Tpp.Enum{"OnUpdate","OnMessage","OnEnter"}local s={}local m={}local l={}local v=2
local i=0
local n=0
local d=Tpp.ApendArray
local t=Tpp.IsTypeTable
local u=GkEventTimerManager.IsTimerActive
local p=Tpp.DEBUG_StrCode32ToString
a.Colors={black=Color(0,0,0,1),white=Color(1,1,1,1),red=Color(1,0,0,1),green=Color(0,1,0,1),blue=Color(0,0,1,1),yellow=Color(1,1,0,1),magenta=Color(1,0,1,1),cyan=Color(0,1,1,1),darkRed=Color(.5,0,0,1),darkGreen=Color(0,.5,0,1),darkBlue=Color(0,0,.5,1),darkYellow=Color(.5,.5,0,1),purple=Color(.5,0,.5,1),darkCyan=Color(0,.5,.5,1)}function a.DEBUG_SetSVars(e)if not t(e)then
return
end
for e,a in pairs(e)do
Tpp._DEBUG_svars[e]=a
end
end
function a.DEBUG_SetGVars(e)if not t(e)then
return
end
for e,a in pairs(e)do
Tpp._DEBUG_gvars[e]=a
end
end
function a.DEBUG_RestoreSVars()if next(Tpp._DEBUG_svars)then
for a,e in pairs(Tpp._DEBUG_svars)do
svars[a]=e
end
TppSave.VarSave()end
end
function a.DEBUG_SetOrderBoxPlayerPosition()if next(Tpp._DEBUG_gvars)then
if Tpp._DEBUG_gvars.mis_orderBoxName then
TppMission.SetMissionOrderBoxPosition(Tpp._DEBUG_gvars.mis_orderBoxName)TppSave.VarSave()end
end
end
function a.DEBUG_SVarsClear()if next(Tpp._DEBUG_svars)then
for e,a in pairs(Tpp._DEBUG_svars)do
if e=="dbg_seq_sequenceName"then
TppSave.ReserveVarRestoreForContinue()end
end
Tpp._DEBUG_svars={}TppSave.VarSave()end
end
function a.DEBUG_GetSysVarsLog()local a=svars or{}local e=mvars or{}local e={"missionName = "..(tostring(e.mis_missionName)..(", vars.missionCode = "..(tostring(vars.missionCode)..(", vars.locationCode = "..tostring(vars.locationCode))))),"mvars.mis_missionStateIsNotInGame = "..tostring(e.mis_missionStateIsNotInGame),"missionClearState = "..tostring(TppDefine.MISSION_CLEAR_STATE_LIST[gvars.mis_missionClearState+1]),"gvars.pck_missionPackLabelName = "..tostring(gvars.pck_missionPackLabelName),"gvars.mis_orderBoxName = "..tostring(gvars.mis_orderBoxName),"gvars.heli_missionStartRoute = "..tostring(gvars.heli_missionStartRoute),"gvars.mis_nextMissionCodeForMissionClear = "..tostring(gvars.mis_nextMissionCodeForMissionClear),"gvars.mis_nextMissionCodeForEmergency = "..tostring(gvars.mis_nextMissionCodeForEmergency),"vars.mbLayoutCode = "..(tostring(vars.mbLayoutCode)..(", mvars.mis_nextLayoutCode = "..tostring(e.mis_nextLayoutCode))),"vars.mbClusterId = "..(tostring(vars.mbClusterId)..(", mvars.mis_nextClusterId = "..tostring(e.mis_nextClusterId))),"mvars.mis_isOutsideOfMissionArea = "..tostring(e.mis_isOutsideOfMissionArea),"svars.mis_isDefiniteGameOver = "..(tostring(a.mis_isDefiniteGameOver)..(", svars.mis_isDefiniteMissionClear = "..tostring(a.mis_isDefiniteMissionClear))),"gvars.needWaitMissionInitialize = "..tostring(gvars.needWaitMissionInitialize),"gvars.canExceptionHandling = "..tostring(gvars.canExceptionHandling),"vars.playerVehicleGameObjectId = "..tostring(vars.playerVehicleGameObjectId),"TppServerManager.FobIsSneak() = "..tostring(TppServerManager.FobIsSneak()),"svars.scoreTime = "..tostring(a.scoreTime)}return e
end
function a.DEBUG_WarpHelicopter(i,o,s,r,n)if not t(soldierNameTable)then
soldierNameTable={soldierNameTable}end
local t=GameObject.GetGameObjectId
local e=GameObject.SendCommand
if not r then
r=0
end
for s,a in pairs(soldierNameTable)do
local a=t(a)e(a,{id="SetEnabled",enabled=false})e(a,{id="SetSneakRoute",route=o,point=r})e(a,{id="SetCautionRoute",route=o,point=r})if n then
e(a,{id="SetAlertRoute",enabled=true,route=o,point=r})else
e(a,{id="SetAlertRoute",enabled=false,route="",point=r})end
e(a,{id="SetEnabled",enabled=true})end
local a=t(i)e(a,{id="SetPosition",position=s,rotY=0})end
function a.DEBUG_WarpVehicleAndSoldier(o,s,n,i,r,l)if not t(o)then
o={o}end
local t=GameObject.GetGameObjectId
local e=GameObject.SendCommand
if not r then
r=0
end
for o,a in pairs(o)do
local a=t(a)e(a,{id="SetEnabled",enabled=false})e(a,{id="SetSneakRoute",route=n,point=r})e(a,{id="SetCautionRoute",route=n,point=r})if l then
e(a,{id="SetAlertRoute",enabled=true,route=n,point=r})else
e(a,{id="SetAlertRoute",enabled=false,route="",point=r})end
e(a,{id="SetEnabled",enabled=true})end
local r=t(s)e(r,{id="SetPosition",position=i,rotY=0})end
a.DEBUG_SkipOnChangeSVarsLog={timeLimitforSneaking=true,timeLimitforNonAbort=true}function a.DEBUG_AddSkipLogSVarsName(e)a.DEBUG_SkipOnChangeSVarsLog[e]=true
end
function a.DEBUG_FobGPU()local e=function(a)math.randomseed(os.time())TppMotherBaseManagement.SetGmp{gmp=1e6}local e=300
if TppMotherBaseManagement.DEBUG_DirectAddRandomStaffs then
TppMotherBaseManagement.DEBUG_DirectAddRandomStaffs{count=e}end
do
local e={CommonMetal=100,MinorMetal=100,PreciousMetal=100,FuelResource=100,BioticResource=100}for a,e in pairs(e)do
TppMotherBaseManagement.SetResourceSvars{resource=a,usableCount=e,processingCount=e,got=true,isNew=false}end
local e={Plant2000=100,Plant2001=100,Plant2002=100,Plant2003=100,Plant2004=100,Plant2005=100,Plant2006=100,Plant2007=100,Plant2008=100}for e,a in pairs(e)do
TppMotherBaseManagement.SetResourceSvars{resource=e,usableCount=a,processingCount=0,got=true,isNew=false}end
end
do
local e={"Orange","Blue","Black","Blick","Gray","Od","Pink","Sand"}local r=math.random(1,#e)TppMotherBaseManagement.SetFobSvars{fob="Fob1",got=true,oceanAreaId=70,topologyType=a,color=e[r]}local e={"Command","Combat","Develop","BaseDev","Support","Spy","Medical"}for e,a in ipairs(e)do
local e=math.random(4,4)TppMotherBaseManagement.SetClusterSvars{base="Fob1",category=a,grade=e,buildStatus="Completed",timeMinute=0,isNew=false}end
for a,e in ipairs(e)do
local a=math.random(1,1)TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category=e,grade=a,buildStatus="Completed",timeMinute=0,isNew=false}end
end
TppSave.VarSave(40010,true)TppSave.VarSaveOnRetry()TppSave.SaveGameData()end
e(90)end
function a.DEBUG_SetFobPlayerSneak()vars.avatarFaceRaceIndex=0
vars.avatarAcceFlag=0
vars.avatarFaceTypeIndex=1
vars.avatarFaceVariationIndex=1
vars.avatarFaceColorIndex=0
vars.avatarHairStyleIndex=0
vars.avatarRightEyeColorIndex=0
vars.avatarRightEyeBrightnessIndex=0
vars.avatarLeftEyeColorIndex=1
vars.avatarLeftEyeBrightnessIndex=0
vars.avatarHairColor=1
vars.avatarBerdStyle=0
vars.avatarBerdLength=1
vars.avatarEbrwStyle=3
vars.avatarEbrwWide=1
vars.avatarGashOrTatoVariationIndex=0
vars.avatarTatoColorIndex=0
vars.avatarMotionFrame[0]=4
vars.avatarMotionFrame[1]=9
vars.avatarMotionFrame[2]=5
vars.avatarMotionFrame[3]=5
vars.avatarMotionFrame[4]=7
vars.avatarMotionFrame[5]=1
vars.avatarMotionFrame[6]=7
vars.avatarMotionFrame[7]=4
vars.avatarMotionFrame[8]=4
vars.avatarMotionFrame[9]=5
vars.avatarMotionFrame[10]=5
vars.avatarMotionFrame[11]=6
vars.avatarMotionFrame[12]=5
vars.avatarMotionFrame[13]=10
vars.avatarMotionFrame[14]=8
vars.avatarMotionFrame[15]=4
vars.avatarMotionFrame[16]=6
vars.avatarMotionFrame[17]=10
vars.avatarMotionFrame[18]=0
vars.avatarMotionFrame[19]=5
vars.avatarMotionFrame[20]=5
vars.avatarMotionFrame[21]=7
vars.avatarMotionFrame[22]=3
vars.avatarMotionFrame[23]=3
vars.avatarMotionFrame[24]=6
vars.avatarMotionFrame[25]=10
vars.avatarMotionFrame[26]=8
vars.avatarMotionFrame[27]=6
vars.avatarMotionFrame[28]=6
vars.avatarMotionFrame[29]=8
vars.avatarMotionFrame[30]=2
vars.avatarMotionFrame[31]=5
vars.avatarMotionFrame[32]=2
vars.avatarMotionFrame[33]=1
vars.avatarMotionFrame[34]=5
vars.avatarMotionFrame[35]=5
vars.avatarMotionFrame[36]=4
vars.avatarMotionFrame[37]=7
vars.avatarMotionFrame[38]=6
vars.avatarMotionFrame[39]=9
vars.avatarMotionFrame[40]=4
vars.avatarMotionFrame[41]=7
vars.avatarMotionFrame[42]=6
vars.avatarMotionFrame[43]=5
vars.avatarMotionFrame[44]=1
vars.avatarMotionFrame[45]=4
vars.avatarMotionFrame[46]=2
vars.avatarMotionFrame[47]=7
vars.avatarMotionFrame[48]=8
vars.avatarMotionFrame[49]=5
vars.avatarMotionFrame[50]=8
vars.avatarMotionFrame[51]=6
vars.avatarMotionFrame[52]=7
vars.avatarMotionFrame[53]=4
vars.avatarMotionFrame[54]=7
vars.avatarMotionFrame[55]=4
vars.avatarMotionFrame[56]=5
vars.avatarMotionFrame[57]=9
vars.avatarMotionFrame[58]=3
vars.avatarMotionFrame[59]=5
vars.avatarSaveIsValid=1
vars.playerType=PlayerType.AVATAR
vars.playerCamoType=PlayerCamoType.BATTLEDRESS
vars.handEquip=TppEquip.EQP_HAND_KILL_ROCKET
vars.playerFaceEquipId=1
vars.itemLevels[TppEquip.EQP_SUIT-TppEquip.EQP_IT_InstantStealth]=1
local e={{equipId=TppEquip.EQP_WP_30105,partsInfo={barrel=TppEquip.BA_30124,ammo=TppEquip.AM_30125,stock=TppEquip.SK_60304,muzzle=TppEquip.MZ_30105,muzzleOption=TppEquip.MO_30102,rearSight=TppEquip.ST_30305,frontSight=TppEquip.ST_30306,option1=TppEquip.LT_30105,option2=TppEquip.LS_40034,underBarrel=TppEquip.UB_50102,underBarrelAmmo=TppEquip.AM_40102}},{equipId=TppEquip.EQP_WP_60206,partsInfo={barrel=TppEquip.BA_60205,ammo=TppEquip.AM_30055,stock=TppEquip.SK_60203,muzzle=TppEquip.MZ_60203,muzzleOption=TppEquip.MO_60204,rearSight=TppEquip.ST_30204,frontSight=TppEquip.ST_20205,option1=TppEquip.LT_30025,option2=TppEquip.LS_30104,underBarrel=TppEquip.UB_40144,underBarrelAmmo=TppEquip.AM_40102}},{equipId=TppEquip.EQP_WP_20004,partsInfo={ammo=TppEquip.AM_20105,stock=TppEquip.SK_20002,muzzleOption=TppEquip.MO_10101,rearSight=TppEquip.ST_30114,option1=TppEquip.LT_10104}}}GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeChimeraWeapon",chimeraInfo=e})GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId=TppEquip.EQP_HAND_KILL_ROCKET})end
function a.DEBUG_SetFobPlayerDefence()vars.avatarFaceRaceIndex=0
vars.avatarAcceFlag=0
vars.avatarFaceTypeIndex=1
vars.avatarFaceVariationIndex=1
vars.avatarFaceColorIndex=0
vars.avatarHairStyleIndex=0
vars.avatarRightEyeColorIndex=0
vars.avatarRightEyeBrightnessIndex=0
vars.avatarLeftEyeColorIndex=1
vars.avatarLeftEyeBrightnessIndex=0
vars.avatarHairColor=1
vars.avatarBerdStyle=0
vars.avatarBerdLength=1
vars.avatarEbrwStyle=3
vars.avatarEbrwWide=1
vars.avatarGashOrTatoVariationIndex=0
vars.avatarTatoColorIndex=0
vars.avatarMotionFrame[0]=4
vars.avatarMotionFrame[1]=9
vars.avatarMotionFrame[2]=5
vars.avatarMotionFrame[3]=5
vars.avatarMotionFrame[4]=7
vars.avatarMotionFrame[5]=1
vars.avatarMotionFrame[6]=7
vars.avatarMotionFrame[7]=4
vars.avatarMotionFrame[8]=4
vars.avatarMotionFrame[9]=5
vars.avatarMotionFrame[10]=5
vars.avatarMotionFrame[11]=6
vars.avatarMotionFrame[12]=5
vars.avatarMotionFrame[13]=10
vars.avatarMotionFrame[14]=8
vars.avatarMotionFrame[15]=4
vars.avatarMotionFrame[16]=6
vars.avatarMotionFrame[17]=10
vars.avatarMotionFrame[18]=0
vars.avatarMotionFrame[19]=5
vars.avatarMotionFrame[20]=5
vars.avatarMotionFrame[21]=7
vars.avatarMotionFrame[22]=3
vars.avatarMotionFrame[23]=3
vars.avatarMotionFrame[24]=6
vars.avatarMotionFrame[25]=10
vars.avatarMotionFrame[26]=8
vars.avatarMotionFrame[27]=6
vars.avatarMotionFrame[28]=6
vars.avatarMotionFrame[29]=8
vars.avatarMotionFrame[30]=2
vars.avatarMotionFrame[31]=5
vars.avatarMotionFrame[32]=2
vars.avatarMotionFrame[33]=1
vars.avatarMotionFrame[34]=5
vars.avatarMotionFrame[35]=5
vars.avatarMotionFrame[36]=4
vars.avatarMotionFrame[37]=7
vars.avatarMotionFrame[38]=6
vars.avatarMotionFrame[39]=9
vars.avatarMotionFrame[40]=4
vars.avatarMotionFrame[41]=7
vars.avatarMotionFrame[42]=6
vars.avatarMotionFrame[43]=5
vars.avatarMotionFrame[44]=1
vars.avatarMotionFrame[45]=4
vars.avatarMotionFrame[46]=2
vars.avatarMotionFrame[47]=7
vars.avatarMotionFrame[48]=8
vars.avatarMotionFrame[49]=5
vars.avatarMotionFrame[50]=8
vars.avatarMotionFrame[51]=6
vars.avatarMotionFrame[52]=7
vars.avatarMotionFrame[53]=4
vars.avatarMotionFrame[54]=7
vars.avatarMotionFrame[55]=4
vars.avatarMotionFrame[56]=5
vars.avatarMotionFrame[57]=9
vars.avatarMotionFrame[58]=3
vars.avatarMotionFrame[59]=5
vars.avatarSaveIsValid=1
vars.playerType=PlayerType.AVATAR
vars.playerCamoType=PlayerCamoType.BATTLEDRESS
vars.handEquip=TppEquip.EQP_HAND_KILL_ROCKET
vars.playerFaceEquipId=1
vars.itemLevels[TppEquip.EQP_SUIT-TppEquip.EQP_IT_InstantStealth]=1
local e={{equipId=TppEquip.EQP_WP_30235,partsInfo={barrel=TppEquip.BA_30214,ammo=TppEquip.AM_30232,stock=TppEquip.SK_30205,muzzle=TppEquip.MZ_30232,muzzleOption=TppEquip.MO_30235,rearSight=TppEquip.ST_30202,frontSight=TppEquip.ST_30114,option1=TppEquip.LT_40103,option2=TppEquip.LS_30104,underBarrel=TppEquip.UB_50002,underBarrelAmmo=TppEquip.AM_50002}},{equipId=TppEquip.EQP_WP_60317,partsInfo={barrel=TppEquip.BA_30044,ammo=TppEquip.AM_30102,stock=TppEquip.SK_60205,muzzle=TppEquip.MZ_30213,muzzleOption=TppEquip.MO_30105,rearSight=TppEquip.ST_50303,option1=TppEquip.LT_30025,option2=TppEquip.LS_30104,underBarrel=TppEquip.UB_40043,underBarrelAmmo=TppEquip.AM_40001}},{equipId=TppEquip.EQP_WP_20215,partsInfo={ammo=TppEquip.AM_20106,stock=TppEquip.SK_20216,muzzleOption=TppEquip.MO_20205,rearSight=TppEquip.ST_60102,option1=TppEquip.LS_10415}}}GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeChimeraWeapon",chimeraInfo=e})GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId=TppEquip.EQP_HAND_KILL_ROCKET})end
function a.QARELEASE_DEBUG_Init()local e
if DebugMenu then
e=DebugMenu
else
return
end
e.AddDebugMenu("LuaSystem","showSysVars","bool",gvars,"DEBUG_showSysVars")e.AddDebugMenu("LuaSystem","gameStatus","bool",gvars,"DEBUG_showGameStatus")mvars.qaDebug.forceCheckPointSave=false
e.AddDebugMenu("LuaSystem","ForceCheckPointSave","bool",mvars.qaDebug,"forceCheckPointSave")mvars.qaDebug.showWeaponVars=false
e.AddDebugMenu("LuaSystem","ShowWeaponVars","bool",mvars.qaDebug,"showWeaponVars")mvars.qaDebug.showPlayerPartsType=false
e.AddDebugMenu("LuaSystem","ShowPlayerPartsType","bool",mvars.qaDebug,"showPlayerPartsType")mvars.qaDebug.setFobForGPU=false
e.AddDebugMenu("LuaSystem","setFobForGPU","bool",mvars.qaDebug,"setFobForGPU")mvars.qaDebug.showEventTask=false
e.AddDebugMenu("LuaUI","showEventTask","bool",mvars.qaDebug,"showEventTask")end
function a.QAReleaseDebugUpdate()local t=svars
local o=mvars
local e=DebugText.Print
local r=DebugText.NewContext()if o.seq_doneDumpCanMissionStartRefrainIds then
e(r,{1,0,0},"TppSequence: Mission.CanStart() wait is time out!\nPlease screen shot [Mission > ViewStartRefrain > true] , [Pause > ShowFlags > true] and [Pause > ShowInstances > true]")end
if(gvars.usingNormalMissionSlot==false)and(not(((vars.missionCode==10115)or(vars.missionCode==50050))or(TppMission.IsHelicopterSpace(vars.missionCode))))then
e(r,{1,.5,.5},"Now gvars.usingNormalMissionSlot is false, but not emergency mission. Call scripter!!!!!!")end
if(vars.fobSneakMode==FobMode.MODE_SHAM)and(not((vars.missionCode==50050)or(TppMission.IsHelicopterSpace(vars.missionCode))))then
e(r,{1,.5,.5},"Now vars.fobSneakMode isFobMode.MODE_SHAM, but not fob mission. Call scripter!!!!!!")end
if TppSave.DEBUG_EraseAllGameDataCounter then
if TppSave.DEBUG_EraseAllGameDataCounter>0 then
e(r,{1,.5,.5},"TppSave.EraseAllGameDataSaveRequest : erase game data save request!")TppSave.DEBUG_EraseAllGameDataCounter=TppSave.DEBUG_EraseAllGameDataCounter-Time.GetFrameTime()else
TppSave.DEBUG_EraseAllGameDataCounter=nil
end
end
if o.qaDebug.forceCheckPointSave then
o.qaDebug.forceCheckPointSave=false
TppMission.UpdateCheckPoint{ignoreAlert=true,atCurrentPosition=true}end
if gvars.DEBUG_showSysVars then
local a=a.DEBUG_GetSysVarsLog()e(r,{.5,.5,1},"LuaSystem showSysVars")for o,a in ipairs(a)do
e(r,a)end
local a={[FobMode.MODE_ACTUAL]="MODE_ACTUAL",[FobMode.MODE_SHAM]="MODE_SHAM",[FobMode.MODE_VISIT]="MODE_VISIT",[FobMode.MODE_NONE]="MODE_NONE"}e(r,"vars.fobSneakMode = "..tostring(a[vars.fobSneakMode]))local a=TppScriptVars.GetVarValueInSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,"vars","mbmTppGmp",0)e(r,"GMP(inSlot) = "..tostring(a))local a=TppScriptVars.GetVarValueInSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,"vars","mbmTppHeroicPoint",0)e(r,"HeroicPoint(inSlot) = "..tostring(a))e(r,"killCount = "..tostring(t.killCount))e(r,"totalKillCount = "..tostring(gvars.totalKillCount))end
if gvars.DEBUG_showGameStatus then
e(r,"")e(r,{.5,.5,1},"LuaSystem gameStatus")for a,o in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
local o=TppGameStatus.IsSet("TppMain.lua",a)if o then
e(r," statusType = "..(tostring(a)..(", IsSet = "..tostring(o))))end
end
local a=TppGameStatus.IsSet("TppMain.lua","S_IS_BLACK_LOADING")if a then
e(r," statusType = "..(tostring"S_IS_BLACK_LOADING"..(", IsSet = "..tostring(a))))end
e(r,"UIStatus")local a={{CallMenu="INVALID"},{PauseMenu="INVALID"},{EquipHud="INVALID"},{EquipPanel="INVALID"},{CqcIcon="INVALID"},{ActionIcon="INVALID"},{AnnounceLog="SUSPEND_LOG"},{AnnounceLog="INVALID_LOG"},{BaseName="INVALID"},{Damage="INVALID"},{Notice="INVALID"},{HeadMarker="INVALID"},{WorldMarker="INVALID"},{HudText="INVALID"},{GmpInfo="INVALID"},{AtTime="INVALID"},{InfoTypingText="INVALID"},{ResourcePanel="SHOW_IN_HELI"}}for o,a in pairs(a)do
for o,a in pairs(a)do
if(TppUiStatusManager.CheckStatus(o,a)==true)then
e(r,string.format(" UI = %s, Status = %s",o,a))end
end
end
end
if o.qaDebug.showWeaponVars then
local a={"PRIMARY_HIP","PRIMARY_BACK","SECONDARY"}e(r,{.5,.5,1},"LuaSystem WeaponVars")for a,o in ipairs(a)do
local a=TppDefine.WEAPONSLOT[o]e(r,string.format("Slot:%16s : vars.initWeapons = %04d, vars.weapons = %04d",o,vars.initWeapons[a],vars.weapons[a]))end
for a=0,7 do
e(r,string.format("Slot:%d : vars.supportWeapons = %04d, vars.initSupportWeapons = %04d, gvars.ply_lastWeaponsUsingTemp = %04d",a,vars.supportWeapons[a],vars.initSupportWeapons[a],gvars.ply_lastWeaponsUsingTemp[a+TppDefine.WEAPONSLOT.SUPPORT_0]))end
for a=0,7 do
e(r,string.format("Slot:%d : vars.items = %04d, vars.initItems = %04d, gvars.ply_lastItemsUsingTemp = %04d",a,vars.items[a],vars.initItems[a],gvars.ply_lastItemsUsingTemp[a]))end
end
if o.qaDebug.showPlayerPartsType then
e(r,{.5,.5,1},"LuaSystem ShowPlayerPartsType")e(r,"gvars.ply_isUsingTempPlayerType = "..tostring(gvars.ply_isUsingTempPlayerType))e(r,string.format("vars.playerPartsType = %04d, gvars.ply_lastPlayerPartsTypeUsingTemp = %04d",vars.playerPartsType,gvars.ply_lastPlayerPartsTypeUsingTemp))e(r,string.format("vars.playerCamoType = %04d, gvars.ply_lastPlayerCamoTypeUsingTemp = %04d",vars.playerCamoType,gvars.ply_lastPlayerCamoTypeUsingTemp))e(r,string.format("vars.playerType = %04d, gvars.ply_lastPlayerTypeUsingTemp = %04d",vars.playerType,gvars.ply_lastPlayerTypeUsingTemp))end
if o.qaDebug.gotFobStatusCount then
e(r,{.5,.5,1},">> Done TppServerManager.GetFobStatus()")o.qaDebug.gotFobStatusCount=o.qaDebug.gotFobStatusCount+1
if o.qaDebug.gotFobStatusCount>120 then
o.qaDebug.gotFobStatusCount=nil
end
end
if o.qaDebug.setFobForGPU then
o.qaDebug.setFobForGPU=false
a.DEBUG_FobGPU()end
if o.qaDebug.showEventTask then
if not o.ui_eventTaskDefine then
o.qaDebug.showEventTask=false
return
end
e(r,{.5,.5,1},"LuaUI ShowEventTask")local function s(t,a,i)local n
if FobUI.IsCompleteEventTask(a,i)then
n=" o "else
n=" x "end
local s=t[a]and t[a].detectType
if s then
local o=o.qaDebug.debugEventTaskTextTable and o.qaDebug.debugEventTaskTextTable[s]if not o then
o="threshold is"end
e(r,string.format("   Task %1d : [%s] %s %06.2f : ( Current %06.2f )",a,n,o,t[a].threshold,FobUI.GetCurrentEventTaskValue(a,i)))end
end
e(r,{.5,1,.5},"FobSneak eventTask")for a=0,7 do
local e=o.ui_eventTaskDefine.sneak
if e and e[a]then
s(e,a,true)end
end
e(r,{.5,1,.5},"FobDefence eventTask")for a=0,7 do
local e=o.ui_eventTaskDefine.defence
if e and e[a]then
s(e,a,false)end
end
end
end
if Tpp.IsQARelease()then
return a
end
function a.Print2D(e)if(e==nil)then
return
end
local t=e.showTime or(3*30)local o=e.xPos or 25
local n=e.yPos or 425
local s=e.size or 20
local r=e.color or"white"local e=e.text or""r=a._GetColor(r)GrxDebug.Print2D{life=t,x=o,y=n,size=s,color=r,args={e}}end
function a.DEBUG_MakeUserSVarList(e)if not t(e)then
return
end
mvars.dbg_userSaveVarList={}for a,e in pairs(e)do
table.insert(mvars.dbg_userSaveVarList,e.name)end
end
function a.AddReturnToSelector(e)e:AddItem("< return",DebugSelector.Pop)end
function a.DEBUG_Init()mvars.debug.returnSelect=false;(nil).AddDebugMenu(" Select","Return select","bool",mvars.debug,"returnSelect")mvars.debug.showSVars=false;(nil).AddDebugMenu("LuaMission","DBG.showSVars","bool",mvars.debug,"showSVars")mvars.debug.showMVars=false;(nil).AddDebugMenu("LuaMission","DBG.showMVars","bool",mvars.debug,"showMVars")mvars.debug.showMissionArea=false;(nil).AddDebugMenu("LuaMission","MIS.missionArea","bool",mvars.debug,"showMissionArea")mvars.debug.showClearState=false;(nil).AddDebugMenu("LuaMission","MIS.clearState","bool",mvars.debug,"showClearState")mvars.debug.openEmergencyTimer=false;(nil).AddDebugMenu("LuaMission","MIS.openEmergencyTimer","bool",mvars.debug,"openEmergencyTimer")mvars.debug.closeEmergencyTimer=false;(nil).AddDebugMenu("LuaMission","MIS.closeEmergencyTimer","bool",mvars.debug,"closeEmergencyTimer")mvars.debug.showDebugPerfCheck=false;(nil).AddDebugMenu("LuaSystem","DBG.showPerf","bool",mvars.debug,"showDebugPerfCheck")mvars.debug.showSysSVars=false;(nil).AddDebugMenu("LuaSystem","DBG.showSysSVars","bool",mvars.debug,"showSysSVars")mvars.debug.showSysMVars=false;(nil).AddDebugMenu("LuaSystem","DBG.showSysMVars","bool",mvars.debug,"showSysMVars")mvars.debug.AnimalBlock=false;(nil).AddDebugMenu("LuaSystem","DBG.AnimalBlock","bool",mvars.debug,"AnimalBlock")mvars.debug.ply_rotCheck=0;(nil).AddDebugMenu("LuaSystem","PLY.rotCheck","int32",mvars.debug,"ply_rotCheck")mvars.debug.ply_intelTrap=false;(nil).AddDebugMenu("LuaSystem","PLY.intelTrap","bool",mvars.debug,"ply_intelTrap")mvars.debug.enableAllMessageLog=false;(nil).AddDebugMenu("LuaMessage","enableAllMessageLog","bool",mvars.debug,"enableAllMessageLog")mvars.debug.showSubscriptMessageTable=0;(nil).AddDebugMenu("LuaMessage","subScripts","int32",mvars.debug,"showSubscriptMessageTable")mvars.debug.showSequenceMessageTable=0;(nil).AddDebugMenu("LuaMessage","sequence","int32",mvars.debug,"showSequenceMessageTable")mvars.debug.showLocationMessageTable=0;(nil).AddDebugMenu("LuaMessage","location","int32",mvars.debug,"showLocationMessageTable")mvars.debug.showLibraryMessageTable=0;(nil).AddDebugMenu("LuaMessage","library","int32",mvars.debug,"showLibraryMessageTable")mvars.debug.showWeaponSelect=false;(nil).AddDebugMenu("LuaWeapon","showWeaponSelect","bool",mvars.debug,"showWeaponSelect")mvars.debug.weaponCategory=1;(nil).AddDebugMenu("LuaWeapon","category","int32",mvars.debug,"weaponCategory")mvars.debug.weaponCategoryList={{"Develop:Hundgan",8,{"EQP_WP_1"}},{"Develop:Submachingun",8,{"EQP_WP_2"}},{"Develop:AssaultRifle",8,{"EQP_WP_3"}},{"Develop:Shotgun",8,{"EQP_WP_4"}},{"Develop:Granader",8,{"EQP_WP_5"}},{"Develop:SniperRifle",8,{"EQP_WP_6"}},{"Develop:MachineGun",8,{"EQP_WP_7"}},{"Develop:Missile",8,{"EQP_WP_8"}},{"EnemyWeapon",8,{"EQP_WP_W","EQP_WP_E","EQP_WP_Q","EQP_WP_C"}},{"SupportWeapon",7,{"EQP_SWP"}},{"Equipment",7,{"EQP_IT_"}}}mvars.debug.selectedWeaponId=0;(nil).AddDebugMenu("LuaWeapon","weaponSelect","int32",mvars.debug,"selectedWeaponId")mvars.debug.enableWeaponChange=false;(nil).AddDebugMenu("LuaWeapon","enableWeaponChange","bool",mvars.debug,"enableWeaponChange")end
function a.DEBUG_OnReload(r)s={}m={}l={}i=0
n=0
a.PERF_CHECK_TYPE=Tpp.Enum(a.PERF_CHECK_TYPE)local e={}d(e,TppDbgStr32.DEBUG_strCode32List)for r,a in pairs(r)do
if a.DEBUG_strCode32List then
d(e,a.DEBUG_strCode32List)end
end
TppDbgStr32.DEBUG_RegisterStrcode32invert(e)end
function a.DebugUpdate()local n=svars
local e=mvars
local t=e.debug
local o=DebugText.Print
local r=DebugText.NewContext()if(not TppUiCommand.IsEndMissionTelop())then
o(r,{.5,.5,1},"Now showing result.")end
if gvars.needWaitMissionInitialize then
o(r,{.5,.5,1},"Now neew wait mission initialize.")end
if t.returnSelect then
TppUI.FadeOut(0)TppSave.ReserveVarRestoreForMissionStart()TppMission.SafeStopSettingOnMissionReload()tpp_editor_menu2.StartTestStage(6e4)t.returnSelect=false
end
if t.showSVars then
o(r,"")o(r,{.5,.5,1},"LuaMission DBG.showSVars")for a,e in pairs(e.dbg_userSaveVarList)do
o(r,string.format(" %s = %s",tostring(e),tostring(n[e])))end
end
if t.showMVars then
o(r,{.5,.5,1},"LuaMission DBG.showMVars")for a,e in pairs(e)do
o(r,string.format(" %s = %s",tostring(a),tostring(e)))end
end
if t.showMissionArea then
o(r,{.5,.5,1},"LuaMission MIS.missionArea")local a
if e.mis_isOutsideOfMissionArea then
a="Outside"else
a="Inside"end
o(r,"outerZone : "..a)if e.mis_isAlertOutOfMissionArea then
a="Outside"else
a="Inside"end
o(r,"innerZone : "..a)if e.mis_isOutsideOfHotZone then
a="Outside"else
a="Inside"end
o(r,"hotZone : "..a)o(r,"hotZone clear check : isNotAlert = "..(tostring(e.debug.notHotZone_isNotAlert)..(", isPlayerStatusNormal = "..(tostring(e.debug.notHotZone_isPlayerStatusNormal)..(", isNotHelicopter = "..tostring(e.debug.notHotZone_isNotHelicopter))))))o(r,"Mission clear timer: "..tostring(u"Timer_OutsideOfHotZoneCount"))o(r,{.5,1,.5},"Recent all target status")local e=e.debug.checkedTargetStatus or{}for a,e in pairs(e)do
o(r,"  TargetName = "..(a..(" : "..e)))end
end
if e.debug.showClearState then
o(r,{.5,.5,1},"LuaMission MIS.showClearState")o(r,"missionClearState = "..tostring(TppDefine.MISSION_CLEAR_STATE_LIST[gvars.mis_missionClearState+1]))end
if e.debug.openEmergencyTimer then
e.debug.openEmergencyTimer=false
if e.mis_openEmergencyMissionTimerName then
GkEventTimerManager.Stop(e.mis_openEmergencyMissionTimerName)GkEventTimerManager.Start(e.mis_openEmergencyMissionTimerName,1)end
end
if e.debug.closeEmergencyTimer then
e.debug.closeEmergencyTimer=false
if e.mis_closeEmergencyMissionTimerName then
GkEventTimerManager.Stop(e.mis_closeEmergencyMissionTimerName)GkEventTimerManager.Start(e.mis_closeEmergencyMissionTimerName,1)end
end
if t.showSysSVars then
o(r,"")o(r,{.5,.5,1},"LuaSystem DBG.showSysSVars")for e,a in pairs(n.__as)do
if(a<=1)then
o(r,string.format(" %s = %s",tostring(e),tostring(n[e])))else
o(r,string.format(" %s = %s",tostring(e),tostring(a)))for a=0,(a-1)do
o(r,string.format("   %s[%d] = %s",tostring(e),a,tostring(n[e][a])))end
end
end
end
if t.showDebugPerfCheck then
o(r,{.5,.5,1},"LuaSystem DBG.showPerf")for t,e in pairs(l)do
o(r," perf["..(a.PERF_CHECK_TYPE[t]..("] = "..e)))end
end
if e.debug.AnimalBlock then
o(r,{.5,.5,1},"LuaSystem DBG.AnimalBlock")local n,t=Tpp.GetCurrentStageSmallBlockIndex()o(r,string.format("current block position (x,y) = (%03d, %03d)",n,t))o(r,"Load animal block area = "..tostring(e.animalBlockAreaName))local n=ScriptBlock.GetScriptBlockId"animal_block"local t
if n~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
t=ScriptBlock.GetScriptBlockState(n)end
local n
if t==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
n="SCRIPT_BLOCK_STATE_EMPTY"elseif t==ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING then
n="SCRIPT_BLOCK_STATE_PROCESSING"elseif t==ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
n="SCRIPT_BLOCK_STATE_INACTIVE"elseif t==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
n="SCRIPT_BLOCK_STATE_ACTIVE"end
o(r,"animal block state : "..tostring(n))if e.animalBlockScript then
o(r,"animalBlockScript exist")local t=""if e.animalBlockScript.OnMessage then
t="exist"else
t="  not"end
local n=""if e.animalBlockScript.OnReload then
n="exist"else
n="  not"end
o(r,"OnMessage "..(tostring(t)..(" OnReload "..tostring(n))))a.ShowMessageTable(r,"MessageTable",e.animalBlockScript.messageExecTable)else
if t==ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE or t==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
o(r,{1,0,0},"this data is invalid!!!! please check data!!!")else
o(r,"animalBlockScript   not")end
end
end
if e.debug.ply_intelTrap then
o(r,{.5,.5,1},"LuaSystem PLY.intelTrap")for e,a in pairs(e.ply_intelTrapInfo)do
if Tpp.IsTypeString(e)then
o(r,{.5,1,.5},"intelName = "..tostring(e))for e,a in pairs(a)do
o(r,tostring(e)..(" = "..tostring(a)))end
end
end
end
if(t.showSubscriptMessageTable>0)then
o(r,{.5,.5,1},"LuaMessage subScripts")local o={"sequence","enemy","demo","radio","sound"}local o=o[e.debug.showSubscriptMessageTable]if o then
local t=TppMission.GetMissionName()..("_"..o)if e.rad_subScripts[o]then
local e=e.rad_subScripts[o]._messageExecTable
a.ShowMessageTable(r,t,e)end
end
end
if(t.showSequenceMessageTable>0)then
o(r,{.5,.5,1},"LuaMessage sequence")local o=TppSequence.GetSequenceNameWithIndex(e.debug.showSequenceMessageTable)if e.seq_sequenceTable then
local e=e.seq_sequenceTable[o]if e then
local e=e._messageExecTable
a.ShowMessageTable(r,o,e)end
end
end
if(t.showLocationMessageTable>0)then
o(r,{.5,.5,1},"LuaMessage location")end
if(t.showLibraryMessageTable>0)then
o(r,{.5,.5,1},"LuaMessage library")local e=Tpp._requireList[t.showLibraryMessageTable]local o=_G[e].messageExecTable
a.ShowMessageTable(r,e,o)end
if e.debug.showWeaponSelect then
o(r,{.5,.5,1},"LuaWeapon")if e.debug.weaponCategory<1 then
e.debug.weaponCategory=1
end
if e.debug.weaponCategory>#e.debug.weaponCategoryList then
e.debug.weaponCategory=#e.debug.weaponCategoryList
end
local a=e.debug.weaponCategory
local n=e.debug.weaponCategoryList[e.debug.weaponCategory]o(r,{.5,1,.5},"Current weapon category : "..n[1])local l,p
local a,t,i=0,1,5
if e.debug.selectedWeaponId>0 then
t=e.debug.selectedWeaponId
end
for e,u in pairs(TppEquip)do
local d=string.sub(e,1,n[2])local s=false
for a,e in ipairs(n[3])do
if d==e then
s=true
end
end
if s then
a=a+1
if(t-a)<=i then
if a==t then
l=u
p=e
o(r,{.5,1,.5},"> EquipId = TppEquip."..e)else
o(r,"  EquipId = TppEquip."..e)end
end
if a==(t+i)then
break
end
end
end
if e.debug.enableWeaponChange then
GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId={l}})e.debug.enableWeaponChange=false
end
end
end
function a.ShowMessageTable(r,o,a)local e=DebugText.Print
e(r,{.5,1,.5},o)if a==nil then
return
end
for o,a in pairs(a)do
local o=p(o)if a then
for t,a in pairs(a)do
local t=p(t)if a.func then
e(r,{1,1,1},o..(" : "..(t..(" : "..tostring(a.func)))))end
local a=a.sender
if a then
for n,a in pairs(a)do
e(r,{1,1,1},o..(" : "..(t..(" : Sender = "..(p(n)..(" : "..tostring(a)))))))end
end
end
end
end
end
function a.PerfCheckStart(e)local a=a
if((e<=0)and(e>#a.PERF_CHECK_TYPE))then
return
end
if(e==a.PERF_CHECK_TYPE.OnUpdate)then
if(s[a.PERF_CHECK_TYPE.OnUpdate]~=nil)then
i=i+(os.clock()-s[a.PERF_CHECK_TYPE.OnUpdate])end
end
s[e]=os.clock()end
function a.PerfCheckEnd(e,r)local t=mvars
local o=a
if((e<=0)and(e>#o.PERF_CHECK_TYPE))then
return
end
local p=r or""local r=0
local a=os.clock()-s[e]if(e==o.PERF_CHECK_TYPE.OnUpdate)then
if(i<v)then
if(a>n)then
n=a
end
else
i=0
n=a
end
r=n
else
r=a
end
l[e]=string.format("%4.2f",r*1e3)..("ms."..p)if t.debug and t.debug.showDebugPerfCheck then
if(r>1/60)then
else
if(e~=o.PERF_CHECK_TYPE.OnUpdate)then
end
end
end
end
function a.ErrorNotSupportYet(e)end
function a._GetColor(e)local e=a.Colors[e]if(e==nil)then
return nil
end
return e
end
return a