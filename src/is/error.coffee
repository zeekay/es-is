import {toStr} from '../utils'

# Test if `value` is an error object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an error object, false otherwise
# @api public
export default isError = (value) ->
  toStr.call(value) == '[object Error]'
