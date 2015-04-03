# bofrev

**bofrev** - Boring Friday Evening - is a typical Friday late-night ego-coding-session.

The idea behind this project was and still IS to implement some kind of basic _Framework_ in order to
speeding up the implementation of 2d grid based applications.
Examples for such applications are old nintendo-like games, numerical simulations, and graphical editors.

This project is licensed under the [MIT License](https://github.com/simplay/bofrev/blob/master/LICENSE).

All sound files are from [freesound.org](www.freesound.org).

## Features

+ 2D Grid Games with Collision Detection.
+ Tetris Music with fancy effect sounds.
+ Pseudo Framework to create custom 2d grid based games.
+ Tetris, Game of Life, and many upcoming events

## Plans

+ Support advanced numerical grid computation to solve graph problems, PDEs.
+ Support advanced networking modes.

## Prerequisites

Ruby **2.2.0** and bundle

## Installation:

+ Have sounds when running the game: `brew install mplayer`.
+ `chmod +x bofrev` to run `./bofrev`.
+ Run `bundle`

## Usage

`./bofrev -d <D> -g <G> -m <M>` to run the game **<G>** in running mode **<D>**.

+ Game Mode <D> is an _optional_ parameter:

  + <D> is **0**: run in normal mode.
  + <D> is **1**: run w/e music.
  + <D> is **2**: further run only based on user interaction.
  + default value is 0.

+ Game to Select <G> is an _optional_ parameter:

  + <D> is **1**: run Tetris.
  + <D> is **2**: run Game of Life.
  + <D> is **3**: run Sokoban.
  + default value is 1

+ <M> indicates whether we want to play in single-or Multiplayer-Mode or want to host a server. This parameter is optional.

  + <M> is **0**: run in single player mode. (default)
  + <M> is **1**: run in multiplayer client mode.
  + <M> is **2**: run in multiplayer server mode.

`./bofrev -h` To list the show the help man.

`rspec tests/some_tests.rb` to run grid tests

## Contributing

1. Fork this repository
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am "Add some feature"`
4. Push to the branch `git push origin my-new-feature`
5. Create new Pull Request (in your forked repository)
