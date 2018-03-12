local e={}local c=SsdSbm.HasRecipe
local n=SsdSbm.AddRecipe
function e.UnlockConditionClearedRecipe(n)local n=SsdRecipeList.GetRecipeListByItemId[n]if not n then
return
end
for i,n in ipairs(n)do
e._UnlockConditionClearedRecipe(n)end
end
function e._UnlockConditionClearedRecipe(e)if c(e)then
return
end
local i=SsdRecipeList.GetStorySequenceByRecipeName[e]if i and(TppStory.GetCurrentStorySequence()<i)then
return
end
local i=SsdRecipeList.GetBuildingNameByRecipeName[e]if i and(SsdBuilding.GetItemCount{id=i}<=0)then
return
end
n(e)end
function e.UnlockRecipeOnAccessCockingFacility(n)local n=SsdRecipeList.GetRecipeNameByBuildingNameAndResourceName[n]for n,i in pairs(n)do
e._UnlockRecipeOnAccessCockingFacility(n,i)end
end
function e._UnlockRecipeOnAccessCockingFacility(i,e)if c(e)then
return
end
if(SsdSbm.GetCountResource{id=i,inInventory=true,inWarehouse=true,inLostCbox=true}>0)then
n(e)end
end
return e