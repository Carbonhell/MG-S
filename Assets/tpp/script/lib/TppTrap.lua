local e={}local a=Fox.StrCode32
local a=Tpp.IsTypeFunc
local a=Tpp.IsTypeTable
local t=Tpp.IsTypeString
local r=64
function e.OnAllocate(e)if e.sequence and e.sequence.VARIABLE_TRAP_SETTING then
if not a(e.sequence.VARIABLE_TRAP_SETTING)then
return
end
mvars.trp_variableTrapList=e.sequence.VARIABLE_TRAP_SETTING
if#mvars.trp_variableTrapList==0 then
return
end
if#mvars.trp_variableTrapList>r then
return
end
mvars.trp_variableTrapTable={}for r,a in ipairs(mvars.trp_variableTrapList)do
local e=a.name
if not t(e)then
return
end
if a.initialState==nil then
return
end
if a.type==nil then
return
end
mvars.trp_variableTrapTable[e]={}mvars.trp_variableTrapTable[e].type=a.type
mvars.trp_variableTrapTable[e].initialState=a.initialState
mvars.trp_variableTrapTable[e].index=r
mvars.trp_variableTrapTable[e].packLabel=a.packLabel
end
end
end
function e.DEBUG_Init()mvars.debug.showTrapStatus=false;(nil).AddDebugMenu("LuaSystem","TRP.trapStatus","bool",mvars.debug,"showTrapStatus")mvars.debug.trapStatusScroll=0;(nil).AddDebugMenu("LuaSystem","TRP.trapScroll","int32",mvars.debug,"trapStatusScroll")end
function e.DebugUpdate()local e=mvars
local a=e.debug
local t=DebugText.Print
local r=DebugText.NewContext()if e.debug.showTrapStatus and e.trp_variableTrapList then
t(r,{.5,.5,1},"LuaSystem TRP.trapStatus")local a=1
if e.debug.trapStatusScroll>1 then
a=e.debug.trapStatusScroll
end
for e,n in ipairs(e.trp_variableTrapList)do
if e>=a then
local a=n.name
local e=svars.trp_variableTrapEnable[e]t(r,{.5,.5,1},"trapName = "..(tostring(a)..(", status = "..tostring(e))))end
end
end
end
function e.InitializeVariableTraps()if mvars.trp_variableTrapList==nil then
return
end
for t,a in ipairs(mvars.trp_variableTrapList)do
local t=true
if a.packLabel then
t=TppPackList.IsMissionPackLabelList(a.packLabel)end
if t then
if a.initialState==TppDefine.TRAP_STATE.ENABLE then
e.Enable(a.name)elseif a.initialState==TppDefine.TRAP_STATE.DISABLE then
e.Disable(a.name)else
e.Enable(a.name)end
end
end
end
function e.RestoreVariableTrapState()if mvars.trp_variableTrapList==nil then
return
end
for r,a in ipairs(mvars.trp_variableTrapList)do
local t=true
if a.packLabel then
t=TppPackList.IsMissionPackLabelList(a.packLabel)end
if t then
if svars.trp_variableTrapEnable[r]then
e.Enable(a.name)else
e.Disable(a.name)end
end
end
end
function e.DeclareSVars()return{{name="trp_variableTrapEnable",arraySize=r,type=TppScriptVars.TYPE_BOOL,value=true,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}end
function e.Enable(a)e.ChangeTrapState(a,true)end
function e.Disable(a)e.ChangeTrapState(a,false)end
function e.ChangeTrapState(a,t)local r=mvars.trp_variableTrapTable[a]if r==nil then
return
end
local i=r.index
local n
if r.type==TppDefine.TRAP_TYPE.NORMAL then
n=e.ChangeNormalTrapState(a,t)elseif r.type==TppDefine.TRAP_TYPE.TRIGGER then
n=e.ChangeTriggerTrapState(a,t)else
n=e.ChangeNormalTrapState(a,t)end
if n then
svars.trp_variableTrapEnable[i]=t
end
end
function e.ChangeNormalTrapState(e,t)local a=Tpp.GetDataBodyWithIdentifier("VariableTrapIdentifier",e,"GeoTrap")if a then
TppDataUtility.SetEnableDataFromIdentifier("VariableTrapIdentifier",e,t)return true
end
end
function e.ChangeTriggerTrapState(a,e)Geo.GeoLuaEnableTriggerTrap(a,e)return true
end
return e