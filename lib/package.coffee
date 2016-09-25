{BufferedProcess} = require 'atom'

{makeEnv} = require 'npm/lib/utils/lifecycle'
extend = require 'lodash/extend'
Promise = require 'promise'

module.exports = class Package
  constructor: (@wd, pkg, @npm) ->
    extend @, pkg

    env = makeEnv pkg
    @conf = cwd: @wd, env: env, shell: yes

    if process.platform is 'win32' then @conf.windowsVerbatimArguments = true

    return

  run: (script) ->
    stdoutBuffer = []
    stderrBuffer = []

    new Promise (resolve, reject) =>
      new BufferedProcess
        command: 'npm'
        args: ['run', script]
        options: @conf
        stdout: (output) ->
          stdoutBuffer = stdoutBuffer.concat output
          return
        stderr: (output) ->
          stderrBuffer = stderrBuffer.concat output
          return
        exit: (code) ->
          if code
            reject code: code, stdout: stdoutBuffer.join('\n'), stderr: stderrBuffer.join('\n')
          else
            resolve stdout: stdoutBuffer.join('\n'), stderr: stderrBuffer.join('\n')
          return

      return

  outdated: () ->
    new Promise (resolve, reject) =>
      @npm.prefix = @wd
      outdated = require 'npm/lib/outdated'
      outdated {}, (_, list) -> resolve list
      return

  install: (name) ->
    name or= []
    new Promise (resolve, reject) =>
      @npm.prefix = @wd
      install = require 'npm/lib/install'
      install name, (err) -> unless err? then resolve() else reject err
      return

  update: (name) ->
    name or= []
    new Promise (resolve, reject) =>
      @npm.prefix = @wd
      update = require 'npm/lib/update'
      update name, (err) -> unless err? then resolve() else reject err
      return
