local n={}local e=Fox.StrCode32
local t=Tpp.StrCode32Table
function n.CreateInstance(n)local e={}e.missionName=n
e.NO_RESULT=true
e.sequences={}e.sequenceList={"Seq_Game_MainGame"}function e.OnLoad()TppSequence.RegisterSequences(e.sequenceList)TppSequence.RegisterSequenceTable(e.sequences)e.enemyScript=_G[tostring(e.missionName).."_enemy"]e.radioScript=_G[tostring(e.missionName).."_radio"]end
function e.MissionPrepare()if e.RegiserMissionSystemCallback()then
e.RegiserMissionSystemCallback()end
end
function e.OnRestoreSVars()end
e.messageTable={Trap={{sender="trap_base",msg="Enter",func=function()e.OnReturnToBaseOrCamp()TppQuest.UpdateActiveQuest()TppMission.UpdateCheckPointAtCurrentPosition()end,option={isExecFastTravel=true}},{sender="trap_base",msg="Exit",func=function()SsdBlankMap.StartExploration()TppMission.UpdateCheckPointAtCurrentPosition()end,option={isExecFastTravel=true}}},GameObject={{msg="GimmickIn",func=function(t,n)if n==Fox.StrCode32"TYPE_CAMP"then
e.OnReturnToBaseOrCamp()TppMission.UpdateCheckPointAtCurrentPosition()end
end}},nil}function e.Messages()if e.messageTable then
return t(e.messageTable)end
end
function e.OnReturnToBaseOrCamp()SsdSbm.ShowSettlementReport()SsdBlankMap.UpdateReachInfo()end
return e
end
return n