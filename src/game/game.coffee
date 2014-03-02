class Game
	running : false
	timer : null
	v : 0

	constructor: ->
		initializeGame()
		return

	start: ->
		Assets.Textures.loadAll()

		@timer = new GameTimer(@)
		@running = true
		@timer.start()

	update: ->
		@v += 0.01
		return

	render: ->
		Assets.Textures.get("test").use()

		Draw.clear([0, 0, 0, 1])
		Draw.setColor(vec4.clone([0, 1, 0, 1]))
		for i in [0...40]
			Draw.rect((i % 10)*50+Math.cos(@v * Math.PI)*50, Math.floor(i / 10)*50+Math.sin(@v * Math.PI)*50, 45, 45)
		Draw.setColor(vec4.clone([0, 0, 1, 1]))
		Draw.rect(50+Math.cos(@v * Math.PI)*50, 50+Math.sin(@v * Math.PI)*50, 45, 45)
		return

class GameTimer
	lt : 0
	now : 0
	delta : 0
	ltr : 0
	ticks : 0
	frames : 0
	mspt : 0
	game : null
	callback : null

	start: ->
		window.requestAnimationFrame(@callback)

	getMillis: ->
		return new Date().getTime()

	constructor: (@game) ->
		@lt = @getMillis()
		@now = @lt
		@ltr = @lt
		@mspt = 60.0 / 1000.0
		@callback = (time) =>
			@update()

	update: () ->
		@now = @getMillis()
		@delta += (@now - @lt) * @mspt
		@lt = @now

		if @delta >= 10 then @delta = 10

		while @delta >= 1
			@game.update()
			@ticks++
			@delta--

		@game.render()
		@frames++

		if @now - @ltr >= 1000
			@ltr += 1000
			console.log("#{@ticks} tps, #{@frames} fps")
			@ticks = 0
			@frames = 0

		if @game.running
			window.requestAnimationFrame(@callback)