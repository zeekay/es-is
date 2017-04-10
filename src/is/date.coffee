import {toStr} from '../utils'

# Test date.

# Test if `value` is a date.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a date, false otherwise
# @api public
export default isDate = (value) ->
  toStr.call(value) == '[object Date]'
