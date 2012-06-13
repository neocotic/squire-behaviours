# Description:
#   Sets up hooks to persist the brain into redis.
#
# Dependencies:
#   redis >= 0.6

Redis = require 'redis'
Url   = require 'url'

module.exports = (squire) ->

  info   = Url.parse process.env.REDISTOGO_URL or 'redis://localhost:6379'
  client = Redis.createClient info.port, info.hostname

  client.auth info.auth.split(':')[1] if info.auth

  client.on 'error', (err) ->
    squire.logger.error err

  client.on 'connect', ->
    squire.logger.info 'Successfully connected to Redis'

    client.get 'squire:memory', (err, reply) ->
      throw err if err?
      squire.brain.mergeMemories JSON.parse reply.toString() if reply

  squire.brain.on 'remember', (memories) ->
    client.set 'squire:memory', JSON.stringify memories

  squire.brain.on 'stop', ->
    client.quit()