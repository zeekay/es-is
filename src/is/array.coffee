import {toStr} from '../utils'

# Test if 'value' is an array.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an array, false otherwise
# @api public
export default isArray = Array.isArray or (value) ->
  toStr.call(value) == '[object Array]'
