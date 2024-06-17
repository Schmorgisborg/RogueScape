/datum/job/roguetown/adventurer/pilgrim
	title = "Pilgrim"
	flag = ADVENTURER
	department_flag = SERFS
	faction = "Station"
	total_positions = 9999
	spawn_positions = 128
	allowed_races = list("Humen",
	"Dwarf",
	"Elf",
	"Half-Elf",
	"Tiefling",
	"Dark Elf",
	"Aasimar"
	)
	tutorial = "The tradesmen of the land, pilgrims come to this land to create community and find security in the wilderness."
	allowed_patrons = list("Psydon", "Saradomin", "Guthix", "Zamorak")
	outfit = /datum/outfit/job/roguetown/adventurer/genadventurer
	outfit_female = /datum/outfit/job/roguetown/adventurer/genadventurer
	bypass_lastclass = TRUE
	bypass_jobban = FALSE
	isvillager = FALSE
	ispilgrim = TRUE
	display_order = JDO_PILGRIM
	min_pq = -999
