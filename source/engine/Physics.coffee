# Physics Engine
# ==============

class Physics

  # 
  constructor: (@integrator = new Euler()) ->
    # 最大fpsは60で固定
    @timestep = 1.0 / 60

    # 摩擦係数
    @viscosity = 0.005

    # 全体に適用する振舞
    @behaviours = []

    # systemに登録されたparticles, springs
    @particles = []
    @springs = []

    # ここから`@step()`で使用するproperty
    # -------
    # Time in seconds.
    # NOTE: 参照されてない?
    @_time = 0.0

    # Last step duration.
    # NOTE: 参照されてない?
    @_step = 0.0

    # 現在時刻
    # stepの処理でdeltaを計るために使用する
    @_clock = null

    # Time buffer.
    # TODO: なにに使用されているか調べる
    @_buffer = 0.0

    # 一回のstepで最大何回integrateするか
    @_maxSteps = 4

  # integrate
  # ---------
  # 1stepごとの更新処理
  # 
  # - return Array(Any) : spring.applyの返り値
  integrate: (dt) ->
    # 最初にphysicsに登録されている振舞を適用したあと
    # それぞれparticle個別の振舞を適用して更新する
    for particle, index in @particles
      for behaviour in @behaviours
        behaviour.apply particle, dt, index
      particle.update dt, index

    # Drag is inversely proportional to viscosity.
    # TODO: integratorのコード読んだあとここのコードの意味を確認
    drag = 1.0 - @viscosity
    # Integrate motion.
    @integrator.integrate @particles, dt, drag

    for spring in @springs
      spring.apply()
  
  # stepの計算
  # - reutrn ()
  step: ->
    # 初回は @_clockを現在時刻で初期化する
    @_clock ?= new Date().getTime()

    # 前回の処理からの時間の差分を計算
    time = new Date().getTime()
    delta = time - @_clock

    # もし時間が進んでいなければ処理しない
    return if delta <= 0.0

    # deltaをmsからsに変換
    delta *= 0.001

    # 更新処理が行われるので、現在時刻を更新
    @_clock = time

    # Increment time buffer.
    # NOTE: 謎
    @_buffer += delta

    # `@_maxStep`で設定した回数か`@_buffer`が空になるまで
    # integrate処理を実行する
    i = 0
    while @_buffer >= @timestep and ++i < @_maxSteps
      @integrate @timestep
      @_buffer -= @timestep
      @_time += @timestep

    # debug用にstepにかかった時間を記録
    @_step = new Date().getTime() - time

  # 後片付け
  destroy: ->
    @integrator = null
    @particles = null
    @springs = null

