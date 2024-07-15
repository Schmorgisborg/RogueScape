GLOBAL_LIST_INIT(kingdomlist, list("Psydonia"))//map.custom_faction_nr
GLOBAL_LIST_INIT(custom_civs, list("Psydonia","psy","#A88B61","#40284E"))
GLOBAL_LIST_INIT(kingdom_hud_users, list())

#define isclient(A) istype(A, /client)
#define isdatum(A) istype(A, /datum)

#define FACTION_TO_ENEMIES 11
#define BASE_FACTION 14
#define SQUAD_FACTION 15
