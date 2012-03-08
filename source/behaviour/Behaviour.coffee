# Behaviour
# =========
class Behaviour
  # behaviourに一意なIDを振るための変数
  @GUID = 0

  constructor: ->
    @GUID = Behaviour.GUID++
    @interval = 1

  apply: (p, dt, index) ->
    # Store some data in each particle.
    (p['__behaviour' + @GUID] ?= {counter: 0}).counter++
