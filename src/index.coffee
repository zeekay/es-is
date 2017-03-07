###*!
# is
# the definitive JavaScript type testing library
#
# @copyright 2013-2014 Enrico Marino / Jordan Harband
# @license MIT
###

objProto = Object.prototype
owns = objProto.hasOwnProperty
toStr = objProto.toString
symbolValueOf = undefined
if typeof Symbol == 'function'
  symbolValueOf = Symbol::valueOf

isActualNaN = (value) ->
  value != value

NON_HOST_TYPES =
  boolean:   1
  number:    1
  string:    1
  undefined: 1

base64Regex = /^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$/
hexRegex    = /^[A-Fa-f0-9]+$/

export isType = (value, type) ->
  typeof value == type

###*
# Test if `value` is defined.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is defined, false otherwise
# @api public
###

export isDefined = (value) ->
  typeof value != 'undefined'

###*
# Test if `value` is empty.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is empty, false otherwise
# @api public
###

export isEmpty = (value) ->
  type = toStr.call(value)
  key = undefined
  if type == '[object Array]' or type == '[object Arguments]' or type == '[object String]'
    return value.length == 0
  if type == '[object Object]'
    for key of value
      `key = key`
      if owns.call(value, key)
        return false
    return true
  !value

###*
# export isequal
# Test if `value` is equal to `other`.
#
# @param {Mixed} value value to test
# @param {Mixed} other value to compare with
# @return {Boolean} true if `value` is equal to `other`, false otherwise
###

export isEqual = (value, other) ->
  if value == other
    return true
  type = toStr.call(value)
  key = undefined
  if type != toStr.call(other)
    return false
  if type == '[object Object]'
    for key of value
      `key = key`
      if !isEqual(value[key], other[key]) or !(key of other)
        return false
    for key of other
      `key = key`
      if !isEqual(value[key], other[key]) or !(key of value)
        return false
    return true
  if type == '[object Array]'
    key = value.length
    if key != other.length
      return false
    while key--
      if !isEqual(value[key], other[key])
        return false
    return true
  if type == '[object Function]'
    return value.prototype == other.prototype
  if type == '[object Date]'
    return value.getTime() == other.getTime()
  false

###*
# export ishosted
# Test if `value` is hosted by `host`.
#
# @param {Mixed} value to test
# @param {Mixed} host host to test with
# @return {Boolean} true if `value` is hosted by `host`, false otherwise
# @api public
###

export isHosted = (value, host) ->
  type = typeof host[value]
  if type == 'object' then ! !host[value] else !NON_HOST_TYPES[type]

###*
# export isinstance
# Test if `value` is an instance of `constructor`.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an instance of `constructor`
# @api public
###

export isInstanceof = (value, constructor) ->
  value instanceof constructor

###*
# export isnil / export isnull
# Test if `value` is null.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is null, false otherwise
# @api public
###

export isNil = (value) ->
  value == null

###*
# export isundef / export isundefined
# Test if `value` is undefined.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is undefined, false otherwise
# @api public
###

export isUndefined = (value) ->
  typeof value == 'undefined'

###*
# Test arguments.
###

###*
# export isargs
# Test if `value` is an arguments object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an arguments object, false otherwise
# @api public
###

export isArgs = (value) ->
  isStandardArguments = toStr.call(value) == '[object Arguments]'
  isOldArguments = !isArray(value) and isArrayLike(value) and isObject(value) and isFn(value.callee)
  isStandardArguments or isOldArguments

###*
# Test array.
###

###*
# export isarray
# Test if 'value' is an array.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an array, false otherwise
# @api public
###

export isArray = Array.isArray or (value) ->
  toStr.call(value) == '[object Array]'

###*
# export isarguments.empty
# Test if `value` is an empty arguments object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an empty arguments object, false otherwise
# @api public
###

export isEmptyArgs = (value) ->
  isArgs(value) and value.length == 0

###*
# export isarray.empty
# Test if `value` is an empty array.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an empty array, false otherwise
# @api public
###

export isEmptyArray = (value) ->
  isArray(value) and value.length == 0

###*
# export isarraylike
# Test if `value` is an arraylike object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an arguments object, false otherwise
# @api public
###

export isArraylike = (value) ->
  ! !value and !isBool(value) and owns.call(value, 'length') and isFinite(value.length) and isNumber(value.length) and value.length >= 0

###*
# Test boolean.
###

###*
# export isbool
# Test if `value` is a boolean.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a boolean, false otherwise
# @api public
###

export isBool = (value) ->
  toStr.call(value) == '[object Boolean]'

