local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local t=GameObject.GetGameObjectId
local a={}function a.CreateInstance(e,a)local e=BaseFlagMission.CreateInstance(e)e.targetList=a
function e.GetTargetNameFromGameObjectId(a)for n,e in ipairs(e.targetList)do
if a==t(e)then
return e
end
end
end
e.commonMessageTable=e.AddMessage(e.commonMessageTable,{GameObject={{msg="Dead",func=function(a)local a=e.GetTargetNameFromGameObjectId(a)if a then
TppUI.ShowAnnounceLog"target_died"SsdFlagMission.ClearWithSave(TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE,e.missionName)SsdFlagMission.FadeOutAndUnloadBlock()end
end}}})function e.ClearCondition()for a,e in ipairs(e.targetList)do
if TppEnemy.GetStatus(e)~=TppGameObject.NPC_STATE_CARRIED then
return false
end
end
return true
end
e.flagStep.GameMain.messageTable={GameObject={{msg="Carried",func=function(a,t)local e=e.GetTargetNameFromGameObjectId(a)if e then
TppUI.ShowAnnounceLog"recoverTarget"SsdFlagMission.SetNextStep"GameEscape"end
end}}}return e
end
return a