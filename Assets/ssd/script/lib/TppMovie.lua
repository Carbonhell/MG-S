local e={}local u=Fox.StrCode32
local t=Tpp.IsTypeFunc
local o=Tpp.IsTypeTable
local a=Tpp.IsTypeString
e.CallbackFunctionTable={}function e.Play(n)if not o(n)then
return
end
local o=n.videoName
if not a(o)then
return
end
local r=n.subtitleName or""local s=false
if n.isLoop then
s=true
end
local i=false
if n.isNoFade then
i=n.isNoFade
end
local a=n.onStart
if a then
if not t(a)then
return
end
end
local d=n.onEnd
if d then
if not t(d)then
return
end
end
local l
if n.onEndFadeOut and t(n.onEndFadeOut)then
l=n.onEndFadeOut
end
local t=n.memoryPool
if not t then
end
local n=u(o)e.CallbackFunctionTable[n]={videoName=o,onStart=a,onEnd=d}local o=TppVideoPlayer.LoadVideo{VideoName=o,SubtitleName=r,MemoryPool=t,Loop=s}TppSoundDaemon.SetMute"Result"mvars.mov_isNoFade=i
mvars.mov_onEndFadeOut=l
mvars.mov_checkEndFadeOut=nil
if not o then
TppVideoPlayer.PlayVideo()else
e.DoMessage(n,"onStart")e.DoMessage(n,"onEnd")end
end
e.CommonDoMessage={}function e.CommonDoMessage.onStart()e._OnStartCommon()end
function e.CommonDoMessage.onEnd()e._OnEndCommon()end
function e.Stop()TppVideoPlayer.StopVideo()e._OnEndCommon()end
function e.DoMessage(n,o)local n=e.CallbackFunctionTable[n]if not n then
return
end
local a=n.videoName
e.CommonDoMessage[o]()local e=n[o]if e then
e()end
end
function e.OnEndFadeOut()if mvars.mov_onEndFadeOut then
mvars.mov_onEndFadeOut()end
end
function e._OnStartCommon()local e={}for n,o in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
e[n]=false
end
for n,o in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
e[n]=false
end
e.PauseMenu=nil
if not mvars.mov_isNoFade then
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_MOMENT,"FadeInForMovieStart",TppUI.FADE_PRIORITY.DEMO,{exceptGameStatus=e})end
TppUiStatusManager.ClearStatus"PauseMenu"Player.SetPause()end
function e._OnEndCommon()if not mvars.mov_isNoFade then
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutForMovieEnd",TppUI.FADE_PRIORITY.DEMO)end
Player.UnsetPause()TppSoundDaemon.ResetMute"Result"end
return e