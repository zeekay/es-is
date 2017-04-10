import {isActualNaN} from '../utils'
import {isInfinite}  from './infinite'

# Test if `value` is less than `other`.
#
# @param {Number} value value to test
# @param {Number} other value to compare with
# @return {Boolean} if `value` is less than `other`
# @api public
export isLt = (value, other) ->
  if isActualNaN(value) or isActualNaN(other)
    throw new TypeError('NaN is not a valid value')
  !isInfinite(value) and !isInfinite(other) and value < other
