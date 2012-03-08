### Edge Bounce Behaviour ###
# 動く範囲が @min < particle < @max になるようにする
class EdgeBounce extends Behaviour
  # これ、引数指定しないと (0, 0)固定になるけどいいの?
  # 引数渡さないときはエラーにしたほうがよい気がする
  constructor: (@min = new Vector(), @max = new Vector()) ->
    super
  
  apply: (p, dt, index) ->
    #super p, dt, index

    # x座標の計算
    if p.pos.x - p.radius < @min.x
      p.pos.x = @min.x + p.radius
    else if p.pos.x + p.radius > @max.x
      p.pos.x = @max.x - p.radius

    # y座標の計算
    if p.pos.y - p.radius < @min.y
      p.pos.y = @min.y + p.radius
    else if p.pos.y + p.radius > @max.y
      p.pos.y = @max.y - p.radius

