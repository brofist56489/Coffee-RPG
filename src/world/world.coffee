class World

	@COMPONENTS : {}
	@registerComponent: (name, comp) ->
		@COMPONENTS[name] = comp
		Entity::components[name] = null
		return

	entities : []
	systems : []
	constructor: ->
		return

	addSystem: (sys) ->
		@systems.push sys
		sys.world = @

	addEntity: (ent) ->
		@entities.push ent

	getEntities: (comps) ->
		ret = []
		for ent in @entities
			works = true
			for arg in comps
				if arg not in ent.componentNames then works = false
			if works then ret.push ent
		return ret

	update: ->
		for sys in @systems
			sys.update()

	render: ->
		Draw.setColor([1, 0, 0, 1])
		for ent in @entities
			Draw.rect(ent.pos[0], ent.pos[1], 32, 32)