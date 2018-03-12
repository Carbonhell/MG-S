local n=Fox.StrCode32
local e=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local r={}function r.CreateInstance(e,a,t,r)local e=BaseFlagMission.CreateInstance(e)e.targetList=a
e.targetAreaIdentifier=t
e.targetAreaKey=r
function e.Initialize()end
function e.GetTargetVariableName(t)local a
if Tpp.IsTypeString(t)then
a=n(t)else
a=t
end
return tostring(e.missionName)..("_"..(tostring(a).."_Count"))end
e.saveVarsList={}for t,a in ipairs(e.targetList)do
table.insert(e.saveVarsList,{name=e.GetTargetVariableName(a.name),type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION})end
function e.IsTarget(a)if fvars[e.GetTargetVariableName(a)]~=nil then
return true
end
return false
end
function e.GetItemCount(a)return fvars[e.GetTargetVariableName(a)]end
function e.ClearCondition()for t,a in ipairs(e.targetList)do
if a.targetAreaIdentifier and a.targetAreaKey then
local e=DataIdentifier.GetDataWithIdentifier(a.targetAreaIdentifier,a.targetAreaKey)local e=e.worldTransform
local t=e.translation
local e=e.scale:GetX()local t,a=Gimmick.SearchNearestSsdGimmick{pos=t,typeId=a.name}if not a or t>e then
return false
end
else
local e=fvars[e.GetTargetVariableName(a.name)]if e<a.count then
return false
end
end
end
return true
end
e.commonMessageTable=e.AddMessage(e.commonMessageTable,{GameObject={{msg="BuildingEnd",func=function(t,a)if e.IsTarget(a)then
local a=e.GetTargetVariableName(a)fvars[a]=fvars[a]+1
if e.ClearCondition()then
SsdFlagMission.SetNextStep"GameEscape"end
end
end}}})return e
end
return r