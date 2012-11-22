{StringBuilder} = require '../lib/stringbuilder'
assert = require 'assert'

describe 'StringBuilder', ->
	describe '#constructor(str)', ->
		it 'should be empty initially', ->
			assert.equal (new StringBuilder()).toString(), ''
		it 'should take a string', ->
			str = 'This is a string.'
			assert.equal (new StringBuilder(str)).toString(), str
		it 'should take an array of characters', ->
			assert.equal (new StringBuilder(['a','b','c'])).toString(), 'abc'

	describe '#append(str)', ->
		it 'should accept a string', ->
			sb = new StringBuilder 'abc'
			sb.append 'def'
			assert.equal sb.toString(), 'abcdef'
		it 'should accept a character array', ->
			sb = new StringBuilder 'abc'
			sb.append ['d', 'e', 'f']
			assert.equal sb.toString(), 'abcdef'
		it 'should accept numbers', ->
			sb = new StringBuilder 'negative twelve point five: '
			sb.append -12.5
			assert.equal sb.toString(), 'negative twelve point five: -12.5'
		it 'should accept another StringBuilder', ->
			abc = new StringBuilder 'abc'
			def = new StringBuilder 'def'
			abc.append def
			assert.equal abc.toString(), 'abcdef'
		it 'should accept objects with a toString() method', ->
			obj =
				toString: ->
					return 'anObject'
			sb = new StringBuilder 'This is '
			sb.append obj
			assert.equal sb.toString(), 'This is anObject'

	describe '#at(index)', ->
		sb = new StringBuilder 'abc'

		it 'should return an empty string given index < -length', ->
			assert.equal sb.at(-4), ''
		it 'should count from the end given a negative index', ->
			assert.equal sb.at(-3), 'a'
		it 'should return the last character given an index of -1', ->
			assert.equal sb.at(-1), 'c'
		it 'should return the first character given an index of zero', ->
			assert.equal sb.at(0), 'a'
		it 'should return the character at the zero-based index', ->
			assert.equal sb.at(1), 'b'
		it 'should return an empty string given index >= length', ->
			assert.equal sb.at(3), ''

	describe '#insert(index, str)', ->
		def = new StringBuilder 'def'

		it 'should insert at the beginning given index < -length', ->
			sb = new StringBuilder 'abc'
			sb.insert -4, def
			assert.equal sb.toString(), 'defabc'
		it 'should insert str at the beginning given index = 0', ->
			sb = new StringBuilder 'abc'
			sb.insert 0, def
			assert.equal sb.toString(), 'defabc'
		it 'should insert str at index', ->
			sb = new StringBuilder 'abc'
			sb.insert 1, def
			assert.equal sb.toString(), 'adefbc'
		it 'should count from the end given negative index', ->
			sb = new StringBuilder 'abc'
			sb.insert -2, def
			assert.equal sb.toString(), 'adefbc'
		it 'should append str given index = length', ->
			sb = new StringBuilder 'abc'
			sb.insert 3, def
			assert.equal sb.toString(), 'abcdef'
		it 'should append str given index > length', ->
			sb = new StringBuilder 'abc'
			sb.insert 4, def
			assert.equal sb.toString(), 'abcdef'

	describe '#length()', ->
		it 'should be 0 initially', ->
			sb = new StringBuilder
			assert.equal sb.length(), 0
		it 'should be 0 for an empty string', ->
			sb = new StringBuilder ''
			assert.equal sb.length(), 0
		it 'should return the length of the string', ->
			sb = new StringBuilder 'abc'
			assert.equal sb.length(), 3
		it 'should be updated after characters are added', ->
			sb = new StringBuilder 'abc'
			sb.append 'def'
			assert.equal sb.length(), 6
		it 'should be updated after characters are removed', ->
			sb = new StringBuilder 'abc'
			sb.remove 1
			assert.equal sb.length(), 2

	describe '#remove(start, end)', ->
		describe 'given only start, no end', ->
			it 'should do nothing if index is out of range', ->
				sb = new StringBuilder 'abc'
				sb.remove -4
				sb.remove 3
				assert.equal sb.toString(), 'abc'
			it 'should use the end-based index if index < 0', ->
				sb = new StringBuilder 'abc'
				sb.remove -2
				assert.equal sb.toString(), 'ac'
			it 'should remove the first character given an index of 0', ->
				sb = new StringBuilder 'abc'
				sb.remove 0
				assert.equal sb.toString(), 'bc'
			it 'should remove the character at the 0-based index', ->
				sb = new StringBuilder 'abc'
				sb.remove 1
				assert.equal sb.toString(), 'ac'
			it 'should remove the last character given index = length - 1', ->
				sb = new StringBuilder 'abc'
				sb.remove 2
				assert.equal sb.toString(), 'ab'

		describe 'given start and end', ->
			it 'should do nothing if end <= start', ->
				sb = new StringBuilder 'abcde'
				sb.remove 2, 2
				assert.equal sb.toString(), 'abcde'
			it 'should remove a single character if end not given', ->
				sb = new StringBuilder 'abc'
				sb.remove 1
				assert.equal sb.toString(), 'ac'
			it 'should remove single char if start< 0 and end not given', ->
				sb = new StringBuilder 'abc'
				sb.remove -2
				assert.equal sb.toString(), 'ac'
			it 'should remove characters on the interval [start, end)', ->
				sb = new StringBuilder 'abcde'
				sb.remove 2, 4
				assert.equal sb.toString(), 'abe'
			it 'should remove to the end if end > length', ->
				sb = new StringBuilder 'abcde'
				sb.remove 2, 8
				assert.equal sb.toString(), 'ab'
			it 'should work on the first character', ->
				sb = new StringBuilder 'abc'
				sb.remove 0, 1
				assert.equal sb.toString(), 'bc'
			it 'should work on the last character', ->
				sb = new StringBuilder 'abc'
				sb.remove 2, 3
				assert.equal sb.toString(), 'ab'

	describe '#reverse()', ->
		it 'should do nothing to an empty string', ->
			sb = new StringBuilder
			sb.reverse()
			assert.equal sb.toString(), ''
		it 'should appear to do nothing to a palindrome', ->
			sb = new StringBuilder 'abcba'
			sb.reverse()
			assert.equal sb.toString(), 'abcba'
		it 'should reverse the string', ->
			sb = new StringBuilder 'abc'
			sb.reverse()
			assert.equal sb.toString(), 'cba'
		it 'should reverse a reversed string to the original string', ->
			sb = new StringBuilder 'abc'
			sb.reverse()
			sb.reverse()
			assert.equal sb.toString(), 'abc'

	describe '#substring(start, end)', ->
		sb = new StringBuilder 'abcde'

		it 'should return an empty string given end <= start', ->
			assert.equal sb.substring(2, 2).toString(), ''
		it 'should return an empty string given start >= length', ->
			assert.equal sb.substring(5, 7).toString(), ''
		it 'should return chars on the 0-based interval [start, end)', ->
			assert.equal sb.substring(2, 4).toString(), 'cd'
		it 'should return chars to end if end >= length', ->
			assert.equal sb.substring(2, 9).toString(), 'cde'
		# Not doing negative indices for now
		# it 'should count from the end given an index < 0', ->
		# 	assert.equal sb.substring(0, -3), 'ab'
		# 	assert.equal sb.substring(-3, -1), 'cd'
		# 	assert.equal sb.substring(-3, 99), 'cde'
		it 'should return the rest of the string given no end', ->
			assert.equal sb.substring(2).toString(), 'cde'
		it 'should return the whole string given [0, length)', ->
			assert.equal sb.substring(0, 5).toString(), 'abcde'
		it 'should return an empty string given a negative index', ->
			assert.equal sb.substring(-1, 1).toString(), ''
			assert.equal sb.substring(1, -1).toString(), ''
			assert.equal sb.substring(-2, -1).toString(), ''
