local a=Fox.StrCode32
local e=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local i={}function i.CreateInstance(t,n)local e=BaseFlagMission.CreateInstance(t)e.targetTable=n
function e.GetTargetCount()local t=0
for e,e in pairs(e.targetTable)do
t=t+1
end
return t
end
function e.GetTargetVariableName(n)local e
if Tpp.IsTypeString(n)then
e=a(n)else
e=n
end
return tostring(t)..("_"..(tostring(e).."_Count"))end
function e.GetTargetClearVariableName(e)local n
if Tpp.IsTypeString(e)then
n=a(e)else
n=e
end
return tostring(t)..("_"..(tostring(n).."_Cleared"))end
function e.GetConditionalExecutionVarsName(e)return tostring(t)..("_"..(tostring(e).."_ConditionCleared"))end
function e.BeforeOnAllocate()if not e.saveVarsList then
e.saveVarsList={}end
for t,n in pairs(e.targetTable)do
table.insert(e.saveVarsList,{name=e.GetTargetVariableName(t),type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION})table.insert(e.saveVarsList,{name=e.GetTargetClearVariableName(t),type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION})end
local t=e.conditionalExecutionTableList
if Tpp.IsTypeTable(t)then
for t,n in pairs(t)do
table.insert(e.saveVarsList,{name=e.GetConditionalExecutionVarsName(t),type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION})end
end
end
function e.IsTarget(t)return fvars[e.GetTargetVariableName(t)]~=nil
end
function e.GetItemCount(t)return fvars[e.GetTargetVariableName(t)]end
function e.GetClearCount()local t=0
for r,a in pairs(e.targetTable)do
local n=0
if a.permitPosession then
n=SsdSbm.GetCountProduction{id=r,inInventory=true,inWarehouse=true}else
n=fvars[e.GetTargetVariableName(r)]end
if n>=a.count then
t=t+1
end
end
return t
end
function e.ClearCondition()for n,a in pairs(e.targetTable)do
local t=0
if a.permitPosession then
t=SsdSbm.GetCountProduction{id=n,inInventory=true,inWarehouse=true}else
t=fvars[e.GetTargetVariableName(n)]end
if t<a.count then
return false
end
end
return true
end
function e.IsConditionalExecutionCleared(t)return fvars[e.GetConditionalExecutionVarsName(t)]end
function e.ClearConditionalExecution(t)fvars[e.GetConditionalExecutionVarsName(t)]=true
end
e.commonMessageTable=e.AddMessage(e.commonMessageTable,{Sbm={{msg="OnGetItem",func=function(t,n,n,r)if SsdFlagMission.GetCurrentStepIndex()>=SsdFlagMission.GetStepIndex"GameEscape"then
return
end
local a=false
if e.IsTarget(t)then
local n=e.GetTargetVariableName(t)fvars[n]=fvars[n]+r
TppUI.ShowAnnounceLog("achieveObjectiveCount",e.GetClearCount(),e.GetTargetCount())if e.ClearCondition()then
SsdFlagMission.SetNextStep"GameEscape"a=true
elseif not fvars[e.GetTargetClearVariableName(t)]then
local n=e.targetTable[t].radio
if n then
TppRadio.Play(n)end
fvars[e.GetTargetClearVariableName(t)]=true
end
end
local t=e.conditionalExecutionTableList
if not Tpp.IsTypeTable(t)then
return false
end
for t,r in pairs(t)do
if not e.IsConditionalExecutionCleared(t)then
local n=r.condition
if Tpp.IsTypeTable(n)then
local a=true
local n=n.resource
if Tpp.IsTypeTable(n)then
for t,e in ipairs(n)do
local t=SsdSbm.GetCountResource{id=e.name,inInventory=true,inWarehouse=true}if t<e.count then
a=false
end
end
end
if a then
local n=r.execution
if Tpp.IsTypeTable(n)then
local e=n.radio
if e then
TppRadio.Play(e)end
end
e.ClearConditionalExecution(t)end
end
end
end
end}}})return e
end
return i