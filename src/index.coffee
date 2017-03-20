# The definitive JavaScript type testing library
#
# @copyright 2013-2014 Enrico Marino / Jordan Harband
# @license MIT

objProto      = Object.prototype
owns          = objProto.hasOwnProperty
toStr         = objProto.toString
symbolValueOf = undefined
if typeof Symbol == 'function'
  symbolValueOf = Symbol::valueOf

isActualNaN = (value) ->
  value != value

NON_HOST_TYPES =
  'boolean': 1
  number:    1
  string:    1
  undefined: 1

base64Regex = /^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$/
hexRegex    = /^[A-Fa-f0-9]+$/

# Test if `value` is a type of `type`.
#
# @param {Mixed} value value to test
# @param {String} type type
# @return {Boolean} true if `value` is a type of `type`, false otherwise
# @api public
export isType = (value, type) ->
  typeof value == type

# Test if `value` is defined.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is defined, false otherwise
# @api public
export isDefined = (value) ->
  typeof value != 'undefined'

# Test if `value` is empty.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is empty, false otherwise
# @api public
export isEmpty = (value) ->
  type = toStr.call value
  if type == '[object Array]' or type == '[object Arguments]' or type == '[object String]'
    return value.length == 0

  if type == '[object Object]'
    for key of value
      if owns.call value, key
        return false
    return true

  !value

# Test if `value` is equal to `other`.
#
# @param {Mixed} value value to test
# @param {Mixed} other value to compare with
# @return {Boolean} true if `value` is equal to `other`, false otherwise
export isEqual = (value, other) ->
  return true if value == other

  type = toStr.call value

  if type != toStr.call(other)
    return false

  if type == '[object Object]'
    for key of value
      if !isEqual(value[key], other[key]) or !(key of other)
        return false
    for key of other
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

# Test if `value` is hosted by `host`.
#
# @param {Mixed} value to test
# @param {Mixed} host host to test with
# @return {Boolean} true if `value` is hosted by `host`, false otherwise
# @api public
export isHosted = (value, host) ->
  type = typeof host[value]
  if type == 'object' then ! !host[value] else !NON_HOST_TYPES[type]

# Test if `value` is an instance of `constructor`.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an instance of `constructor`
# @api public
export isInstanceof = (value, constructor) ->
  value instanceof constructor

# Test if `value` is null.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is null, false otherwise
# @api public
export isNil = (value) ->
  value == null

# Test if `value` is undefined.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is undefined, false otherwise
# @api public

export isUndefined = (value) ->
  typeof value == 'undefined'

# Test if `value` is an arraylike object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an arguments object, false otherwise
# @api public
export isArrayLike = (value) ->
  !!value and !isBool(value) and owns.call(value, 'length') and isFinite(value.length) and isNumber(value.length) and value.length >= 0

# Test if `value` is an arguments object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an arguments object, false otherwise
# @api public
export isArguments = isArgs = (value) ->
  isStandardArguments = toStr.call(value) == '[object Arguments]'
  isOldArguments = !isArray(value) and isArrayLike(value) and isObject(value) and isFn(value.callee)
  isStandardArguments or isOldArguments

# Test if 'value' is an array.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an array, false otherwise
# @api public
export isArray = Array.isArray or (value) ->
  toStr.call(value) == '[object Array]'

# Test if `value` is an empty arguments object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an empty arguments object, false otherwise
# @api public
export isEmptyArgs = (value) ->
  isArgs(value) and value.length == 0

# Test if `value` is an empty array.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an empty array, false otherwise
# @api public
export isEmptyArray = (value) ->
  isArray(value) and value.length == 0

# Test if `value` is a boolean.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a boolean, false otherwise
# @api public
export isBool = (value) ->
  toStr.call(value) == '[object Boolean]'

# Test if `value` is false.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is false, false otherwise
# @api public
export isFalse = (value) ->
  isBool(value) and Boolean(Number(value)) == false

# Test if `value` is true.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is true, false otherwise
# @api public
export isTrue = (value) ->
  isBool(value) and Boolean(Number(value)) == true

# Test date.

# Test if `value` is a date.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a date, false otherwise
# @api public
export isDate = (value) ->
  toStr.call(value) == '[object Date]'

