# bofrev

**bofrev** - Boring Friday Evening - is a typical Friday late night ego-coding-session outcome that can be considered as some kind of Sandbox project.

This project is licensed under the [MIT License](https://github.com/simplay/bofrev/blob/master/LICENSE).

All sound files are from [freesound.org](www.freesound.org).

## Features

+ 2D Grid Game with Collision Detection.
+ Tetris Music with fancy effect sounds.

## Prerequisites

Ruby 2.2.0 and bundle

## Installation:

+ Have sounds when running the game: `brew install mplayer`.
+ `chmod +x bofrev` to run `./bofrev`.
+ Run `bundle`

## Usage

`./bofrev -d <D> -g <G>` to run the game **<G>** in running mode **<D>**.

+ Game Mode <D> is an _optional_ parameter:
  + <D> is **0**: run in normal mode.
  + <D> is **1**: run w/e music.
  + <D> is **2**: further run only based on user interaction.
  + default value is 0.

+ Game to Select <G> is an _optional_ parameter:
  + <D> is **1**: run Tetris game.
  + default value is 1

`./bofrev -h` To list the show the help man.

`rspec tests/some_tests.rb` to run grid tests

## Contributing

1. Fork this repository
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am "Add some feature"`
4. Push to the branch `git push origin my-new-feature`
5. Create new Pull Request (in your forked repository)
