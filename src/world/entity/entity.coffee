class Entity
	componentNames : []
	components : {}

	pos : [0, 0]
	vel : [0, 0]

	constructor: (@componentNames) ->
		@initComponents()
		return

	initComponents: ->
		@components = {}
		@componentNames.forEach (name) =>
			@components[name] = new World.COMPONENTS[name](@)
		return

	getComponent: (name) ->
		@components[name]