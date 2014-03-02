// Generated by CoffeeScript 1.7.1
var MESHES, Mesh, initMeshes;

Mesh = (function() {
  function Mesh() {}

  Mesh.prototype.vertexBuffer = null;

  Mesh.prototype.indexBuffer = null;

  Mesh.prototype.size = null;

  Mesh.prototype.setVertices = function(vert) {
    if (this.vertexBuffer == null) {
      this.vertexBuffer = gl.createBuffer();
    }
    gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);
    return gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vert), gl.STATIC_DRAW);
  };

  Mesh.prototype.render = function(mat) {
    var shader;
    shader = DrawUtil.shader;
    shader.uniformObjectMatrix.set(mat);
    gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);
    gl.vertexAttribPointer(shader.attributePosition, 2, gl.FLOAT, false, 16, 0);
    gl.vertexAttribPointer(shader.attributeTexCoord, 2, gl.FLOAT, false, 16, 8);
    return gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
  };

  return Mesh;

})();

MESHES = {
  "QUAD": new Mesh()
};

initMeshes = function() {
  return MESHES.QUAD.setVertices([0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1]);
};