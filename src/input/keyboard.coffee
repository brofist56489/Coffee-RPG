class Keyboard
	keys : new Array()

	constructor: ->
		for i in [0...256]
			@keys.push false

		document.addEventListener("keydown", (e) => @keyDown(e))
		document.addEventListener("keyup", (e) => @keyUp(e))

	keyDown: (e) ->
		@keys[e.keyCode] = true

	keyUp: (e) ->
		@keys[e.keyCode] = false

	isKeyDown: (key) ->
		return @keys[key]