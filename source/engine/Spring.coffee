# Spring
# ======
# ばね。
class Spring
  # - p1 Particle : 始点
  # - p2 Particle : 終点
  # - restLength Int : 長さ
  # - stiffness Float : 堅さ
  constructor: (@p1, @p2, @restLength = 100, @stiffness = 1.0) ->
    # private
    # p2とp1のapply処理の作業用変数
    @_delta = new Vector()

  # `F = -kx`を表現
  # TODO: 物理勉強してばねの動作を調べる
  # - return () :
  apply: ->
    (@_delta.copy @p2.pos).sub @p1.pos

    dist = @_delta.mag() + 0.000001
    force = (dist - @restLength) / (dist * (@p1.massInv + @p2.massInv)) * @stiffness

    if not @p1.fixed
      @p1.pos.add (@_delta.clone().scale force * @p1.massInv)

    if not @p2.fixed
      @p2.pos.add (@_delta.scale -force * @p2.massInv)
