# Particle
# ========
# particleは円として表現される
# 四角などの表現はまだ存在しない
class Particle
  # 質量を指定してparticleを作成する
  # ex: `new Particle 1.0`
  # mass : Float
  #
  # - return Particle : new Particle
  constructor: (@mass = 1.0) ->
    # 質量
    @setMass @mass

    # 半径
    @setRadius 1.0
    # trueだと他のobjectの影響を受けず、固定される
    @fixed = false
    # このparticleがどのように振る舞うか
    @behaviours = []

    # particleのvector
    @pos = new Vector() # 現在位置
    @vel = new Vector() # 速さ
    @acc = new Vector() # 加速度

    # 一つ前の状態
    @old =
      pos: new Vector()
      vel: new Vector()
      acc: new Vector()

  # _pos_に移動
  #
  # - pos : Vector
  #
  # - return Vector : pos
  moveTo: (pos) ->
    @pos.copy pos
    @old.pos.copy pos

  # massを再設定
  # このときmassの逆数も覚えておく
  #
  # - mass : Float
  #
  # - return Float : massInv
  setMass: (@mass = 1.0) ->
    @massInv = 1.0 / @mass

  # radiusを再設定
  # このときradiusの平方も覚えておく
  #
  # - radius : Float
  #
  # - return Float : radiusSq
  setRadius: (@radius = 1.0) ->
    @radiusSq = @radius * @radius

  # @behavioursに登録された振舞を適用する
  # ただし、固定されていないときに限る
  # TODO: _dt_と_index_の意味をbehavioursを見て調べる
  # Collisionでindexは使用されている
  # NOTE: `if not`は`unless`
  # 
  # - dt : ?
  # - index : ?
  #
  # - return Array(Any) : behaviourのapplyの返り値
  update: (dt, index) ->
    if not @fixed
      for behaviour in @behaviours
        behaviour.apply @, dt, index
