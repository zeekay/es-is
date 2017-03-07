'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

/**!
 * is
 * the definitive JavaScript type testing library
 *
 * @copyright 2013-2014 Enrico Marino / Jordan Harband
 * @license MIT
 */
var NON_HOST_TYPES;
var base64Regex;
var hexRegex;
var isActualNaN;
var objProto;
var owns;
var symbolValueOf;
var toStr;

objProto = Object.prototype;

owns = objProto.hasOwnProperty;

toStr = objProto.toString;

symbolValueOf = void 0;

if (typeof Symbol === 'function') {
  symbolValueOf = Symbol.prototype.valueOf;
}

isActualNaN = function(value) {
  return value !== value;
};

NON_HOST_TYPES = {
  boolean: 1,
  number: 1,
  string: 1,
  undefined: 1
};

base64Regex = /^([A-Za-z0-9+\/]{4})*([A-Za-z0-9+\/]{4}|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{2}==)$/;

hexRegex = /^[A-Fa-f0-9]+$/;

var isType = function(value, type) {
  return typeof value === type;
};


/**
 * Test if `value` is defined.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if 'value' is defined, false otherwise
 * @api public
 */

var isDefined = function(value) {
  return typeof value !== 'undefined';
};


/**
 * Test if `value` is empty.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is empty, false otherwise
 * @api public
 */

var isEmpty = function(value) {
  var key, type;
  type = toStr.call(value);
  key = void 0;
  if (type === '[object Array]' || type === '[object Arguments]' || type === '[object String]') {
    return value.length === 0;
  }
  if (type === '[object Object]') {
    for (key in value) {
      key = key;
      if (owns.call(value, key)) {
        return false;
      }
    }
    return true;
  }
  return !value;
};


/**
 * export isequal
 * Test if `value` is equal to `other`.
 *
 * @param {Mixed} value value to test
 * @param {Mixed} other value to compare with
 * @return {Boolean} true if `value` is equal to `other`, false otherwise
 */

var isEqual = function(value, other) {
  var key, type;
  if (value === other) {
    return true;
  }
  type = toStr.call(value);
  key = void 0;
  if (type !== toStr.call(other)) {
    return false;
  }
  if (type === '[object Object]') {
    for (key in value) {
      key = key;
      if (!isEqual(value[key], other[key]) || !(key in other)) {
        return false;
      }
    }
    for (key in other) {
      key = key;
      if (!isEqual(value[key], other[key]) || !(key in value)) {
        return false;
      }
    }
    return true;
  }
  if (type === '[object Array]') {
    key = value.length;
    if (key !== other.length) {
      return false;
    }
    while (key--) {
      if (!isEqual(value[key], other[key])) {
        return false;
      }
    }
    return true;
  }
  if (type === '[object Function]') {
    return value.prototype === other.prototype;
  }
  if (type === '[object Date]') {
    return value.getTime() === other.getTime();
  }
  return false;
};


/**
 * export ishosted
 * Test if `value` is hosted by `host`.
 *
 * @param {Mixed} value to test
 * @param {Mixed} host host to test with
 * @return {Boolean} true if `value` is hosted by `host`, false otherwise
 * @api public
 */

var isHosted = function(value, host) {
  var type;
  type = typeof host[value];
  if (type === 'object') {
    return !!host[value];
  } else {
    return !NON_HOST_TYPES[type];
  }
};


/**
 * export isinstance
 * Test if `value` is an instance of `constructor`.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is an instance of `constructor`
 * @api public
 */

var isInstanceof = function(value, constructor) {
  return value instanceof constructor;
};


/**
 * export isnil / export isnull
 * Test if `value` is null.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is null, false otherwise
 * @api public
 */

var isNil = function(value) {
  return value === null;
};


/**
 * export isundef / export isundefined
 * Test if `value` is undefined.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is undefined, false otherwise
 * @api public
 */

var isUndefined = function(value) {
  return typeof value === 'undefined';
};


/**
 * Test arguments.
 */


/**
 * export isargs
 * Test if `value` is an arguments object.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is an arguments object, false otherwise
 * @api public
 */

var isArgs = function(value) {
  var isOldArguments, isStandardArguments;
  isStandardArguments = toStr.call(value) === '[object Arguments]';
  isOldArguments = !isArray(value) && isArrayLike(value) && isObject(value) && isFn(value.callee);
  return isStandardArguments || isOldArguments;
};


