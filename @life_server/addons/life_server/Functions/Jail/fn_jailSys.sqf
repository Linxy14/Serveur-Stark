/*
	File: fn_jailSys.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	I forget?
*/
private["_unit","_bad","_id","_ret","_time"];
_unit = [_this,0,Objnull,[Objnull]] call BIS_fnc_param;
if(isNull _unit) exitWith {};
_bad = [_this,1,false,[false]] call BIS_fnc_param;
_time = [_this,2,15,[0]] call BIS_fnc_param;
_id = owner _unit;

diag_log format["**TIMEJAIL** Le temps de prison de %1 est de %2",name _unit , _time];

_ret = [_unit] call life_fnc_wantedPerson;
[[_ret,_bad,_time],"life_fnc_jailMe",_id,false] spawn life_fnc_MP;