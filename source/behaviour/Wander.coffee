### Wander Behaviour ###
class Wander extends Behaviour

  # - jitter Float : 映像や音楽の乱れ とのこと
  # - radius Float? : 
  # - strength Float : 一度の振舞での変化量
  constructor: (@jitter = 0.5, @radius = 100, @strength = 1.0) ->
    @theta = Math.random() * Math.PI * 2
    super
  
  apply: (p, dt, index) ->
    #super p, dt, index

    @theta += (Math.random() - 0.5) * @jitter * Math.PI * 2

    p.acc.x += Math.cos(@theta) * @radius * @strength
    p.acc.y += Math.sin(@theta) * @radius * @strength

