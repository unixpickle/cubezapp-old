if window?
  {Cube, MoveMaker} = window.Cubezapp
else if module?
  {Cube, MoveMaker} = require './cube'

class Algorithm
  constructor: (@moves, @side) ->
  
  
