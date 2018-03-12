local s={}local n={"s","e","f","h","o"}local e={"story","extra","free","heli","online"}function s.MakeDefaultMissionPackList(i)s.AddLocationCommonScriptPack(i)end
function s.AddMissionPack(i)if Tpp.IsTypeString(i)then
table.insert(s.missionPackList,i)end
end
function s.DeleteMissionPack(a)if Tpp.IsTypeString(a)then
local i
for n,s in ipairs(s.missionPackList)do
if s==a then
i=n
break
end
end
if i then
table.remove(s.missionPackList,i)end
end
end
function s.AddLocationCommonScriptPack(i)local i=TppLocation.GetLocationName()if(i=="afgh"or i=="ssd_afgh2")or i=="aftr"then
s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SSD_AFGH_SCRIPT)elseif i=="mafr"then
s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_SCRIPT)elseif i=="cypr"then
s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.CYPR_SCRIPT)elseif i=="mtbs"then
s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_SCRIPT)elseif i=="mbqf"then
s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_SCRIPT)end
end
function s.AddLocationCommonMissionAreaPack(i)local i=TppLocation.GetLocationName()if i=="afgh"then
s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SSD_AFGH_MISSION_AREA)elseif i=="ssd_afgh2"then
s.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_afgh2.fpk"end
end
function s.AddZombieCommonPack(i)s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ZOMBIE)end
function s.AddCoopCommonPack(i)s.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_coop.fpk"s.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_coop.fpk"end
function s.AddFreeCommonPack(i)s.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_opening_demo.fpk"end
function s.IsMissionPackLabelList(i)if not Tpp.IsTypeTable(i)then
return
end
for a,i in ipairs(i)do
if s.IsMissionPackLabel(i)then
return true
end
end
return false
end
function s.AddRobbyStagePack(i)s.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_robby_stage.fpk"s.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_staging_area.fpk"s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SSD_PLAYER_EMOTION)s.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_digger_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_range_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c02.fpk"s.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_range_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c02.fpk"s.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_digger_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_range_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c02.fpk"s.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_digger_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_range_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c02.fpk"s.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_range_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c01.fpk"s.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c02.fpk"end
function s.IsMissionPackLabel(s)if not Tpp.IsTypeString(s)then
return
end
if gvars.pck_missionPackLabelName==Fox.StrCode32(s)then
return true
else
return false
end
end
function s.AddAvatarEditPack()local i=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST
for a,i in ipairs(i)do
s.AddMissionPack(i)end
local i=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST_FEMALE
for a,i in ipairs(i)do
s.AddMissionPack(i)end
s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT)end
function s.AddAvatarMaleEditPack()local i=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST
for a,i in ipairs(i)do
s.AddMissionPack(i)end
s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT)end
function s.AddAvatarFemaleEditPack()local i=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST_FEMALE
for a,i in ipairs(i)do
s.AddMissionPack(i)end
s.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT)end
function s.SetUseDdEmblemFova(s)end
function s.SetMissionPackLabelName(s)if Tpp.IsTypeString(s)then
gvars.pck_missionPackLabelName=Fox.StrCode32(s)end
end
function s.SetDefaultMissionPackLabelName()s.SetMissionPackLabelName"default"end
function s.MakeMissionPackList(a,i)s.missionPackList={}if Tpp.IsTypeFunc(i)then
i(a)end
return s.missionPackList
end
function s.GetMissionTypeAndMissionName(a)local s=math.floor(a/1e4)local e=e[s]local i
if n[s]then
i=n[s]..a
end
return e,i
end
function s.GetLocationNameFormMissionCode(i)local s
if i and TppMission.IsEventMission(i)then
local a=Mission.GetDlcLocationSettings()for a,n in pairs(a)do
for e,n in pairs(n)do
local n=tonumber(n)if n==i then
s=a
break
end
end
if s then
return s
end
end
end
for n,a in pairs(SsdMissionList.MISSION_LIST_FOR_LOCATION)do
for e,a in pairs(a)do
local a=tonumber(a)if a==i then
s=n
break
end
end
if s then
break
end
end
return s
end
function s.AddTitleMissionPack(a,i)if i then
s.AddMissionPack"/Assets/ssd/pack/mission/common/title_sequence_script.fpk"s.AddMissionPack"/Assets/ssd/pack/ui/ssd_init_mission_ui.fpk"s.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_title.fpk"end
s.AddMissionPack"/Assets/ssd/pack/mission/common/title_sequence.fpk"end
return s