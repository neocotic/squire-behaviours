# Description:
#   Luckily, a Squire never leaves home without their magic eightball.
#
# Commands:
#   ask magic eightball <question> - Ask the magic 8-ball a question

module.exports = (squire) ->

  ANSWERS = [
    'It is certain'
    'It is decidedly so'
    'Without a doubt'
    'Yes – definitely'
    'You may rely on it'
    'As I see it, yes'
    'Most likely'
    'Outlook good'
    'Signs point to yes'
    'Yes'
    'Reply hazy, try again'
    'Ask again later'
    'Better not tell you now'
    'Cannot predict now'
    'Concentrate and ask again'
    "Don't count on it"
    'My reply is no'
    'My sources say no'
    'Outlook not so good'
    'Very doubtful'
  ]

  squire.hear /// ^
      (ask \s+ (the \s+)?)?
      (magic \s+)?
      (8 | eight) (- | \s*)
    ball \s+ (.+) $ ///i, (msg) ->
    msg.reply msg.random ANSWERS