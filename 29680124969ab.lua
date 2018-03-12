local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local e=1
local i={}function i.CreateInstance(a)local e=BaseFlagMission.CreateInstance(a)table.insert(e.stepList,4,"GameDefense")e.saveVarsList={{name=tostring(a).."isClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}}function e.ClearCondition()return fvars[tostring(a).."isClear"]end
function e.ClearDefense()SsdFlagMission.SetNextStep"GameEscape"fvars[tostring(a).."isClear"]=true
SsdFastTravel.UnlockFastTravelPoint(e.fasttravelPointName)end
e.commonMessageTable=e.AddMessage(e.commonMessageTable,{GameObject={{msg="BreakGimmick",func=function(t,a,t,t)if e.targetName and a==Fox.StrCode32(e.targetName)then
TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.TARGET_DEAD,TppDefine.GAME_OVER_RADIO.TARGET_DEAD)end
end}}})e.flagStep.GameMain.commonMessageTable=e.AddMessage(e.flagStep.GameMain.commonMessageTable,{GameObject={{msg="SwitchGimmick",func=function(t,n,n,a)if a~=0 then
local a=SsdFastTravel.GetFastTravelPointNameFromGimmick(t)if a==e.fasttravelPointName then
SsdFlagMission.SetNextStep"GameDefense"end
end
end}}})function e.flagStep.GameMain:OnEnter()e.baseStep.OnEnter(self)SsdFastTravel.UnlockFastTravelPointGimmick(e.fasttravelPointName)end
e.flagStep.GameDefense=e.CreateStep"GameDefense"e.flagStep.GameDefense.commonMessageTable=e.AddMessage(e.flagStep.GameDefense.commonMessageTable,{GameObject={{msg="FinishWave",func=function(a,a)e.ClearDefense()end},{msg="FinishDefenseGame",func=function()e.ClearDefense()end}}})function e.flagStep.GameDefense:OnEnter()e.baseStep.OnEnter(self)local n=e.waveName
local t=e.waveAttackerPos or nil
local s=e.waveAttackerRadius or 30
if n then
local n=e.targetIdentifier
local i=e.targetKey
local a,o
if n and i then
a,o=Tpp.GetLocator(n,targetkey)if a then
TppMission.SetDefensePosition(a)t=a
end
end
local a=e.waveLimitTime
local a=e.waveAnnihilation
if not a then
a=DEFAULT_ANNIHILATION
end
GameObject.SendCommand({type="TppCommandPost2"},{id="SetWaveAnnihilation",targetCount=a})GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=true})if Tpp.IsTypeTable(t)then
GameObject.SendCommand({type="SsdZombie"},{id="SetWaveAttacker",pos=t,radius=s})end
if e.waveStartEffectId and Tpp.IsTypeTable(e.waveStartEffectId)then
for a,e in ipairs(e.waveStartEffectId)do
TppDataUtility.CreateEffectFromGroupId(e)end
end
end
TppMission.StartDefenseGame(e.defenseTime,e.defenseTime/10)Mission.StartWave{waveName=n,waveLimitTime=waveLimitTime}end
function e.flagStep.GameDefense:OnLeave()e.baseStep.OnLeave(self)TppMission.OnClearDefenseGame()TppMission.StopDefenseGame()GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=false})GameObject.SendCommand({type="SsdZombie"},{id="ResetWaveAttacker"})GameObject.SendCommand({type="TppCommandPost2"},{id="KillWaveEnemy"})local a=e.waveEndEffectId or"explosion"TppDataUtility.CreateEffectFromGroupId(a)TppSoundDaemon.PostEvent"sfx_s_waveend_plasma"if e.waveStartEffectId and Tpp.IsTypeTable(e.waveStartEffectId)then
for a,e in ipairs(e.waveStartEffectId)do
TppDataUtility.DestroyEffectFromGroupId(e)end
end
end
return e
end
return i