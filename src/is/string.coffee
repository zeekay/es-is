import {toStr} from '../utils'

# Test if `value` is a string.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is a string, false otherwise
# @api public
export default isString = (value) ->
  toStr.call(value) == '[object String]'
