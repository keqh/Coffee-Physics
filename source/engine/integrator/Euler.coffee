# Euler Integrator
# ================
class Euler extends Integrator

  # v += a * dt
  # x += v * dt
  #
  # - particles : 
  # - dt :
  # - drag :
  integrate: (particles, dt, drag) ->
    vel = new Vector()
    for p in particles when not p.fixed
      # 現在位置をoldに記録
      p.old.pos.copy p.pos

      # 加速度を更新
      p.acc.scale p.massInv

      # particleのvelをローカル変数にcopy
      vel.copy p.vel

      # v += a * dt
      p.vel.add p.acc.scale dt

      # x += v * dt
      p.pos.add vel.scale dt

      # 摩擦適用
      if drag then p.vel.scale drag

      # 加速度リセット
      p.acc.clear()
