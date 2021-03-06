// Generated by CoffeeScript 1.7.1
var World,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

World = (function() {
  World.COMPONENTS = {};

  World.registerComponent = function(name, comp) {
    this.COMPONENTS[name] = comp;
    Entity.prototype.components[name] = null;
  };

  World.prototype.entities = [];

  World.prototype.systems = [];

  function World() {
    return;
  }

  World.prototype.addSystem = function(sys) {
    this.systems.push(sys);
    return sys.world = this;
  };

  World.prototype.addEntity = function(ent) {
    return this.entities.push(ent);
  };

  World.prototype.getEntities = function(comps) {
    var arg, ent, ret, works, _i, _j, _len, _len1, _ref;
    ret = [];
    _ref = this.entities;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      ent = _ref[_i];
      works = true;
      for (_j = 0, _len1 = comps.length; _j < _len1; _j++) {
        arg = comps[_j];
        if (__indexOf.call(ent.componentNames, arg) < 0) {
          works = false;
        }
      }
      if (works) {
        ret.push(ent);
      }
    }
    return ret;
  };

  World.prototype.update = function() {
    var sys, _i, _len, _ref, _results;
    _ref = this.systems;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      sys = _ref[_i];
      _results.push(sys.update());
    }
    return _results;
  };

  World.prototype.render = function() {
    var ent, _i, _len, _ref, _results;
    Draw.setColor([1, 0, 0, 1]);
    _ref = this.entities;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      ent = _ref[_i];
      _results.push(Draw.rect(ent.pos[0], ent.pos[1], 32, 32));
    }
    return _results;
  };

  return World;

})();
