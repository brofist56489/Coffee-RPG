#WebGL context
gl = null

class DrawUtil
	@canvas : null

	@WIDTH : 854
	@HEIGHT : 480

	@shader : null

	@initGlContext: ->
		@canvas = $("#gameCanvas")[0]
		@canvas.width = @WIDTH
		@canvas.height = @HEIGHT

		gl = @__getGlContext()
		if gl?
			@setupGlContext()
			@setupShaders()
			initMeshes()


	@__getGlContext: ->
		return @canvas.getContext("webgl") || @canvas.getContext("experimental-webgl")

	@setupGlContext: ->
		gl.viewport(0, 0, @WIDTH, @HEIGHT)
		gl.disable(gl.DEPTH_TEST)
		gl.disable(gl.CULL_FACE) 

	@setupShaders: ->
		@initShaders()

		@shader = SHADERS[0].use()

		viewMat = mat4.create()
		mat4.identity(viewMat)
		mat4.ortho(viewMat, 0, @WIDTH, @HEIGHT, 0, -1, 1)
		@shader.uniformViewMatrix.set(viewMat)

		camMat = mat4.create()
		mat4.identity(camMat)
		mat4.translate(camMat, camMat, vec3.clone([0, 0, 0]))
		@shader.uniformCameraMatrix.set(camMat)
		return

	@initShaders: ->
		for shader in SHADERS
			shader.getShaderCode(shader.vertexShaderCode, shader.fragmentShaderCode)

			if not shader.compile() then throw "Poop!"
			shader.setupAttribs()