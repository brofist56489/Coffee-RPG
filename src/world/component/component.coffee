class Component

	@register: (name) ->
		World.registerComponent(name, @)
		return

	entity : null

	constructor: (@entity) ->
		return

class MoveableComponent extends Component

	constructor: (@entity) ->
		@entity.vel = [0, 0]
		@entity.pos = [427, 240]

class ControllableComponent extends Component

	up : 87
	down : 83
	left : 65
	right : 68
	constructor: (@entity) ->
		return