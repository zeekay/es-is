# Test if `value` is defined.
#
# @param {Mixed} value value to test
# @return {Boolean} true if 'value' is defined, false otherwise
# @api public
export isDefined = (value) ->
  typeof value != 'undefined'
