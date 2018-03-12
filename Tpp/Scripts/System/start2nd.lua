local function e()coroutine.yield()end
dofile"/Assets/tpp/sound/scripts/motion/setup.lua"e()local t=SubtitlesDaemon.GetInstance()if SubtitlesCommand then
dofile"/Assets/tpp/ui/Subtitles/script/priorityTable.lua"if TppGameSequence.IsMaster()==false then
e()dofile"/Assets/ssd/ui/Subtitles/script/sdTextRelationalTableNotEd.lua"end
end
e()if Script.LoadLibrary then
Script.LoadLibrary"/Assets/ssd/level_asset/chara/player/game_object/SsdPlayerInitializeScript.lua"e()end
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
dofile"/Assets/tpp/radio/script/RadioParameterTable.lua"end