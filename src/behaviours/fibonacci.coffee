# Description:
#   Calculates the nth fibonacci number. Squire's quite clever you know.
#
# Commands:
#   fibonacci <n> - Calculates nth fibonacci number
#
# Notes:
#   From https://gist.github.com/1032685.

module.exports = (squire) ->

  bits = (n) ->
    (
      while n > 0
        [n, bit] = divMod n, 2
        bit
    ).reverse()

  divMod = (x, y) ->
    [(q = Math.floor x / y), (r = if x < y then x else x % y)]

  fibonacci = (n) ->
    [a, b, c] = [1, 0, 1]

    for bit in bits n
      if bit
        [a, b] = [(a + c) * b, b * b + c * c]
      else
        [a, b] = [a * a + b * b, (a + c) * b]
      c = a + b
    b

  squire.hear /// ^
      fibonacci \s+ (\d+)
    $ ///i, (msg) ->
    msg.reply fibonacci(msg.match[1]).toString()