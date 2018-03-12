local e={}local r=Tpp.IsTypeFunc
local s=Tpp.IsTypeTable
local i=TppScriptVars.IsSavingOrLoading
local S=SsdSaveSystem.IsIdle
local _=SsdSaveSystem.ICON_TYPE_SAVE
local T=SsdSaveSystem.ICON_TYPE_LOAD
local a=SsdSaveSystem.ICON_TYPE_NONE
e.saveQueueDepth=0
e.saveQueueList={}local p={{checkStorySequenceSpan={TppDefine.STORY_SEQUENCE.BEFORE_s10050,TppDefine.STORY_SEQUENCE.CLEARED_s10050},checkMissionCode=10050,checkMissionSequence=3,returnStorySequence=TppDefine.STORY_SEQUENCE.BEFORE_s10050,returnMissionCode=30020,returnLocationCode=TppDefine.LOCATION_ID.MAFR},{checkStorySequenceSpan={TppDefine.STORY_SEQUENCE.CLEARED_k40260,TppDefine.STORY_SEQUENCE.BEFORE_STORY_LAST},checkMissionCode=30010,checkMissionSequence=9,returnStorySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40270,returnMissionCode=30010,returnLocationCode=TppDefine.LOCATION_ID.SSD_AFGH},{checkStorySequenceSpan={TppDefine.STORY_SEQUENCE.BEFORE_k40270,TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST},checkMissionCode=10060,checkMissionSequence=3,returnStorySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40270,returnMissionCode=30010,returnLocationCode=TppDefine.LOCATION_ID.SSD_AFGH}}local function a(a)if gvars.sav_isReservedMbSaveResultNotify then
gvars.sav_isReservedMbSaveResultNotify=false
if a then
TppMotherBaseManagement.SetRequestSaveResultSuccess()else
TppMotherBaseManagement.SetRequestSaveResultFailure()end
end
end
e.SAVE_RESULT_FUNCTION={[Fox.StrCode32(TppDefine.CONFIG_SAVE_FILE_NAME)]=function(e)end,[Fox.StrCode32(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)]=function(e)if e==false then
return
end
if(vars.isPersonalDirty==1)then
vars.isPersonalDirty=0
end
end,[Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME)]=a,[Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME_TMP)]=a}function e.GetSaveFileVersion(e)return(TppDefine.SAVE_FILE_INFO[e].version+TppDefine.PROGRAM_SAVE_FILE_VERSION[e]*TppDefine.PROGRAM_SAVE_FILE_VERSION_OFFSET)end
function e.IsExistConfigSaveFile()return TppScriptVars.FileExists(TppDefine.CONFIG_SAVE_FILE_NAME)end
function e.IsExistPersonalSaveFile()return TppScriptVars.FileExists(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)end
function e.ForbidSave()gvars.sav_permitGameSave=false
end
function e.IsForbidSave()return(not gvars.sav_permitGameSave)end
function e.NeedWaitSavingErrorCheck()if gvars.sav_SaveResultCheckFileName==0 then
return false
else
return true
end
end
function e.IsSaving()if i()then
return true
end
if e.IsEnqueuedSaveData()then
return true
end
if(gvars.sav_SaveResultCheckFileName~=0)then
return true
end
if not S()then
return true
end
return false
end
function e.IsSavingWithFileName(e)if gvars.sav_SaveResultCheckFileName==Fox.StrCode32(e)then
return true
else
return false
end
end
function e.HasQueue(a)if(e.GetSaveRequestFromQueue(a)~=nil)then
return true
else
return false
end
end
function e.GetSaveRequestFromQueue(n)for a=1,e.saveQueueDepth do
if e.saveQueueList[a].fileName==n then
return a,e.saveQueueList[a]end
end
end
function e.EraseAllGameDataSaveRequest()local a,n
repeat
a,n=e.GetSaveRequestFromQueue(e.GetGameSaveFileName())if a then
if(n.doSaveFunc==e.ReserveNoticeOfMbSaveResult)then
TppMotherBaseManagement.SetRequestSaveResultFailure()end
e.DequeueSave(a)if not Tpp.IsMaster()then
e.DEBUG_EraseAllGameDataCounter=3
end
end
until(a==nil)end
function e.IsEnqueuedSaveData()if e.saveQueueDepth>0 then
return true
else
return false
end
end
local o=e.IsEnqueuedSaveData
function e.RegistCompositSlotSize(a)e.COMPOSIT_SLOT_SIZE=a
end
function e.SetUpCompositSlot()if e.COMPOSIT_SLOT_SIZE then
TppScriptVars.SetUpSlotAsCompositSlot(TppDefine.SAVE_SLOT.SAVING,e.COMPOSIT_SLOT_SIZE)end
end
function e.SaveGameData(r,i,t,a,n)if a then
e.ReserveNextMissionStartSave(e.GetGameSaveFileName(),n)else
local a=e.GetSaveGameDataQueue(r,i,t,n)e.EnqueueSave(a)end
e.CheckAndSavePersonalData(a)end
function e.GetSaveGameDataQueue(r,i,n,t)local a=e.GetGameSaveFileName()local a=e.GetIntializedCompositSlotSaveQueue(a,i,n,t)a=e._SaveGlobalData(a)a=e._SaveMissionData(a)a=e._SaveMissionRestartableData(a)a=e._SaveRetryData(a)a=e._SaveMbManagementData(a,r)a=e._SaveQuestData(a)return a
end
function e.SaveConfigData(a,n,t)if n then
local a=e.MakeNewSaveQueue(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)return e.DoSave(a,true)elseif t then
e.ReserveNextMissionStartSave(TppDefine.CONFIG_SAVE_FILE_NAME)else
e.EnqueueSave(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)end
end
function e.SavePersonalData(a,t,n)if t then
local a=e.MakeNewSaveQueue(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,a)return e.DoSave(a,true)elseif n then
e.ReserveNextMissionStartSave(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)else
e.EnqueueSave(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,a)end
end
function e.CheckAndSavePersonalData(n)local a=TppDefine.PERSONAL_DATA_SAVE_FILE_NAME
if e.IsSavingWithFileName(a)or e.HasQueue(a)then
return
end
if(vars.isPersonalDirty==1)then
e.VarSavePersonalData()e.SavePersonalData(nil,nil,n)end
end
function e.SaveEditData()e.VarSavePersonalData()e.SavePersonalData()SsdSaveSystem.SaveCommunicationConfig()end
function e.SaveOnlyMbManagement(n)local a=vars.missionCode
e.VarSaveMbMangement(a)e.SaveGameData(a,nil,n)end
function e.ReserveNoticeOfMbSaveResult()gvars.sav_isReservedMbSaveResultNotify=true
end
function e.SaveOnlyGlobalData()e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)e.SaveGameData(vars.missionCode)end
function e.SaveGzPrivilege()e.SaveMBAndGlobal()end
function e.SaveMBAndGlobal()e.VarSaveMBAndGlobal()e.SaveGameData(currentMissionCode)end
function e.VarSaveMBAndGlobal()local a=vars.missionCode
e.VarSaveMbMangement(a)e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)end
e.DO_RESERVE_SAVE_FUNCTION={[TppDefine.CONFIG_SAVE_FILE_NAME]=e.SaveConfigData,[TppDefine.PERSONAL_DATA_SAVE_FILE_NAME]=e.SavePersonalData,[TppDefine.GAME_SAVE_FILE_NAME]=e.SaveGameData,[TppDefine.GAME_SAVE_FILE_NAME_TMP]=e.SaveGameData}function e.ReserveNextMissionStartSave(a,t)if not e.DO_RESERVE_SAVE_FUNCTION[a]then
return
end
e.missionStartSaveFilePool=e.missionStartSaveFilePool or{}local n=e.missionStartSaveFilePool[a]or{}if n and t then
n.isCheckPoint=t
end
e.missionStartSaveFilePool[a]=n
end
function e.DoReservedSaveOnMissionStart()if not e.missionStartSaveFilePool then
return
end
local a=Fox.GetPlatformName()if a=="Xbox360"or a=="XboxOne"then
if not SignIn.IsSignedIn()then
e.missionStartSaveFilePool=nil
return
end
end
for a,n in pairs(e.missionStartSaveFilePool)do
local e=e.DO_RESERVE_SAVE_FUNCTION[a]e(nil,nil,nil,nil,n.isCheckPoint)end
e.missionStartSaveFilePool=nil
end
function e._SaveGlobalData(a)if TppScriptVars.StoreUtcTimeToScriptVars then
TppScriptVars.StoreUtcTimeToScriptVars()end
return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.GLOBAL,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_GAME_GLOBAL)end
function e._SaveMissionData(a)return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MISSION)end
function e._SaveRetryData(a)return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.RETRY,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_RETRY)end
function e._SaveMbManagementData(a,n)return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MB_MANAGEMENT)end
function e._SaveQuestData(a)return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.QUEST,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_QUEST)end
function e._SaveMissionRestartableData(a)a=e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.MISSION_START,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)a=e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)return a
end
function e.MakeNewGameSaveData(a)TppVarInit.InitializeOnNewGameAtFirstTime()TppVarInit.InitializeOnNewGame()if a then
TppTerminal.AcquirePrivilegeInTitleScreen()end
gvars.sav_skipRestoreToVars=true
e.VarSave(vars.missionCode,true)e.VarSaveOnRetry()local n,t=e.GetSaveGameDataQueue(vars.missionCode)if gvars.sav_permitGameSave then
n=e.GetSaveGameDataQueue(vars.missionCode)t=e.DoSave(n,true)end
if a then
e.CheckAndSavePersonalData()end
return t
end
function e.SaveImportedGameData()local a,n=e.GetSaveGameDataQueue(vars.missionCode)if gvars.sav_permitGameSave then
a=e.GetSaveGameDataQueue(vars.missionCode)n=e.DoSave(a,true)end
return n
end
function e.SaveToServer(a,n)if n and r(n)then
table.insert(mvars.sav_serverSaveFinishCallback,n)end
if not a then
return
end
if mvars.mis_skipServerSave or mvars.fms_skipServerSave then
return
end
if gvars.exc_skipServerSaveForException then
return
end
if TppMission.IsMultiPlayMission(vars.missionCode)then
return
end
if a==TppDefine.SERVER_SAVE_TYPE.MISSION_START then
SsdSaveSystem.SaveMissionStart()elseif a==TppDefine.SERVER_SAVE_TYPE.CHECK_POINT then
SsdSaveSystem.SaveCheckPoint()elseif a==TppDefine.SERVER_SAVE_TYPE.MISSION_END then
SsdSaveSystem.SaveMissionEnd()elseif a==TppDefine.SERVER_SAVE_TYPE.FLAG_MISSION_END then
SsdSaveSystem.SaveFlagMissionEnd()elseif a==TppDefine.SERVER_SAVE_TYPE.AVATAR_EDIT_END then
SsdSaveSystem.SaveAvatar()else
return
end
e.ReserveVarRestoreForContinue()end
function e.LoadFromServer(e)if e and r(e)then
table.insert(mvars.sav_serverSaveFinishCallback,e)end
if gvars.exc_skipServerSaveForException then
return
end
gvars.sav_skipRestoreToVars=false
SsdSaveSystem.Reset()SsdSaveSystem.LoadInit()end
function e.AddServerSaveCallbackFunc(e)if mvars.mis_skipServerSave or mvars.fms_skipServerSave then
return
end
if gvars.exc_skipServerSaveForException then
return
end
if not r(e)then
return
end
table.insert(mvars.sav_serverSaveFinishCallback,e)end
function e.RestoreToVars(a)if gvars.sav_skipRestoreToVars then
return
end
if gvars.exc_skipServerSaveForException then
return
end
SsdSaveSystem.RestoreToVars(a)if gvars.sav_continueForOutOfBaseArea then
TppPlayer.RestoreTempInitialPosition()elseif TppMission.IsStoryMission(vars.missionCode)then
TppPlayer.SetInitialPositionToCurrentPosition()else
TppPlayer.ResetInitialPosition()end
SsdSbm.RestoreFromSVars()e.VarSave()end
function e.GetIntializedCompositSlotSaveQueue(n,a,e,t)return{fileName=n,needIcon=a,doSaveFunc=e,isCheckPoint=t}end
function e.AddSlotToSaveQueue(e,t,a,n)if t==nil then
return
end
if a==nil then
return
end
if n==nil then
return
end
local e=e or{}e.savingSlot=a
e.slot=e.slot or{}e.category=e.category or{}local a=#e.slot+1
e.slot[a]=t
e.category[a]=n
return e
end
function e.EnqueueSave(a,i,t,r,S)if a==nil then
return
end
if(gvars.isLoadedInitMissionOnSignInUserChanged or TppException.isLoadedInitMissionOnSignInUserChanged)or TppException.isNowGoingToMgo then
return
end
if gvars.exc_processingForDisconnect then
return
end
local n
if s(a)then
n=a
else
if i==nil then
return
end
if t==nil then
return
end
end
if gvars.sav_permitGameSave==false then
return
end
e.saveQueueDepth=e.saveQueueDepth+1
if n then
e.saveQueueList[e.saveQueueDepth]=n
else
e.saveQueueList[e.saveQueueDepth]=e.MakeNewSaveQueue(a,i,t,r,S)end
end
function e.MakeNewSaveQueue(t,a,r,i,n,S)local e={}e.slot=t
e.savingSlot=a
e.category=r
e.fileName=i
e.needIcon=n
e.doSaveFunc=S
return e
end
function e.DequeueSave(a)if(a==nil)then
a=1
end
for a=a,(e.saveQueueDepth-1)do
e.saveQueueList[a]=e.saveQueueList[a+1]end
if(e.saveQueueDepth<=0)then
return
end
e.saveQueueList[e.saveQueueDepth]=nil
e.saveQueueDepth=e.saveQueueDepth-1
end
function e.ProcessSaveQueue()if not o()then
return false
end
local a=e.saveQueueList[1]if a then
local a=e.DoSave(a)if a~=nil then
e.DequeueSave()if a==TppScriptVars.WRITE_FAILED then
if(gvars.sav_SaveResultCheckFileName~=0)then
local e=e.SAVE_RESULT_FUNCTION[gvars.sav_SaveResultCheckFileName]if e then
e(false)end
gvars.sav_SaveResultCheckFileName=0
end
TppException.ShowSaveErrorPopUp(TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON)end
end
end
end
function e.DoSave(a,n)local o=true
if n then
o=false
end
local n
local p
local i
local r
local t
local S
if s(a.slot)then
e.SetUpCompositSlot()i=a.fileName
r=a.needIcon
t=a.doSaveFunc
S=a.isCheckPoint
for i,t in ipairs(a.slot)do
n=a.category[i]p=e.GetSaveFileVersion(n)TppScriptVars.CopySlot({a.savingSlot,t},t)end
else
n=a.category
if n then
p=e.GetSaveFileVersion(n)i=a.fileName
r=a.needIcon
t=a.doSaveFunc
TppScriptVars.CopySlot(a.savingSlot,a.slot)else
return false
end
end
if t then
t()end
local e=TppScriptVars.WriteSlotToFile(a.savingSlot,i,r)if o then
gvars.sav_SaveResultCheckFileName=Fox.StrCode32(i)if S then
gvars.sav_isCheckPointSaving=true
end
end
return e
end
function e.Update()local a=gvars
if(not i())then
if(a.sav_SaveResultCheckFileName~=0)then
local n=true
local t=TppScriptVars.GetLastResult()local t,i=e.GetSaveResultErrorMessage(t)if t then
n=false
if vars.missionCode==TppDefine.SYS_MISSION_ID.INIT then
TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"end
TppUiCommand.ShowErrorPopup(t,i)end
local e=e.SAVE_RESULT_FUNCTION[a.sav_SaveResultCheckFileName]if e then
e(n)end
a.sav_SaveResultCheckFileName=0
a.sav_isCheckPointSaving=false
a.sav_isPersonalSaving=false
a.sav_isConfigSaving=false
end
if not PatchDlc.IsCheckingPatchDlc()then
if e.IsEnqueuedSaveData()then
e.ProcessSaveQueue()end
end
end
if i()then
local e=TppScriptVars.GetSaveState()if e==TppScriptVars.STATE_SAVING then
if a.sav_isPersonalSaving or a.sav_isConfigSaving then
TppUI.ShowSavingIcon()end
elseif e==TppScriptVars.STATE_LOADING then
TppUI.ShowLoadingIcon()elseif e==TppScriptVars.STATE_PROCESSING then
TppUI.ShowLoadingIcon()end
end
if not S()then
local e=SsdSaveSystem.GetIconType()if e==_ then
if a.sav_isCheckPointSaving then
TppUI.ShowSavingIcon"checkpoint"else
TppUI.ShowSavingIcon()end
elseif e==T then
TppUI.ShowLoadingIcon()end
else
local e=mvars.sav_serverSaveFinishCallback
if s(e)and next(e)then
for a,e in pairs(e)do
if r(e)then
e()end
end
mvars.sav_serverSaveFinishCallback={}end
end
if not Tpp.IsMaster()then
if e.DEBUG_RecoverSaveDataCount then
if e.DEBUG_RecoverSaveDataCount>0 then
e.DEBUG_RecoverSaveDataCount=e.DEBUG_RecoverSaveDataCount-Time.GetFrameTime()local e=DebugText.NewContext()DebugText.Print(e,{1,0,0},"TppSave: Recover mission cleared broken save data.")else
e.DEBUG_RecoverSaveDataCount=nil
end
end
if e.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount then
if e.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount>0 then
e.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount=e.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount-Time.GetFrameTime()local e=DebugText.NewContext()DebugText.Print(e,{1,0,0},"TppSave: Execute save data break!!!.")else
e.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount=nil
end
end
end
end
e.SaveErrorMessageIdTable={[TppScriptVars.RESULT_ERROR_INVALID_STORAGE]={TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,nil}}function e.GetSaveResultErrorMessage(a)if a==TppScriptVars.RESULT_OK then
return
end
local e=e.SaveErrorMessageIdTable[a]if e then
return e[1],e[2]else
return TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON
end
end
function e.Init(a)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())mvars.sav_serverSaveFinishCallback={}Mission.ClearDeceptiveSaveSettings()Mission.SetDeceptiveSaveSettings(p)end
function e.OnReload(a)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())Mission.ClearDeceptiveSaveSettings()Mission.SetDeceptiveSaveSettings(p)end
function e.Messages()return Tpp.StrCode32Table{UI={{msg="PopupClose",sender=TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,func=function()e.ForbidSave()end}}}end
function e.OnMessage(t,n,i,S,a,r,s)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,t,n,i,S,a,r,s)end
function e.WaitingAllEnqueuedSaveOnStartMission()e.WaitSaving()while o()do
e.ProcessSaveQueue()e.WaitSaving()end
e.WaitServerSaving()end
function e.WaitSaving()while i()do
e.CoroutineYieldWithShowSavingIcon()end
end
function e.WaitServerSaving()while not S()do
e.CoroutineYieldWithShowSavingIcon()end
end
function e.CoroutineYieldWithShowSavingIcon()TppUI.ShowSavingIcon()coroutine.yield()end
function e.SaveVarsToSlot(t,n,a)if gvars.exc_processingForDisconnect then
return
end
local e=e.GetSaveFileVersion(a)TppScriptVars.SaveVarsToSlot(t,n,a,e)end
function e.VarSaveOnlyGlobalData()e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)end
function e.VarSave(n,a)e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)e.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)if a then
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)e.SaveVarsToSlot(TppDefine.SAVE_SLOT.MISSION_START,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)else
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)end
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)e.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)e.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)end
function e.VarSaveOnRetry()e.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)end
function e.VarSaveMbMangement(a)e.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)end
function e.VarSaveQuest(a)e.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)end
function e.VarSaveConfig()e.SaveVarsToSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)gvars.sav_isConfigSaving=true
end
function e.VarSavePersonalData()e.SaveVarsToSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_PERSONAL)gvars.sav_isPersonalSaving=true
end
function e.LoadFromSaveFile(a,e,n)if not n then
return TppScriptVars.ReadSlotFromFile(a,e)else
return TppScriptVars.ReadSlotFromAreaFile(a,n,e)end
end
function e.GetGameSaveFileName()local e=Fox.GetPlatformName()if((Tpp.IsMaster()or Tpp.IsQARelease())or e=="PS4")then
return TppDefine.GAME_SAVE_FILE_NAME
else
if gvars.DEBUG_usingTemporarySaveData then
return TppDefine.GAME_SAVE_FILE_NAME_TMP
else
return TppDefine.GAME_SAVE_FILE_NAME
end
end
end
function e.DEBUG_IsUsingTemporarySaveData()if Tpp.IsMaster()then
return false
end
return gvars.DEBUG_usingTemporarySaveData
end
function e.LoadGameDataFromSaveFile(n)local a=e.GetGameSaveFileName()return e.LoadFromSaveFile(TppDefine.SAVE_SLOT.SAVING,a,n)end
local n={TppScriptVars.CATEGORY_GAME_GLOBAL,TppScriptVars.CATEGORY_MISSION,TppScriptVars.CATEGORY_RETRY,TppScriptVars.CATEGORY_MB_MANAGEMENT,TppScriptVars.CATEGORY_QUEST,TppDefine.CATEGORY_MISSION_RESTARTABLE}function e.CheckGameDataVersion()for n,a in ipairs(n)do
local n=TppDefine.SAVE_FILE_INFO[a].slot
local n=e.CheckSlotVersion(a,TppDefine.SAVE_SLOT.SAVING)if n~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
return n
end
if TppDefine.SAVE_FILE_INFO[a].missionStartSlot then
local e=e.CheckSlotVersion(a,TppDefine.SAVE_SLOT.SAVING,true)if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
return e
end
end
end
return TppDefine.SAVE_FILE_LOAD_RESULT.OK
end
function e.CopyGameDataFromSavingSlot()for a,e in ipairs(n)do
local a=TppDefine.SAVE_FILE_INFO[e].slot
TppScriptVars.CopySlot(a,{TppDefine.SAVE_SLOT.SAVING,a})local e=TppDefine.SAVE_FILE_INFO[e].missionStartSlot
if e then
TppScriptVars.CopySlot(e,{TppDefine.SAVE_SLOT.SAVING,e})end
end
end
function e.LoadConfigDataFromSaveFile(a)return e.LoadFromSaveFile(TppDefine.SAVE_SLOT.CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)end
function e.LoadPersonalDataFromSaveFile(a)return e.LoadFromSaveFile(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,a)end
function e.CheckSlotVersion(a,n,t)local i=e.GetSaveFileVersion(a)local e=TppDefine.SAVE_FILE_INFO[a].slot
if t then
e=TppDefine.SAVE_FILE_INFO[a].missionStartSlot
end
if n then
e={n,e}end
local e=TppScriptVars.GetScriptVersionFromSlot(e)if e==nil then
return TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
end
if e<=i then
return TppDefine.SAVE_FILE_LOAD_RESULT.OK
else
return TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
end
end
function e.CheckSlotVersionConfigData()return e.CheckSlotVersion(TppScriptVars.CATEGORY_CONFIG)end
function e.IsReserveVarRestoreForContinue()return gvars.sav_varRestoreForContinue
end
function e.ReserveVarRestoreForContinue()gvars.sav_varRestoreForContinue=true
end
function e.ReserveVarRestoreForMissionStart()gvars.sav_varRestoreForContinue=false
end
function e.VarRestoreOnMissionStart()TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.GLOBAL,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_GAME_GLOBAL)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MISSION)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MISSION_START,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppDefine.CATEGORY_MISSION_RESTARTABLE)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.RETRY,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_RETRY)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MB_MANAGEMENT)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.QUEST,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_QUEST)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_PERSONAL)gvars.sav_varRestoreForContinue=false
end
function e.VarRestoreOnContinueFromCheckPoint()TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppDefine.CATEGORY_MISSION_RESTARTABLE)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_PERSONAL)e.RestoreToVars()end
function e.CheckAndSaveInitMission()if TppMission.IsInvitationStart()then
vars.locationCode=TppDefine.SYS_MISSION_ID.INIT
vars.missionCode=TppMission.GetCoopLobbyMissionCode()TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()e.VarSave()gvars.sav_skipRestoreToVars=true
elseif(TppMission.IsInitMission(vars.missionCode)or TppMission.IsMultiPlayMission(vars.missionCode))or TppMission.IsAvatarEditMission(vars.missionCode)then
local a=TppStory.GetCurrentStorySequence()if a<TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL then
vars.missionCode=10010
vars.locationCode=TppDefine.LOCATION_ID.SSD_OMBS
elseif a>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST and a<TppDefine.STORY_SEQUENCE.CLEARED_RETURN_TO_AFGH then
vars.missionCode=30020
vars.locationCode=TppDefine.LOCATION_ID.MAFR
TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()else
vars.missionCode=30010
vars.locationCode=TppDefine.LOCATION_ID.SSD_AFGH
TppPlayer.ResetInitialPosition()TppPlayer.ResetMissionStartPosition()end
e.VarSave()gvars.sav_skipRestoreToVars=true
end
TppVarInit.SetBuildingLevel()end
function e.DeleteGameSaveFile()TppScriptVars.DeleteFile(TppDefine.GAME_SAVE_FILE_NAME)end
function e.DeleteTemporaryGameSaveFile()TppScriptVars.DeleteFile(TppDefine.GAME_SAVE_FILE_NAME_TMP)end
function e.DeleteConfigSaveFile()TppScriptVars.DeleteFile(TppDefine.CONFIG_SAVE_FILE_NAME)end
function e.DeletePersonalDataSaveFile()TppScriptVars.DeleteFile(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)end
function e.IsNewGame()return gvars.isNewGame
end
function e.IsGameDataLoadResultOK()if(gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.OK)or(gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP)then
return true
else
return false
end
end
e.SAVE_FILE_OK_RESULT_TABLE={[TppScriptVars.RESULT_OK]=TppDefine.SAVE_FILE_LOAD_RESULT.OK,[TppScriptVars.RESULT_ERROR_LOAD_BACKUP]=TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP}function e.CheckGameSaveDataLoadResult()local n=TppScriptVars.GetLastResult()local a=e.SAVE_FILE_OK_RESULT_TABLE[n]if a then
local e=e.CheckGameDataVersion()if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
gvars.gameDataLoadingResult=e
else
gvars.gameDataLoadingResult=a
end
else
if n==TppScriptVars.RESULT_ERROR_NOSPACE then
gvars.gameDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
else
gvars.gameDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
end
end
end
function e.CheckPersonalSaveDataLoadResult()local n=TppScriptVars.GetLastResult()local a=e.SAVE_FILE_OK_RESULT_TABLE[n]if gvars.personalDataLoadingResult~=TppDefine.SAVE_FILE_LOAD_RESULT.OK and gvars.personalDataLoadingResult~=TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE then
return
end
if a then
local e=e.CheckSlotVersion(TppScriptVars.CATEGORY_PERSONAL)if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
gvars.personalDataLoadingResult=e
else
gvars.personalDataLoadingResult=a
end
else
if n==TppScriptVars.RESULT_ERROR_NOSPACE then
gvars.personalDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
else
gvars.personalDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
end
end
end
function e.GetGameDataLoadingResult()return gvars.gameDataLoadingResult
end
if DebugMenu then
function e.QARELEASE_DEBUG_Init()mvars.qaDebug.sav_forbidSave=false
DebugMenu.AddDebugMenu(" SaveData","ForbidSave","bool",mvars.qaDebug,"sav_forbidSave")mvars.qaDebug.sav_permitSave=false
DebugMenu.AddDebugMenu(" SaveData","PermitSave","bool",mvars.qaDebug,"sav_permitSave")mvars.qaDebug.sav_dumpSaveData=false
DebugMenu.AddDebugMenu(" SaveData","DumpSaveData","bool",mvars.qaDebug,"sav_dumpSaveData")mvars.qaDebug.sav_loadDumpSaveData=false
DebugMenu.AddDebugMenu(" SaveData","LoadDumpedSaveData","bool",mvars.qaDebug,"sav_loadDumpSaveData")mvars.qaDebug.sav_makeNewGameSaveData=false
DebugMenu.AddDebugMenu(" SaveData","MakeNewGameSaveData","bool",mvars.qaDebug,"sav_makeNewGameSaveData")mvars.qaDebug.sav_cyprEndEntry=false
DebugMenu.AddDebugMenu(" SaveData","GoCyprEndEntry","bool",mvars.qaDebug,"sav_cyprEndEntry")mvars.qaDebug.sav_makeFullOpenSaveData=false
DebugMenu.AddDebugMenu(" SaveData","MakeFullOpenSaveData","bool",mvars.qaDebug,"sav_makeFullOpenSaveData")mvars.qaDebug.sav_deleteTemporaryGameFile=false
DebugMenu.AddDebugMenu(" SaveData","DeleteTemopraryGameSaveFile","bool",mvars.qaDebug,"sav_deleteTemporaryGameFile")mvars.qaDebug.sav_deleteGameFile=false
DebugMenu.AddDebugMenu(" SaveData","DeleteGameSaveFile","bool",mvars.qaDebug,"sav_deleteGameFile")mvars.qaDebug.sav_deleteConfigFile=false
DebugMenu.AddDebugMenu(" SaveData","DeleteConfigFile","bool",mvars.qaDebug,"sav_deleteConfigFile")mvars.qaDebug.sav_deletePersonalDataFile=false
DebugMenu.AddDebugMenu(" SaveData","DeletePersonalDataFile","bool",mvars.qaDebug,"sav_deletePersonalDataFile")mvars.qaDebug.sav_makeConfigFile=false
DebugMenu.AddDebugMenu(" SaveData","MakeConfigFile","bool",mvars.qaDebug,"sav_makeConfigFile")DebugMenu.AddDebugMenu(" SaveData","reserveDestroySave","bool",gvars,"DEBUG_reserveDestroySaveData")end
function e.QARELEASE_DEBUG_IsAvatarEditPlayer()if(vars.playerCamoType==PlayerCamoType.AVATAR_EDIT_MAN)or(vars.playerPartsType==PlayerPartsType.AVATAR_EDIT_MAN)then
return true
end
end
function e.QAReleaseDebugUpdate()local a=5
local a=svars
local a=mvars
local n=DebugText.NewContext()if a.qaDebug.sav_forbidSave then
a.qaDebug.sav_forbidSave=false
e.ForbidSave()end
if a.qaDebug.sav_permitSave then
a.qaDebug.sav_permitSave=false
gvars.sav_permitGameSave=true
end
if gvars.sav_permitGameSave==false then
DebugText.Print(n,{1,.5,1},"Now forbid save mode!")end
if a.qaDebug.sav_dumpSaveData then
a.qaDebug.sav_dumpSaveData=false
TppScriptVars.DEBUG_DumpVarsInSlot(TppDefine.SAVE_SLOT.SAVING,e.GetGameSaveFileName()..".lua")TppScriptVars.DEBUG_DumpVarsInSlot(TppDefine.SAVE_SLOT.CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME..".lua")TppScriptVars.DEBUG_DumpVarsInSlot(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME..".lua")end
if a.qaDebug.sav_loadDumpSaveData then
a.qaDebug.sav_loadDumpSaveData=false
TppScriptVars.DEBUG_LoadDumpedVars(e.GetGameSaveFileName()..".lua")TppScriptVars.DEBUG_LoadDumpedVars(TppDefine.CONFIG_SAVE_FILE_NAME..".lua")e.VarSave(vars.missionCode,true)e.VarSaveOnRetry()e.SaveGameData(vars.missionCode)e.SaveConfigData()end
if a.qaDebug.sav_makeNewGameSaveData then
a.qaDebug.sav_makeNewGameSaveData=false
if e.QARELEASE_DEBUG_IsAvatarEditPlayer()then
return
end
e.MakeNewGameSaveData()end
if a.qaDebug.sav_cyprEndEntry then
a.qaDebug.sav_cyprEndEntry=false
if not tpp_editor_menu2 then
Script.LoadLibrary"/Assets/tpp/editor_scripts/tpp_editor_menu2.lua"Script.LoadLibrary"/Assets/tpp/script/entry/entry_prologue.lua"end
entry_prologue.Bridge()end
if a.qaDebug.sav_makeRescueMillerSaveData then
a.qaDebug.sav_makeRescueMillerSaveData=false
if e.QARELEASE_DEBUG_IsAvatarEditPlayer()then
return
end
end
if a.qaDebug.sav_makeFullOpenSaveData then
a.qaDebug.sav_makeFullOpenSaveData=false
if e.QARELEASE_DEBUG_IsAvatarEditPlayer()then
return
end
TppStory.DEBUG_AllMissionOpen()e.VarSave(vars.missionCode,true)e.VarSaveOnRetry()e.SaveGameData()end
if a.qaDebug.sav_deleteTemporaryGameFile then
a.qaDebug.sav_deleteTemporaryGameFile=false
e.DeleteTemporaryGameSaveFile()end
if a.qaDebug.sav_deleteGameFile then
a.qaDebug.sav_deleteGameFile=false
e.DeleteGameSaveFile()end
if a.qaDebug.sav_deleteConfigFile then
a.qaDebug.sav_deleteConfigFile=false
e.DeleteConfigSaveFile()end
if a.qaDebug.sav_deletePersonalDataFile then
a.qaDebug.sav_deletePersonalDataFile=false
e.DeletePersonalDataSaveFile()end
if a.qaDebug.sav_makeConfigFile then
a.qaDebug.sav_makeConfigFile=false
e.VarSaveConfig()e.SaveConfigData()end
end
function e.UpdateMotherBaseStaffWithoutCheckpointSave()TppTerminal.AddStaffsFromTempBuffer(true)e.VarSaveMbMangement(vars.missionCode)e.SaveGameData(vars.missionCode)end
function e.QARELEASE_DEBUG_ExecuteReservedDestroySaveData()if gvars.DEBUG_reserveDestroySaveData then
e.SaveGameData()e.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount=3
gvars.DEBUG_reserveDestroySaveData=false
end
end
end
return e