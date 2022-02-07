/obj/item/seeds/poppy/bloodleaf
	name = "pack of bloodleaf seeds"
	desc = "These seeds grow into bloodleaves."
	species = "bloodleaf"
	plantname = "Bloodleaf"
	product = /obj/item/reagent_containers/food/snacks/grown/bloodleaf
	lifespan = 25
	endurance = 10
	yield = 4
	growthstages = 3
	production = 4
	maturation = 4
	growing_icon = 'icons/obj/hydroponics/growing_flowers.dmi'
	icon_harvest = "bloodleaf-harvest"//temp
	icon_grow = "bloodleaf-grow"//temp
	icon_dead = "bloodleaf-dead"//temp
	reagents_add = list(/datum/reagent/medicine/dexalin = 0.2, /datum/reagent/medicine/salglu_solution = 0.05, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/medicine/bicaridine = 0.1,)

/obj/item/reagent_containers/food/snacks/grown/bloodleaf
	seed = /obj/item/seeds/poppy/bloodleaf
	name = "bloodleaf flower"
	desc = "This strange, reddish flower grows most often on the banks of rivers, their roots adapted for the waterand the land. Sometimes found deep in floodplains."
	icon_state = "bloodleaf"
	//slot_flags = SLOT_HEAD
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/consumable/tea/bloodleaftea = 0)//temp
	distill_reagent = /datum/reagent/consumable/ethanol/bloodleafbrew//temp
