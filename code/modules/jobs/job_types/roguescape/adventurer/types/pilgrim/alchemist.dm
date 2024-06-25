/datum/advclass/alchemist
	name = "Alchemist"
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen", "Elf", "Dark Elf", "Dwarf")
	outfit = /datum/outfit/job/roguetown/adventurer/alchemist
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/alchemist/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	cloak = /obj/item/clothing/cloak/apron
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backr = /obj/item/storage/backpack/rogue/satchel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather

	/obj/item/reagent_containers/glass/bottle/rogue/strongpoison
	/obj/item/reagent_containers/glass/bottle/rogue/strongmanapot
	/obj/item/reagent_containers/glass/bottle/rogue/diseasecure
	/obj/item/reagent_containers/glass/bottle/rogue/stronghealthpot
	beltl = 
	beltr =
	if(prob(50))
		beltl = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/reagent_containers/powder/flour/salt = 1,/obj/item/reagent_containers/food/snacks/rogue/cheese=1,/obj/item/reagent_containers/food/snacks/rogue/cheddar=1)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
