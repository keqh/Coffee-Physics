### Constant Force Behaviour ###
# 同じ力を加え続ける
class ConstantForce extends Behaviour
  constructor: (@force = new Vector()) ->
    super

  apply: (p, dt,index) ->
    #super p, dt, index
    p.acc.add @force
