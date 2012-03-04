# 汎用的なnamespace生成処理
# ただしgrepしても使用されている場所は見当らない
namespace = (id) ->
	root = self
	root = root[path] ?= {} for path in id.split '.'

### RequestAnimationFrame shim. ###
# RequestAnimationFrameのvendor毎の差異を吸収する処理
do ->
  # なぞ。requestAnimationFrameのfallbackで使用されているらしいが
  # とくに代入されている箇所はない
  time = 0
  
  # requestAnimationFrameをチェックするvendor prefix
  vendors = ['ms', 'moz', 'webkit', 'o']

  # vendor prefixが付いたものが見つかればそれを
  # window.RequestAnimationFrameに上書きする
  for vendor in vendors when not window.requestAnimationFrame
    window.requestAnimationFrame = window[ vendor + 'RequestAnimationFrame']
    window.cancelRequestAnimationFrame = window[ vendor + 'CancelRequestAnimationFrame']

  # もしrequestAnimationFrameが見つからなかったらsetTimeoutで代用
  # NOTE: if文ではなく ?= で初期化すればいいのでは?
  if not window.requestAnimationFrame
    window.requestAnimationFrame = (callback, element) ->
      now = new Date().getTime()
      delta = Math.max 0, 16 - (now - old)
      setTimeout (-> callback(time + delta)), delta
      old = now + delta

  # cancelAnimationFrameの設定
  # requestAnimationFrameが見つからなかったときの代用処理
  # NOTE: if文ではなく ?= で初期化すればいいのでは?
  # NOTE: たぶんこの処理使われていない
  if not window.cancelAnimationFrame
    window.cancelAnimationFrame = (id) ->
      clearTimeout id
