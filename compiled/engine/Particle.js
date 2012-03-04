var Particle;

Particle = (function() {

  function Particle(mass) {
    this.mass = mass != null ? mass : 1.0;
    this.setMass(this.mass);
    this.setRadius(1.0);
    this.fixed = false;
    this.behaviours = [];
    this.pos = new Vector();
    this.vel = new Vector();
    this.acc = new Vector();
    this.old = {
      pos: new Vector(),
      vel: new Vector(),
      acc: new Vector()
    };
  }

  Particle.prototype.moveTo = function(pos) {
    this.pos.copy(pos);
    return this.old.pos.copy(pos);
  };

  Particle.prototype.setMass = function(mass) {
    this.mass = mass != null ? mass : 1.0;
    return this.massInv = 1.0 / this.mass;
  };

  Particle.prototype.setRadius = function(radius) {
    this.radius = radius != null ? radius : 1.0;
    return this.radiusSq = this.radius * this.radius;
  };

  Particle.prototype.update = function(dt, index) {
    var behaviour, _i, _len, _ref, _results;
    if (!this.fixed) {
      _ref = this.behaviours;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        behaviour = _ref[_i];
        _results.push(behaviour.apply(this, dt, index));
      }
      return _results;
    }
  };

  return Particle;

})();
