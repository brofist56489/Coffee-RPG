initializeGame = () ->
	Assets.init()

	Assets.Textures.add("test", "res/images/test.png")

	Input.init()

	# init Components
	MoveableComponent.register("Moveable")
	ControllableComponent.register("Controllable")