###*
# export isfalse
# Test if `value` is false.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is false, false otherwise
# @api public
###

export isFalse = (value) ->
  isBool(value) and Boolean(Number(value)) == false

###*
# export istrue
# Test if `value` is true.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is true, false otherwise
# @api public
###

export isTrue = (value) ->
  isBool(value) and Boolean(Number(value)) == true

###*
# Test date.
###

###*
# export isdate
# Test if `value` is a date.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a date, false otherwise
# @api public
###

export isDate = (value) ->
  toStr.call(value) == '[object Date]'

###*
# export isdate.valid
# Test if `value` is a valid date.
#
# @param {Mixed} value value to test
# @returns {Boolean} true if `value` is a valid date, false otherwise
###

export isValidDate = (value) ->
  isDate(value) and !isNaN(Number(value))

###*
# Test element.
###

###*
# export iselement
# Test if `value` is an html element.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an HTML Element, false otherwise
# @api public
###

export isElement = (value) ->
  value != undefined and typeof HTMLElement != 'undefined' and value instanceof HTMLElement and value.nodeType == 1

###*
# Test error.
###

###*
# export iserror
# Test if `value` is an error object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an error object, false otherwise
# @api public
###

export isError = (value) ->
  toStr.call(value) == '[object Error]'

###*
# Test function.
###

###*
# export isfn / export isfunction (deprecated)
# Test if `value` is a function.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a function, false otherwise
# @api public
###

export isFunction = (value) ->
  isAlert = typeof window != 'undefined' and value == window.alert
  if isAlert
    return true
  str = toStr.call(value)
  str == '[object Function]' or str == '[object GeneratorFunction]' or str == '[object AsyncFunction]'

###*
# Test number.
###

###*
# export isnumber
# Test if `value` is a number.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a number, false otherwise
# @api public
###

export isNumber = (value) ->
  toStr.call(value) == '[object Number]'

###*
# export isinfinite
# Test if `value` is positive or negative infinity.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is positive or negative Infinity, false otherwise
# @api public
###

export isInfinite = (value) ->
  value == Infinity or value == -Infinity

###*
# export isdecimal
# Test if `value` is a decimal number.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a decimal number, false otherwise
# @api public
###

export isDecimal = (value) ->
  isNumber(value) and !isActualNaN(value) and !isInfinite(value) and value % 1 != 0

###*
# export isdivisibleBy
# Test if `value` is divisible by `n`.
#
# @param {Number} value value to test
# @param {Number} n dividend
# @return {Boolean} true if `value` is divisible by `n`, false otherwise
# @api public
###

export isDivisibleBy = (value, n) ->
  isDividendInfinite = isInfinite(value)
  isDivisorInfinite = isInfinite(n)
  isNonZeroNumber = isNumber(value) and !isActualNaN(value) and isNumber(n) and !isActualNaN(n) and n != 0
  isDividendInfinite or isDivisorInfinite or isNonZeroNumber and value % n == 0

###*
# export isinteger
# Test if `value` is an integer.
#
# @param value to test
# @return {Boolean} true if `value` is an integer, false otherwise
# @api public
###

export isInteger = (value) ->
  isNumber(value) and !isActualNaN(value) and value % 1 == 0

###*
# export ismaximum
# Test if `value` is greater than 'others' values.
#
# @param {Number} value value to test
# @param {Array} others values to compare with
# @return {Boolean} true if `value` is greater than `others` values
# @api public
###

export isMaximum = (value, others) ->
  if isActualNaN(value)
    throw new TypeError('NaN is not a valid value')
  else if !isArrayLike(others)
    throw new TypeError('second argument must be array-like')
  len = others.length
  while --len >= 0
    if value < others[len]
      return false
  true

###*
# export isminimum
# Test if `value` is less than `others` values.
#
# @param {Number} value value to test
# @param {Array} others values to compare with
# @return {Boolean} true if `value` is less than `others` values
# @api public
###

export isMinimum = (value, others) ->
  if isActualNaN(value)
    throw new TypeError('NaN is not a valid value')
  else if !isArrayLike(others)
    throw new TypeError('second argument must be array-like')
  len = others.length
  while --len >= 0
    if value > others[len]
      return false
  true

###*
# export isnan
# Test if `value` is not a number.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is not a number, false otherwise
# @api public
###

export isNan = (value) ->
  isNumber(value) or value != value

###*
# export iseven
# Test if `value` is an even number.
#
# @param {Number} value value to test
# @return {Boolean} true if `value` is an even number, false otherwise
# @api public
###