/**
 * Test array.
 */


/**
 * export isarray
 * Test if 'value' is an array.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is an array, false otherwise
 * @api public
 */

var isArray = Array.isArray || function(value) {
  return toStr.call(value) === '[object Array]';
};


/**
 * export isarguments.empty
 * Test if `value` is an empty arguments object.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is an empty arguments object, false otherwise
 * @api public
 */

var isEmptyArgs = function(value) {
  return isArgs(value) && value.length === 0;
};


/**
 * export isarray.empty
 * Test if `value` is an empty array.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is an empty array, false otherwise
 * @api public
 */

var isEmptyArray = function(value) {
  return isArray(value) && value.length === 0;
};


/**
 * export isarraylike
 * Test if `value` is an arraylike object.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is an arguments object, false otherwise
 * @api public
 */

var isArraylike = function(value) {
  return !!value && !isBool(value) && owns.call(value, 'length') && isFinite(value.length) && isNumber(value.length) && value.length >= 0;
};


/**
 * Test boolean.
 */


/**
 * export isbool
 * Test if `value` is a boolean.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is a boolean, false otherwise
 * @api public
 */

var isBool = function(value) {
  return toStr.call(value) === '[object Boolean]';
};


/**
 * export isfalse
 * Test if `value` is false.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is false, false otherwise
 * @api public
 */

var isFalse = function(value) {
  return isBool(value) && Boolean(Number(value)) === false;
};


/**
 * export istrue
 * Test if `value` is true.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is true, false otherwise
 * @api public
 */

var isTrue = function(value) {
  return isBool(value) && Boolean(Number(value)) === true;
};


/**
 * Test date.
 */


/**
 * export isdate
 * Test if `value` is a date.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is a date, false otherwise
 * @api public
 */

var isDate = function(value) {
  return toStr.call(value) === '[object Date]';
};


/**
 * export isdate.valid
 * Test if `value` is a valid date.
 *
 * @param {Mixed} value value to test
 * @returns {Boolean} true if `value` is a valid date, false otherwise
 */

var isValidDate = function(value) {
  return isDate(value) && !isNaN(Number(value));
};


/**
 * Test element.
 */


/**
 * export iselement
 * Test if `value` is an html element.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is an HTML Element, false otherwise
 * @api public
 */

var isElement = function(value) {
  return value !== void 0 && typeof HTMLElement !== 'undefined' && value instanceof HTMLElement && value.nodeType === 1;
};


/**
 * Test error.
 */


/**
 * export iserror
 * Test if `value` is an error object.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is an error object, false otherwise
 * @api public
 */

var isError = function(value) {
  return toStr.call(value) === '[object Error]';
};


/**
 * Test function.
 */


/**
 * export isfn / export isfunction (deprecated)
 * Test if `value` is a function.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is a function, false otherwise
 * @api public
 */

var isFunction = function(value) {
  var isAlert, str;
  isAlert = typeof window !== 'undefined' && value === window.alert;
  if (isAlert) {
    return true;
  }
  str = toStr.call(value);
  return str === '[object Function]' || str === '[object GeneratorFunction]' || str === '[object AsyncFunction]';
};


/**
 * Test number.
 */


/**
 * export isnumber
 * Test if `value` is a number.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is a number, false otherwise
 * @api public
 */

var isNumber = function(value) {
  return toStr.call(value) === '[object Number]';
};


/**
 * export isinfinite
 * Test if `value` is positive or negative infinity.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is positive or negative Infinity, false otherwise
 * @api public
 */

var isInfinite = function(value) {
  return value === 2e308 || value === -2e308;
};


/**
 * export isdecimal
 * Test if `value` is a decimal number.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is a decimal number, false otherwise
 * @api public
 */

var isDecimal = function(value) {
  return isNumber(value) && !isActualNaN(value) && !isInfinite(value) && value % 1 !== 0;
};


/**
 * export isdivisibleBy
 * Test if `value` is divisible by `n`.
 *
 * @param {Number} value value to test
 * @param {Number} n dividend
 * @return {Boolean} true if `value` is divisible by `n`, false otherwise
 * @api public
 */

var isDivisibleBy = function(value, n) {
  var isDividendInfinite, isDivisorInfinite, isNonZeroNumber;
  isDividendInfinite = isInfinite(value);
  isDivisorInfinite = isInfinite(n);
  isNonZeroNumber = isNumber(value) && !isActualNaN(value) && isNumber(n) && !isActualNaN(n) && n !== 0;
  return isDividendInfinite || isDivisorInfinite || isNonZeroNumber && value % n === 0;
};


