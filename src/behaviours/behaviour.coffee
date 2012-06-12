# Load behaviours from the squire behaviours directory on the fly for testing
# purposes.
#
# add <name> behaviour - Adds the named behaviour
# help for <name> behaviour - Gives help for the named behaviour
# show behaviours - Gives names of all availiable behaviours
#
# Examples:
#
#   add coin behaviour
#   > flip a coin - Gives you heads or tails
#
#   help for coin behaviour
#   > flip a coin - Gives you heads or tails
#
#   show behaviours
#   > behaviour
#     brain-file
#     brain-redis
#     ...
#     dice
#     eightball
#     fibonacci
#
# Note:
#
#   1. Any behaviours that are added will be lost when the squire is
#      re-summoned unless you define then in `squire-behaviours.json`.
#   2. If this behaviours is enabled ANYBODY will be able to load behaviours,
#      you may not want to leave this behaviours enabled.

Fs   = require 'fs'
Path = require 'path'

module.exports = (squire) ->

  PATHS = ['node_modules', 'squire-behaviours', 'src', 'behaviours']
  WORDS = ['for', 'on', 'with']

  printHelp = (behaviour, msg) ->
    path = Path.resolve PATHS...
    tmpSquire = commands:
      push: (command) ->
        msg.reply command

    file = Path.join path, "#{behaviour}.coffee"
    squire.buildHelp.call tmpSquire, file, (err) ->
      if err?
        file = Path.join path, "#{behaviour}.js"
        squire.buildHelp.call tmpSquire, file, (err) ->
          squire.logger.error err if err?

  squire.hear /// ^
      (add | load)
      (\s+ the)?
    \s+ (.+) \s+ behaviour $ ///i, (msg) ->
    behaviour = msg.match[4].trim()
    unless behaviour.toLowerCase() is 'the'
      path = require.resolve Path.resolve PATHS..., behaviour

      printHelp behaviour, msg
      squire.loadResource Path.dirname(path), Path.basename path

  squire.hear /// ^
      (display | list | show)
      (\s+ all)? (\s+ available)?
    \s+ behaviours $ ///i, (msg) ->
    Fs.readdir Path.resolve(PATHS...), (err, files) ->
      squire.logger.error err if err?

      behaviours = (Path.basename file, Path.extname file for file in files)

      msg.reply behaviours.join '\n'

  squire.hear /// ^ (
        ((i \s+)? need \s+)?
        help
        (\s+ me)? (\s+ (#{WORDS.join '|'}))?
      | what(\'?s | \s+ is)
      | what \s+ does
    ) (\s+ the)? \s+ (.+) \s+ behaviour (\s+ do)? \?? $ ///i, (msg) ->
    behaviour = msg.match[9].trim()
    if behaviour.toLowerCase() not in WORDS.concat 'the'
      printHelp behaviour, msg