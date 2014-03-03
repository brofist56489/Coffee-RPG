class System
	world : null

	constructor: () ->
		return

	update: () ->
		return

	render: () ->
		return

class ControlSystem
	update: ->
		entities = @world.getEntities(["Controllable"])

		entities.forEach (ent) ->
			comp = ent.getComponent("Controllable")
			vel = vec2.create()
			if Input.Keys.isKeyDown(comp.up)
				vel[1] = -2
			if Input.Keys.isKeyDown(comp.down)
				vel[1] = 2
			if Input.Keys.isKeyDown(comp.left)
				vel[0] = -2
			if Input.Keys.isKeyDown(comp.right)
				vel[0] = 2
			ent.vel = vel

class MoveSystem
	update: ->
		entities = @world.getEntities(["Moveable"])

		entities.forEach (ent) ->
			vec2.add(ent.vel, ent.vel, vec2.clone([Math.random() * 2 - 1, Math.random() * 2 - 1]))
			vec2.add(ent.pos, ent.pos, ent.vel)

			col = ent.getComponent("Color")
			if col? then ent.pos = vec2.clone([427, 240])
		return

class BounceSystem
	update: ->
		entities = @world.getEntities(["Moveable"])

		entities.forEach (ent) ->
			vec2.clamp(ent.pos, ent.pos, [0, 0], [822, 448])
		