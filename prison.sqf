/*
	"Prison" static mission for Gulfcoast.
	Created by eraser1
	Credits to "Darth Rogue" for creating the base.
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
	[4572.69,14982.9,14.8614],
	[4525.67,14983.2,14.8614],
	[4451.04,14983.3,14.8614],
	[4447.88,14919.4,14.8614],
	[4455.75,14921.9,14.8614],
	[4444.26,14823.2,15.5908],
	[4504.14,14819.3,14.8614],
	[4631.27,14820.4,14.8614],
	[4634.75,14898.7,14.8614],
	[4516.04,14871.7,14.8614],
	[4506.41,14880.8,14.8614],
	[4488.73,14897.2,14.8614],
	[4471.5,14923.4,14.8614],
	[4488.59,14871.1,14.8614],
	[4511.08,14834.9,14.8614],
	[4597.29,14829.1,14.8614],
	[4473.2,14831.2,14.8614],
	[4468.21,14836.1,16.6216],
	[4453.17,14865.4,14.8614],
	[4458.92,14957,14.8614],
	[4483.2,14973.2,14.8614],
	[4536.39,14973.9,14.8614],
	[4584.96,14974.3,14.8614],
	[4612.31,14958.8,14.8614],
	[4592.09,14939.8,14.8614],
	[4589.11,14935.7,14.8614],
	[4587.01,14932.1,14.8614],
	[4584.6,14931,14.8614],
	[4586.66,14947.5,15.4024],
	[4523.17,14947.3,14.8614],
	[4524.35,14951.7,14.8614],
	[4521.87,14949.7,14.8614],
	[4558.53,14912.5,14.9477],
	[4552.87,14914.9,14.9476],
	[4546.47,14914.1,14.9477],
	[4552.81,14861.2,14.8614],
	[4589.34,14878.9,14.8614],
	[4498.32,14880.1,14.8614],
	[4495.13,14882.4,14.8614],
	[4483,14882.8,14.8614],
	[4473.43,14879.9,14.8614],
	[4511.28,14950.3,15.4024],
	[4516.26,14950.8,15.4024],
	[4541.78,14946.2,15.4024],
	[4552.38,14945.8,15.4024],
	[4573.27,14946.6,15.4024],
	[4498.67,14898.4,14.8614],
	[4480.66,14862.5,14.8614],
	[4505.97,14859.4,14.8614],
	[4473.3,14933.6,18.0297],
	[4465.35,14967.5,16.6226],
	[4607.14,14968.4,16.7288],
	[4614.71,14843.3,15.9089]
];

// Create AI
_AICount = 30 + (round (random 5));


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
		[4615.56,14833.9,27.6723],			
		[4616.4,14969.7,28.4922],			
		[4462.24,14969.7,28.3764],			
		[4459.44,14835.6,28.3849],			
		[4489.08,14829.7,18.996],
		[4582.95,14827.7,18.9953],
		[4596.17,14975.2,19.7411],
		[4473.43,14879.9,14.8614],
		[4501.48,14976.2,19.7172],
		[4587.32,14910.1,15.4024],
		[4503.42,14899.1,21.2209],
		[4596.66,14871.1,23.7784],
		[4595.99,14857.1,23.7784],
		[4609.24,14870.8,23.7784]
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
			
	        [4552.73,14853.4,14.8614],
	        [4555.61,14856.6,14.8614],
			[4586.91,14920.5,15.4024],
			[4586.17,14901.8,15.4024],
			[4632.39,14924.4,15.0248],
			[4631.91,14982.4,14.8614],
	        [4609.51,14921.7,14.8614],
	        [4609.53,14918.1,14.8614],
			[4587.39,14888.8,14.8614],
	        [4587.45,14886.6,14.8614],
	        [4587.9,14881.3,14.8614],
	        [4522.27,14891.8,19.2055],
	        [4522.25,14877.8,19.2055]
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
