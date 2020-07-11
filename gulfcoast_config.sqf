

// Making these configs below as strict as possible will help in reducing the number of attempts taken to find a valid position, and as a result, improve performance.

DMS_MinDistFromWestBorder			= 900;
DMS_MinDistFromEastBorder			= 300;
DMS_MinDistFromSouthBorder			= 250;
DMS_MinDistFromNorthBorder			= 300;

// Gulfcoast is pretty flat
DMS_MinSurfaceNormal				= 0.8;

DMS_StaticMissionTypes append 
[["prison",5]];

// Add the "comms_alpha_buildings" to spawn on server startup. NOTE: "append" and "pushback" are NOT the same.
DMS_BasesToImportOnServerStart append ["prisonbase"];


// These configs are the default values from the main config. Just included here as an example.
DMS_PlayerNearBlacklist				= 200;
DMS_SpawnZoneNearBlacklist			= 500;
DMS_TraderZoneNearBlacklist			= 500;
DMS_MissionNearBlacklist			= 500;
DMS_WaterNearBlacklist				= 250;
