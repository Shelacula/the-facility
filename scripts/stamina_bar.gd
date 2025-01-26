extends ColorRect


@onready var stamina_bar: ColorRect = $"."

func update_stamina_bar(stamina, max_stamina):
	stamina_bar.size.x = 100 * stamina/max_stamina
