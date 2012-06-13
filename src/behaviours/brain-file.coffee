# Description:
#   Sets up hooks to persist the brain into a file.

Fs   = require 'fs'
Path = require 'path'

module.exports = (squire) ->

  PATH   = process.env.SQUIRE_BRAIN_PATH
  PATH or= Path.resolve process.env.HOME, 'squire'
  PATH   = Path.join PATH, 'brain-dump.json'

  try
    memories = Fs.readFileSync PATH, 'utf-8'
    squire.brain.mergeMemories JSON.parse memories if memories
  catch err
    squire.logger.error err unless err.code is 'ENOENT'

  squire.brain.on 'remember', (memories) ->
    Fs.writeFileSync PATH, JSON.stringify(memories), 'utf-8'