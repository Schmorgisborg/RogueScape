#define MATURESERVER
#define ALLOWPLAY

//Mack, respawn/restart vote timer
#define RESPAWNTIME (5 SECONDS)
#define INITIAL_ROUND_TIMER (90 MINUTES)
#define ROUND_EXTENSION_TIME (15 MINUTES)

//#define MODE_RESTART
//comment out if you want to restart the server instead of shutting down

// Comment this out if you are debugging problems that might be obscured by custom error handling in world/Error
#ifdef DEBUG
#define USE_CUSTOM_ERROR_HANDLER
#endif

#ifdef TESTING
#define DATUMVAR_DEBUGGING_MODE

//#define GC_FAILURE_HARD_LOOKUP	//makes paths that fail to GC call find_references before del'ing.
									//implies FIND_REF_NO_CHECK_TICK

//#define FIND_REF_NO_CHECK_TICK	//Sets world.loop_checks to false and prevents find references from sleeping


//#define VISUALIZE_ACTIVE_TURFS	//Highlights atmos active turfs in green
#endif

//#define UNIT_TESTS			//Enables unit tests via TEST_RUN_PARAMETERF

#ifndef PRELOAD_RSC					//set to:
#define PRELOAD_RSC		2			//	0 to allow using external resources or on-demand behaviour;
#endif								//	1 to use the default behaviour;
									//	2 for preloading absolutely everything;

#ifdef LOWMEMORYMODE
#define FORCE_MAP "_maps/runtimestation.json"
#endif

//Update this whenever you need to take advantage of more recent byond features
#define MIN_COMPILER_VERSION 514
#if DM_VERSION < MIN_COMPILER_VERSION
//Don't forget to update this part
#error Your version of BYOND is too out-of-date to compile this project. Go to https://secure.byond.com/download and update.
#error You need version 513 or higher
#endif
#ifdef GC_FAILURE_HARD_LOOKUP
#define FIND_REF_NO_CHECK_TICK
#endif

#ifdef TRAVISBUILDING
#define UNIT_TESTS
#endif

#define TESTING
