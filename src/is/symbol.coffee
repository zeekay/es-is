import {symbolValueOf, toStr} from '../utils'

# Test if `value` is an ES6 Symbol
#
# @param {Mixed} value value to test
# @return {Boolean} true if `value` is a Symbol, false otherise
# @api public
export default isSymbol = (value) ->
  typeof Symbol == 'function' and
  toStr.call(value) == '[object Symbol]' and
  typeof symbolValueOf.call(value) == 'symbol'
