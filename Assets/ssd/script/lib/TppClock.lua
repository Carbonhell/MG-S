local e={}local a=Fox.StrCode32
local r=(1/60)/60
local s=1/60
local l=60*60
local o=60
e.DEPLOY_TIME={CURRENT=0,MORNING=1,NIGHT=2}function e.FormalizeTime(n,t)local i=t or"time"if(i=="number")then
return n
end
local r=math.floor(n*r)local a=r*l
local t=math.floor((n-a)*s)local l=t*o
local n=math.floor((n-a)-l)local a=n
if(i=="time")then
return r,t,n
elseif(i=="string")then
return string.format("%02d:%02d:%02d",r,t,n)else
return nil
end
end
e.DAY_TO_NIGHT=e.FormalizeTime(WeatherManager.NIGHT_START_CLOCK,"string")e.NIGHT_TO_DAY=e.FormalizeTime(WeatherManager.NIGHT_END_CLOCK,"string")e.NIGHT_TO_MIDNIGHT="22:00:00"function e.RegisterClockMessage(r,n)local t
if(type(n)=="string")then
t=e.ParseTimeString(n,"number")elseif(type(n)=="number")then
t=n
else
return
end
TppCommand.Weather.RegisterClockMessage{id=a(r),seconds=t,isRepeat=true,nil}end
function e.UnregisterClockMessage(e)TppCommand.Weather.UnregisterClockMessage{id=a(e)}end
function e.GetTime(n)return e.FormalizeTime(vars.clock,n)end
function e.GetDays()return WeatherManager.GetDays()end
function e.GetClockValue()return WeatherManager.GetClockValue()end
function e.GetTimeOfDay()if(WeatherManager.IsNight())then
return"night"else
return"day"end
end
function e.GetTimeOfDayIncludeMidNight()if WeatherManager.IsNight()then
local n=e.GetTime"number"if(n<e.TIME_AT_MIDNIGHT)then
return"night"else
return"midnight"end
else
return"day"end
end
function e.SetTime(n)local e=e.ParseTimeString(n,"number")vars.clock=e
end
function e.AddTime(n)local t
if(type(n)=="number")then
t=n
else
t=e.ParseTimeString(n,"number")end
vars.clock=vars.clock+t
end
function e.Start()TppCommand.Weather.SetClockTimeScale(20)end
function e.Stop()TppCommand.Weather.SetClockTimeScale(0)end
function e.SaveMissionStartClock(n)if n then
gvars.missionStartClock=e.ParseTimeString(n,"number")else
gvars.missionStartClock=vars.clock
end
end
function e.RestoreMissionStartClock()vars.clock=gvars.missionStartClock
end
function e.ParseTimeString(n,e)if(type(n)~="string")then
return nil
end
local n=Tpp.SplitString(n,":")local t=tonumber(n[1])local r=tonumber(n[2])local n=tonumber(n[3])e=e or"time"if(e=="time")then
return t,r,n
elseif(e=="number")then
local t=t*l
local e=r*o
local n=n
return((t+e)+n)else
return nil
end
end
function e.OnAllocate(n)if TppCommand.Weather.UnregisterAllClockMessages then
TppCommand.Weather.UnregisterAllClockMessages()end
end
e.TIME_AT_NIGHT=e.ParseTimeString(e.DAY_TO_NIGHT,"number")e.TIME_AT_MORNING=e.ParseTimeString(e.NIGHT_TO_DAY,"number")e.TIME_AT_MIDNIGHT=e.ParseTimeString(e.NIGHT_TO_MIDNIGHT,"number")return e