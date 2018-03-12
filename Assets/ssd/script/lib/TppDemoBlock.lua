local t={}local e=ScriptBlock.GetCurrentScriptBlockId
local c=ScriptBlock.GetScriptBlockState
function t.OnAllocate()TppScriptBlock.InitScriptBlockState()end
function t.OnInitialize()end
function t.OnUpdate()local t=e()local c=c(t)if c==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
TppDemo.PlayOnDemoBlock()return
end
if TppScriptBlock.IsRequestActivate(t)then
TppScriptBlock.ActivateScriptBlockState(t)end
end
function t.OnTerminate()TppDemo.FinalizeOnDemoBlock()TppScriptBlock.FinalizeScriptBlockState()end
return t