{Cube, MoveMaker} = require './cube'

console.log MoveMaker.makeMove('R', 0, 3).encode()
console.log MoveMaker.makeMove('L', 0, 3).encode()
console.log MoveMaker.makeMove('U', 0, 3).encode()
console.log MoveMaker.makeMove('D', 0, 3).encode()
console.log MoveMaker.makeMove('F', 0, 3).encode()
console.log MoveMaker.makeMove('B', 0, 3).encode()
