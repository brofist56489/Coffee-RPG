class TextureManager

	@textures : {}

	@add: (name, path) ->
		@textures[name] = new Texture(path)
		if gl? then @textures[name].load()
		return

	@loadAll: ->
		if not gl? then return
		for text in @textures
			text.load()

	@get: (name) ->
		return @textures[name]

class Texture
	width : 0
	height : 0
	image : null
	texture : -1
	path : ""
	loaded : false

	constructor: (@path) ->
		return

	load: ->
		if @loaded then return
		@image = new Image()
		@image.onLoad = () =>
			@texture = gl.createTexture()
			gl.bindTexture(gl.TEXTURE_2D, @texture)
			gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, image)
			gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)
			gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST)
			gl.bindTexture(gl.TEXTURE_2D, null)
			@loaded = true
			return

		@image.src = @path
		return