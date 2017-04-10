import toString from 'es-tostring'

# Test if `value` is an object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an object, false otherwise
# @api public
export isObject = (value) ->
  toString(value) == '[object Object]'
