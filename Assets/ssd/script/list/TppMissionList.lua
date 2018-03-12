local p={}local i={}i[TppDefine.LOCATION_ID.INIT]={"/Assets/tpptest/pack/location/empty/empty.fpk"}i[TppDefine.LOCATION_ID.AFGH]={"/Assets/tpp/pack/location/afgh/afgh.fpk"}i[TppDefine.LOCATION_ID.MAFR]={"/Assets/tpp/pack/location/mafr/mafr.fpk"}i[TppDefine.LOCATION_ID.CYPR]={"/Assets/tpp/pack/location/cypr/cypr.fpk"}i[TppDefine.LOCATION_ID.GNTN]={"/Assets/tpp/pack/location/gntn/gntn.fpk"}i[TppDefine.LOCATION_ID.OMBS]={"/Assets/tpp/pack/location/ombs/ombs.fpk"}i[TppDefine.LOCATION_ID.MTBS]={"/Assets/tpp/pack/location/mtbs/mtbs.fpk"}i[TppDefine.LOCATION_ID.HLSP]={"/Assets/tpp/pack/location/hlsp/hlsp.fpk"}i[TppDefine.LOCATION_ID.MBQF]={"/Assets/tpp/pack/location/mbqf/mbqf.fpk"}i[TppDefine.LOCATION_ID.FLYK]={"/Assets/tpp/pack/location/flyk/flyk.fpk"}i[TppDefine.LOCATION_ID.SSD_AFGH]={"/Assets/ssd/pack/location/afgh/afgh.fpk"}i[TppDefine.LOCATION_ID.SSD_OMBS]={"/Assets/ssd/pack/location/ombs/ombs.fpk"}i[TppDefine.LOCATION_ID.SSD_AFGH2]={"/Assets/ssd/pack/location/afgh2/afgh2.fpk"}i[TppDefine.LOCATION_ID.SAND_AFGH]={"/Assets/tpp_sandbox/pack/game_core/stage/gc_afgh.fpk"}i[TppDefine.LOCATION_ID.SAND_MAFR]={"/Assets/tpp/pack/location/mafr/mafr.fpk"}i[TppDefine.LOCATION_ID.SAND_MTBS]={"/Assets/tpp_sandbox/pack/game_core/stage/gc_mtbs.fpk"}local s={}s[1]={"/Assets/ssd/pack/ui/ssd_init_mission_ui.fpk","/Assets/ssd/pack/ui/ssd_option_menu_ui.fpk","/Assets/ssd/pack/mission/init/init.fpk"}s[5]=function(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/init/title.fpk"end
s[1010]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e01010/e01010.fpk"TppPackList.AddAvatarEditPack()end
s[30010]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/free/f30010/f30010.fpk"end
s[10010]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/story/s10010/s10010.fpk"TppPackList.AddAvatarEditPack()end
s[10020]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/story/s10020/s10020.fpk"end
s[10050]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/story/s10050/s10050.fpk"end
s[20010]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/coop/c20010/c20010.fpk"TppPackList.AddMissionPack"/Assets/ssd/pack/collectible/rewardCbox/rewardCbox.fpk"end
s[20110]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/coop/c20110/c20110.fpk"end
s[21010]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/coop/c21010/c21010.fpk"end
s[12010]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/debug/s12010/s12010.fpk"end
s[12020]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/debug/s12020/s12020.fpk"end
s[12030]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/debug/s12030/s12030.fpk"end
s[32010]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/free/f32010/f32010.fpk"end
s[65010]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/debug/e65010/e65010.fpk"end
s[65020]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e65020/e65020.fpk"end
s[65030]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e65030/e65030.fpk"end
s[65040]=function(i)TppPackList.AddLocationCommonScriptPack(i)TppPackList.AddLocationCommonMissionAreaPack(i)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e65040/e65040.fpk"end
s[65060]=function(s)TppPackList.AddLocationCommonScriptPack(s)TppPackList.AddLocationCommonMissionAreaPack(s)TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e65060/e65060.fpk"end
function p.GetLocationPackagePath(s)local i=i[s]if i then
end
TppLocation.SetBuddyBlock(s)return i
end
function p.GetMissionPackagePath(i)TppPackList.SetUseDdEmblemFova(i)local p
if s[i]==nil then
p=TppPackList.MakeMissionPackList(i,TppPackList.MakeDefaultMissionPackList)elseif Tpp.IsTypeFunc(s[i])then
p=TppPackList.MakeMissionPackList(i,s[i])elseif Tpp.IsTypeTable(s[i])then
p=s[i]end
return p
end
function p.IsStartHeliToMB()end
return p