// Generated by CoffeeScript 1.7.1
var Entity;

Entity = (function() {
  Entity.prototype.componentNames = [];

  Entity.prototype.components = {};

  Entity.prototype.pos = [0, 0];

  Entity.prototype.vel = [0, 0];

  function Entity(componentNames) {
    this.componentNames = componentNames;
    this.initComponents();
    return;
  }

  Entity.prototype.initComponents = function() {
    this.components = {};
    this.componentNames.forEach((function(_this) {
      return function(name) {
        return _this.components[name] = new World.COMPONENTS[name](_this);
      };
    })(this));
  };

  Entity.prototype.getComponent = function(name) {
    return this.components[name];
  };

  return Entity;

})();
