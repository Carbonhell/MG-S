local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local n=GameObject.GetGameObjectId
local a={}function a.CreateInstance(t,a)local e=BaseFlagMission.CreateInstance(t)e.targetList=a
function e.GetTargetDeadVariableName(a)return tostring(t)..("_"..(tostring(a).."_IsDead"))end
e.saveVarsList={}for a,t in ipairs(e.targetList)do
table.insert(e.saveVarsList,{name=e.GetTargetDeadVariableName(t),type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION})end
function e.IsTarget(t)if fvars[e.GetTargetDeadVariableName(t)]~=nil then
return true
end
return false
end
function e.GetTargetNameFromGameObjectId(t)for a,e in ipairs(e.targetList)do
if t==n(e)then
return e
end
end
end
function e.IsTargetDead(t)return fvars[e.GetTargetDeadVariableName(t)]end
function e.OnTargetDead(t)fvars[e.GetTargetDeadVariableName(t)]=true
end
function e.ClearCondition()for a,t in ipairs(e.targetList)do
if not e.IsTargetDead(t)then
return false
end
end
return true
end
function e.GetDeadCount()local t=0
for n,a in ipairs(e.targetList)do
if e.IsTargetDead(a)then
t=t+1
end
end
return t
end
e.commonMessageTable=e.AddMessage(e.commonMessageTable,{GameObject={{msg="Dead",func=function(t)local t=e.GetTargetNameFromGameObjectId(t)if t then
e.OnTargetDead(t)else
return
end
TppUI.ShowAnnounceLog("achieveObjectiveCount",e.GetDeadCount(),#e.targetList)if e.ClearCondition()then
SsdFlagMission.SetNextStep"GameEscape"end
end}}})return e
end
return a