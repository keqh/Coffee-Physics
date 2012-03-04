# Random
# ======
# 乱数生成処理
# Math.randomでは[0,1)の範囲で疑似乱数を返すが、
# このライブラリでは各用途に特化したRandom処理を定義している

# [min, max)の範囲の乱数を返す
# maxを省略した場合、[0, min)を返す
# return Float : [min, max)
# return Float : [0, min) if max is undefined
Random = (min, max) ->
  if not max?
      max = min
      min = 0
      
  min + Math.random() * (max - min)

# NOTE: Random(min, max)を使わないのは関数呼出しを減らすため?
# これで良くね? -> Math.floor Random(min, max)
# return Int : [min, max)
# return Int : [0, min) if max is undefined
Random.int = (min, max) ->
  if not max?
      max = min
      min = 0
      
  Math.floor min + Math.random() * (max - min)

# 出現頻度は引数に指定したprobに依る
# probが1に近いほど1が出やすくなる
# NOTE: Random.bool使ってもいいのでは
# return Int : 1 or -1
Random.sign = (prob = 0.5) ->
  if do Math.random < prob then 1 else -1

# 出現頻度は引数に指定したprobに依る
# probが1に近いほどtrueが出やすくなる
# return Bool : 
Random.bool = (prob = 0.5) ->
  do Math.random < prob

# listで渡した値を等頻度で返す
# return Any : listの値のどれか
Random.item = (list) ->
  list[ Math.floor Math.random() * list.length ]
