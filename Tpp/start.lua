if(DEFAULT_OFFLINE_FIRST_PARTY_NETWORK_MODE and Fox.GetPlatformName()=="PS4")and DebugMenu then
DebugMenu.SetDebugMenuValue("TppNetwork","UseKonamiLAN","On")DebugMenu.SetDebugMenuValue("TppNetwork","ConnectDebugGate","Dev_Prod")end
if DebugMenu then
DebugMenu.SetDebugMenuValue("ZzHostMigration","RequierHostNo",1)DebugMenu.SetDebugMenuValue("ZzHostMigration","SetHostIndex",true)DebugMenu.SetDebugMenuValue("TppNetwork","dispActiveMessage",1)end
local function t()coroutine.yield()end
FoxFadeIo.FadeOut(0)TppUiStatusManager.SetStatus("PauseMenu","INVALID")TppUiCommand.SetLoadIndicatorVisible(true)Gimmick.OnlineInitializeEnable(true)if not SignIn.PresetUserIdExists()then
if(not Editor and(F_DISC_IMAGE or F_HDD_IMAGE))and TppGameSequence.GetTargetArea()=="Japan"then
local e=SplashScreen.Create("cesa","/Assets/ssd/ui/texture/logo/common_cesa_logo_clp_nmp.ftex",1280,640)SplashScreen.Show(e,.33,4,.33)end
end
Mission.StartSystemMenuPause()GameConfig.Reset()UiDaemon.SetPrefetchTexture"/Assets/tpp/ui/ModelAsset/cmn_loadmark/Pictures/cmn_loadmark_logo_mini_nmp.ftex"AssetConfiguration.RegisterExtensionInfo{extensions={"tetl","tmss","tmsl","tlsp","tmsu","tmsf","twpf","adm","tevt","vpc","ends","spch","mbl","gimr"},categories={"Target"}}local e=CheckpointDaemon{name="CheckpointDaemon"}if GkNoiseSystem then
GkNoiseSystem.InitNoiseSet"Tpp/Scripts/Noises/TppNoiseDefinitions.lua"end
if ChVoiceTaskOrganizer2 then
ChVoiceTaskOrganizer2.PrepareTaskPool("Player",1)ChVoiceTaskOrganizer2.PrepareTaskPool("Enemy",8)ChVoiceTaskOrganizer2.PrepareTaskPool("HqSquad",1)end
if Editor then
if Preference then
local e=Preference.GetPreferenceEntity"EdRailPreference"if not Entity.IsNull(e)and Fox.GetPlatformName()=="Windows"then
if e.railSystemScript==""then
e.railSystemScript="/Assets/tpp/editor_scripts/fox/rail/TppRailSystem.lua"end
end
end
do
local e=Preference.GetPreferenceEntity"EdRoutePreference"if not Entity.IsNull(e)and e.characterType=="Soldier"then
e.characterType="Soldier2"end
end
EdRouteDataNodeEvent.SetEventDefinitionPath("Zombie","Tpp/Scripts/RouteEvents/AiRtEvZombie.lua")EdRouteDataEdgeEvent.SetEventDefinitionPath("Zombie","Tpp/Scripts/RouteEvents/AiRtEvZombie.lua")EdRouteDataNodeEvent.SetEventDefinitionPath("Spider","Tpp/Scripts/RouteEvents/AiRtEvSpider.lua")EdRouteDataEdgeEvent.SetEventDefinitionPath("Spider","Tpp/Scripts/RouteEvents/AiRtEvSpider.lua")EdRouteDataNodeEvent.SetEventDefinitionPath("SirenCamera","Tpp/Scripts/RouteEvents/AiRtEvSirenCamera.lua")EdRouteDataEdgeEvent.SetEventDefinitionPath("SirenCamera","Tpp/Scripts/RouteEvents/AiRtEvSirenCamera.lua")EdRouteDataNodeEvent.SetEventDefinitionPath("Aerial","Tpp/Scripts/RouteEvents/AiRtEvAerial.lua")EdRouteDataEdgeEvent.SetEventDefinitionPath("Aerial","Tpp/Scripts/RouteEvents/AiRtEvAerial.lua")EdRouteDataNodeEvent.SetEventDefinitionPath("Gluttony","Tpp/Scripts/RouteEvents/AiRtEvGluttony.lua")EdRouteDataEdgeEvent.SetEventDefinitionPath("Gluttony","Tpp/Scripts/RouteEvents/AiRtEvGluttony.lua")EdRouteDataNodeEvent.SetEventDefinitionPath("Destroyer","Tpp/Scripts/RouteEvents/AiRtEvDestroyer.lua")EdRouteDataNodeEvent.SetEventList"Zombie"EdRouteDataEdgeEvent.SetEventList"Zombie"EdRouteDataNodeEvent.SetEventDefinitionPath("Animal","Tpp/Scripts/RouteEvents/AiRtEvAnimal.lua")EdRouteDataEdgeEvent.SetEventDefinitionPath("Animal","Tpp/Scripts/RouteEvents/AiRtEvAnimal.lua")EdRouteDataNodeEvent.SetEventDefinitionPath("AimTarget","Tpp/Scripts/RouteEvents/AiRtEvAimTarget.lua")EdRouteDataEdgeEvent.SetEventDefinitionPath("AimTarget","Tpp/Scripts/RouteEvents/AiRtEvAimTarget.lua")EdRouteDataNodeEvent.SetEventDefinitionPath("MapData","Tpp/Scripts/RouteEvents/AiRtEvMapData.lua")EdRouteDataEdgeEvent.SetEventDefinitionPath("MapData","Tpp/Scripts/RouteEvents/AiRtEvMapData.lua")if Preference then
local e=Preference.GetPreferenceEntity"EdRoutePreference"if not Entity.IsNull(e)and Fox.GetPlatformName()=="Windows"then
if e.routeSystemScript==""then
e.routeSystemScript="/Assets/tpp/editor_scripts/fox/route/TppRouteSystem.lua"end
end
end
end
if TppCoverPointProvider then
TppCoverPointProvider.Create()end
NavTactical.SetTacticalActionSystemScript"/Assets/tpp/editor_scripts/fox/tactical_action/TppTacticalActionSystem.lua"local a=true
if not AssetConfiguration.IsDiscOrHddImage()then
a=AssetConfiguration.GetConfigurationFromAssetManager"EnableWindowsDX11Texture"end
if GrDaemon then
local e=Fox.GetPlatformName()local t=""if GrTools then
t=GrTools.GetDeviceName()end
if e=="Windows"then
if t=="directx9"then
GrTools.LoadShaderPack"shaders/win32/TppShaders_win32.fsop"if a then
dofile"shaders/win32/TppShadersNoLnm_win32.lua"else
dofile"shaders/win32/TppShaders_win32.lua"end
end
if t=="directx11"then
GrTools.LoadShaderPack"shaders/dx11/TppShaders_dx11.fsop"if a then
dofile"shaders/dx11/TppShadersNoLnm_dx11.lua"else
dofile"shaders/dx11/TppShaders_dx11.lua"end
end
elseif e=="Xbox360"then
GrTools.LoadShaderPack"shaders\\xbox360\\TppShaders_x360.fsop"dofile"shaders/xbox360/TppShaders_x360.lua"elseif e=="PS3"then
GrTools.LoadShaderPack"shaders/ps3/TppShaders_ps3.fsop.sdat"dofile"shaders/ps3/TppShaders_ps3.lua"elseif e=="XboxOne"then
GrTools.LoadShaderPack"shaders/xboxone/TppShaders_xone.fsop"dofile"shaders/xboxone/TppShadersNoLnm_xone.lua"elseif e=="PS4"then
GrTools.LoadShaderPack"shaders/ps4/TppShaders_ps4.fsop"dofile"shaders/ps4/TppShadersNoLnm_ps4.lua"end
end
TppFadeOutEffectHolder.Create()TppEffectUtility.SetEnableWindowsDirectX11Textures(a)TppEffectUtility.InitThermalReactionObjectUnionMaterial()if Preference then
local e=Preference.GetPreferenceEntity"FxEditorSetting"if not Entity.IsNull(e)and Fox.GetPlatformName()=="Windows"then
if#e.defineFiles==0 then
Command.AddPropertyElement{entity=e,property="defineFiles"}end
e.defineFiles[1]="../../Tpp/Tpp/Fox/LevelEditor/Fx/tppFxModuleDefines.xml"end
end
if FxDaemon then
FxDaemon:InitializeReserveObject"TppShaderPool"FxDaemon:InitializeReserveObject"TppTexturePoolManager"if Fox.GetPlatformName()=="Windows"then
FxSystemConfig.SetLimitInstanceMemorySize((1024*1024)*24)FxSystemConfig.SetLimitInstanceMemoryDefaultSize((1024*1024)*24)else
FxSystemConfig.SetLimitInstanceMemorySize((1024*1024)*24)FxSystemConfig.SetLimitInstanceMemoryDefaultSize((1024*1024)*24)end
end
AssetConfiguration.SetLanguageGroupExtention{group={"Sound"},extensions={"mas","fsm","sbp","wem","evf","sani","sad","stm","wmv","mp4"}}local e="jpn"do
local t=GameConfig.GetDefaultLanguage()if t=="Japanese"then
e="jpn"elseif t=="French"then
e="fre"elseif t=="Itarian"then
e="ita"elseif t=="German"then
e="deu"elseif t=="Spanish"then
e="spa"elseif t=="Portugese"then
e="por"elseif t=="Russian"then
e="rus"else
if Fox.GetPlatformName()=="PS4"then
e="eng"if TppGameSequence.GetTargetArea()=="ChinaKorea"then
if t=="ChineseTaipei"then
e="cht"elseif t=="Korean"then
e="kor"end
end
else
if t=="ChineseTaipei"then
e="cht"elseif t=="Korean"then
e="kor"else
e="eng"end
end
end
end
AssetConfiguration.SetDefaultCategory("Language",e)if e=="jpn"then
AssetConfiguration.SetGroupCurrentLanguage("Sound","jpn")else
AssetConfiguration.SetGroupCurrentLanguage("Sound","eng")end
if e=="jpn"then
SubtitlesDaemon.SetDefaultVoiceLanguage"jpn"SubtitlesCommand.SetVoiceLanguage"jpn"else
SubtitlesDaemon.SetDefaultVoiceLanguage"eng"SubtitlesCommand.SetVoiceLanguage"eng"end
SubtitlesCommand.SetLanguage(e)if LuaUnitTest then
SoundCoreDaemon.SetAssetPath"/Assets/ssd/sound/asset/"else
SoundCoreDaemon.SetAssetPath"/Assets/ssd/sound/asset/"end
SoundCoreDaemon.SetInterferenceRTPCName("obstruction_rtpc","occlusion_rtpc")SoundCoreDaemon.SetDopplerRTPCName"doppler"SoundCoreDaemon.SetRearParameter("rear_rtpc",5)if TppSoundDaemon then
local e=TppSoundDaemon{}if TppSoundEditorDaemon then
local e=TppSoundEditorDaemon{}end
end
TppRadioCommand.CreateSoundControl()TppRadioCommand.RegisterTppCommonConditionCheckFunc()VoiceCommand:SetVoiceTypePriority(1,1,0)VoiceCommand:SetVoiceTypePriority(2,1,1)VoiceCommand:SetVoiceTypePriority(4,12,12)VoiceCommand:SetVoiceTypePriority(5,1,1)VoiceCommand:SetVoiceTypePriority(6,6,6)VoiceCommand:SetVoiceTypePriority(7,10,10)VoiceCommand:SetVoiceTypePriority(8,10,10)VoiceCommand:SetVoiceTypePriority(10,17,17)VoiceCommand:SetVoiceTypePriority(11,17,17)VoiceCommand:SetVoiceTypePriority(12,11,11)VoiceCommand:SetVoiceTypePriority(13,9,9)VoiceCommand:SetVoiceTypePriority(15,14,14)VoiceCommand:SetVoiceEventType(6,"DD_Intelmen")VoiceCommand:SetVoiceEventType(5,"DD_RTR")VoiceCommand:SetVoiceEventType(5,"DD_OPR")VoiceCommand:SetVoiceEventType(5,"DD_TUTR")VoiceCommand:SetVoiceEventType(6,"DD_Ishmael")VoiceCommand:SetVoiceEventType(6,"DD_Ocelot")VoiceCommand:SetVoiceEventType(6,"DD_Miller")VoiceCommand:SetVoiceEventType(6,"DD_Huey")VoiceCommand:SetVoiceEventType(6,"DD_CodeTalker")VoiceCommand:SetVoiceEventType(6,"DD_Quiet")VoiceCommand:SetVoiceEventType(6,"DD_SkullFace")VoiceCommand:SetVoiceEventType(6,"DD_conversation_s10150")VoiceCommand:SetVoiceEventType(10,"DD_MammalPod")VoiceCommand:SetVoiceEventType(6,"DD_Paz")VoiceCommand:SetVoiceEventType(5,"DD_missionUQ")VoiceCommand:SetVoiceEventType(4,"DD_vox_SH_radio")VoiceCommand:SetVoiceEventType(4,"DD_vox_SH_voice")VoiceCommand:SetVoiceEventType(7,"DD_vox_ene_ld")VoiceCommand:SetVoiceEventType(7,"DD_vox_cp_radio")VoiceCommand:SetVoiceEventType(10,"DD_hostage")VoiceCommand:SetVoiceEventType(10,"DD_chsol")VoiceCommand:SetVoiceEventType(10,"DD_hostage")VoiceCommand:SetVoiceEventType(10,"DD_hostage_fml")VoiceCommand:SetVoiceEventType(10,"DD_hostage_ru")VoiceCommand:SetVoiceEventType(10,"DD_hostage_ps")VoiceCommand:SetVoiceEventType(10,"DD_hostage_af")VoiceCommand:SetVoiceEventType(10,"DD_hostage_kg")VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10052")VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10085")VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10033")VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10081")VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10091")VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10115")VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10200")VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10211")VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10054")VoiceCommand:SetVoiceEventType(10,"DD_vox_kaz_rt_ld")VoiceCommand:SetVoiceEventType(10,"DD_Ishmael")VoiceCommand:SetVoiceEventType(13,"DD_vox_ene_conversation")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10036")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10043")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10041")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10052")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10045")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10195")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10086")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10090")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10121")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10085")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10110")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10200")VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10120")VoiceCommand:SetVoiceEventType(13,"CHSOL_conversation_s10120")VoiceCommand:SetVoiceEventType(13,"CHSOL_conversation_s10200")VoiceCommand:SetVoiceEventType(13,"CH_conversation_s10120")VoiceCommand:SetVoiceEventType(13,"CH_conversation_s10200")if TppGadgetManager then
TppGadgetManager.InitSound()end
if Bush then
Bush.SetParameters{rotSpeedMax=foxmath.DegreeToRadian(1),alphaDistanceMin=1,alphaDistanceMax=3}end
local a=Fox.GetPlatformName()if a~="Windows"or not Editor then
Fox.SetActMode"GAME"end
GeoPathService.RegisterPathTag("Elude",0)GeoPathService.RegisterPathTag("Jump",1)GeoPathService.RegisterPathTag("Fence",2)GeoPathService.RegisterPathTag("StepOn",3)GeoPathService.RegisterPathTag("Behind",4)GeoPathService.RegisterPathTag("Urgent",5)GeoPathService.RegisterPathTag("Pipe",6)GeoPathService.RegisterPathTag("Climb",7)GeoPathService.RegisterPathTag("Rail",8)GeoPathService.RegisterPathTag("ForceFallDown",9)GeoPathService.RegisterPathTag("DontFallWall",10)GeoPathService.RegisterPathTag("Move",11)GeoPathService.RegisterPathTag("Road",12)GeoPathService.RegisterEdgeTag("Stand",0)GeoPathService.RegisterEdgeTag("Squat",1)GeoPathService.RegisterEdgeTag("BEHIND_LOW",2)GeoPathService.RegisterEdgeTag("FenceElude",3)GeoPathService.RegisterEdgeTag("Elude",4)GeoPathService.RegisterEdgeTag("Jump",5)GeoPathService.RegisterEdgeTag("Fence",6)GeoPathService.RegisterEdgeTag("StepOn",7)GeoPathService.RegisterEdgeTag("Behind",8)GeoPathService.RegisterEdgeTag("Urgent",9)GeoPathService.RegisterEdgeTag("NoEnd",10)GeoPathService.RegisterEdgeTag("NoStart",11)GeoPathService.RegisterEdgeTag("FenceJump",12)GeoPathService.RegisterEdgeTag("Wall",13)GeoPathService.RegisterEdgeTag("NoWall",14)GeoPathService.RegisterEdgeTag("ToIdle",15)GeoPathService.RegisterEdgeTag("EnableFall",16)GeoPathService.RegisterEdgeTag("NoFreeFall",17)GeoPathService.RegisterEdgeTag("Fulton",18)GeoPathService.RegisterEdgeTag("BEHIND_SNAP",19)GeoPathService.RegisterEdgeTag("LineCheck",20)GeoPathService.RegisterEdgeTag("FallNear",21)GeoPathService.RegisterEdgeTag("FenceToStepOn",22)GeoPathService.RegisterEdgeTag("ForceFallCatch",23)GeoPathService.RegisterEdgeTag("Window",24)GeoPathService.RegisterEdgeTag("AimIsBack",25)GeoPathService.RegisterNodeTag("Edge",0)GeoPathService.RegisterNodeTag("Cover",1)GeoPathService.RegisterNodeTag("BEHIND_LOOK_IN",2)GeoPathService.RegisterNodeTag("CHANGE_TO_60",3)GeoPathService.RegisterNodeTag("NoTurn",4)GeoPathService.RegisterNodeTag("BEHIND_STOP",5)GeoPathService.RegisterNodeTag("NoOut",6)GeoPathService.RegisterNodeTag("NoStart",7)GeoPathService.RegisterNodeTag("EludeToElude",8)GeoPathService.BindNodeTag("Elude","EludeToElude")GeoPathService.BindEdgeTag("Elude","Wall")GeoPathService.BindEdgeTag("Elude","NoWall")GeoPathService.BindEdgeTag("Elude","NoEnd")GeoPathService.BindEdgeTag("Elude","Urgent")GeoPathService.BindEdgeTag("Elude","FenceElude")GeoPathService.BindEdgeTag("Elude","EnableFall")GeoPathService.BindEdgeTag("Elude","LineCheck")GeoPathService.BindEdgeTag("Elude","ForceFallCatch")GeoPathService.BindEdgeTag("Urgent","Wall")GeoPathService.BindEdgeTag("Urgent","NoEnd")GeoPathService.BindEdgeTag("Urgent","Urgent")GeoPathService.BindEdgeTag("Urgent","FenceElude")GeoPathService.BindEdgeTag("Urgent","LineCheck")GeoPathService.BindEdgeTag("Urgent","ForceFallCatch")GeoPathService.BindNodeTag("Behind","BEHIND_LOOK_IN")GeoPathService.BindNodeTag("Behind","BEHIND_STOP")GeoPathService.BindEdgeTag("Behind","BEHIND_LOW")GeoPathService.BindEdgeTag("Behind","BEHIND_SNAP")GeoPathService.BindEdgeTag("Behind","LineCheck")GeoPathService.BindEdgeTag("Behind","AimIsBack")GeoPathService.BindEdgeTag("Jump","FenceJump")GeoPathService.BindEdgeTag("Jump","NoFreeFall")GeoPathService.BindEdgeTag("Jump","LineCheck")GeoPathService.BindNodeTag("Climb","Edge")GeoPathService.BindNodeTag("Pipe","NoTurn")GeoPathService.BindNodeTag("Pipe","NoOut")GeoPathService.BindNodeTag("Pipe","NoStart")GeoPathService.BindEdgeTag("Pipe","NoEnd")GeoPathService.BindEdgeTag("Pipe","NoStart")GeoPathService.BindEdgeTag("Fence","ToIdle")GeoPathService.BindEdgeTag("Fence","EnableFall")GeoPathService.BindEdgeTag("Fence","LineCheck")GeoPathService.BindEdgeTag("Fence","FallNear")GeoPathService.BindEdgeTag("Fence","FenceToStepOn")GeoPathService.BindEdgeTag("Fence","Window")GeoPathService.BindEdgeTag("StepOn","Fulton")GeoPathService.BindEdgeTag("StepOn","LineCheck")GeoPathService.BindEdgeTag("StepOn","Window")local e=PhDaemon.GetInstance()if a=="Xbox360"then
PhDaemon.SetMemorySize(1792,1024,768)elseif a=="PS3"then
PhDaemon.SetMemorySize(1792,1024,768)elseif a=="Windows"then
if Editor then
PhDaemon.SetMemorySize(5120,3072,2048)else
PhDaemon.SetMemorySize(5120,3072,2048)end
else
PhDaemon.SetMemorySize(5120,3072,2048)end
PhDaemon.SetUpdateDtMax(1/15)PhDaemon.SetWorldMin(Vector3(-4200,-1e3,-4200))PhDaemon.SetWorldMax(Vector3(4200,3e3,4200))PhDaemon.SetMaxRigidBodyNum(1e3)e.SetCollisionGroupState(1,3,false)e.SetCollisionGroupState(1,4,true)e.SetCollisionGroupState(1,6,true)e.SetCollisionGroupState(3,3,true)e.SetCollisionGroupState(3,4,true)e.SetCollisionGroupState(3,5,true)e.SetCollisionGroupState(6,3,false)e.SetCollisionGroupState(6,9,false)e.SetCollisionGroupState(7,1,false)e.SetCollisionGroupState(7,2,false)e.SetCollisionGroupState(7,3,false)e.SetCollisionGroupState(7,4,false)e.SetCollisionGroupState(7,5,false)e.SetCollisionGroupState(7,6,false)e.SetCollisionGroupState(7,8,false)e.SetCollisionGroupState(7,9,false)e.SetCollisionGroupState(7,10,false)e.SetCollisionGroupState(9,3,false)e.SetCollisionGroupState(9,10,false)e.SetCollisionGroupState(10,9,false)e.SetCollisionGroupState(11,3,true)e.SetCollisionGroupState(11,4,true)e.SetCollisionGroupState(11,5,true)e.SetCollisionGroupState(12,3,true)e.SetCollisionGroupState(12,4,true)e.SetCollisionGroupState(12,5,true)dofile"Tpp/Scripts/Ui/TppUiBootInit.lua"TppCassetteTapeInfo.Setup()if Editor or F_ENABLE_AUTO_DUMP then
package.path=package.path..";/Assets/tpp/editor_scripts/?.lua"package.path=package.path..";/Assets/ssd/editor_scripts/?.lua"end
if Editor then
local e=Application:GetInstance()local t=e:GetMainGame()local e=e:GetScene"MainScene"local e=t:CreateBucket("SetupBucket",e)e:LoadProjectFile"/Assets/tpp/level/location/SetupLocation2.fxp"end
if a=="Windows"then
if TppLightCapture then
TppLightCapture.InitInstance()end
end
local e=(.8*1024)*1024
e=e+258*1024
if a=="Xbox360"then
e=e+20*1024
end
if a=="Windows"then
e=((e+450*1024)+400*1024)+150*1024
elseif a=="XboxOne"then
e=((e+450*1024)+400*1024)+150*1024
elseif a=="PS4"then
e=((e+450*1024)+400*1024)+150*1024
end
TppGameSequence.SetSystemBlockSize(e,(40.5*1024)*1024)TppGameSequence.LoadResidentBlock"/Assets/ssd/pack/resident/resident00.fpk"Player.CreateResidentMotionBlock{size=((6*1024)*1024-8*1024)-(.55*1024)*1024}Player.CreateResidentPartsBlock{count=4,size=(1.5*1024)*1024}Player.RegisterCommonMotionPackagePath("DefaultCommonMotion","/Assets/ssd/pack/player/motion/player_resident_motion.fpk","/Assets/ssd/motion/motion_graph/player/SsdPlayer_layers.mog")Player.RegisterCommonMtarPath("/Assets/ssd/motion/mtar/player/SsdPlayer_layers.mtar","/Assets/tpp/motion/mtar/player2/TppPlayer2Facial.mtar")Player.RegisterCameraCaarPath"/Assets/tpp/motion/mtar/player2/player2_camera_anim.caar"if SsdNpcHumanCommonBlockController then
SsdNpcHumanCommonBlockController.CreateCommonMotionBlockGroup(9559*1024)SsdNpcHumanCommonBlockController.SetPackagePathWithPrerequisites{path="/Assets/ssd/pack/npc/common/NpcHumanCommon.fpk"}end
TppEquip.CreateResidentBlockGroups{commonBlockSize=(2*1024)*1024,primary1BlockSize=(.55*1024)*1024,primary2BlockSize=(.55*1024)*1024,secondaryBlockSize=(.34*1024)*1024}TppEquip.LoadCommonBlock(0,"/Assets/ssd/pack/collectible/common/col_common_ssd.fpk")if Editor then
TppEdMissionListEditInfo.SetConverterScriptPath"Tpp/Scripts/Classes/TppEdMissionConverterCaller.lua"EdDemoEditBlockController.AddToolsBlockPath"/Assets/tpp/demo/event/info/TppEdDemoEditTools.fpk"EdDemoEditBlockController.AddToolsBlockPath"/Assets/ssd/demo/event/info/SsdEdDemoEditTools.fpk"end
if NavWorldDaemon then
NavWorldDaemon.AddWorld{sceneName="MainScene",worldName="",maxLoadFileCount=64,maxChunkCountPerFile=7,maxGraphBounderCount=30,maxTacticalActionCount=120,navigationGraphDynamicLinkContainerInfo={maxArrayCount=810,extendCount=2},segmentGraphDynamicLinkContainerInfo={maxArrayCount=675,extendCount=2},segmentGraphDynamicPortalContainerInfo={maxArrayCount=635,extendCount=2},islandGraphDynamicLinkContainerInfo={maxArrayCount=360,extendCount=2}}NavWorldDaemon.AddWorld{sceneName="MainScene",worldName="sky",maxLoadFileCount=1,maxChunkCountPerFile=5}NavWorldDaemon.AddWorld{sceneName="MainScene",worldName="sahelan",maxLoadFileCount=2,maxChunkCountPerFile=6}NavWorldDaemon.AddWorld{sceneName="MainScene",worldName="boss",maxLoadFileCount=200,maxChunkCountPerFile=6,maxGraphBounderCount=30,maxTacticalActionCount=120,navigationGraphDynamicLinkContainerInfo={maxArrayCount=810,extendCount=2},segmentGraphDynamicLinkContainerInfo={maxArrayCount=675,extendCount=2},segmentGraphDynamicPortalContainerInfo={maxArrayCount=635,extendCount=2},islandGraphDynamicLinkContainerInfo={maxArrayCount=360,extendCount=2}}end
local e=false
if TPP_MISSION_MANAGER_ENABLED then
if e==false then
TppGameSequence.RequestGameSetup()end
end
if TppNewCollectibleModule then
TppNewCollectibleModule.InitializeWhenStartLua()end
t()t()if Script.LoadLibrary then
local e
e="/Assets/tpp/"TppDamage.ReloadDamageParameter()SsdSbm.ReloadSbmParameterTable()TppEquip.ReloadWeaponParametersSsd()TppEquip.ReloadEquipIdTableSsd()SsdBuff.ReloadBuffParameter()TppBullet.ReloadRecoilMaterials()t()Script.LoadLibrary"/Assets/ssd/fova/common_source/chara/cm_head/face_id/SsdNpcFaceAndBodyData.lua"Script.LoadLibrary"/Assets/ssd/level_asset/chara/enemy/TppEnemyFaceId.lua"Script.LoadLibrary"/Assets/ssd/level_asset/chara/enemy/TppEnemyBodyId.lua"t()Script.LoadLibrary"/Assets/ssd/level_asset/chara/ssdnpc/SsdZombieAnimationTrackPool.lua"Script.LoadLibrary"/Assets/ssd/level_asset/chara/ssdnpc/SsdZombieBomAnimationTrackPool.lua"Script.LoadLibrary"/Assets/ssd/level_asset/chara/enemy/TppEnemyFaceGroupId.lua"Script.LoadLibrary"/Assets/ssd/level_asset/chara/enemy/TppEnemyFaceGroup.lua"t()Script.LoadLibraryAsync"/Assets/ssd/script/lib/Tpp.lua"while Script.IsLoadingLibrary"/Assets/ssd/script/lib/Tpp.lua"do
t()end
Script.LoadLibrary"/Assets/ssd/script/lib/TppDefine.lua"Script.LoadLibrary"/Assets/ssd/script/lib/TppVarInit.lua"Script.LoadLibrary"/Assets/ssd/script/lib/TppGVars.lua"Gear.RegisterGear()Script.LoadLibrary"/Assets/ssd/level_asset/config/GearConfig.lua"Script.LoadLibrary"/Assets/ssd/script/list/TppMissionList.lua"Script.LoadLibrary"/Assets/ssd/script/list/TppQuestList.lua"Script.LoadLibrary"/Assets/ssd/script/list/SsdFlagMissionList.lua"Script.LoadLibrary"/Assets/ssd/script/list/SsdBaseDefenseList.lua"if Tpp.IsQARelease()then
Script.LoadLibrary"/Assets/ssd/script/list/TppDebugMissionList.lua"end
do
Script.LoadLibrary"/Assets/tpp/editor_scripts/tpp_editor_menu2.lua"Script.LoadLibrary"/Assets/tpptest/script/lib/MissionTest.lua"local e=function()end
end
SsdCrew.ReloadCrewParameterTable()SsdBuilding.ReloadBuildingParameterTable()SsdCombatDeploy.ReloadCombatDeployParameterTable()SsdBaseManagement.InitializeResource()end
t()if TppSystemUtility.GetCurrentGameMode()=="TPP"then
Script.LoadLibrary"/Assets/ssd/level_asset/chara/player/game_object/player2_camouf_param.lua"end
t()if Editor then
TppGeoMaterial.EDIT_CheckWastedMaterialNames()end
if Tpp.IsQARelease()then
local e,t=pcall(function()local e="Tpp/Debug/Scripts/debug_start.lua"local t=io.open(e,"r")if t~=nil then
io.close(t)dofile(e)end
end)if not e then
end
if Editor then
if TppNetworkUtil then
TppNetworkUtil.DEBUG_StartAutoDebugSession()end
end
end
if Game.DEBUG_AddScript then
local e,t=pcall(function()local e=io.open("tmp/my_debug_script.lua","r")if e then
local t=e:read"*a"local e=Application.GetInstance()local e=e:GetMainGame()e:DEBUG_AddScript(t)end
end)if not e then
end
end
if Game.DEBUG_AddScript then
local e=io.open("Tpp/tmp/release_test_script.lua","r")if e then
local t=e:read"*a"local e=Application.GetInstance()local e=e:GetMainGame()e:DEBUG_AddScript(t)Script.LoadLibrary"/Assets/tpp/editor_scripts/tpp_editor_menu2.lua"Script.LoadLibrary"/Assets/tpp/script/entry/MissionEntry.lua"Script.LoadLibrary"/Assets/tpptest/script/lib/MissionTest.lua"end
end
math.randomseed(os.time())t()GrTools.SetSunLightReflectionMapShader"TPPSunLightReflectMap"GrTools.SetEnvironmentSpecularCubeTexture"/Assets/tpp/effect/gr_pic/gr_cub01_sm_SkySpecCommon.ftex"GrTools.SetEnableLocalReflection(true)GrTools.SetLightingColorScale(1.8)t()do
local e=coroutine.create(loadfile"Tpp/Scripts/System/start2nd.lua")repeat
coroutine.yield()local t,a=coroutine.resume(e)if not t then
error(a)end
until coroutine.status(e)=="dead"end
t()while SplashScreen.GetSplashScreenWithName"cesa"do
if DebugText then
DebugText.Print(DebugText.NewContext(),"waiting for cesa screen to disappear...")end
t()end
SsdBuilding.CreateCamera()SsdLoadingTipsParameterTable.ReadLoadingTips()SsdBehaviorGuidelinesParameterTable.ReadBehaviorGuidelines()MapParameterSystem.ReadParameterFile()SsdBlankMap.InitBlankMapVarsAndMapParam()SsdReleaseAnnounceParameterTable.ReadReleaseAnnounce()StorySummarySystem.ReadParameterFile()TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil,{setMute=true})TppVarInit.InitializeOnStartTitle()TppVarInit.StartInitMission()TppUiCommand.SetLoadIndicatorVisible(false)if SsdSystem.StartHighlightSystem then
SsdSystem.StartHighlightSystem()end