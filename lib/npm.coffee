npm = require 'npm'
Promise = require 'promise'


module.exports.initialize = () ->
  new Promise (resolve, reject) ->
    npm.load (err) ->
      if err then reject err
      resolve npm
    return
