class Draw

	@clear: (col=[0, 0, 0, 1]) ->
		gl.clearColor(col[0], col[1], col[2], col[3])
		gl.clear(gl.COLOR_BUFFER_BIT)

	@setColor: (color) ->
		DrawUtil.shader.uniformColor.set(color)
		return

	@rect: (x, y, w, h, r=0) ->
		mat = mat4.create()
		mat4.identity(mat)
		mat4.translate(mat,  mat, vec3.clone([x, y, 0]))
		if r != 0
			mat4.translate(mat, mat, vec3.clone([w/2, h/2, 0]))
			mat4.rotateZ(mat, mat, r)
			mat4.translate(mat, mat, vec3.clone([-w/2, -h/2, 0]))
		mat4.scale(mat, mat, vec3.clone([w, h, 1]))
		MESHES.QUAD.render(mat)
		return
