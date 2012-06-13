# Description:
#   Let Squire make ALL decisions for you.
#
# Commands:
#   decide between "<options...>" - Picks a random option for you
#
# Examples:
#   decide "Vodka Tonic" "Tom Collins" "Rum & Coke"
#   decide "Stay in bed like a lazy bastard" "You have shit to code, get up!"

module.exports = (squire) ->

  squire.hear /// ^ (
        choose
      | decide
    ) \s+ (between \s+)? "(.+)" $ ///i, (msg) ->
    options = msg.match[3].split '" "'
    msg.reply """Definitely "#{msg.random options}"."""