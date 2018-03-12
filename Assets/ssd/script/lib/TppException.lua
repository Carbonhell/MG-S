local e={}e.MGO_INVITATION_CANCEL_POPUP_ID=5010
e.CLOSE_INIVITATION_CANCEL_POPUP_INTERVAL=1.5
e.PROCESS_STATE=Tpp.Enum{"EMPTY","START","SHOW_DIALOG","SUSPEND","FINISH"}e.TYPE=Tpp.Enum{"INVITATION_ACCEPT","DISCONNECT_FROM_PSN","DISCONNECT_FROM_KONAMI","DISCONNECT_FROM_NETWORK","SESSION_DISCONNECT_FROM_HOST","SESSION_JOIN_FAILED","SIGNIN_USER_CHANGED","INVITATION_PATCH_DLC_CHECKING","INVITATION_PATCH_DLC_ERROR","INVITATION_ACCEPT_BY_OTHER","INVITATION_ACCEPT_WITHOUT_SIGNIN","WAIT_MGO_CHUNK_INSTALLATION"}e.GAME_MODE=Tpp.Enum{"TPP","TPP_FOB","MGO"}e.TYPE_DISCONNECT_NETWORK_LIST={"DISCONNECT_FROM_PSN","DISCONNECT_FROM_KONAMI","DISCONNECT_FROM_NETWORK"}e.TYPE_DISCONNECT_P2P_LIST={"SESSION_DISCONNECT_FROM_HOST","SESSION_JOIN_FAILED"}e.OnEndExceptionDialog={}e.mgoInvitationUpdateCount=0
e.fadingCountForDisconnection=0
function e.IsDisabledMgoInChinaKorea()if(TppGameSequence.GetShortTargetArea()=="ck")then
if(not TppGameSequence.IsMgoEnabled())then
return true
end
end
return false
end
e.SHOW_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=function()e.mgoInvitationUpdateCount=0
e.mgoInvitationPopupId=nil
if e.IsDisabledMgoInChinaKorea()then
return 5013
elseif TppStory.CanPlayMgo()then
if e.GetCurrentGameMode()==e.GAME_MODE.TPP_FOB then
e.mgoInvitationPopupId=e.MGO_INVITATION_CANCEL_POPUP_ID
return e.MGO_INVITATION_CANCEL_POPUP_ID
else
return 5001,Popup.TYPE_TWO_BUTTON,nil,true
end
else
return 5004
end
end,[e.TYPE.DISCONNECT_FROM_PSN]=function()return TppDefine.ERROR_ID.DISCONNECT_FROM_PSN
end,[e.TYPE.DISCONNECT_FROM_KONAMI]=function()return TppDefine.ERROR_ID.DISCONNECT_FROM_KONAMI
end,[e.TYPE.DISCONNECT_FROM_NETWORK]=function()return TppDefine.ERROR_ID.DISCONNECT_FROM_NETWORK
end,[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=function()if e.GetCurrentGameMode()=="TPP"then
return TppDefine.ERROR_ID.DISCONNECT_FROM_NETWORK
end
return TppDefine.ERROR_ID.SESSION_ABANDON
end,[e.TYPE.SESSION_JOIN_FAILED]=function()return TppDefine.ERROR_ID.FAILED_JOIN_SESSION
end,[e.TYPE.SIGNIN_USER_CHANGED]=function()return TppDefine.ERROR_ID.SIGNIN_USER_CHANGED
end,[e.TYPE.INVITATION_PATCH_DLC_CHECKING]=function()return 5100,false,"POPUP_TYPE_NO_BUTTON_NO_EFFECT",nil
end,[e.TYPE.INVITATION_PATCH_DLC_ERROR]=function()return 5103
end,[e.TYPE.INVITATION_ACCEPT_BY_OTHER]=function()return 5005
end,[e.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN]=function()return 5012
end,[e.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=function()return TppDefine.ERROR_ID.NOW_INSTALLING,Popup.TYPE_ONE_CANCEL_BUTTON
end}function e.NoProcessOnEndExceptionDialog()if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if not Tpp.IsMaster()then
local n=e.TYPE[gvars.exc_processingExecptionType]local n=e.GetCurrentGameMode()local e=e.GAME_MODE[n]end
return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionForDisconnectDialog()local n=vars.missionCode
if n==TppDefine.SYS_MISSION_ID.INIT then
return e.PROCESS_STATE.FINISH
end
if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if TppSave.IsSaving()then
return e.PROCESS_STATE.SUSPEND
end
if e.fadingCountForDisconnection==0 then
TppUI.SetFadeColorToBlack()TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnEndExceptionDialogForDisconnect",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})end
e.fadingCountForDisconnection=e.fadingCountForDisconnection+1
if e.fadingCountForDisconnection<3 then
return e.PROCESS_STATE.SUSPEND
end
FadeFunction.SetFadeCallEnable(false)TppVideoPlayer.StopVideo()TppUI.FinishLoadingTips()SsdUiSystem.RequestForceClose()SignIn.SetStartupProcessCompleted(false)SubtitlesCommand.SetIsEnabledUiPrioStrong(false)TppRadio.StopForException()TppMusicManager.StopMusicPlayer(1)TppMusicManager.EndSceneMode()TppRadioCommand.SetEnableIgnoreGamePause(false)GkEventTimerManager.StopAll()StageBlockCurrentPositionSetter.SetEnable(false)TppQuest.OnMissionGameEnd()SsdFlagMission.OnMissionGameEnd()SsdBaseDefense.OnMissionGameEnd()TppScriptBlock.UnloadAll()Mission.AddFinalizer(function()TppMission.DisablePauseForShowResult()FadeFunction.SetFadeCallEnable(true)TppUI.SetFadeColorToBlack()gvars.waitLoadingTipsEnd=false
end)TppSimpleGameSequenceSystem.Start()TppMission.ReturnToTitleForException()return e.PROCESS_STATE.FINISH
end
function e.CanExceptionHandlingForFromHost()if not gvars.canExceptionHandling then
return false
end
return true
end
function e.OnEndExceptionForFromHost()if not e.CanExceptionHandlingForFromHost()then
return e.PROCESS_STATE.SUSPEND
end
if TppMission.IsMultiPlayMission(vars.missionCode)then
local e=TppNetworkUtil.IsHost()if e then
TppMission.AbandonMission()else
if Mission.IsHostMigrationActive()then
else
TppMission.AbandonMission()end
end
end
TppMission.SetInvitationStart(false)return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionDialogForSignInUserChange()if not TppSequence.CanHandleSignInUserChangedException()then
return e.PROCESS_STATE.FINISH
end
TppUI.FinishLoadingTips()TppRadio.playingBlackTelInfo=nil
if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if TppSave.IsSaving()then
return e.PROCESS_STATE.SUSPEND
end
if TppUiCommand.IsShowPopup()then
TppUiCommand.ErasePopup()end
if e.fadingCountForDisconnection==0 then
TppUI.SetFadeColorToBlack()TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnEndExceptionDialogForSignInUserChange",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})end
e.fadingCountForDisconnection=e.fadingCountForDisconnection+1
if e.fadingCountForDisconnection<3 then
return e.PROCESS_STATE.SUSPEND
end
FadeFunction.SetFadeCallEnable(false)TppVideoPlayer.StopVideo()if not Tpp.IsMaster()then
gvars.dbg_forceMaster=true
end
gvars.isLoadedInitMissionOnSignInUserChanged=true
SignIn.SetStartupProcessCompleted(false)TppUiCommand.SetLoadIndicatorVisible(true)SsdUiSystem.RequestForceClose()StageBlockCurrentPositionSetter.SetEnable(false)SubtitlesCommand.SetIsEnabledUiPrioStrong(false)TppRadio.Stop()TppMusicManager.StopMusicPlayer(1)TppMusicManager.EndSceneMode()TppRadioCommand.SetEnableIgnoreGamePause(false)GkEventTimerManager.StopAll()TppQuest.OnMissionGameEnd()SsdFlagMission.OnMissionGameEnd()SsdBaseDefense.OnMissionGameEnd()TppScriptBlock.UnloadAll()Mission.AddFinalizer(function()e.waitPatchDlcCheckCoroutine=nil
TppSave.missionStartSaveFilePool=nil
TppMission.DisablePauseForShowResult()FadeFunction.SetFadeCallEnable(true)TppUI.SetFadeColorToBlack()gvars.isLoadedInitMissionOnSignInUserChanged=false
gvars.waitLoadingTipsEnd=false
end)TppVarInit.StartInitMission()return e.PROCESS_STATE.FINISH
end
function e.UpdateMgoInvitationAccept()if(e.currentErrorPopupLangId==e.MGO_INVITATION_CANCEL_POPUP_ID)then
e.mgoInvitationUpdateCount=e.mgoInvitationUpdateCount+Time.GetFrameTime()if e.mgoInvitationUpdateCount>e.CLOSE_INIVITATION_CANCEL_POPUP_INTERVAL then
TppUiCommand.ErasePopup()end
end
end
function e.OnEndExceptionDialogForMgoInvitationAccept()if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if e.IsDisabledMgoInChinaKorea()then
e.CancelMgoInvitation()return e.PROCESS_STATE.FINISH
end
if not TppStory.CanPlayMgo()then
e.CancelMgoInvitation()return e.PROCESS_STATE.FINISH
end
if(e.mgoInvitationPopupId==e.MGO_INVITATION_CANCEL_POPUP_ID)then
e.CancelMgoInvitation()return e.PROCESS_STATE.FINISH
end
if TppSave.IsSaving()then
if DebugText then
local e=DebugText.NewContext()DebugText.Print(e,{.5,.5,1},"TppException : Wating saving process.")end
return e.PROCESS_STATE.SUSPEND
end
local n=TppUiCommand.GetPopupSelect()if n==Popup.SELECT_OK then
PatchDlc.StartCheckingPatchDlc()if PatchDlc.IsCheckingPatchDlc()then
local n=e.GetCurrentGameMode()e.Enqueue(e.TYPE.INVITATION_PATCH_DLC_CHECKING,n)else
if PatchDlc.DoesExistPatchDlc()then
e.CheckMgoChunkInstallation()else
local n=e.GetCurrentGameMode()e.Enqueue(e.TYPE.INVITATION_PATCH_DLC_ERROR,n)end
end
else
e.CancelMgoInvitation()end
return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionDialogForPatchDlcCheck()if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if TppSave.IsSaving()then
return e.PROCESS_STATE.SUSPEND
end
if PatchDlc.DoesExistPatchDlc()then
e.CheckMgoChunkInstallation()else
local n=e.GetCurrentGameMode()e.Enqueue(e.TYPE.INVITATION_PATCH_DLC_ERROR,n)end
return e.PROCESS_STATE.FINISH
end
function e.CheckMgoChunkInstallation()if Chunk.GetChunkState(Chunk.INDEX_MGO)==Chunk.STATE_INSTALLED then
e.GoToMgoByInivitaion()else
Tpp.StartWaitChunkInstallation(Chunk.INDEX_MGO)local n=e.GetCurrentGameMode()e.Enqueue(e.TYPE.WAIT_MGO_CHUNK_INSTALLATION,n)end
end
function e.GoToMgoByInivitaion()TppPause.RegisterPause"GoToMGO"TppGameStatus.Set("GoToMGO","S_DISABLE_PLAYER_PAD")e.isNowGoingToMgo=true
e.fadeOutRemainTimeForGoToMgo=TppUI.FADE_SPEED.FADE_HIGHSPEED
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,"GoToMgoByInivitaion",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})FadeFunction.SetFadeCallEnable(false)end
function e.UpdateMgoChunkInstallingPopup()Tpp.ShowChunkInstallingPopup(Chunk.INDEX_MGO,true)if Chunk.GetChunkState(Chunk.INDEX_MGO)==Chunk.STATE_INSTALLED then
TppUiCommand.ErasePopup()end
end
function e.OnEndExceptionDialogForPatchDlcError()if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
Tpp.ClearDidCancelPatchDlcDownloadRequest()e.CancelMgoInvitation()return e.PROCESS_STATE.FINISH
end
function e.UpdateMgoPatchDlcCheckingPopup()if PatchDlc.IsCheckingPatchDlc()then
TppUI.ShowAccessIconContinue()return
end
TppUiCommand.ErasePopup()end
function e.OnEndExceptionDialogForInvitationAcceptFromOther()if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if not Tpp.IsMaster()then
local n=e.TYPE[gvars.exc_processingExecptionType]local n=e.GetCurrentGameMode()local e=e.GAME_MODE[n]end
e.CancelMgoInvitation()return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionDialogForInvitationAcceptWithoutSignIn()if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if not Tpp.IsMaster()then
local n=e.TYPE[gvars.exc_processingExecptionType]local n=e.GetCurrentGameMode()local e=e.GAME_MODE[n]end
e.CancelMgoInvitation()return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionDialogForCheckMgoChunkInstallation()if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if Chunk.GetChunkState(Chunk.INDEX_MGO)==Chunk.STATE_INSTALLED then
e.GoToMgoByInivitaion()else
e.CancelMgoInvitation()end
return e.PROCESS_STATE.FINISH
end
function e.CancelMgoInvitation()InvitationManager.ResetAccept()InvitationManager.EnableMessage(true)if Chunk.GetChunkState(Chunk.INDEX_MGO)~=Chunk.STATE_INSTALLED then
Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)end
end
function e.CoopMissionEndOnException()return e.PROCESS_STATE.FINISH
end
e.POPUP_CLOSE_CHECK_FUNC={[e.TYPE.INVITATION_ACCEPT]=e.UpdateMgoInvitationAccept,[e.TYPE.INVITATION_PATCH_DLC_CHECKING]=e.UpdateMgoPatchDlcCheckingPopup,[e.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=e.UpdateMgoChunkInstallingPopup}e.TPP_ON_END_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=e.OnEndExceptionDialogForMgoInvitationAccept,[e.TYPE.DISCONNECT_FROM_PSN]=e.OnEndExceptionForDisconnectDialog,[e.TYPE.DISCONNECT_FROM_KONAMI]=e.OnEndExceptionForDisconnectDialog,[e.TYPE.DISCONNECT_FROM_NETWORK]=e.OnEndExceptionForDisconnectDialog,[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=e.OnEndExceptionForFromHost,[e.TYPE.SESSION_JOIN_FAILED]=e.OnEndExceptionForFromHost,[e.TYPE.SIGNIN_USER_CHANGED]=e.OnEndExceptionDialogForSignInUserChange,[e.TYPE.INVITATION_PATCH_DLC_CHECKING]=e.OnEndExceptionDialogForPatchDlcCheck,[e.TYPE.INVITATION_PATCH_DLC_ERROR]=e.OnEndExceptionDialogForPatchDlcError,[e.TYPE.INVITATION_ACCEPT_BY_OTHER]=e.OnEndExceptionDialogForInvitationAcceptFromOther,[e.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN]=e.OnEndExceptionDialogForInvitationAcceptWithoutSignIn,[e.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=e.OnEndExceptionDialogForCheckMgoChunkInstallation}function e.RegisterOnEndExceptionDialog(n,t)e.OnEndExceptionDialog[n]=t
end
e.RegisterOnEndExceptionDialog(e.GAME_MODE.TPP,e.TPP_ON_END_EXECPTION_DIALOG)function e.GetCurrentGameMode()return e.GAME_MODE.TPP
end
function e.Enqueue(n,t)if not e.TYPE[n]then
return
end
local o=gvars.exc_exceptionQueueDepth
local i=gvars.exc_exceptionQueueDepth+1
if i>=TppDefine.EXCEPTION_QUEUE_MAX then
return
end
if(gvars.exc_processingExecptionType==n)then
return
end
if e.HasQueue(n,t)then
return
end
gvars.exc_exceptionQueueDepth=i
gvars.exc_exceptionQueue[o]=n
gvars.exc_queueGameMode[o]=t
end
function e.Dequeue(e)local e=e or 0
if e>gvars.exc_exceptionQueueDepth then
return
end
local t=gvars.exc_exceptionQueue[e]local o=gvars.exc_queueGameMode[e]local n=gvars.exc_exceptionQueueDepth
for e=e,(n-1)do
gvars.exc_exceptionQueue[e]=gvars.exc_exceptionQueue[e+1]gvars.exc_queueGameMode[e]=gvars.exc_queueGameMode[e+1]end
gvars.exc_exceptionQueue[n]=0
gvars.exc_queueGameMode[n]=0
gvars.exc_exceptionQueueDepth=n-1
return t,o
end
function e.HasQueue(n,e)for t=0,gvars.exc_exceptionQueueDepth do
if n==nil then
return true
end
if(gvars.exc_exceptionQueue[t]==n)and((e==nil)or(gvars.exc_queueGameMode[t]==e))then
return true
end
end
return false
end
function e.StartProcess(n,t)gvars.exc_processState=e.PROCESS_STATE.START
gvars.exc_processingExecptionType=n
gvars.exc_processingExecptionGameMode=t
e.EnablePause()end
function e.FinishProcess()gvars.exc_processState=e.PROCESS_STATE.EMPTY
gvars.exc_processingExecptionType=0
gvars.exc_processingExecptionGameMode=0
e.DisablePause()end
function e.EnablePause()TppPause.RegisterPause"TppException.lua"TppGameStatus.Set("TppException","S_DISABLE_PLAYER_PAD")end
function e.DisablePause()TppPause.UnregisterPause"TppException.lua"TppGameStatus.Reset("TppException","S_DISABLE_PLAYER_PAD")end
e.currentErrorPopupLangId=nil
local n=false
function e.Update()if not gvars then
return
end
if e.isNowGoingToMgo then
if DebugText then
DebugText.Print(DebugText.NewContext(),{.5,.5,1},"TppException : Now going to mgo by invitation")end
if e.fadeOutRemainTimeForGoToMgo~=nil then
if e.fadeOutRemainTimeForGoToMgo>0 then
e.fadeOutRemainTimeForGoToMgo=e.fadeOutRemainTimeForGoToMgo-Time.GetFrameTime()else
if not n then
n=true
Mission.SwitchApplication"mgo"end
end
end
return
end
if gvars.isLoadedInitMissionOnSignInUserChanged then
if DebugText then
DebugText.Print(DebugText.NewContext(),{.5,.5,1},"TppException : Now loaded for sign in user changed.")end
return
end
if gvars.exc_exceptionQueueDepth<=0 and(gvars.exc_processState<=e.PROCESS_STATE.EMPTY)then
return
end
if(gvars.exc_processState>e.PROCESS_STATE.EMPTY)then
local t=e.GetCurrentGameMode()if e.IsProcessing()then
gvars.exc_processState=e.PROCESS_STATE.SHOW_DIALOG
local n=e.POPUP_CLOSE_CHECK_FUNC[gvars.exc_processingExecptionType]if n then
n()end
if DebugText then
local n=DebugText.NewContext()DebugText.Print(n,{.5,.5,1},"TppException : Now execption proccessing. execptionType = "..(tostring(e.TYPE[gvars.exc_processingExecptionType])..(", gameMode = "..tostring(e.GAME_MODE[t]))))DebugText.Print(n,{.5,.5,1},"TppException : queueDepth = "..tostring(gvars.exc_exceptionQueueDepth))end
else
e.currentErrorPopupLangId=nil
local n=e.OnEndExceptionDialog[t]if not n then
e.FinishProcess()return
end
local n=n[gvars.exc_processingExecptionType]if not n then
e.FinishProcess()return
end
gvars.exc_processState=n()local n=gvars.exc_processState
if DebugText then
local o=DebugText.NewContext()DebugText.Print(o,{.5,.5,1},"TppException : Now execption proccessing. execptionType = "..(tostring(e.TYPE[gvars.exc_processingExecptionType])..(", gameMode = "..tostring(e.GAME_MODE[t]))))DebugText.Print(o,{.5,.5,1},"TppException : gvars.exc_processState = "..tostring(n))end
if n>e.PROCESS_STATE.SHOW_DIALOG then
e.DisablePause()end
if n==e.PROCESS_STATE.FINISH then
e.FinishProcess()end
end
else
local n,t=e.Dequeue()e.StartProcess(n,t)local n=e.ShowPopup(n)if not n then
e.FinishProcess()end
end
end
function e.ShowPopup(n)local n=e.SHOW_EXECPTION_DIALOG[n]if not n then
return
end
local n,t,o,i=n()if not n then
return
end
if t==nil then
t=Popup.TYPE_ONE_BUTTON
end
if o then
TppUiCommand.SetPopupType(o)end
if i then
TppUiCommand.SetPopupSelectNegative()end
TppUiCommand.ShowErrorPopup(n,t)e.currentErrorPopupLangId=n
return true
end
function e.OnAllocate(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
function e.OnReload(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
function e.Messages()return Tpp.StrCode32Table{Network={{msg="InvitationAccept",func=e.OnInvitationAccept},{msg="DisconnectFromPsn",func=e.OnDisconnectFromPsn},{msg="DisconnectFromKonami",func=e.OnDisconnectFromKonami},{msg="DisconnectFromNetwork",func=e.OnDisconnectFromNetwork},{msg="SignInUserChanged",func=e.SignInUserChanged},{msg="InvitationAcceptByOther",func=e.OnInvitationAcceptByOther},{msg="InvitationAcceptWithoutSignIn",func=e.OnInvitationAcceptWithoutSignIn},{msg="EndLogin",func=function()gvars.exc_skipServerSaveForException=false
gvars.exc_processingForDisconnect=false
end},{msg="SessionDisconnectFromHost",func=e.OnSessionDisconnectFromHost},{msg="FailedJoinSession",func=e.OnFailedJoinSession},{msg="NoPrivilegeMultiPlay",func=function()TppUiCommand.ShowErrorPopup(2310)end}},Nt={{msg="SessionDisconnectFromHost",func=e.OnSessionDisconnectFromHost},{msg="FailedJoinSession",func=e.OnFailedJoinSession},{msg="SessionDeleteMember",func=function()if TppServerManager.FobIsSneak()then
local e=4181
TppUiCommand.ShowErrorPopup(e)end
end}},Dlc={{msg="DlcStatusChanged",func=e.OnDlcStatusChanged}}}end
function e.OnInvitationAccept()local n=e.GetCurrentGameMode()e.Enqueue(e.TYPE.INVITATION_ACCEPT,n)e.Update()end
function e.OnDisconnectFromPsn()local n=e.GetCurrentGameMode()vars.invitationDisableRecieveFlag=1
e.DequeueP2PDisconnectException()e.Enqueue(e.TYPE.DISCONNECT_FROM_PSN,n)e._OnDisconnectNetworkCommon()e.Update()end
function e.OnDisconnectFromKonami()local n=e.GetCurrentGameMode()vars.invitationDisableRecieveFlag=1
e.DequeueP2PDisconnectException()e.Enqueue(e.TYPE.DISCONNECT_FROM_KONAMI,n)e._OnDisconnectNetworkCommon()e.Update()end
function e.OnDisconnectFromNetwork()local n=e.GetCurrentGameMode()vars.invitationDisableRecieveFlag=1
e.DequeueP2PDisconnectException()e.Enqueue(e.TYPE.DISCONNECT_FROM_NETWORK,n)e._OnDisconnectNetworkCommon()e.Update()end
function e.OnSessionDisconnectFromHost()local n=TppNetworkUtil.IsHost()if n then
TppMission.AbandonMission()return
end
e._OnP2PDisconnect(e.TYPE.SESSION_DISCONNECT_FROM_HOST)e.Update()end
function e.OnFailedJoinSession()e._OnP2PDisconnect(e.TYPE.SESSION_JOIN_FAILED)e.Update()end
function e._OnP2PDisconnect(o)if e.IsSkipDisconnectFromHost()then
return
end
if TppGameMode.GetUserMode()~=TppGameMode.U_KONAMI_LOGIN then
return
end
local n=e.GetCurrentGameMode()for o,t in ipairs(e.TYPE_DISCONNECT_NETWORK_LIST)do
if gvars.exc_processingExecptionType==t then
return
elseif e.HasQueue(t,n)then
return
end
end
e.Enqueue(o,n)end
function e.SignInUserChanged()if not TppSequence.CanHandleSignInUserChangedException()then
return
end
InvitationManager.EnableMessage(false)gvars.exc_skipServerSaveForException=true
gvars.exc_processingForDisconnect=true
e.fadingCountForDisconnection=0
local n=e.GetCurrentGameMode()e.Enqueue(e.TYPE.SIGNIN_USER_CHANGED,n)e.Update()end
function e.OnInvitationAcceptByOther()local n=e.GetCurrentGameMode()e.Enqueue(e.TYPE.INVITATION_ACCEPT_BY_OTHER,n)e.Update()end
function e.OnInvitationAcceptWithoutSignIn()local n=e.GetCurrentGameMode()e.Enqueue(e.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN,n)e.Update()end
function e.OnDlcStatusChanged()if vars.missionCode==TppDefine.SYS_MISSION_ID.INIT then
return
end
local e=8014
if gvars.ini_isTitleMode then
e=8013
end
if TppUiCommand.IsShowPopup(e)then
else
TppUiCommand.ShowErrorPopup(e,Popup.TYPE_ONE_BUTTON)end
end
function e._OnDisconnectNetworkCommon()if IS_GC_2017_COOP then
TppMission.DisconnectMatching(false)end
Mission.HostMigration_SetActive(false)if gvars.canExceptionHandling then
SsdMatching.RequestDisconnect()end
gvars.exc_skipServerSaveForException=true
gvars.exc_processingForDisconnect=true
e.fadingCountForDisconnection=0
end
function e.DequeueWithType(o)local t=gvars.exc_exceptionQueueDepth
local n=0
while n<t do
if gvars.exc_exceptionQueue[n]==o then
e.Dequeue(n)t=gvars.exc_exceptionQueueDepth
else
n=n+1
end
end
end
function e.HasQueueNetworkDisconnect()local t=e.GetCurrentGameMode()for o,n in ipairs(e.TYPE_DISCONNECT_NETWORK_LIST)do
if gvars.exc_processingExecptionType==n then
return true
elseif e.HasQueue(n,t)then
return true
end
end
return false
end
function e.SetSkipDisconnectFromHost()gvars.exc_skipDisconnectFromHostException=true
end
function e.ResetSkipDisconnectFromHost()gvars.exc_skipDisconnectFromHostException=false
end
function e.IsSkipDisconnectFromHost()return gvars.exc_skipDisconnectFromHostException
end
function e.DequeueP2PDisconnectException()for t,n in ipairs(e.TYPE_DISCONNECT_P2P_LIST)do
e.DequeueWithType(e.TYPE[n])end
end
function e.IsProcessing()return e.currentErrorPopupLangId and TppUiCommand.IsShowPopup(e.currentErrorPopupLangId)end
local n={}function n.Update()e.Update()end
function n:OnMessage(a,i,n,t,o,c)local r
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOptionWhileLoading,a,i,n,t,o,c,r)end
ScriptUpdater.Create("exceptionMessageHandler",n,{"Network","Nt","UI","Dlc"})return e