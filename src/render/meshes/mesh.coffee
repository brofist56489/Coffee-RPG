class Mesh
	vertexBuffer : null
	indexBuffer : null
	size : null

	setVertices: (vert) ->
		if not @vertexBuffer? then @vertexBuffer = gl.createBuffer()
		# if not @indexBuffer? then @indexBuffer = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, @vertexBuffer)
		gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vert), gl.STATIC_DRAW)

		# gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, @indexBuffer)
		# gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, new Int16Array(ind), gl.STATIC_DRAW)
		# @size = ind.length

	render: (mat) ->
		shader = DrawUtil.shader
		shader.uniformObjectMatrix.set(mat)

		gl.bindBuffer(gl.ARRAY_BUFFER, @vertexBuffer)
		gl.vertexAttribPointer(shader.attributes[0], 2, gl.FLOAT, false, 16, 0)
		gl.vertexAttribPointer(shader.attributes[1], 2, gl.FLOAT, false, 16, 8)
		gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4)
		# gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, @indexBuffer)
		# gl.drawElements(gl.TRIANGLES, @size, gl.UNSIGNED_SHORT, 0)


MESHES =
	"QUAD" : new Mesh()


initMeshes = ->
	MESHES.QUAD.setVertices([
			0, 0, 0, 0,
			1, 0, 1, 0,
			0, 1, 1, 1,
			1, 1, 0, 1,
		])