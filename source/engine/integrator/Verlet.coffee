# Velocity Verlet Integrator
# ==========================
# 分子運動学でverletの方法というのがあるらしい
# これを使用して積分すると大変計算が楽とのこと
# 参考：http://ja.wikipedia.org/wiki/ベレの方法
# 参考：http://d.hatena.ne.jp/Gemma/20080517/1211010942
class Verlet extends Integrator
  
  # v = x - ox 注：oxはold xのこと
  # x = x + (v + a * dt * dt)
  integrate: (particles, dt, drag) ->
    # 作業用変数
    # NOTE: 計算内でNOTEに書いてる処理にするとこの変数不要になる
    pos = new Vector()

    dtSq = dt * dt
    for p in particles when not p.fixed
      # Scale force to mass.
      p.acc.scale p.massInv

      # Derive velocity.
      # v = x - ox
      # NOTE: わざわざp.velでなくてもlocal変数でvel使えばいいのでは
      (p.vel.copy p.pos).sub p.old.pos

      # Apply friction.
      if drag then p.vel.scale drag

      # x += v + a * dt * dt
      # 上記を計算してp.old.posとp.posを設定している
      # NOTE:以下のコードでも同じ動きすると思う
      #
      # ```
      # p.old.pos.copy p.pos
      # p.pos.add (p.vel.add p.acc.scale dtSq)
      # ```
      (pos.copy p.pos).add (p.vel.add p.acc.scale dtSq)
      p.old.pos.copy p.pos
      p.pos.copy pos

      # Reset forces.
      p.acc.clear()

