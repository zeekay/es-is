import {toStr} from '../utils'

# Test if `value` is a number.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a number, false otherwise
# @api public
export default isNumber = (value) ->
  toStr.call(value) == '[object Number]'
