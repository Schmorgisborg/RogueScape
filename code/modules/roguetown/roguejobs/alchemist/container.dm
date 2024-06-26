/obj/item/reagent_containers/glass/bottle/vial
	name = "vial"
	desc = "A vial with a cork."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "clear_bottle1"
	amount_per_transfer_from_this = 15
	possible_transfer_amounts = list(15)
	volume = 15
	fill_icon_thresholds = list(0, 25, 50, 75, 100)
	dropshrink = 0.5
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	obj_flags = CAN_BE_HIT
	spillable = FALSE
	closed = TRUE
	reagent_flags = TRANSPARENT
	w_class = WEIGHT_CLASS_NORMAL
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
	experimental_onhip = TRUE

/obj/item/reagent_containers/glass/bottle/vial/rmb_self(mob/user)
	. = ..()
	closed = !closed
	user.changeNext_move(CLICK_CD_RAPID)
	if(closed)
		reagent_flags = TRANSPARENT
		reagents.flags = reagent_flags
		desc = "A vial with a cork."
		spillable = FALSE
	else
		reagent_flags = OPENCONTAINER
		reagents.flags = reagent_flags
		playsound(user.loc,'sound/items/uncork.ogg', 100, TRUE)
		desc = "An open vial, easy to drink quickly."
		spillable = TRUE
	update_icon()

/obj/item/reagent_containers/glass/bottle/rogue/additive
	list_reagents = list(/datum/reagent/additive = 10)

/obj/item/reagent_containers/glass/bottle/rogue/healthpot
	list_reagents = list(/datum/reagent/medicine/healthpot = 45)

/obj/item/reagent_containers/glass/bottle/rogue/stronghealthpot
	list_reagents = list(/datum/reagent/medicine/stronghealth = 45)

/obj/item/reagent_containers/glass/bottle/rogue/manapot
	list_reagents = list(/datum/reagent/medicine/manapot = 45)

/obj/item/reagent_containers/glass/bottle/rogue/strongmanapot
	list_reagents = list(/datum/reagent/medicine/strongmana = 45)

/obj/item/reagent_containers/glass/bottle/rogue/poison
	list_reagents = list(/datum/reagent/toxin/killersice = 1)

/obj/item/reagent_containers/glass/bottle/rogue/strongpoison
	list_reagents = list(/datum/reagent/strongpoison = 15)

/obj/item/reagent_containers/glass/bottle/rogue/wine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 45)

/obj/item/reagent_containers/glass/bottle/rogue/water
	list_reagents = list(/datum/reagent/water = 45)

/obj/item/reagent_containers/glass/bottle/rogue/antidote
	list_reagents = list(/datum/reagent/medicine/antidote = 45)

/obj/item/reagent_containers/glass/bottle/rogue/diseasecure
	list_reagents = list(/datum/reagent/medicine/diseasecure = 45)
