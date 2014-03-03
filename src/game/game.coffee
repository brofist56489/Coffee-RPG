class Game
	running : false
	timer : null

	world : null

	constructor: ->
		initializeGame()

		@world = new World()

		@world.addSystem(new ControlSystem())
		@world.addSystem(new MoveSystem())
		@world.addSystem(new BounceSystem())
		for i in [0...30]
			# val = if Math.random() > 0.5 then ["Moveable"] else ["Moveable", "Color"]
			e = new Entity(["Moveable", "Controllable"])
			e.pos[0] = (i % 10) * 50
			e.pos[1] = Math.floor(i / 10) * 50
			@world.addEntity(e)
		return

	start: ->
		Assets.Textures.loadAll()

		@timer = new GameTimer(@)
		@running = true
		@timer.start()

	update: ->
		@world.update()
		return

	render: ->
		Draw.clear([0, 0, 0, 1])
		@world.render()
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
			# console.log("#{@ticks} tps, #{@frames} fps")
			@ticks = 0
			@frames = 0

		if @game.running
			window.requestAnimationFrame(@callback)