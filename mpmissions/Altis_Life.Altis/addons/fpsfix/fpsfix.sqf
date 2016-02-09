//	@file Version: 1.0
//	@file Name: fpsfix.sqf
//      @file Author: AgentRev
//	@file Edit/traduz: RenildoMarcio
//      @file WebSite: www.altisliferpg.com.br
//	@file Created: 01/03/2015 07:50

// Ce script va augmenter FPS client de 25-50% pour les missions avec beaucoup de véhicules répartis dans la carte.
// Il doit être engendré ou execVM'd une fois sur chaque client. Pour A3Wasteland, il est execVM'd à la fin de "client \ init.sqf"

// Si vous décidez de l'utiliser dans une autre mission, un peu mention dans les crédits serait appréciée :) - RenildoMarcio

if (isServer) exitWith {};

diag_log "-------- Lade FPS-Fix (intern) --------";

#define MOVEMENT_DISTANCE_RESCAN 100
#define DISABLE_DISTANCE_IMMOBILE 1000
#define DISABLE_DISTANCE_MOBILE 2500

private ["_eventCode", "_vehicleManager"];

_eventCode =
{
	_vehicle = _this select 0;
	if (!simulationEnabled _vehicle) then { _vehicle enableSimulation true };
	_vehicle setVariable ["fpsFix_simulationCooloff", diag_tickTime + 20];
};

_vehicleManager =
{
	private ["_vehicle", "_tryEnable", "_dist", "_vel"];

	{
		if !(_x isKindOf "CAManBase") then
		{
			_vehicle = _x;
			_tryEnable = true;

			if (!local _vehicle &&
			   {_vehicle isKindOf "Man" || {count crew _vehicle == 0}} &&
			   {_vehicle getVariable ["fpsFix_simulationCooloff", 0] < diag_tickTime} &&
			   {isTouchingGround _vehicle}) then
			{
				_dist = _vehicle distance positionCameraToWorld [0,0,0];
				_vel = velocity _vehicle distance [0,0,0];

				if ((_vel < 0.1 && {!(_vehicle isKindOf "Man")} && {_dist > DISABLE_DISTANCE_IMMOBILE}) ||
				   {_dist > DISABLE_DISTANCE_MOBILE}) then
				{
					_vehicle enableSimulation false;
					_tryEnable = false;
					sleep 0.01;
				};
			};
			
			if (_tryEnable && {!simulationEnabled _vehicle}) then
			{
				_vehicle enableSimulation true;
			};

			if !(_vehicle getVariable ["fpsFix_eventHandlers", false]) then
			{
				if (_vehicle isKindOf "AllVehicles" && {!(_vehicle isKindOf "Man")}) then
				{
					//_vehicle addEventHandler ["EpeContactStart", _eventCode];
					_vehicle addEventHandler ["GetIn", _eventCode];
				};
				
				_vehicle addEventHandler ["Killed", _eventCode];

				_vehicle setVariable ["fpsFix_eventHandlers", true];
			};
		};
	} forEach entities "All";
};

_lastPos = [0,0,0];

while {true} do
{
	_camPos = positionCameraToWorld [0,0,0];

	if (_lastPos distance _camPos > MOVEMENT_DISTANCE_RESCAN) then
	{
		_lastPos = _camPos;
		call _vehicleManager;
	};

	sleep 5;
};
diag_log "-------- FPS-Fix (intern) geladen --------";