// Generated by CoffeeScript 1.7.1
var SHADERS, Shader, ShaderUniform, ShaderUniformType, ShaderUniformTypeMethods;

Shader = (function() {
  Shader.prototype.vertexShader = null;

  Shader.prototype.fragmentShader = null;

  Shader.prototype.vertexShaderCode = "";

  Shader.prototype.fragmentShaderCode = "";

  Shader.prototype.program = null;

  Shader.prototype.attributePosition = null;

  Shader.prototype.attributeTexCoord = null;

  Shader.prototype.uniformViewMatrix = null;

  Shader.prototype.uniformCameraMatrix = null;

  Shader.prototype.uniformObjectMatrix = null;

  Shader.prototype.uniformColor = null;

  Shader.prototype.uniformTextureMatrix = null;

  function Shader(vert, frag) {
    this.vertexShaderCode = vert;
    this.fragmentShaderCode = frag;
  }

  Shader.prototype.getShaderCode = function(vertex_id, fragment_id) {
    this.vertexShaderCode = $("#" + vertex_id)[0].innerText;
    console.log(this.vertexShaderCode);
    this.fragmentShaderCode = $("#" + fragment_id)[0].innerText;
    return console.log(this.fragmentShaderCode);
  };

  Shader.prototype.compile = function() {
    if (typeof gl === "undefined" || gl === null) {
      return;
    }
    this.vertexShader = gl.createShader(gl.VERTEX_SHADER);
    gl.shaderSource(this.vertexShader, this.vertexShaderCode);
    gl.compileShader(this.vertexShader);
    if (!gl.getShaderParameter(this.vertexShader, gl.COMPILE_STATUS)) {
      throw gl.getShaderInfoLog(this.vertexShader);
      return false;
    }
    this.fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
    gl.shaderSource(this.fragmentShader, this.fragmentShaderCode);
    gl.compileShader(this.fragmentShader);
    if (!gl.getShaderParameter(this.fragmentShader, gl.COMPILE_STATUS)) {
      throw gl.getShaderInfoLog(this.fragmentShader);
      return false;
    }
    this.program = gl.createProgram();
    gl.attachShader(this.program, this.vertexShader);
    gl.attachShader(this.program, this.fragmentShader);
    gl.linkProgram(this.program);
    if (!gl.getProgramParameter(this.program, gl.LINK_STATUS)) {
      throw gl.getProgramInfoLog(this.program);
      return false;
    }
    return true;
  };

  Shader.prototype.setupAttribs = function() {
    this.attributePosition = gl.getAttribLocation(this.program, "aPos");
    this.attributeTexCoord = gl.getAttribLocation(this.program, "aTexCoord");
    this.uniformViewMatrix = new ShaderUniform(this.program, "uViewMatrix", ShaderUniformType.MATRIX_4);
    this.uniformCameraMatrix = new ShaderUniform(this.program, "uCameraMatrix", ShaderUniformType.MATRIX_4);
    this.uniformObjectMatrix = new ShaderUniform(this.program, "uObjectMatrix", ShaderUniformType.MATRIX_4);
    this.uniformColor = new ShaderUniform(this.program, "uColor", ShaderUniformType.VECTOR_4);
    this.uniformTextureMatrix = new ShaderUniform(this.program, "uTextureMatrix", ShaderUniformType.MATRIX_4);
    return this;
  };

  Shader.prototype.use = function() {
    gl.useProgram(this.program);
    gl.enableVertexAttribArray(this.attributePosition);
    gl.enableVertexAttribArray(this.attributeTexCoord);
    return this;
  };

  return Shader;

})();

SHADERS = [new Shader("basic-vs", "basic-fs")];

ShaderUniformType = {
  VECTOR_3: 0,
  VECTOR_4: 1,
  VECTOR_2: 2,
  MATRIX_4: 3
};

ShaderUniformTypeMethods = [
  function(uni, val) {
    return gl.uniform3fv(uni, val);
  }, function(uni, val) {
    return gl.uniform4fv(uni, val);
  }, function(uni, val) {
    return gl.uniform2fv(uni, val);
  }, function(uni, val) {
    return gl.uniformMatrix4fv(uni, false, val);
  }
];

ShaderUniform = (function() {
  ShaderUniform.prototype.name = "";

  ShaderUniform.prototype.type = -1;

  ShaderUniform.prototype.uniform = null;

  ShaderUniform.prototype.value = null;

  function ShaderUniform(prog, name, type) {
    this.name = name;
    this.type = type;
    this.uniform = gl.getUniformLocation(prog, this.name);
  }

  ShaderUniform.prototype.set = function(val) {
    this.val = val;
    return ShaderUniformTypeMethods[this.type](this.uniform, val);
  };

  return ShaderUniform;

})();
