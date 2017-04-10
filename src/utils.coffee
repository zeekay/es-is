export objProto      = Object.prototype
export owns          = objProto.hasOwnProperty
export toStr         = objProto.toString
export symbolValueOf = if typeof Symbol == 'function' then Symbol::valueOf else undefined

export isActualNaN = (value) ->
  value != value