# Test if `value` is a valid date.
#
# @param {Mixed} value value to test
# @returns {Boolean} true if `value` is a valid date, false otherwise
export isValidDate = (value) ->
  isDate(value) and !isNaN(Number(value))

# Test if `value` is an html element.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an HTML Element, false otherwise
# @api public
export isElement = (value) ->
  value != undefined and typeof HTMLElement != 'undefined' and value instanceof HTMLElement and value.nodeType == 1

# Test if `value` is an error object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an error object, false otherwise
# @api public
export isError = (value) ->
  toStr.call(value) == '[object Error]'

# Test if `value` is a function.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a function, false otherwise
# @api public
export isFunction = isFn = (value) ->
  isAlert = typeof window != 'undefined' and value == window.alert
  if isAlert
    return true
  str = toStr.call(value)
  str == '[object Function]' or str == '[object GeneratorFunction]' or str == '[object AsyncFunction]'

# Test if `value` is a number.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a number, false otherwise
# @api public
export isNumber = (value) ->
  toStr.call(value) == '[object Number]'

# Test if `value` is positive or negative infinity.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is positive or negative Infinity, false otherwise
# @api public
export isInfinite = (value) ->
  value == Infinity or value == -Infinity

# Test if `value` is a decimal number.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a decimal number, false otherwise
# @api public
export isDecimal = (value) ->
  isNumber(value) and !isActualNaN(value) and !isInfinite(value) and value % 1 != 0

# Test if `value` is divisible by `n`.
#
# @param {Number} value value to test
# @param {Number} n dividend
# @return {Boolean} true if `value` is divisible by `n`, false otherwise
# @api public
export isDivisibleBy = (value, n) ->
  isDividendInfinite = isInfinite(value)
  isDivisorInfinite = isInfinite(n)
  isNonZeroNumber = isNumber(value) and !isActualNaN(value) and isNumber(n) and !isActualNaN(n) and n != 0
  isDividendInfinite or isDivisorInfinite or isNonZeroNumber and value % n == 0

# Test if `value` is an integer.
#
# @param value to test
# @return {Boolean} true if `value` is an integer, false otherwise
# @api public
export isInteger = (value) ->
  isNumber(value) and !isActualNaN(value) and value % 1 == 0

# Test if `value` is greater than 'others' values.
#
# @param {Number} value value to test
# @param {Array} others values to compare with
# @return {Boolean} true if `value` is greater than `others` values
# @api public
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

# Test if `value` is less than `others` values.
#
# @param {Number} value value to test
# @param {Array} others values to compare with
# @return {Boolean} true if `value` is less than `others` values
# @api public
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

# Test if `value` is not a number.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is not a number, false otherwise
# @api public
export isNan = (value) ->
  isNumber(value) or value != value

# Test if `value` is an even number.
#
# @param {Number} value value to test
# @return {Boolean} true if `value` is an even number, false otherwise
# @api public
export isEven = (value) ->
  isInfinite(value) or isNumber(value) and value == value and value % 2 == 0

# Test if `value` is an odd number.
#
# @param {Number} value value to test
# @return {Boolean} true if `value` is an odd number, false otherwise
# @api public
export isOdd = (value) ->
  isInfinite(value) or isNumber(value) and value == value and value % 2 != 0

# Test if `value` is greater than or equal to `other`.
#
# @param {Number} value value to test
# @param {Number} other value to compare with
# @return {Boolean}
# @api public
export isGe = (value, other) ->
  if isActualNaN(value) or isActualNaN(other)
    throw new TypeError('NaN is not a valid value')
  !isInfinite(value) and !isInfinite(other) and value >= other

# Test if `value` is greater than `other`.
#
# @param {Number} value value to test
# @param {Number} other value to compare with
# @return {Boolean}
# @api public
export isGt = (value, other) ->
  if isActualNaN(value) or isActualNaN(other)
    throw new TypeError('NaN is not a valid value')
  !isInfinite(value) and !isInfinite(other) and value > other

# Test if `value` is less than or equal to `other`.
#
# @param {Number} value value to test
# @param {Number} other value to compare with
# @return {Boolean} if 'value' is less than or equal to 'other'
# @api public
export isLe = (value, other) ->
  if isActualNaN(value) or isActualNaN(other)
    throw new TypeError('NaN is not a valid value')
  !isInfinite(value) and !isInfinite(other) and value <= other

