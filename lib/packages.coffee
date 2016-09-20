path = require 'path'

{initialize} = require './npm'
Promise = require 'promise'
readJson = require 'read-package-json'

Package = require './package'


getPackage = (pkgdir) ->
  initialize()
  .then (npm) ->
    new Promise (resolve, reject) ->
      readJson path.resolve(pkgdir, 'package.json'), (err, pkg) ->
        resolve if err then {} else new Package pkgdir, pkg, npm
        return
      return

module.exports.getPackages = () ->
  Promise.all atom.project.getDirectories().map (dir) -> getPackage dir.path