export even = (value) ->
  isInfinite(value) or isNumber(value) and value == value and value % 2 == 0

###*
# export isodd
# Test if `value` is an odd number.
#
# @param {Number} value value to test
# @return {Boolean} true if `value` is an odd number, false otherwise
# @api public
###

export odd = (value) ->
  isInfinite(value) or isNumber(value) and value == value and value % 2 != 0

###*
# export isge
# Test if `value` is greater than or equal to `other`.
#
# @param {Number} value value to test
# @param {Number} other value to compare with
# @return {Boolean}
# @api public
###

export isge = (value, other) ->
  if isActualNaN(value) or isActualNaN(other)
    throw new TypeError('NaN is not a valid value')
  !sInfinite(value) and !isInfinite(other) and value >= other

###*
# export isgt
# Test if `value` is greater than `other`.
#
# @param {Number} value value to test
# @param {Number} other value to compare with
# @return {Boolean}
# @api public
###

export gt = (value, other) ->
  if isActualNaN(value) or isActualNaN(other)
    throw new TypeError('NaN is not a valid value')
  !isInfinite(value) and !isInfinite(other) and value > other

###*
# export isle
# Test if `value` is less than or equal to `other`.
#
# @param {Number} value value to test
# @param {Number} other value to compare with
# @return {Boolean} if 'value' is less than or equal to 'other'
# @api public
###

export le = (value, other) ->
  if isActualNaN(value) or isActualNaN(other)
    throw new TypeError('NaN is not a valid value')
  !isInfinite(value) and !isInfinite(other) and value <= other

###*
# export islt
# Test if `value` is less than `other`.
#
# @param {Number} value value to test
# @param {Number} other value to compare with
# @return {Boolean} if `value` is less than `other`
# @api public
###

export lt = (value, other) ->
  if isActualNaN(value) or isActualNaN(other)
    throw new TypeError('NaN is not a valid value')
  !isInfinite(value) and !isInfinite(other) and value < other

###*
# export iswithin
# Test if `value` is within `start` and `finish`.
#
# @param {Number} value value to test
# @param {Number} start lower bound
# @param {Number} finish upper bound
# @return {Boolean} true if 'value' is is within 'start' and 'finish'
# @api public
###

export within = (value, start, finish) ->
  if isActualNaN(value) or isActualNaN(start) or isActualNaN(finish)
    throw new TypeError('NaN is not a valid value')
  else if !isNumber(value) or !isNumber(start) or !isNumber(finish)
    throw new TypeError('all arguments must be numbers')
  isAnyInfinite = isInfinite(value) or isInfinite(start) or isInfinite(finish)
  isAnyInfinite or value >= start and value <= finish

###*
# Test object.
###

###*
# export isobject
# Test if `value` is an object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an object, false otherwise
# @api public
###

export isObject = (value) ->
  toStr.call(value) == '[object Object]'

###*
# export isprimitive
# Test if `value` is a primitive.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a primitive, false otherwise
# @api public
###

export isPrimitive = (value) ->
  if !value
    return true
  if typeof value == 'object' or isObject(value) or isFn(value) or isArray(value)
    return false
  true

###*
# export ishash
# Test if `value` is a hash - a plain object literal.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a hash, false otherwise
# @api public
###

export isHash = (value) ->
  isObject(value) and value.constructor == Object and !value.nodeType and !value.setInterval

###*
# Test regexp.
###

###*
# export isregexp
# Test if `value` is a regular expression.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a regexp, false otherwise
# @api public
###

export isRegexp = (value) ->
  toStr.call(value) == '[object RegExp]'

###*
# Test string.
###

###*
# export isstring
# Test if `value` is a string.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is a string, false otherwise
# @api public
###

export isString = (value) ->
  toStr.call(value) == '[object String]'

###*
# Test base64 string.
###

###*
# export isbase64
# Test if `value` is a valid base64 encoded string.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is a base64 encoded string, false otherwise
# @api public
###

export isBase64 = (value) ->
  isString(value) and (!value.length or base64Regex.test(value))

###*
# Test base64 string.
###

###*
# export ishex
# Test if `value` is a valid hex encoded string.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is a hex encoded string, false otherwise
# @api public
###

export isHex = (value) ->
  isString(value) and (!value.length or hexRegex.test(value))

###*
# export issymbol
# Test if `value` is an ES6 Symbol
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a Symbol, false otherise
# @api public
###

export isSymbol = (value) ->
  typeof Symbol == 'function' and toStr.call(value) == '[object Symbol]' and typeof symbolValueOf.call(value) == 'symbol'
