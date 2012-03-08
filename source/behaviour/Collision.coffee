### Collision Behaviour ###

# TODO: Collision response for non Verlet integrators.
class Collision extends Behaviour

  constructor: (@useMass = yes, @callback = null) ->
    # Pool of collidable particles.
    # 直接外部から更新される
    @pool = []

    # Delta between particle positions.
    @_delta = new Vector()

    super
  
  apply: (p, dt, index) ->
    #super p, dt, index

    # Check pool for collisions.
    for i in [index..@pool.length - 1]
      o = @pool[i]
      # oとpが同じparticleを指してる場合があるので、それを除外
      if o isnt p

        # よくある衝突判定
        # 二つのpの半径を足したのよりも距離が短かければ
        # 重なる部分がある = 衝突している
        (@_delta.copy o.pos).sub p.pos
        distSq = @_delta.magSq()
        radii = p.radius + o.radius
        if distSq <= radii * radii

          dist = Math.sqrt distSq

          # 衝突してる部分の計算
          overlap = (p.radius + o.radius) - dist
          overlap += 0.5

          # Distribute collision responses.
          mt = p.mass + o.mass
          r1 = if @useMass then o.mass / mt else 0.5
          r2 = if @useMass then p.mass / mt else 0.5

          # 重なる部分がなくなるようにparticleを移動する
          p.pos.add (@_delta.clone().norm().scale overlap * -r1)
          o.pos.add (@_delta.norm().scale overlap * r2)

          # Fire callback if defined.
          @callback?(p, o, overlap)
