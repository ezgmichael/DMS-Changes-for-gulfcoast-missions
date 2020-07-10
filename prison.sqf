/*
	"Prison" static mission for Gulfcoast.
	Created by JustMichael											
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [4534,14904,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	_pos,
	_pos,
	_pos,
	[4500.52,14885.1,14.86],
	[4538.14,14885.4,14.86],
	[4579.8,14884.5,14.86],
	[4532.96,14835.3,14.86],
	[4545.87,14885.1,14.86],
	[4540.32,14939.2,14.86]
	[4492.66,14942,14.86],
	[4548.14,14885.4,14.86],
	[4569.8,14887.5,14.86],
	[4542.96,14845.3,14.86],
	[4555.87,14895.1,14.86],
	[4550.32,14949.2,14.86],
	[4482.66,14952,14.86],					   
	[4555.32,14940.2,14.86],
	[4488.66,14956,14.86],					   
	[4608.44,14894.8,14.86],
	[4464.45,14861.7,14.86],
	[4491.94,14919.4,14.86],
	[4533.31,14904.7,14.86],
	[4491.94,14919.4,14.86],
	[4533.31,14904.7,14.86],					   
	[4592.41,14850.6,14.86],
	[4585.16,14938.9,14.86],
	[4628.23,14918.9,14.86],
	[4628.46,14923,14.86],
	[4513.01,14824.9,14.86],
	[4520.18,14981.7,14.86]
];

// Create AI
_AICount = 20 + (round (random 5));


_group =
[
	_AISoldierSpawnLocations,
	_AICount,
	_difficulty,
	"random",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;


_staticGuns =
[
	[												  
		_pos vectorAdd [5,0,0],			// 5 meters East of center pos
		_pos vectorAdd [-5,0,0],		// 5 meters West of center pos
		_pos vectorAdd [0,5,0],			// 5 meters North of center pos
		_pos vectorAdd [0,-5,0],		// 5 meters South of center pos
		[4456.89,14959.2,19.6845],
	        [4622.77,14959.6,19.7786],
	        [4453.45,14846.9,19.7038],
	        [4604.85,14828,18.9939],
	        [4512.3,14899.8,21.2194]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;



// Create Crate
_crateClassname = "I_CargoNet_01_ammo_F";
deleteVehicle (nearestObject [_pos, _crateClassname]);		// Make sure to remove any previous crate.

_crate = [_crateClassname, _pos] call DMS_fnc_SpawnCrate;



// Spawn the vehicle AFTER the base so that it spawns the vehicle in a (relatively) clear position.
_veh =
[
	[
		_pos getPos [100,random 360],
		_pos
	],
	_group,
	"assault",
	_difficulty,
	_side
] call DMS_fnc_SpawnAIVehicle;


// Define mission-spawned AI Units
_missionAIUnits =
[
	_group 		// We only spawned the single group for this mission
];

// Define the group reinforcements
_groupReinforcementsInfo =
[
	[
		_group,			// pass the group
		[
			[
				5,		// Only 5 "waves" (5 vehicles can spawn as reinforcement)
				0
			],
			[
				-1,		// No need to limit the number of units since we're limiting "waves"
				0
			]
		],
		[
			300,		// At least a 5 minute delay between reinforcements.
			diag_tickTime
		],
		[	
	        [4608.19,14945.7,0],
	        [4542.34,14837.6,0],
	        [4539.79,14964.1,0],
	        [4460.68,14922.1,0],
	        [4461,14927.4,0],
	        [4461.52,14933,0],
	        [4446.81,14904.1,0],
		[4449.81,14704.1,0]
		],
		"random",
		_difficulty,
		_side,
		"armed_vehicle",
		[
			7,			// Reinforcements will only trigger if there's fewer than 7 members left in the group
			"random"	// Select a random armed vehicle from "DMS_ArmedVehicles"
		]
	],
	[
		_group,			// pass the group (again)
		[
			[
				-1,		// Let's limit number of units instead...
				0
			],
			[
				100,	// Maximum 100 units can be given as reinforcements.
				0
			]
		],
		[
			240,		// About a 4 minute delay between reinforcements.
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			10,			// Reinforcements will only trigger if there's fewer than 10 members left in the group
			7			// 7 reinforcement units per wave.
		]
	]
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns+[_veh],			// armed AI vehicle and static gun(s). Note, we don't add the base itself because we don't want to delete it and respawn it if the mission respawns.
	[],
	[[_crate,[75,250,25]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "A heavily guarded base has been located on the Prison! There are reports they have a large weapon cache..."];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully assaulted the base on the Prison and secured the cache!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Seems like the guards got bored and left the base, taking the cache with them..."];

// Define mission name (for map marker and logging)
_missionName = "Prison Raid";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

(_markers select 1) setMarkerSize [750,750];

// Record time here (for logging purposes, otherwise you could just put "diag_tickTime" into the "DMS_AddMissionToMonitor" parameters directly)
_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			_group
		],
		[
			"playerNear",
			[_pos,100]
		]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_markers,
	_side,
	_difficulty,
	[]
] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));

	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;


	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;


	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};


// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;



if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};
