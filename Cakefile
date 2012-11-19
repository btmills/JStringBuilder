{exec} = require 'child_process'
fs = require 'fs'
path = require 'path'

# Regular build system
task 'build', 'Build from src/*.coffee to lib/*.js', ->
	build()

# Sublime Text CoffeeScript build system
task 'sbuild', 'Build from Sublime Text 2 editor', ->
	build()

task 'build:test', 'Build the test suite', ->
	buildTest()

task 'clean', 'Remove all compiled JavaScript', ->
	removeFiles /.js$/, path.join '.', 'test'
	removeFiles /.js$/, path.join '.', 'lib'

task 'test', 'Run unit tests', ->
	build ->
		buildTest ->
			runTest ->
				#removeFiles /.js$/, path.join '.', 'test'


build = (callback) ->
	exec 'coffee --compile --bare --output lib/ src/', (err, stdout, stderr) ->
		#throw err if err
		console.log stdout + stderr
		callback() if callback

buildTest = (callback) ->
	exec 'coffee --compile --bare test/test.coffee', (err, stdout, stderr) ->
		#throw err if err
		console.log stdout + stderr
		callback() if callback

runTest = (callback) ->
	exec 'mocha --reporter spec', (err, stdout, stderr) ->
		#throw err if err
		console.log stdout + stderr
		callback() if callback

removeFiles = (re, dir) ->
	dir = __dirname if not dir
	#console.log 'Searching ' + dir + '...'
	fs.readdir dir, (err, files) ->
		throw err if err
		files.forEach (file) ->
			return if file == '.' or file == '..'
			file = path.join dir, file
			#console.log 'Found ' + file
			fs.stat file, (err, stat) ->
				if stat and stat.isDirectory()
					removeFiles re, file
				else if re.test file
					#console.log 'Removing ' + file
					fs.unlink file, (err) ->
						throw err if err
						console.log 'Removed ' + file
