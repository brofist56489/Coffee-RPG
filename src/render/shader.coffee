class Shader
	vertexShader : null
	fragmentShader : null
	vertexShaderCode : "",
	fragmentShaderCode : ""
	program : null,
	attributes : [-1, -1],
	uniforms : {},

	constructor: (vert, frag) ->
		@vertexShaderCode = vert
		@fragmentShaderCode = frag

	getShaderCode: (vertex_id, fragment_id) ->
		@vertexShaderCode = $("#"+vertex_id)[0].innerText
		console.log(@vertexShaderCode)
		@fragmentShaderCode = $("#"+fragment_id)[0].innerText
		console.log(@fragmentShaderCode)

	compile: ->
		if not gl? then return
		@vertexShader = gl.createShader(gl.VERTEX_SHADER)
		gl.shaderSource(@vertexShader, @vertexShaderCode)
		gl.compileShader(@vertexShader)
		if not gl.getShaderParameter(@vertexShader, gl.COMPILE_STATUS)
			throw gl.getShaderInfoLog(@vertexShader)
			return no

		@fragmentShader = gl.createShader(gl.FRAGMENT_SHADER)
		gl.shaderSource(@fragmentShader, @fragmentShaderCode)
		gl.compileShader(@fragmentShader)
		if not gl.getShaderParameter(@fragmentShader, gl.COMPILE_STATUS)
			throw gl.getShaderInfoLog(@fragmentShader)
			return no

		@program = gl.createProgram()
		gl.attachShader(@program, @vertexShader)
		gl.attachShader(@program, @fragmentShader)
		gl.linkProgram(@program)
		if not gl.getProgramParameter(@program, gl.LINK_STATUS)
			throw gl.getProgramInfoLog(@program)
			return no

		return yes

	setupAttribs: ->
		@attributes[0] = gl.getAttribLocation(@program, "aPos")
		@attributes[1] = gl.getAttribLocation(@program, "aTexCoord")

		@uniforms["viewMatrix"] = new ShaderUniform(@program, "uViewMatrix", ShaderUniformType.MATRIX_4)
		@uniforms["cameraMatrix"] = new ShaderUniform(@program, "uCameraMatrix", ShaderUniformType.MATRIX_4)
		@uniforms["objectMatrix"] = new ShaderUniform(@program, "uObjectMatrix", ShaderUniformType.MATRIX_4)
		@uniforms["color"] = new ShaderUniform(@program, "uColor", ShaderUniformType.VECTOR_4)
		return this

	use: ->
		gl.useProgram(@program)
		gl.enableVertexAttribArray(@attributes[0])
		gl.enableVertexAttribArray(@attributes[1])
		return this

SHADERS = [
	new Shader("basic-vs", "basic-fs")
]

ShaderUniformType = 
	VECTOR_3 : 0
	VECTOR_4 : 1,
	VECTOR_2 : 2,
	MATRIX_4 : 3,

ShaderUniformTypeMethods = [
	(uni, val) -> #Vector 3
		gl.uniform3fv(uni, val)

	(uni, val) -> #Vector 4
		gl.uniform4fv(uni, val)

	(uni, val) -> #Vector 2
		gl.uniform2fv(uni, val)

	(uni, val) -> #Matrix 4
		gl.uniformMatrix4fv(uni, false, val)
]

class ShaderUniform
	name : ""
	type : -1
	uniform : null
	value : null

	constructor: (prog, @name, @type) ->
		@uniform = gl.getUniformLocation(prog, @name)

	set: (@val) ->
		ShaderUniformTypeMethods[@type](@uniform, val)