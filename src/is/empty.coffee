import {owns, toStr} from '../utils'

# Test if `value` is empty.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is empty, false otherwise
# @api public
export default isEmpty = (value) ->
  type = toStr.call value
  if type == '[object Array]' or type == '[object Arguments]' or type == '[object String]'
    return value.length == 0

  if type == '[object Object]'
    for key of value
      if owns.call value, key
        return false
    return true

  !value
