# bofrev

**bofrev** - Boring Friday Evening - is a typical Friday late-night ego-coding-session outcome.

The idea behind this project was and still _is_ to implement some kind of basic _Framework_ in order to
implement 2D grid-based applications.
Examples for such applications are old nintendo-like games, numerical simulations, and graphical editors.

This project is licensed under the [MIT License](https://github.com/simplay/bofrev/blob/master/LICENSE).

All sound files are from [freesound.org](www.freesound.org).

## Features

+ 2D Grid Games with Collision Detection.
+ Tetris Music with fancy effect sounds.
+ Pseudo Framework to create custom 2d grid based games.
+ Tetris, Game of Life, and many upcoming events
+ Fractal Image Renderer
+ Freeform image renderer with animations.

## Plans

+ Support advanced numerical grid computation to solve graph problems, PDEs.
+ Support advanced networking modes.

## Prerequisites

Ruby **2.2.0** and bundle

## Installation:

### Windows 
Go to `http://rubyinstaller.org/downloads/`
Download ruby Ruby 2.2.1 and install it
Download Development Kit _for use with Ruby 2.0 and 2.1_ and install
Install the [Development Kit](https://forwardhq.com/help/installing-ruby-windows)
with the following key-steps: 

+ First extract files to `C:\DevKit`:

 1. Open **cmd**
 2. Enter `cd c:`
 3. Enter `mkdir DevKit`
 4. Copy downloaded DevKit Archieve File into that folder.
 5. Run the downloaded DevKit executable within that directory.

+ Then perfrom the following steps:

 1. `chdir C:\DevKit`
 2. `ruby dk.rb init`
 3. `ruby dk.rb install`

### Mac
+ Have sounds when running the game: `brew install mplayer`.
+ `chmod +x bofrev` to run `./bofrev`.
+ Run `bundle`

## Usage

`./bofrev -d <D> -g <G> -m <M>` to run the game `<G>` in running mode `<D>`.

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
