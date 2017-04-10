# Test if `value` is a type of `type`.
#
# @param {Mixed} value value to test
# @param {String} type type
# @return {Boolean} true if `value` is a type of `type`, false otherwise
# @api public
export isType = (value, type) ->
  typeof value == type
