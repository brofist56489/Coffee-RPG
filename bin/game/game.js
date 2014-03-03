// Generated by CoffeeScript 1.7.1
var Game, GameTimer;

Game = (function() {
  Game.prototype.running = false;

  Game.prototype.timer = null;

  Game.prototype.world = null;

  function Game() {
    var e, i, _i;
    initializeGame();
    this.world = new World();
    this.world.addSystem(new ControlSystem());
    this.world.addSystem(new MoveSystem());
    this.world.addSystem(new BounceSystem());
    for (i = _i = 0; _i < 30; i = ++_i) {
      e = new Entity(["Moveable", "Controllable"]);
      e.pos[0] = (i % 10) * 50;
      e.pos[1] = Math.floor(i / 10) * 50;
      this.world.addEntity(e);
    }
    return;
  }

  Game.prototype.start = function() {
    Assets.Textures.loadAll();
    this.timer = new GameTimer(this);
    this.running = true;
    return this.timer.start();
  };

  Game.prototype.update = function() {
    this.world.update();
  };

  Game.prototype.render = function() {
    Draw.clear([0, 0, 0, 1]);
    this.world.render();
  };

  return Game;

})();

GameTimer = (function() {
  GameTimer.prototype.lt = 0;

  GameTimer.prototype.now = 0;

  GameTimer.prototype.delta = 0;

  GameTimer.prototype.ltr = 0;

  GameTimer.prototype.ticks = 0;

  GameTimer.prototype.frames = 0;

  GameTimer.prototype.mspt = 0;

  GameTimer.prototype.game = null;

  GameTimer.prototype.callback = null;

  GameTimer.prototype.start = function() {
    return window.requestAnimationFrame(this.callback);
  };

  GameTimer.prototype.getMillis = function() {
    return new Date().getTime();
  };

  function GameTimer(game) {
    this.game = game;
    this.lt = this.getMillis();
    this.now = this.lt;
    this.ltr = this.lt;
    this.mspt = 60.0 / 1000.0;
    this.callback = (function(_this) {
      return function(time) {
        return _this.update();
      };
    })(this);
  }

  GameTimer.prototype.update = function() {
    this.now = this.getMillis();
    this.delta += (this.now - this.lt) * this.mspt;
    this.lt = this.now;
    if (this.delta >= 10) {
      this.delta = 10;
    }
    while (this.delta >= 1) {
      this.game.update();
      this.ticks++;
      this.delta--;
    }
    this.game.render();
    this.frames++;
    if (this.now - this.ltr >= 1000) {
      this.ltr += 1000;
      this.ticks = 0;
      this.frames = 0;
    }
    if (this.game.running) {
      return window.requestAnimationFrame(this.callback);
    }
  };

  return GameTimer;

})();
