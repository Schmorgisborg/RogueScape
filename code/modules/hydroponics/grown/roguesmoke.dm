
/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf
	seed = /obj/item/seeds/sweetleaf
	name = "sweetleaf"
	desc = ""
	icon_state = "sweetleaf"
	filling_color = "#008000"
	bitesize_mod = 1
	foodtype = VEGETABLES
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 5)
	tastes = list("sweet" = 1,"bitterness" = 1)
	eat_effect = /datum/status_effect/debuff/badmeal
	rotprocess = 15 MINUTES
	//Mack added:
	mill_result = /obj/item/reagent_containers/powder/moondust

/datum/crafting_recipe/roguetown/dryleaf
	name = "dry sweetleaf"
	result = /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf = 1)
	structurecraft = /obj/structure/fluff/dryingrack
	time = 2 SECONDS
	verbage = "dries"
	craftsound = null
	skillcraft = null

/datum/crafting_recipe/roguetown/sigsweet
	name = "sweetleaf zig"
	result = /obj/item/clothing/mask/cigarette/rollie/cannabis
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry = 1,
				/obj/item/paper/scroll = 1)
	req_table = TRUE
	time = 10 SECONDS
	verbage = "rolls"
	craftdiff = 0

/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry
	seed = null
	name = "sweetleaf"
	desc = ""
	icon_state = "sweetleafd"
	dry = 1
	pipe_reagents = list(/datum/reagent/drug/space_drugs = 30)
	list_reagents = list(/datum/reagent/drug/space_drugs = 2,/datum/reagent/consumable/nutriment = 1)
	eat_effect = /datum/status_effect/debuff/badmeal
	//Mack added:
	mill_result = /obj/item/reagent_containers/powder/moondust

/obj/item/seeds/sweetleaf
	name = "seeds"
	desc = ""
	species = "weed"
	plantname = "sweetleaf plant"
	product = /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf
	production = 1
	yield = 3
	potency = 1

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed
	seed = /obj/item/seeds/pipeweed
	name = "westleach leaf"
	desc = "A generic kind of pipe weed."
	icon_state = "pipeweed"
	filling_color = "#008000"
	bitesize_mod = 1
	foodtype = VEGETABLES
	tastes = list("sweet" = 1,"bitterness" = 1)
	list_reagents = list(/datum/reagent/drug/nicotine = 2, /datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 5)
	eat_effect = /datum/status_effect/debuff/badmeal
	rotprocess = 15 MINUTES
	//Mack added:
	mill_result = /obj/item/reagent_containers/powder/ozium

/datum/crafting_recipe/roguetown/dryweed
	name = "dry westleach leaf"
	result = /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed = 1)
	structurecraft = /obj/structure/fluff/dryingrack
	time = 2 SECONDS
	verbage = "drie"
	craftsound = null
	skillcraft = null

/datum/crafting_recipe/roguetown/sigdry
	name = "westleach zig"
	result = /obj/item/clothing/mask/cigarette/rollie/nicotine
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry = 1,
				/obj/item/paper/scroll = 1)
	req_table = TRUE
	time = 10 SECONDS
	verbage = "roll"
	craftdiff = 0

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry
	seed = null
	name = "westleach leaf"
	desc = "A dried leaf."
	icon_state = "pipeweedd"
	dry = 1
	pipe_reagents = list(/datum/reagent/drug/nicotine = 30)
	eat_effect = /datum/status_effect/debuff/badmeal
	list_reagents = list(/datum/reagent/drug/nicotine = 5, /datum/reagent/consumable/nutriment = 1)
	//Mack added:
	mill_result = /obj/item/reagent_containers/powder/ozium

/obj/item/seeds/pipeweed
	desc = ""
	species = "tobacco"
	plantname = "westleach plant"
	product = /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed
	production = 1
	yield = 3
	potency = 1

/datum/crafting_recipe/roguetown/spice
	name = "spice"
	result = /obj/item/reagent_containers/powder
	reqs = list(/obj/item/reagent_containers/powder/moondust = 1,
				/obj/item/reagent_containers/powder/ozium = 1)
	req_table = TRUE
	time = 8 SECONDS
	verbage = "mix"
	craftdiff = 0

/datum/crafting_recipe/roguetown/spice
	name = "pure moondust"
	result = /obj/item/reagent_containers/powder/moondust_purest
	reqs = list(/obj/item/reagent_containers/powder/moondust = 3)
	req_table = TRUE
	time = 8 SECONDS
	verbage = "mix"
	craftdiff = 0

/datum/crafting_recipe/roguetown/scroll
	name = "scroll"
	result = /obj/item/paper/scroll
	reqs = list(/obj/item/natural/fibers = 3)
	req_table = TRUE
	time = 8 SECONDS
	verbage = "mash out"
	craftdiff = 1