/**
 * export isinteger
 * Test if `value` is an integer.
 *
 * @param value to test
 * @return {Boolean} true if `value` is an integer, false otherwise
 * @api public
 */

var isInteger = function(value) {
  return isNumber(value) && !isActualNaN(value) && value % 1 === 0;
};


/**
 * export ismaximum
 * Test if `value` is greater than 'others' values.
 *
 * @param {Number} value value to test
 * @param {Array} others values to compare with
 * @return {Boolean} true if `value` is greater than `others` values
 * @api public
 */

var isMaximum = function(value, others) {
  var len;
  if (isActualNaN(value)) {
    throw new TypeError('NaN is not a valid value');
  } else if (!isArrayLike(others)) {
    throw new TypeError('second argument must be array-like');
  }
  len = others.length;
  while (--len >= 0) {
    if (value < others[len]) {
      return false;
    }
  }
  return true;
};


/**
 * export isminimum
 * Test if `value` is less than `others` values.
 *
 * @param {Number} value value to test
 * @param {Array} others values to compare with
 * @return {Boolean} true if `value` is less than `others` values
 * @api public
 */

var isMinimum = function(value, others) {
  var len;
  if (isActualNaN(value)) {
    throw new TypeError('NaN is not a valid value');
  } else if (!isArrayLike(others)) {
    throw new TypeError('second argument must be array-like');
  }
  len = others.length;
  while (--len >= 0) {
    if (value > others[len]) {
      return false;
    }
  }
  return true;
};


/**
 * export isnan
 * Test if `value` is not a number.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is not a number, false otherwise
 * @api public
 */

var isNan = function(value) {
  return isNumber(value) || value !== value;
};


/**
 * export iseven
 * Test if `value` is an even number.
 *
 * @param {Number} value value to test
 * @return {Boolean} true if `value` is an even number, false otherwise
 * @api public
 */

var even = function(value) {
  return isInfinite(value) || isNumber(value) && value === value && value % 2 === 0;
};


/**
 * export isodd
 * Test if `value` is an odd number.
 *
 * @param {Number} value value to test
 * @return {Boolean} true if `value` is an odd number, false otherwise
 * @api public
 */

var odd = function(value) {
  return isInfinite(value) || isNumber(value) && value === value && value % 2 !== 0;
};


/**
 * export isge
 * Test if `value` is greater than or equal to `other`.
 *
 * @param {Number} value value to test
 * @param {Number} other value to compare with
 * @return {Boolean}
 * @api public
 */

var isge = function(value, other) {
  if (isActualNaN(value) || isActualNaN(other)) {
    throw new TypeError('NaN is not a valid value');
  }
  return !sInfinite(value) && !isInfinite(other) && value >= other;
};


/**
 * export isgt
 * Test if `value` is greater than `other`.
 *
 * @param {Number} value value to test
 * @param {Number} other value to compare with
 * @return {Boolean}
 * @api public
 */

var gt = function(value, other) {
  if (isActualNaN(value) || isActualNaN(other)) {
    throw new TypeError('NaN is not a valid value');
  }
  return !isInfinite(value) && !isInfinite(other) && value > other;
};


/**
 * export isle
 * Test if `value` is less than or equal to `other`.
 *
 * @param {Number} value value to test
 * @param {Number} other value to compare with
 * @return {Boolean} if 'value' is less than or equal to 'other'
 * @api public
 */

var le = function(value, other) {
  if (isActualNaN(value) || isActualNaN(other)) {
    throw new TypeError('NaN is not a valid value');
  }
  return !isInfinite(value) && !isInfinite(other) && value <= other;
};


/**
 * export islt
 * Test if `value` is less than `other`.
 *
 * @param {Number} value value to test
 * @param {Number} other value to compare with
 * @return {Boolean} if `value` is less than `other`
 * @api public
 */

var lt = function(value, other) {
  if (isActualNaN(value) || isActualNaN(other)) {
    throw new TypeError('NaN is not a valid value');
  }
  return !isInfinite(value) && !isInfinite(other) && value < other;
};


/**
 * export iswithin
 * Test if `value` is within `start` and `finish`.
 *
 * @param {Number} value value to test
 * @param {Number} start lower bound
 * @param {Number} finish upper bound
 * @return {Boolean} true if 'value' is is within 'start' and 'finish'
 * @api public
 */

