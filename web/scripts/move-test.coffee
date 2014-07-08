{Cube, MoveMaker} = require './cube'
{Algorithm, Move} = require './algorithm'

compareArrays = (a1, a2) ->
  return false if a1.length isnt a2.length
  for arg1, i in a1
    arg2 = a2[i]
    if arg1 instanceof Array
      return false if not (arg2 instanceof Array)
      return false if not compareArrays arg1, arg2
    else
      return false if arg1 isnt arg2
  return true

test3x3 = ->
  process.stdout.write 'testing 3x3x3 sune algorithm ... '
  algo = Algorithm.parse "R U R' U R U2 R'", 3
  cube = algo.toCube()
  shouldBe = [
    [3, 1, 6, 1, 1, 1, 1, 1, 1],
    [1, 5, 5, 2, 2, 2, 2, 2, 2],
    [1, 3, 3, 3, 3, 3, 5, 3, 2],
    [4, 4, 4, 4, 4, 4, 4, 4, 4],
    [3, 6, 6, 5, 5, 5, 5, 5, 5],
    [3, 2, 2, 6, 6, 6, 6, 6, 6]
  ]
  if not compareArrays shouldBe, cube.encode()
    console.error 'FAILED!'
    process.exit 1
  else
    console.log 'passed!'

test4x4 = ->
  process.stdout.write 'testing 4x4x4 huge algorithm ... '
  algo = Algorithm.parse "R Rw' Uw L2 U2 Dw 3Rw Bw' Uw2", 4
  cube = algo.toCube()
  shouldBe = [
    [5, 1, 5, 5, 3, 3, 2, 3, 1, 1, 1, 1, 1, 4, 4, 4],
    [6, 2, 3, 3, 2, 4, 4, 4, 3, 3, 2, 3, 4, 4, 4, 4],
    [1, 1, 3, 3, 1, 1, 3, 3, 4, 6, 4, 4, 2, 6, 2, 2],
    [3, 5, 5, 5, 4, 5, 5, 5, 2, 2, 4, 2, 6, 6, 6, 6],
    [4, 1, 2, 2, 5, 6, 6, 6, 3, 3, 5, 6, 1, 1, 5, 1],
    [6, 6, 2, 3, 1, 1, 5, 6, 5, 6, 2, 5, 2, 6, 2, 5]
  ]
  if not compareArrays shouldBe, cube.encode()
    console.error 'FAILED!'
    process.exit 1
  else
    console.log 'passed!'

test3x3()
test4x4()
  