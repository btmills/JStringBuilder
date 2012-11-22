((exports) ->

	exports.StringBuilder = class
		@chars: []

		### Constructor ###

		constructor: (str) ->
			if str instanceof Array then @chars = str
			else if typeof str == 'string' then @chars = str.split ''
			else @chars = []

		### Internal ###

		asCharArray: (src) ->
			if typeof src == 'string'
				return src.split ''
			else if typeof src == 'number'
				src.toString().split ''
			else if src.constructor == exports.StringBuilder
				return src.chars
			else if src instanceof Array
				return src
			else
				return src.toString().split ''

		### StringBuilder methods ###

		append: (str) ->
			@chars = @chars.concat @asCharArray str

		at: (index) ->
			if 0 <= index < @chars.length # 0-based index
				return @chars[index]
			else if -@chars.length <= index <= -1 # End-based index
				return @chars[@chars.length + index]
			else
				return ''

		insert: (index, str) ->
			str = @asCharArray str
			@chars = @chars.slice(0, index)
				.concat(
					str.concat(
						@chars.slice index, @chars.length))

		length: ->
			return @chars.length

		remove: (start, end) ->
			if end is undefined and -@chars.length <= start < @chars.length
				@chars.splice start, 1
			else if 0 <= start < end
				@chars.splice start, end - start

		reverse: ->
			@chars = @chars.reverse()

		substring: (start, end) =>
			end = @chars.length if end is undefined # If no end, return rest of string
			if 0 <= start < end
				return new exports.StringBuilder @chars.slice(start, end).join ''
			else
				return new exports.StringBuilder

		toString: ->
			return @chars.join ''

)(if typeof exports is 'undefined' then this['StringBuilder'] = {} else exports)