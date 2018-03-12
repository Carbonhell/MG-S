local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local t={}function t.CreateInstance(a,s)local e=BaseFlagMission.CreateInstance(a)t.targetTrapName=s
e.saveVarsList={{name=tostring(a).."isClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}}function e.ClearCondition()return fvars[tostring(a).."isClear"]end
e.commonMessageTable=e.AddMessage(e.commonMessageTable,{Trap={{sender=s,msg="Enter",func=function(t,e)if Tpp.IsPlayer(e)then
local e=SsdFlagMission.GetCurrentStepName()if e~="GameEscape"then
SsdFlagMission.SetNextStep"GameEscape"fvars[tostring(a).."isClear"]=true
end
end
end,option={isExecFastTravel=true}}}})return e
end
return t