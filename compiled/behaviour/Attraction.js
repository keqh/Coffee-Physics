var Attraction,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

Attraction = (function(_super) {

  __extends(Attraction, _super);

  function Attraction(target, radius, strength) {
    this.target = target != null ? target : new Vector();
    this.radius = radius != null ? radius : 1000;
    this.strength = strength != null ? strength : 100.0;
    this._delta = new Vector();
    this.setRadius(this.radius);
    Attraction.__super__.constructor.apply(this, arguments);
  }

  Attraction.prototype.setRadius = function(radius) {
    this.radius = radius;
    return this.radiusSq = radius * radius;
  };

  Attraction.prototype.apply = function(p, dt, index) {
    var distSq;
    (this._delta.copy(this.target)).sub(p.pos);
    distSq = this._delta.magSq();
    if (distSq < this.radiusSq && distSq > 0.000001) {
      this._delta.norm().scale(1.0 - distSq / this.radiusSq);
      return p.acc.add(this._delta.scale(this.strength));
    }
  };

  return Attraction;

})(Behaviour);
