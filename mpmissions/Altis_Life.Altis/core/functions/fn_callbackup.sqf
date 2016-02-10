/*
Script file made by: Maximum
Edited : Benoit Katecpo àKà ScaniaGaming
Idea based off: Liemans script - did way to much to achieve the same thing.
Description: Lets a officer request backup VIA scroll menu, made for AltisLifeRPG.com
*/
private ["_backupmsg"];
_msgBck = format["%1 a besoin de renforts en %2 !", name player, getPos player];

[[0,localize "STR_Item_backup",true,[profileName]],"life_fnc_broadcast",west,false] call life_fnc_MP;
[[ObjNull,_msgBck,player,1],"TON_fnc_handleMessages",false] spawn life_fnc_MP;

backupmsg = createMarker [("_backupmsg" + name player), getPos player];
_backupmsg setmarkertype "mil_warning";
_backupmsg setmarkercolor "colorRed";
_backupmsg setmarkertext format ["%1 a besoin de renforts !",name player];
sleep 60;
deletemarker _backupmsg;
hint "Marqueur supprimé";
sleep 320;
hint format ["%1, vous pouvez maintenant appeler du renfort !",name player];