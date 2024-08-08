GLOBAL_LIST_INIT(kingdomlist, list("Psydonia"))//map.custom_faction_nr
GLOBAL_LIST_INIT(custom_civs, list(
							"Psydonia" = list("Psydonia","psy","#A88B61","#40284E"),
							"Night Manor" = list("Night Manor","moon","#ff0000","#00ff00"),
							"Creachers" = list("Creachers","upsy","ff0000","#0000ff")))
GLOBAL_LIST_INIT(kingdom_hud_users, list())

#define isclient(A) istype(A, /client)
#define isdatum(A) istype(A, /datum)
