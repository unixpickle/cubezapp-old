if window?
  {Cube, MoveMaker} = window.Cubezapp
else if module?
  {Cube, MoveMaker} = require './cube'

class Move
  constructor: (@layers, @face, @exponent) ->
  
  @parse: (string) ->
    match = /^([0-9]*)([RUFLDB])(w?)([0-2]?|')$/.exec string
    if not match?
      throw new Error 'invalid move: ' + string
    
    face = match[2]
    
    # parse layer count
    if match[1].length is 0
      if match[3] is 'w' then wideCount = 2
      else wideCount = 1
    else wideCount = parseInt match[1]
    
    # parse exponent
    if match[4].length is 0 then exponent = 1
    else if match[4] is "'" then exponent = 3
    else exponent = parseInt match[4]
    
    # validate numerals
    if isNaN(wideCount) or isNaN(exponent)
      throw new Error 'invalid move: ' + string
    
    return new Move wideCount, face, exponent


class Algorithm
  constructor: (@moves, @side) ->
  
  toCube: ->
    cube = new Cube @side
    for move in @moves
      for offset in [0...move.layers] by 1
        transform = MoveMaker.makeMove(move.face, offset, @side)
        resultTransform = transform
        for x in [0...move.exponent - 1] by 1
          resultTransform = transform.apply resultTransform
        cube = resultTransform.apply cube
    return cube
  
  @parse: (algorithm, side) ->
    if 'string' isnt typeof algorithm
      throw new TypeError 'invalid algorithm type'
    if 'number' isnt typeof side
      throw new TypeError 'invalid side type'
    names = algorithm.split /\s+/
    moves = []
    for name in names
      moves.push Move.parse name
    return new Algorithm moves, side

if module?
  module.exports = {Algorithm, Move}
else if window?
  window.Cubezapp ?= {}
  window.Cubezapp.Algorithm = Algorithm
