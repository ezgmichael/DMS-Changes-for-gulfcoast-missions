

// Making these configs below as strict as possible will help in reducing the number of attempts taken to find a valid position, and as a result, improve performance.

DMS_MinDistFromWestBorder			= 900;
DMS_MinDistFromEastBorder			= 300;
DMS_MinDistFromSouthBorder			= 250;
DMS_MinDistFromNorthBorder			= 300;

// Gulfcoast is pretty flat
DMS_MinSurfaceNormal				= 0.85;
// These configs are the default values from the main config. Just included here as an example.
DMS_PlayerNearBlacklist				= 200;
DMS_SpawnZoneNearBlacklist			= 500;
DMS_TraderZoneNearBlacklist			= 1000;
DMS_MissionNearBlacklist			= 1500;
DMS_WaterNearBlacklist				= 250;

DMS_StaticMissionTypes append [ 
                                        //["DerHafen",1],
                                        //["WasserFun",1],
                                        //["Caro",1]
];

// Add the "salt flats base" and "slums" to the "bases" to spawn on server startup. NOTE: "append" and "pushback" are NOT the same."saltflatsbase",
//DMS_BasesToImportOnServerStart append ["slums_objects"];
