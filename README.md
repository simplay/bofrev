# bofrev

[![Build Status](https://travis-ci.org/simplay/bofrev.svg?branch=master)](https://travis-ci.org/simplay/bofrev)

**bofrev** - Boring Friday Evening - originates from a Friday late-night coding session.

The idea behind this project _is_ to implement a _Framework_ to
implement 2D applications similar to old nintendo games and numerical simulations. 

The framework should allow to easily implement a game without having to understand how the framework is implemented. Ultimatively, a simple game should be implementable by only defining how user input affects the game state and how the game state should be periodically updated (according to a given world clock).

This project is licensed under the [MIT License](https://github.com/simplay/bofrev/blob/master/LICENSE).

## Acknowledgement

+ All sound files are from [freesound.org](www.freesound.org).
+ For playing sound files, bofrev uses the java library [TinySound](https://github.com/finnkuusisto/TinySound).

## Features

+ 2D Grid Games 
+ Freefrom games without a grid
+ Collision Detection.
+ Music Player, Sound Effect Player
+ Tetris Music with fancy effect sounds.
+ Tetris, Game of Life
+ Fractal Image Renderer

## Plans

+ Support advanced networking modes.

## Prerequisites
+ JRuby 9.0.0.0.pre1
+ bundle

## Installation

+ install `rvm`. See [here](https://rvm.io/)
 + run `\curl -sSL https://get.rvm.io | bash -s stable` 
+ install JRuby 9.0.0.0.pre1
 + run `rvm install jruby-9.0.0.0.pre1`  
+ install `bundler`
+ clone this repository
+ `cd` into `bofrev/`
+ run `bundle`

## Start application
Either run `ruby bofrev` or run `java -jar bofrev.jar`. For further information, please have a look at the **Usage** section below.

## Usage

Enter `./bofrev -d <D> -g <G> -m <M>` into your terminal to run the game `<G>` in running mode `<D>`.

+ Game Mode `<D>` is an _optional_ parameter:

  + `<D>` is **0**: run in normal mode.
  + `<D>` is **1**: run w/e music.
  + `<D>` is **2**: further run only based on user interaction.
  + default value is 0.

+ Game to Select `<G>` is an _optional_ parameter:

  + `<G>`is **1**: run Tetris.
  + `<G>`is **2**: run Game of Life.
  + `<G>`is **3**: run Sokoban.
  + `<G>`is **4**: run Snake.
  + `<G>`is **5**: run Ping Pong.
  + `<G>`is **6**: run 2d Fractal Renderer 
  + `<G>`is **7**: run sprites demo 
  + default value is 1

+ `<M>` indicates whether we want to play in single-or Multiplayer-Mode or want to host a server. This parameter is optional.

  + `<M>` is **0**: run in single player mode. (default)
  + `<M>` is **1**: run in multiplayer client mode.
  + `<M>` is **2**: run in multiplayer server mode.

`./bofrev -h` To list the show the help man.

`rspec tests/some_tests.rb` to run grid tests

On windows, please run the application the following way:
`ruby bofrev -g <G> -d 1`
without the parameter `-d 1`, the application will start to lag eventually (pretty soon).

## Applications
### Tetris

A standard Tetris game implementation with known rules.
Try to fill whole rows by placing blocks to increase your score.
The higher your score gets the faster the game becomes.
There are also some achievements to unlock. :sheep:
You lose the game when your grid gets over-crowded (i.e. the latest block reached top row).

+ Controls:
 + **a key** left
 + **d key** right
 + **s key** down
 + **w key** rotate shape clock-wise

### Game of Life

Click (left click) and drag you mouse over the game grid to mark the grid's state.
Depending on the marking, the grid will be updated according to the rules of [Game of Life](http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

+ Controls:
 + **a key** start update
 + **s key** decrease update rate
 + **w key** increase update rate

### Sokoban

The player (red block) has to push the chest (blue block) onto a target (green block).

+ Controls:
 + **a key** left
 + **d key** right
 + **s key** down
 + **w key** up

### Snake

_WIP state game_

+ Controls:
 + **a key** left
 + **d key** right
 + **s key** down
 + **w key** up

### Ping Pong

_WIP state game_

+ Controls:
 + **a key** left
 + **d key** right
 

### Sprites demo

_WIP state game_

+ Controls:
 + **a key** left
 + **d key** right

## Contributing

1. Fork this repository
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am "Add some feature"`
4. Push to the branch `git push origin my-new-feature`
5. Create new Pull Request (in your forked repository)
