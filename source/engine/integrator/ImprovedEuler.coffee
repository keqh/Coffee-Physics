# Improved Euler Integrator
# =========================
# Eulerを改善したもの
# 計算式はintegrateを参照
class ImprovedEuler extends Integrator
  # x += (v * dt) + (a * 0.5 * dt * dt)
  # v += a * dt
  #
  # - particles Array(Particles) :
  # - dt Float :
  # - drag Float :
  integrate: (particles, dt, drag) ->
    acc = new Vector()
    vel = new Vector()

    # NOTE: dtSqを用意するならx0.5もしておいていい気がする
    dtSq = dt * dt

    for p in particles when not p.fixed
      # Eulerと同じ
      p.old.pos.copy p.pos
      p.acc.scale p.massInv

      # 作業用変数にpの各値をcopy
      vel.copy p.vel
      acc.copy p.acc

      # x += (x * dt) + (a * 0.5 * dt * dt)
      p.pos.add (vel.scale dt).add (acc.scale 0.5 * dtSq)

      # v += a * dt
      p.vel.add p.acc.scale dt

      # Eulerと同じ
      if drag then p.vel.scale drag
      p.acc.clear()
