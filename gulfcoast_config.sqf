// Making these configs below as strict as possible will help in reducing the number of attempts taken to find a valid position, and as a result, improve performance.

DMS_MinDistFromWestBorder			= 900;
DMS_MinDistFromEastBorder			= 300;
DMS_MinDistFromSouthBorder			= 250;
DMS_MinDistFromNorthBorder			= 300;

// Gulfcoast is pretty flat
DMS_MinSurfaceNormal				= 0.85;

DMS_findSafePosBlacklist append
[
	[[4534,14904],1000]		// Salt flats are blacklisted for Altis by default.
];


// These configs are the default values from the main config. Just included here as an example.
DMS_PlayerNearBlacklist				= 200;
DMS_SpawnZoneNearBlacklist			= 500;
DMS_TraderZoneNearBlacklist			= 1000;
DMS_MissionNearBlacklist			= 1500;
DMS_WaterNearBlacklist				= 250;

// Add the "saltflats" and "slums" mission to the existing mission types.
DMS_StaticMissionTypes append [["prison"]];

// Add the "salt flats base" and "slums" to the "bases" to spawn on server startup. NOTE: "append" and "pushback" are NOT the same.
DMS_BasesToImportOnServerStart append ["prisonbase"];
