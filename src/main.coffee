main = () ->
	DrawUtil.initGlContext()
	new Game().start()

window.startGameMethod = main