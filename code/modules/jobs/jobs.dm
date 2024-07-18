GLOBAL_LIST_INIT(good_positions, list(
	"Master Wizard",
	"Artificer",
	"Guard",
	"Monk",
	"Pilgrim",
	"Adventurer"
	))

GLOBAL_LIST_INIT(bad_positions, list(
	"Nightman",
	"Grabber",
	"Younker"
	))

GLOBAL_LIST_INIT(evil_positions, list(
	"Skeleton",
	"Goblin"
	))


//to be removed
GLOBAL_LIST_INIT(command_positions, list(
	"Captain",
	"Head of Personnel",
	"Head of Security",
	"Chief Engineer",
	"Research Director",
	"Chief Medical Officer"))


GLOBAL_LIST_INIT(engineering_positions, list(
	"Chief Engineer",
	"Station Engineer",
	"Atmospheric Technician"))


GLOBAL_LIST_INIT(medical_positions, list(
	"Chief Medical Officer",
	"Medical Doctor",
	"Geneticist",
	"Virologist",
	"Chemist"))


GLOBAL_LIST_INIT(science_positions, list(
	"Research Director",
	"Scientist",
	"Roboticist"))


GLOBAL_LIST_INIT(supply_positions, list(
	"Head of Personnel",
	"Quartermaster",
	"Cargo Technician",
	"Shaft Miner"))


GLOBAL_LIST_INIT(civilian_positions, list(
	"Bartender",
	"Kek",
	"Cook",
	"Janitor",
	"Curator",
	"Lawyer",
	"Chaplain",
	"Clown",
	"Mime",
	"Assistant"))


GLOBAL_LIST_INIT(security_positions, list(
	"Head of Security",
	"Warden",
	"Detective",
	"Security Officer"))


GLOBAL_LIST_INIT(nonhuman_positions, list(
	"AI",
	"Cyborg",
	ROLE_PAI))

GLOBAL_LIST_INIT(noble_positions, list(
	"King",
	"Queen",
	"Prince",
	"Sheriff",
	"Steward",
	"Court Magician"
	))

GLOBAL_LIST_INIT(garrison_positions, list(
	"Town Guard",
	"Castle Guard",
	"Veteran",
	"Dungeoneer",
	"Gatemaster",
	"Village Elder"
	))

GLOBAL_LIST_INIT(church_positions, list(
	"Priest",
	"Cleric",
	"Acolyte",
	"Witch Hunter",
	"Confessor"
	))

GLOBAL_LIST_INIT(peasant_positions, list(
	))

GLOBAL_LIST_INIT(serf_positions, list(
	))

GLOBAL_LIST_INIT(youngfolk_positions, list(
	"Squire",
	"Smithy Apprentice",
	"Magician's Apprentice",
	"Churchling",
	"Servant",
	"Orphan"
	))

GLOBAL_LIST_INIT(allmig_positions, list(
	"Adventurer",
	"Pilgrim"
	))

GLOBAL_LIST_INIT(roguewar_positions, list(
	"Adventurer"
	))

GLOBAL_LIST_INIT(roguefight_positions, list(
	"Red Captain",
	"Red Caster",
	"Red Ranger",
	"Red Fighter",
	"Green Captain",
	"Green Caster",
	"Green Ranger",
	"Green Fighter"
	))

GLOBAL_LIST_INIT(test_positions, list(
	"Tester"
	))

GLOBAL_LIST_INIT(exp_jobsmap, list(
	EXP_TYPE_CREW = list("titles" = peasant_positions | command_positions | engineering_positions | medical_positions | science_positions | supply_positions | security_positions | civilian_positions | list("AI","Cyborg")), // crew positions
	EXP_TYPE_COMMAND = list("titles" = command_positions),
	EXP_TYPE_ENGINEERING = list("titles" = engineering_positions),
	EXP_TYPE_MEDICAL = list("titles" = medical_positions),
	EXP_TYPE_SCIENCE = list("titles" = science_positions),
	EXP_TYPE_SUPPLY = list("titles" = supply_positions),
	EXP_TYPE_SECURITY = list("titles" = security_positions),
	EXP_TYPE_SILICON = list("titles" = list("AI","Cyborg")),
	EXP_TYPE_SERVICE = list("titles" = civilian_positions),
))

GLOBAL_LIST_INIT(exp_specialmap, list(
	EXP_TYPE_LIVING = list(), // all living mobs
	EXP_TYPE_ANTAG = list(),
	EXP_TYPE_SPECIAL = list("Lifebringer","Ash Walker","Exile","Servant Golem","Free Golem","Hermit","Translocated Vet","Escaped Prisoner","Hotel Staff","SuperFriend","Space Syndicate","Ancient Crew","Space Doctor","Space Bartender","Beach Bum","Skeleton","Zombie","Space Bar Patron","Lavaland Syndicate","Ghost Role"), // Ghost roles
	EXP_TYPE_GHOST = list() // dead people, observers
))
GLOBAL_PROTECT(exp_jobsmap)
GLOBAL_PROTECT(exp_specialmap)

/proc/guest_jobbans(job)
	return ((job in GLOB.command_positions) || (job in GLOB.nonhuman_positions) || (job in GLOB.security_positions))



//this is necessary because antags happen before job datums are handed out, but NOT before they come into existence
//so I can't simply use job datum.department_head straight from the mind datum, laaaaame.
/proc/get_department_heads(var/job_title)
	if(!job_title)
		return list()

	for(var/datum/job/J in SSjob.occupations)
		if(J.title == job_title)
			return J.department_head //this is a list

