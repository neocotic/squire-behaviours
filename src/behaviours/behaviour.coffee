# Description:
#   Load behaviours from the squire behaviours directory on the fly for testing
#   purposes.
#
# Commands:
#   add <name> behaviour - Adds the named behaviour
#   show behaviours - Gives names of all availiable behaviours

# Notes:
#   1. Any behaviours that are added will be lost when the squire is
#      re-summoned unless you define then in `squire-behaviours.json`.
#   2. If this behaviours is enabled ANYBODY will be able to load behaviours,
#      you may not want to leave this behaviours enabled.
#
# Examples:
#   Squire> add coin behaviour
#   flip a coin - Gives you heads or tails
#
#   Squire> show behaviours
#   behaviour
#   brain-file
#   coin
#   ...
#   dice
#   eightball
#   fibonacci

Fs   = require 'fs'
Path = require 'path'

module.exports = (squire) ->

  PATHS = ['node_modules', 'squire-behaviours', 'src', 'behaviours']

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