local e={}local r=Fox.StrCode32
local t=type
local C=GameObject.GetGameObjectId
local p=GameObject.GetTypeIndex
local b=TppGameObject.GAME_OBJECT_TYPE_PLAYER2
local D=TppGameObject.GAME_OBJECT_TYPE_COMMAND_POST2
local S=TppGameObject.GAME_OBJECT_TYPE_KAIJU
local I=TppGameObject.GAME_OBJECT_TYPE_BOSS_1
local G=TppGameObject.GAME_OBJECT_TYPE_BOSS_2
local E=TppGameObject.GAME_OBJECT_TYPE_BOSS_3
local A=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local h=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2
local P=TppGameObject.GAME_OBJECT_TYPE_HELI2
local m=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI
local O=TppGameObject.GAME_OBJECT_TYPE_HORSE2
local g=TppGameObject.GAME_OBJECT_TYPE_VEHICLE
local M=TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2
local y=TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2
local N=TppGameObject.GAME_OBJECT_TYPE_VOLGIN2
local Y=TppGameObject.GAME_OBJECT_TYPE_MARKER2_LOCATOR
local k=TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2
local U=TppGameObject.GAME_OBJECT_TYPE_PARASITE2
local L=TppGameObject.GAME_OBJECT_TYPE_SECURITYCAMERA2
local f=TppGameObject.GAME_OBJECT_TYPE_UAV
local B=TppGameObject.PHASE_ALERT
local a=GameObject.NULL_ID
local n=bit.bnot
local n,n,n=bit.band,bit.bor,bit.bxor
e.requires={"/Assets/ssd/script/lib/TppDefine.lua","/Assets/ssd/script/list/SsdStorySequenceList.lua","/Assets/ssd/script/list/SsdStorySequenceRewardList.lua","/Assets/ssd/script/list/SsdCrewList.lua","/Assets/ssd/script/list/SsdRecipeList.lua","/Assets/ssd/script/list/SsdMissionList.lua","/Assets/ssd/script/list/SsdCreatureList.lua","/Assets/ssd/script/list/SsdFastTravelPointList.lua","/Assets/ssd/script/list/SsdWaterPumpList.lua","/Assets/ssd/script/lib/TppMath.lua","/Assets/ssd/script/lib/TppSave.lua","/Assets/ssd/script/lib/TppLocation.lua","/Assets/ssd/script/lib/TppSequence.lua","/Assets/ssd/script/lib/TppWeather.lua","/Assets/ssd/script/lib/TppDbgStr32.lua","/Assets/ssd/script/lib/TppDebug.lua","/Assets/ssd/script/lib/TppClock.lua","/Assets/ssd/script/lib/TppUI.lua","/Assets/ssd/script/lib/TppResult.lua","/Assets/ssd/script/lib/TppSound.lua","/Assets/ssd/script/lib/TppTerminal.lua","/Assets/ssd/script/lib/TppMarker.lua","/Assets/ssd/script/lib/TppRadio.lua","/Assets/ssd/script/lib/TppPlayer.lua","/Assets/ssd/script/lib/TppScriptBlock.lua","/Assets/ssd/script/lib/TppMission.lua","/Assets/ssd/script/lib/TppStory.lua","/Assets/ssd/script/lib/TppDemo.lua","/Assets/ssd/script/lib/TppCrew.lua","/Assets/ssd/script/lib/TppEnemy.lua","/Assets/ssd/script/lib/TppGimmick.lua","/Assets/ssd/script/lib/TppMain.lua","/Assets/ssd/script/lib/TppDemoBlock.lua","/Assets/ssd/script/lib/TppAnimalBlock.lua","/Assets/ssd/script/lib/TppCheckPoint.lua","/Assets/ssd/script/lib/TppPackList.lua","/Assets/ssd/script/lib/TppQuest.lua","/Assets/ssd/script/lib/TppTrap.lua","/Assets/ssd/script/lib/TppReward.lua","/Assets/ssd/script/lib/TppReinforceBlock.lua","/Assets/ssd/script/lib/TppEneFova.lua","/Assets/ssd/script/lib/TppTelop.lua","/Assets/ssd/script/lib/TppRatBird.lua","/Assets/ssd/script/lib/TppMovie.lua","/Assets/ssd/script/lib/TppAnimal.lua","/Assets/ssd/script/lib/TppException.lua","/Assets/ssd/script/lib/TppTutorial.lua","/Assets/ssd/script/lib/TppRanking.lua","/Assets/ssd/script/lib/TppTrophy.lua","/Assets/ssd/script/lib/SsdFlagMission.lua","/Assets/ssd/script/lib/SsdBaseDefense.lua","/Assets/ssd/script/lib/SsdCreatureBlock.lua","/Assets/ssd/script/lib/SsdRecipe.lua","/Assets/ssd/script/lib/SsdFastTravel.lua","/Assets/ssd/script/mission/flag/BaseFlagMission.lua","/Assets/ssd/script/mission/quest/BaseQuest.lua","/Assets/ssd/script/mission/quest/AnnihilationQuest.lua","/Assets/ssd/script/mission/quest/DefenseQuest.lua","/Assets/ssd/script/mission/quest/RescueQuest.lua","/Assets/ssd/script/mission/quest/CollectionQuest.lua","/Assets/ssd/script/mission/quest/AnimalQuest.lua","/Assets/ssd/script/mission/quest/BossQuest.lua","/Assets/ssd/script/mission/quest/ExtraDiggingQuest.lua","/Assets/ssd/script/mission/quest/VehicleQuest.lua","/Assets/ssd/script/mission/common/BaseMissionSequence.lua","/Assets/ssd/script/mission/common/BaseMissionRadio.lua","/Assets/ssd/script/mission/free/BaseFreeMissionSequence.lua","/Assets/ssd/script/mission/free/BaseFreeMissionEnemy.lua","/Assets/ssd/script/mission/free/BaseFreeMissionRadio.lua","/Assets/ssd/script/mission/free/BaseFreeMissionDemo.lua","/Assets/ssd/script/mission/coop/BaseCoopMissionSequence.lua","/Assets/ssd/script/mission/coop/BaseCoopMissionEnemy.lua","/Assets/ssd/script/mission/coop/BaseCoopMissionRadio.lua","/Assets/ssd/script/mission/defense/BaseBaseDigging.lua"}function e.IsTypeFunc(e)return t(e)=="function"end
local T=e.IsTypeFunc
function e.IsTypeTable(e)return t(e)=="table"end
local l=e.IsTypeTable
function e.IsTypeString(e)return t(e)=="string"end
local n=e.IsTypeString
function e.IsTypeNumber(e)return t(e)=="number"end
local n=e.IsTypeNumber
function e.Enum(e)if e==nil then
return
end
if#e==0 then
return e
end
for n=1,#e do
e[e[n]]=n
end
return e
end
function e.IsMaster()if TppGameSequence.IsMaster()then
return true
else
if gvars and gvars.dbg_forceMaster then
return true
else
return false
end
end
end
function e.IsQARelease()return(Fox.GetDebugLevel()==Fox.DEBUG_LEVEL_QA_RELEASE)end
function e.IsEditor()if(Fox.GetPlatformName()=="Windows")and Editor then
return true
end
return false
end
function e.IsEditorNoLogin()if not e.IsEditor()then
return false
end
if not TppServerManager.IsLoginKonami()then
return true
end
return false
end
function e.SplitString(e,s)local t={}local n
local e=e
while true do
n=string.find(e,s)if(n==nil)then
table.insert(t,e)break
else
local s=string.sub(e,0,n-1)table.insert(t,s)e=string.sub(e,n+1)end
end
return t
end
function e.StrCode32Table(n)local s={}for n,i in pairs(n)do
local n=n
if t(n)=="string"then
n=r(n)end
if t(i)=="table"then
s[n]=e.StrCode32Table(i)else
s[n]=i
end
end
return s
end
function e.ApendArray(e,n)for t,n in pairs(n)do
e[#e+1]=n
end
end
function e.MergeTable(s,e,n)local n=s
for e,t in pairs(e)do
if s[e]==nil then
n[e]=t
else
n[e]=t
end
end
return n
end
function e.BfsPairs(r)local i,n,s={r},1,1
local function a(t,e)local e,t=e,nil
while true do
e,t=next(i[n],e)if l(t)then
s=s+1
i[s]=t
end
if e then
return e,t
else
n=n+1
if n>s then
return
end
end
end
end
return a,r,nil
end
e._DEBUG_svars={}e._DEBUG_gvars={}function e.MakeMessageExecTable(n)if n==nil then
return
end
if next(n)==nil then
return
end
local e={}local f=r"msg"local p=r"func"local u=r"sender"local _=r"option"for n,s in pairs(n)do
e[n]=e[n]or{}for s,i in pairs(s)do
local s,d,c,o=s,nil,nil,nil
if T(i)then
c=i
elseif l(i)and T(i[p])then
s=r(i[f])local e={}if(t(i[u])=="string")or(t(i[u])=="number")then
e[1]=i[u]elseif l(i[u])then
e=i[u]end
d={}for s,e in pairs(e)do
if t(e)=="string"then
if n==r"GameObject"then
d[s]=C(e)if msgSndr==a then
end
else
d[s]=r(e)end
elseif t(e)=="number"then
d[s]=e
end
end
c=i[p]o=i[_]end
if c then
e[n][s]=e[n][s]or{}if next(d)~=nil then
for i,t in pairs(d)do
e[n][s].sender=e[n][s].sender or{}e[n][s].senderOption=e[n][s].senderOption or{}if e[n][s].sender[t]then
end
e[n][s].sender[t]=c
if o and l(o)then
e[n][s].senderOption[t]=o
end
end
else
if e[n][s].func then
end
e[n][s].func=c
if o and l(o)then
e[n][s].option=o
end
end
end
end
end
return e
end
function e.DoMessage(n,s,t,r,a,o,d,l,i)if not n then
return
end
local n=n[t]if not n then
return
end
local n=n[r]if not n then
return
end
local t=true
e.DoMessageAct(n,s,a,o,d,l,i,t)end
function e.DoMessageAct(n,l,e,i,s,r,t)if n.func then
if l(n.option)then
n.func(e,i,s,r)end
end
local t=n.sender
if t and t[e]then
if l(n.senderOption[e])then
t[e](e,i,s,r)end
end
end
function e.GetRotationY(e)if not e then
return
end
if(t(e.Rotate)=="function")then
local e=e:Rotate(Vector3(0,0,1))local e=foxmath.Atan2(e:GetX(),e:GetZ())return TppMath.RadianToDegree(e)end
end
function e.GetLocator(n,t)local n,t=e.GetLocatorByTransform(n,t)if n~=nil then
return TppMath.Vector3toTable(n),e.GetRotationY(t)else
return nil
end
end
function e.GetLocatorByTransform(n,t)local e=e.GetDataWithIdentifier(n,t,"TransformData")if e==nil then
return
end
local e=e.worldTransform
return e.translation,e.rotQuat
end
function e.GetDataWithIdentifier(e,n,t)local e=DataIdentifier.GetDataWithIdentifier(e,n)if e==NULL then
return
end
if(e:IsKindOf(t)==false)then
return
end
return e
end
function e.GetDataBodyWithIdentifier(e,t,n)local e=DataIdentifier.GetDataBodyWithIdentifier(e,t)if(e.data==nil)then
return
end
if(e.data:IsKindOf(n)==false)then
return
end
return e
end
function e.SetGameStatus(n)if not l(n)then
return
end
local s=n.enable
local t=n.scriptName
local e=n.target
local n=n.except
if s==nil then
return
end
if e=="all"then
e={}for t,n in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
e[t]=n
end
for t,n in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
e[t]=n
end
elseif l(e)then
e=e
else
return
end
if l(n)then
for n,t in pairs(n)do
e[n]=t
end
end
if s then
for n,s in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
if e[n]then
TppGameStatus.Reset(t,n)end
end
for n,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
local t=e[n]local e=mvars.ui_unsetUiSetting
if l(e)and e[n]then
TppUiStatusManager.UnsetStatus(n,e[n])else
if t then
TppUiStatusManager.ClearStatus(n)end
end
end
else
for n,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
local e=e[n]if e then
TppUiStatusManager.SetStatus(n,e)else
TppUiStatusManager.ClearStatus(n)end
end
for n,s in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
local e=e[n]if e then
TppGameStatus.Set(t,n)end
end
end
end
function e.GetAllDisableGameStatusTable()local e={}for n,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
e[n]=false
end
for n,t in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
e[n]=false
end
return e
end
function e.GetHelicopterStartExceptGameStatus()local e={}e.EquipPanel=false
e.AnnounceLog=false
e.HeadMarker=false
e.WorldMarker=false
return e
end
local function n(e,n)if e==nil then
return
end
if e==a then
return
end
local e=p(e)if e==n then
return true
else
return false
end
end
function e.IsPlayer(e)return n(e,b)end
function e.IsLocalPlayer(e)if e==PlayerInfo.GetLocalPlayerIndex()then
return true
else
return false
end
end
function e.IsCommandPost(e)return n(e,D)end
function e.IsKaiju(e)return n(e,S)end
function e.IsBoss1(e)return n(e,I)end
function e.IsBoss2(e)return n(e,G)end
function e.IsBoss3(e)return n(e,E)end
function e.IsZombie(e)return n(e,A)end
function e.IsSoldier(e)return n(e,h)end
function e.IsHostage(e)if e==nil then
return
end
if e==a then
return
end
local e=p(e)return TppDefine.HOSTAGE_GM_TYPE[e]end
function e.IsVolgin(e)return n(e,N)end
function e.IsHelicopter(e)return n(e,P)end
function e.IsEnemyHelicopter(e)return n(e,m)end
function e.IsHorse(e)return n(e,O)end
function e.IsVehicle(e)return n(e,g)end
function e.IsPlayerWalkerGear(e)return n(e,M)end
function e.IsEnemyWalkerGear(e)return n(e,y)end
function e.IsUav(e)return n(e,f)end
function e.IsFultonContainer(e)return n(e,TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER)end
function e.IsMortar(e)return n(e,TppGameObject.GAME_OBJECT_TYPE_MORTAR)end
function e.IsGatlingGun(e)return n(e,TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN)end
function e.IsMachineGun(e)return n(e,TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN)end
function e.IsFultonableGimmick(e)if e==nil then
return
end
if e==a then
return
end
local e=p(e)return TppDefine.FULTONABLE_GIMMICK_TYPE[e]end
function e.GetBuddyTypeFromGameObjectId(e)if e==nil then
return
end
if e==a then
return
end
local e=p(e)return TppDefine.BUDDY_GM_TYPE_TO_BUDDY_TYPE[e]end
function e.IsMarkerLocator(e)return n(e,Y)end
function e.IsAnimal(e)if e==nil then
return
end
if e==a then
return
end
local e=p(e)return TppDefine.ANIMAL_GAMEOBJECT_TYPE[e]end
function e.IsBossQuiet(e)return n(e,k)end
function e.IsParasiteSquad(e)return n(e,U)end
function e.IsSecurityCamera(e)return n(e,L)end
function e.IsGunCamera(n)if n==a then
return false
end
local t={id="IsGunCamera"}local e=false
e=GameObject.SendCommand(n,t)return e
end
function e.IsUAV(e)return n(e,f)end
function e.IncrementPlayData(e)if gvars[e]==nil then
return
end
if gvars[e]<TppDefine.MAX_32BIT_UINT then
gvars[e]=gvars[e]+1
end
end
function e.IsNotAlert()if vars.playerPhase<B then
return true
else
return false
end
end
function e.IsPlayerStatusNormal()local e=vars
if e.playerLife>0 and e.playerStamina>0 then
return true
else
return false
end
end
function e.AreaToIndices(e)local n,t,i,s=e[1],e[2],e[3],e[4]local e={}for i=n,i do
for n=t,s do
table.insert(e,{i,n})end
end
return e
end
function e.CheckBlockArea(e,t,n)local r,e,s,i=e[1],e[2],e[3],e[4]if(((t>=r)and(t<=s))and(n>=e))and(n<=i)then
return true
end
return false
end
function e.FillBlockArea(e,r,s,n,t,i)for n=r,n do
e[n]=e[n]or{}for t=s,t do
e[n][t]=i
end
end
end
function e.GetCurrentStageSmallBlockIndex()local e=2
local t,n=StageBlock.GetCurrentMinimumSmallBlockIndex()return(t+e),(n+e)end
function e.IsLoadedSmallBlock(n,e)local t=4
local s,i=StageBlock.GetCurrentMinimumSmallBlockIndex()local r=s+t
local t=i+t
return((s<=n and n<=r)and i<=e)and e<=t
end
function e.IsLoadedLargeBlock(e)local n=r(e)local e=StageBlock.GetLoadedLargeBlocks(0)for t,e in pairs(e)do
if e==n then
return true
end
end
return false
end
function e.GetLoadedLargeBlock()local e=StageBlock.GetLoadedLargeBlocks(0)for n,e in pairs(e)do
return e
end
return nil
end
function e.GetChunkIndexList(t,n)local e={}if n and TppMission.IsMultiPlayMission(n)then
e={Chunk.INDEX_AFGH,Chunk.INDEX_MAFR}else
local n=TppDefine.LOCATION_CHUNK_INDEX_TABLE[t]if n==nil then
if not TppGameSequence.IsMaster()then
Fox.Hungup()end
else
e={n}end
end
return e
end
function e.StartWaitChunkInstallation(n)Chunk.PrefetchChunk(n)Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)e.ClearChunkInstallPopupUpdateTime()end
local s=1
local n=0
function e.ShowChunkInstallingPopup(t,i)local e=Time.GetFrameTime()n=n-e
if n>0 then
return
end
n=n+s
if n<0 then
n=0
end
local n=Fox.GetPlatformName()local e=0
for t,n in ipairs(t)do
local n=Chunk.GetChunkInstallationEta(n)if n then
e=e+n
end
end
if e and n=="PS4"then
if e>86400 then
e=86400
end
TppUiCommand.SetErrorPopupParam(e)end
local e=0
for t,n in ipairs(t)do
local n=Chunk.GetChunkInstallationRate(n)if n then
e=e+n
end
end
e=e/#t
if e and n=="XboxOne"then
TppUiCommand.SetErrorPopupParam(e*1e4,"None",2)end
local e
if i then
e=Popup.TYPE_ONE_CANCEL_BUTTON
else
TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"end
TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.NOW_INSTALLING,e)end
function e.ClearChunkInstallPopupUpdateTime()n=0
end
function e.GetFormatedStorageSizePopupParam(t)local n=1024
local e=1024*n
local s=1024*e
local r,s,i=t/s,t/e,t/n
local n=0
local e=""if r>=1 then
n=r*100
e="G"elseif s>=1 then
n=s*100
e="M"elseif i>=1 then
n=i*100
e="K"else
return t,"",0
end
local n=math.ceil(n)return n,e,2
end
if DebugText then
e.DEBUG_debugDlcTypeTextTable={[PatchDlc.PATCH_DLC_TYPE_MGO_DATA]="PATCH_DLC_TYPE_MGO_DATA",[PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]="PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA"}end
function e.PatchDlcCheckCoroutine(r,i,l,n)if n==nil then
n=PatchDlc.PATCH_DLC_TYPE_MGO_DATA
end
local t={[PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=true,[PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=true}if not t[n]then
Fox.Hungup"Invalid dlc type."return false
end
local s=DebugText
local function t(t)if s then
local e=e.DEBUG_debugDlcTypeTextTable[n]or"PATCH_DLC_TYPE_MGO_DATA"s.Print(s.NewContext(),"Tpp.PatchDlcCheckCoroutine: dlcType = "..(tostring(e)..(", "..tostring(t))))end
end
local function e()if TppUiCommand.IsShowPopup()then
TppUiCommand.ErasePopup()while TppUiCommand.IsShowPopup()do
t"waiting popup closed..."coroutine.yield()end
end
end
local function s()while TppSave.IsSaving()do
t"waiting saving end..."coroutine.yield()end
end
s()PatchDlc.StartCheckingPatchDlc(n)if PatchDlc.IsCheckingPatchDlc()then
if not l then
e()local e={[PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=5100,[PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=5150}local e=e[n]TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"TppUiCommand.ShowErrorPopup(e)end
while PatchDlc.IsCheckingPatchDlc()do
t"waiting checking PatchDlc end..."coroutine.yield()TppUI.ShowAccessIconContinue()end
end
e()if PatchDlc.DoesExistPatchDlc(n)then
if r then
r()end
return true
else
if i then
i()end
return false
end
end
function e.IsPatchDlcValidPlatform(e)local n={[PatchDlc.PATCH_DLC_TYPE_MGO_DATA]={PS3=true,PS4=true},[PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]={Xbox360=true,PS3=true,PS4=true}}local e=n[e]if not e then
Fox.Hungup"Invalid dlc type."return false
end
local n=Fox.GetPlatformName()if e[n]then
return true
else
return false
end
end
function e.ClearDidCancelPatchDlcDownloadRequest()if(vars.didCancelPatchDlcDownloadRequest==1)then
vars.didCancelPatchDlcDownloadRequest=0
vars.isPersonalDirty=1
TppSave.CheckAndSavePersonalData()end
end
function e.MergeMessageTable(e,n)if not e then
e={}end
for n,t in pairs(n)do
if not e[n]then
e[n]={}end
for s,t in ipairs(t)do
table.insert(e[n],t)end
end
return e
end
function e.IsBaseLoaded()return e.IsLoadedSmallBlock(129,150)end
function e.DEBUG_DunmpBlockArea(s,t,n)local e="       "for n=1,n do
e=e..string.format("%02d,",n)end
for t=1,t do
local e=""for n=1,n do
e=e..string.format("%02d,",s[t][n])end
end
end
function e.DEBUG_DumpTable(s,n)if n==nil then
end
if(t(s)~="table")then
return
end
local i=""if n then
for e=0,n do
i=i.." "end
end
for i,s in pairs(s)do
if t(s)=="table"then
local n=n or 0
n=n+1
e.DEBUG_DumpTable(s,n)else
if t(s)=="number"then
end
end
end
end
function e.DEBUG_Where(e)local e=debug.getinfo(e+1)if e then
return e.short_src..(":"..e.currentline)end
return"(unknown)"end
function e.DEBUG_StrCode32ToString(e)if e~=nil then
local n
if(TppDbgStr32)then
n=TppDbgStr32.DEBUG_StrCode32ToString(e)end
if n then
return n
else
if t(e)=="string"then
end
return tostring(e)end
else
return"nil"end
end
function e.DEBUG_Fatal(e,e)end
function e.DEBUG_SetPreference(n,t,s)local n=Preference.GetPreferenceEntity(n)if(n==nil)then
return
end
if(n[t]==nil)then
return
end
Command.SetProperty{entity=n,property=t,value=s}end
e._requireList={}do
for t,n in ipairs(e.requires)do
local n=e.SplitString(n,"/")local n=string.sub(n[#n],1,#n[#n]-4)local t={TppMain=true,TppDemoBlock=true,mafr_luxury_block_list=true}if not t[n]then
e._requireList[#e._requireList+1]=n
end
end
end
return e