import {toStr} from '../utils'

# Test if `value` is an object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an object, false otherwise
# @api public
export default isObject = (value) ->
  toStr.call(value) == '[object Object]'
