# Roll dice with your Squire.
#
# roll die - Rolls a six-sided die
# roll <x> - Rolls x number of dice
# roll <x>-sided die - Rolls a die with x number of sides
# roll <x> <y>-sided dice - Rolls x number of dice with y number of sides

module.exports = (squire) ->

  squire.hear /// ^ roll \s+
      ((a | the | [\d]+) \s+)?
      (([\d+]) (- | \s+) sided \s+)?
    dic?e $ ///i, (msg) ->
    count = parseInt msg.match[2]
    count = 1 if isNaN count
    sides = parseInt msg.match[4]
    sides = 6 if isNaN sides

    msg.reply if count < 1
      "So you don't want me to roll dice?"
    else if count > 100
      "I am your squire, not your slave."
    else if sides is 2
      'Perhaps it would be better if I flipped a coin instead.'
    else if sides < 1
      'What kind of die has no sides?'
    else
      rolls = (1 + Math.floor Math.random() * sides for i in [0...count])
      if rolls.length is 1
        "I rolled a #{rolls[0]}."
      else
        total = rolls.reduce (x, y) -> x + y
        lastComma = if (rolls.length > 2) then ',' else ''
        last = rolls.pop()
        "I rolled #{rolls.join ', '}#{lastComma} and #{last}, making #{total}."