var within = function(value, start, finish) {
  var isAnyInfinite;
  if (isActualNaN(value) || isActualNaN(start) || isActualNaN(finish)) {
    throw new TypeError('NaN is not a valid value');
  } else if (!isNumber(value) || !isNumber(start) || !isNumber(finish)) {
    throw new TypeError('all arguments must be numbers');
  }
  isAnyInfinite = isInfinite(value) || isInfinite(start) || isInfinite(finish);
  return isAnyInfinite || value >= start && value <= finish;
};


/**
 * Test object.
 */


/**
 * export isobject
 * Test if `value` is an object.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is an object, false otherwise
 * @api public
 */

var isObject = function(value) {
  return toStr.call(value) === '[object Object]';
};


/**
 * export isprimitive
 * Test if `value` is a primitive.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is a primitive, false otherwise
 * @api public
 */

var isPrimitive = function(value) {
  if (!value) {
    return true;
  }
  if (typeof value === 'object' || isObject(value) || isFn(value) || isArray(value)) {
    return false;
  }
  return true;
};


/**
 * export ishash
 * Test if `value` is a hash - a plain object literal.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is a hash, false otherwise
 * @api public
 */

var isHash = function(value) {
  return isObject(value) && value.constructor === Object && !value.nodeType && !value.setInterval;
};


/**
 * Test regexp.
 */


/**
 * export isregexp
 * Test if `value` is a regular expression.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is a regexp, false otherwise
 * @api public
 */

var isRegexp = function(value) {
  return toStr.call(value) === '[object RegExp]';
};


/**
 * Test string.
 */


/**
 * export isstring
 * Test if `value` is a string.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if 'value' is a string, false otherwise
 * @api public
 */

var isString = function(value) {
  return toStr.call(value) === '[object String]';
};


/**
 * Test base64 string.
 */


/**
 * export isbase64
 * Test if `value` is a valid base64 encoded string.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if 'value' is a base64 encoded string, false otherwise
 * @api public
 */

var isBase64 = function(value) {
  return isString(value) && (!value.length || base64Regex.test(value));
};


/**
 * Test base64 string.
 */


/**
 * export ishex
 * Test if `value` is a valid hex encoded string.
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if 'value' is a hex encoded string, false otherwise
 * @api public
 */

var isHex = function(value) {
  return isString(value) && (!value.length || hexRegex.test(value));
};


/**
 * export issymbol
 * Test if `value` is an ES6 Symbol
 *
 * @param {Mixed} value value to test
 * @return {Boolean} true if `value` is a Symbol, false otherise
 * @api public
 */

var isSymbol = function(value) {
  return typeof Symbol === 'function' && toStr.call(value) === '[object Symbol]' && typeof symbolValueOf.call(value) === 'symbol';
};

exports.isType = isType;
exports.isDefined = isDefined;
exports.isEmpty = isEmpty;
exports.isEqual = isEqual;
exports.isHosted = isHosted;
exports.isInstanceof = isInstanceof;
exports.isNil = isNil;
exports.isUndefined = isUndefined;
exports.isArgs = isArgs;
exports.isArray = isArray;
exports.isEmptyArgs = isEmptyArgs;
exports.isEmptyArray = isEmptyArray;
exports.isArraylike = isArraylike;
exports.isBool = isBool;
exports.isFalse = isFalse;
exports.isTrue = isTrue;
exports.isDate = isDate;
exports.isValidDate = isValidDate;
exports.isElement = isElement;
exports.isError = isError;
exports.isFunction = isFunction;
exports.isNumber = isNumber;
exports.isInfinite = isInfinite;
exports.isDecimal = isDecimal;
exports.isDivisibleBy = isDivisibleBy;
exports.isInteger = isInteger;
exports.isMaximum = isMaximum;
exports.isMinimum = isMinimum;
exports.isNan = isNan;
exports.even = even;
exports.odd = odd;
exports.isge = isge;
exports.gt = gt;
exports.le = le;
exports.lt = lt;
exports.within = within;
exports.isObject = isObject;
exports.isPrimitive = isPrimitive;
exports.isHash = isHash;
exports.isRegexp = isRegexp;
exports.isString = isString;
exports.isBase64 = isBase64;
exports.isHex = isHex;
exports.isSymbol = isSymbol;
//# sourceMappingURL=index.js.map
