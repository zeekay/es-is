import isArray     from './array'
import isArrayLike from './array-like'
import isFunction  from './function'
import isObject    from './object'
import {toStr}     from '../utils'

# Test if `value` is an arguments object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an arguments object, false otherwise
# @api public
export default isArguments = (value) ->
  isStandardArguments = toStr.call(value) == '[object Arguments]'

  isOldArguments = !isArray(value) and
                   isArrayLike(value) and
                   isObject(value) and
                   isFunction(value.callee)

  isStandardArguments or isOldArguments
