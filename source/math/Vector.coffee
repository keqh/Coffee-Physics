# 2D Vector
# =========
class Vector
  # class method
  # ------------

  # Vectorの足し算
  #
  # - return Vector : v1 + v2
  @add: (v1, v2) ->
    new Vector v1.x + v2.x, v1.y + v2.y
  
  # Vectorの引き算
  #
  # - return Vector : v1 - v2
  @sub: (v1, v2) ->
    new Vector v1.x - v2.x, v1.y - v2.y

  # v1をv2に投影する
  # このときv1, v2はそのままで新しいinstanceを生成する
  #
  # - return Vector : v1 `project` v2
  @project: (v1, v2) ->
    v1.clone().scale ((v1.dot v2) / v1.magSq())

  # instance method
  # ------------

  # constructor
  # 2D Vectorなので(x, y)の値がある
  # 初期値が指定されなければ両方とも0で初期化される
  constructor: (@x = 0.0, @y = 0.0) ->

  # vectorのx, yの値を設定する
  #
  # - return Vector : @
  set: (@x, @y) ->
    @
  
  # @ + v
  #
  # - return Vector : @
  add: (v) ->
    @x += v.x; @y += v.y; @
  
  # @ - v
  #
  # - return Vector : @
  sub: (v) ->
    @x -= v.x; @y -= v.y; @

  # @ * f
  #
  # - return Vector : @
  scale: (f) ->
    @x *= f; @y *= f; @

  # - return Float : @ dot v
  dot: (v) ->
    @x * v.x + @y * v.y

  # - return Float : @ cross v
  cross: (v) ->
    (@x * v.y) - (@y * v.x)

  # 長さを計算する
  #
  # - return Float : magnitude @
  mag: ->
    Math.sqrt @x*@x + @y*@y

  # 長さを計算する
  # ただし平方根ではない
  #
  # - return Float : magnitude @
  magSq: ->
    @x*@x + @y*@y

  # _v_との距離を計算する
  # NOTE: `@mag()`使おう
  #
  # - return Float : @ distance v
  dist: (v) ->
    dx = v.x - @x; dy = v.y - @y
    Math.sqrt dx*dx + dy*dy

  # _v_との距離を計算する
  # ただし平方根ではない
  # NOTE: `@magSq()`を使おう
  # 
  # - return Float : @ distanceSq v
  distSq: (v) ->
    dx = v.x - @x; dy = v.y - @y
    dx*dx + dy*dy

  # 単位Vectorで正規化する
  # NOTE: `@mag()`使おう
  # 
  # - return Vector : @
  norm: ->
    m = Math.sqrt @x*@x + @y*@y
    @x /= m
    @y /= m
    @

  # _l_の値を元に正規化する
  # NOTE: まだ使用されていない
  # NOTE: `@norm()`か`@mag()`
  #
  # - return Vector : @
  limit: (l) ->
    mSq = @x*@x + @y*@y
    if mSq > l*l
      m = Math.sqrt mSq
      @x /= m; @y /= m
      @x *= l; @y *= l
      @

  # _v_の(x, y)を_@_にcopyする
  # 新しいinstanceを作成するわけではない
  # 
  # - return Vector : @
  copy: (v) ->
    @x = v.x; @y = v.y; @

  # _@_と同じvectorを生成する
  #
  # - return Vector : new Vector(@)
  clone: ->
    new Vector @x, @y

  # (0, 0)で初期化する
  #
  # - return Vector : @
  clear: ->
    @x = 0.0; @y = 0.0; @