# Test if `value` is less than `other`.
#
# @param {Number} value value to test
# @param {Number} other value to compare with
# @return {Boolean} if `value` is less than `other`
# @api public
export isLt = (value, other) ->
  if isActualNaN(value) or isActualNaN(other)
    throw new TypeError('NaN is not a valid value')
  !isInfinite(value) and !isInfinite(other) and value < other

# Test if `value` is within `start` and `finish`.
#
# @param {Number} value value to test
# @param {Number} start lower bound
# @param {Number} finish upper bound
# @return {Boolean} true if 'value' is is within 'start' and 'finish'
# @api public
export isWithin = (value, start, finish) ->
  if isActualNaN(value) or isActualNaN(start) or isActualNaN(finish)
    throw new TypeError('NaN is not a valid value')
  else if !isNumber(value) or !isNumber(start) or !isNumber(finish)
    throw new TypeError('all arguments must be numbers')
  isAnyInfinite = isInfinite(value) or isInfinite(start) or isInfinite(finish)
  isAnyInfinite or value >= start and value <= finish

# Test if `value` is an object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an object, false otherwise
# @api public
export isObject = (value) ->
  toStr.call(value) == '[object Object]'

# Test if `value` is a primitive.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a primitive, false otherwise
# @api public
export isPrimitive = (value) ->
  if !value
    return true
  if typeof value == 'object' or isObject(value) or isFn(value) or isArray(value)
    return false
  true

# Test if `value` is a promise.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a promise, false otherwise
# @api public
export isPromise = (value) ->
  !!value and (typeof value == 'object' or typeof value == 'function') and typeof value.then == 'function'

# Test if `value` is a hash - a plain object literal.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a hash, false otherwise
# @api public
export isHash = (value) ->
  isObject(value) and value.constructor == Object and !value.nodeType and !value.setInterval

# Test if `value` is a regular expression.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a regexp, false otherwise
# @api public
export isRegexp = (value) ->
  toStr.call(value) == '[object RegExp]'

# Test if `value` is a string.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is a string, false otherwise
# @api public
export isString = (value) ->
  toStr.call(value) == '[object String]'

# Test if `value` is a valid base64 encoded string.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is a base64 encoded string, false otherwise
# @api public
export isBase64 = (value) ->
  isString(value) and (!value.length or base64Regex.test(value))

# Test if `value` is a valid hex encoded string.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is a hex encoded string, false otherwise
# @api public
export isHex = (value) ->
  isString(value) and (!value.length or hexRegex.test(value))

# Test if `value` is an ES6 Symbol
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a Symbol, false otherise
# @api public
export isSymbol = (value) ->
  typeof Symbol == 'function' and toStr.call(value) == '[object Symbol]' and typeof symbolValueOf.call(value) == 'symbol'

classic =
  type:         isType
  defined:      isDefined
  empty:        isEmpty
  equal:        isEqual
  hosted:       isHosted
  'instanceof': isInstanceof
  instance:     isInstanceof
  nil:          isNil
  undefined:    isUndefined
  undef:        isUndefined
  'arguments':  isArguments
  args:         isArguments
  array:        isArray
  arraylike:    isArrayLike
  bool:         isBool
  false:        isFalse
  true:         isTrue
  date:         isDate
  element:      isElement
  error:        isError
  function:     isFunction
  fn:           isFunction
  number:       isNumber
  infinite:     isInfinite
  decimal:      isDecimal
  divisibleBy:  isDivisibleBy
  integer:      isInteger
  maximum:      isMaximum
  max:          isMaximum
  minimum:      isMinimum
  min:          isMinimum
  nan:          isNan
  even:         isEven
  odd:          isOdd
  ge:           isGe
  gt:           isGt
  le:           isLe
  lt:           isLt
  within:       isWithin
  object:       isObject
  primitive:    isPrimitive
  promise:      isPromise
  hash:         isHash
  regexp:       isRegexp
  string:       isString
  base64:       isBase64
  hex:          isHex
  symbol:       isSymbol

classic.args.empty  = isEmptyArgs
classic.array.empty = isEmptyArray
classic.date.valid  = isValidDate

export default classic
