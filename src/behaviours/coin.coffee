# Description:
#   Let Squire make easy 50/50 decisions for you.
#
# Commands:
#   flip a coin - Gives you heads or tails

module.exports = (squire) ->

  SIDES = ['Heads', 'Tails']

  squire.hear /// ^
      (flip | throw | toss) \s+ ((a | the) \s+)?
    coin $ ///i, (msg) ->
    msg.reply msg.random SIDES