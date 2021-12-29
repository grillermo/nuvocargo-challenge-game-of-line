# Nuvocargo Conways Game of Life
This repo holds an implementation of Conway's Game of Life as a challenge to join Nuvocargo's tech team.

## Implementation
A single class implements a method to output the next generation.
It assumes a well-formed seed: an array of length n that contains arrays of length n. The inner arrays elements could be a the symbol :dead or :alive.
You can add additional test cases following that structure.

## Requirements

Ruby 3: it uses tally but i added the monkey patch to backport the method to ruby 2

## How to test
1. Clone
2. ruby conways-game-of-line.rb
