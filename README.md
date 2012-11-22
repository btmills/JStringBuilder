# JStringBuilder

A mutable string class for JavaScript.

## Methods

- [constructor(str)](#constructor)
- [append(str)](#append)
- [at(index)](#at)
- [insert(index, str)](#insert)
- [length()](#length)
- [remove(start, end)](#remove)
- [reverse()](#reverse)
- [substring(start, end)](#substring)

### <a name="constructor"></a>constructor(str)

The StringBuilder constructor will prepopulate the object with `str` if it is supplied.

```JavaScript
var sb = new StringBuilder('abc');
console.log(sb.toString()); // Prints 'abc'
```

### <a name="append"></a>append(str)

Add `str` to the end of the string.

```JavaScript
var sb = new StringBuilder('abc');
sb.append('def');
console.log(sb.toString()); // Prints 'abcdef'
```

### <a name="at"></a>at(index)
	
Get the single character at `index` (zero-based). Negative `index` counts from end (rightmost character is -1).

```JavaScript
var sb = new StringBuilder('abc');
console.log(sb.at(-2)); // Prints 'b'
```

### <a name="insert"></a>insert(index, str)

Insert `str` at `index` (0-based).

```JavaScript
var sb = new StringBuilder('abe');
sb.insert(-1, 'cd');
console.log(sb.toString()); // Prints 'abcde'
```

### <a name="length"></a>length()

Get the length of the string in characters.

```JavaScript
var sb = new StringBuilder('abc');
console.log(sb.length()); // Prints '3'
```

### <a name="remove"></a>remove(start, end)

Remove characters on the interval [`start`, `end`). If `end` is not given, remove a single character at `start` (0-based). Negative `start` counts from end (rightmost character is -1).

```JavaScript
var sb = new StringBuilder('abcde');
sb.remove(2, 4);
console.log(sb.toString()); // Prints 'abe'
```

```JavaScript
var sb = new StringBuilder('abc');
sb.remove(-2);
console.log(sb.toString()); // Prints 'ac'
```

### <a name="reverse"></a>reverse()

Reverse the contents of the StringBuilder.

```JavaScript
var sb = new StringBuilder('abc');
sb.reverse();
console.log(sb.toString()); // Prints 'cba'
```

### <a name="substring"></a>substring(start, end)

Get as StringBuilder containing just the substring on the interval [`start`, `end`).

```JavaScript
var sb = new StringBuilder('abcde');
console.log(sb.substring(2, 4).toString()); // Prints 'cd'
```

## Developing

To set up, run `npm install`. Build with `cake build`. Test with `cake test`.

## License

(The MIT License)

Copyright (c) 2012 Brandon Mills

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.