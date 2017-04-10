import {toStr} from '../utils'

# Test if `value` is a regular expression.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a regexp, false otherwise
# @api public
export default isRegExp = (value) ->
  toStr.call(value) == '[object RegExp]'
