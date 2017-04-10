import {isArguments} from './arguments'

# Test if `value` is an empty arguments object.
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is an empty arguments object, false otherwise
# @api public
export isEmptyArguments = (value) ->
  isArguments(value) and value.length == 0
