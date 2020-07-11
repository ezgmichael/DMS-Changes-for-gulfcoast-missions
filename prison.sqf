/*
	"Prison" static mission for Gulfcoast.
	Created by JustMichael											
*/
private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_cash"];																																																																																															 

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [4564,14885,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								"difficult",
								"difficult",
								"difficult",
								"hardcore",
								"hardcore",
								"hardcore",
								"hardcore"
							];
							
							
//choose mission difficulty and set value and is also marker colour
_difficultyM = selectRandom _PossibleDifficulty;

switch (_difficultyM) do
{
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (30 + (round (random 7)));
		_AIMaxReinforcements = (30 + (round (random 20)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (750 + round (random (1000)));					//this gives 750 to 1750 cash
		_crate_weapons0 	= (30 + (round (random 20)));
		_crate_items0 		= (15 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (8 + (round (random 3)));
		_crate_items1 		= (30 + (round (random 20)));
		_crate_backpacks1 	= (6 + (round (random 4)));
	};
	//case "hardcore":
	default
	{
		_difficulty = "hardcore";
		_AICount = (30 + (round (random 10)));
		_AIMaxReinforcements = (40 + (round (random 20)));
		_AItrigger = (15 + (round (random 5)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (1000 + round (random (1500)));					//this gives 1000 to 2500 cash
		_crate_weapons0 	= (20 + (round (random 5)));
		_crate_items0 		= (20 + (round (random 5)));
		_crate_backpacks0 	= (2 + (round (random 1)));
		_crate_weapons1 	= (10 + (round (random 2)));
		_crate_items1 		= (40 + (round (random 10)));
		_crate_backpacks1 	= (10 + (round (random 2)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	[4546.53,14884.9,0],
	[4487.93,14882.4,0],
	[4487.03,14921.4,0],
	[4590.76,14882.2,0],
	[4606.09,14911.8,0],
	[4605.79,14922,0],
	[4570.33,14915.7,0],
	[4628.47,14919.4,0],
	[4631.81,14962.6,0],
	[4633.73,14863.6,0],
	[4516.22,14849,0],
	[4520.63,14946.2,0],
	[4547.27,14939.9,0],
	[4586.17,14941.3,0],
	[4520.65,14819.8,0],
	[4446.75,14908.4,0],
	[4445.37,14865.2,0],
	[4591.49,14983.1,0],
	[4514.05,14983.2,0],
	[4521.44,14968,0],
	[4578.2,14968.1,0],
	[4584.62,14880.8,0],
	[4589.15,14847.7,0],
	[4528.02,14834.7,0],
	[4603.61,14895,0],
	[4476.91,14951.2,0]
];

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
		[4602.96,14828.1,4.12296],
	    [4470.44,14830,4.12296],
	    [4454.94,14891.7,4.83266],
	    [4455.86,14917.9,4.83266],
	    [4473.72,14976,4.85782],
	    [4602.64,14975.2,4.83266],
	    [4622.36,14940.1,4.83266],
	    [4622.83,14900.5,4.83266],
	    [4511.78,14898.1,6.39788]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;

// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =
								[
									[[4575.56,14857.1,0],"I_CargoNet_01_ammo_F"],
	                                [[4536.75,14857.9,0],"I_CargoNet_01_ammo_F"],
	                                [[4475.98,14895.1,0],"I_CargoNet_01_ammo_F"],
	                                [[4473.21,14953.3,0],"I_CargoNet_01_ammo_F"],
	                                [[4606.42,14876.3,0],"I_CargoNet_01_ammo_F"]
								];	
								
{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;

// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;
_crate1 = [_crateClasses_and_Positions select 1 select 1, _crateClasses_and_Positions select 1 select 0] call DMS_fnc_SpawnCrate;


// Enable smoke on the crates due to size of area
{
	_x setVariable ["DMS_AllowSmoke", true];
} forEach [_crate0,_crate1];

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
				0,		// Let's limit number of units instead...
				0
			],
			[
				_AIMaxReinforcements,	// Maximum units that can be given as reinforcements (defined in difficulty selection).
				0
			]
		],
		[
			_AIdelay,		// The delay between reinforcements. >> you can change this in difficulty settings
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
			_AIwave			// X reinforcement units per wave. >> you can change this in mission difficulty section
		]
	]
];

// setup crates with items from choices
_crate_loot_values0 =
						[
							_crate_weapons0,		// Set in difficulty select - Weapons
							_crate_items0,			// Set in difficulty select - Items
							_crate_backpacks0 		// Set in difficulty select - Backpacks
						];
_crate_loot_values1 =
						[
							_crate_weapons1,		// Set in difficulty select - Weapons
							_crate_items1,			// Set in difficulty select - Items
							_crate_backpacks1 		// Set in difficulty select - Backpacks
						];

// add cash to crate
_crate1 setVariable ["ExileMoney", _cash,true];						
// Define mission-spawned objects and loot values
_missionObjs =
				[
					_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
					[],
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
				];


// Define Mission Start message
_msgStart = ['#FFFF00',format["%1 Armed militants are raiding the Prison",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully assaulted the base on the Prison and secured the cache!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Seems like the militants got bored and left the base, taking the cache with them..."];

// Define mission name (for map marker and logging)
_missionName = "Prison Raid";

// Create Markers
_markers =
			[
				_pos,
				_missionName,
				_difficultyM
			] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [300,300];

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
	_difficultyM,
				[[],[]]
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