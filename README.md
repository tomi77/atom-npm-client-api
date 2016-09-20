# atom-npm-client-api

[![dependencies Status](https://david-dm.org/tomi77/atom-npm-client-api/status.svg)](https://david-dm.org/tomi77/atom-npm-client-api)

NPM client API for Atom

## Installation

~~~bash
npm i atom-npm-client-api
~~~

## Usage

~~~coffee-script
{getPackages} = require 'atom-npm-client-api'

getPackages().done (pkgs) ->
  pkgs.forEach (pkg) ->
    pkg.install()
    .then () -> console.log "All dependencies for package #{pkg.name} installed successfully"
    .catch (err) -> console.log "Some error occurred: #{err}"
~~~

## Multi-project support

Multiple projects in one window are supported.

## Supported commands

### Run script

~~~coffee-script
pkg.run 'test'
pkg.on 'exit', (code, stdout, stderr) ->
  if code
    console.error stderr
  else
    console.log stdout
~~~

### List outdated packages

~~~coffee-script
pkh.outdated()
.then (list) ->
  if list.length is 0
    console.log 'Everyting is up-to-date'
  else
    console.log 'Outdated packages: ', list
~~~

### Install project dependencies

~~~coffee-script
pkg.install()
.then () -> console.log "All dependencies for package #{pkg.name} installed successfully"
.catch (err) -> console.log "Some error occurred: #{err}"
~~~

### Install specific package

~~~coffee-script
pkg.install 'lodash'
.then () -> console.log "lodash installed successfully"
.catch (err) -> console.log "Some error occurred: #{err}"
~~~

### Update project dependencies

~~~coffee-script
pkg.update()
.then () -> console.log "All dependencies for package #{pkg.name} updated successfully"
.catch (err) -> console.log "Some error occurred: #{err}"
~~~

### Update specific package

~~~coffee-script
pkg.update 'lodash'
.then () -> console.log "lodash updated successfully"
.catch (err) -> console.log "Some error occurred: #{err}"
~~~
