# bofrev [![Build Status](https://travis-ci.org/simplay/bofrev.svg?branch=master)](https://travis-ci.org/simplay/bofrev) [![Test Coverage](https://codeclimate.com/github/simplay/bofrev/badges/coverage.svg)](https://codeclimate.com/github/simplay/bofrev/coverage)  [![Code Climate](https://codeclimate.com/github/simplay/bofrev/badges/gpa.svg)](https://codeclimate.com/github/simplay/bofrev) [![Inline docs](http://inch-ci.org/github/simplay/bofrev.svg?branch=master)](http://inch-ci.org/github/simplay/bofrev)

**bofrev** - Boring Friday Evening - originates from a Friday late-night coding session.

The idea behind this project _is_ to implement a _Framework_ to
implement 2D applications similar to old nintendo games and numerical simulations. 

The framework should allow to easily implement a game without having to understand how the framework is implemented. Ultimatively, a simple game should be implementable by only defining how user input affects the game state and how the game state should be periodically updated (according to a given world clock).

A list of all implemented applications can be found [here](https://github.com/simplay/bofrev/wiki/Applications).

This project is licensed under the [MIT License](https://github.com/simplay/bofrev/blob/master/LICENSE).

## Acknowledgement

+ All sound files are from [freesound.org](www.freesound.org).
+ For playing sound files, bofrev uses the java library [TinySound](https://github.com/finnkuusisto/TinySound).
+ For generating an exectuable bofrev jar file we make use of [Warble](https://github.com/jruby/warbler).
+ For testing we rely on [Minitest](https://github.com/seattlerb/minitest)
+ For evaluating the quality of the code documentation, we rely on [inch](https://github.com/rrrene/inch)

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
+ JRuby 9.0.1.0
+ bundler
+ git (optional)

## Installation

+ Install `rvm`. See [here](https://rvm.io/)
 + Run `\curl -sSL https://get.rvm.io | bash -s stable` 
+ Install JRuby 9.0.1.0
 + Run `rvm install jruby-9.0.1.0` 
+ Install `bundler`
 + Enter `gem install bundler`
+ Clone this repository
 + Enter `git clone https://github.com/simplay/bofrev.git`
+ Go to cloned repository: 
 + Enter `cd path_where_i_put_this_repo_to/bofrev/`
+ Install dependencies:
 + Enter `bundle`

## Run a application

Either enter `ruby bofrev` into your console or run the latest bofrev.jar via `java -jar bofrev.jar`. For further information, please have a look at the **Usage** section below.

## Usages

### Running tests
Enter `rake test` or simply `rake` in your console.

### Generating an executable jar
Enter `chmod +x make_jar` and then `./make_jar` into your console.

### Running bofrev
Enter `./bofrev -d <D> -g <G> -m <M>` into your terminal to run the game `<G>` in running mode `<D>`.
Example `ruby bofrev -g 3 -d 1` To run the game number 3 in the mode 2.

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

## Known Issues

+ when running the test suit locally entering entering `rake`, it may report _Coverage may be inaccurate_ which will result in reporting `Coverage = 0.0%`. By entering `export JRUBY_OPTS="-Xcli.debug=true --debug"` into your console this will be fixed.

## Contributing

1. Fork this repository
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am "Add some feature"`
4. Push to the branch `git push origin my-new-feature`
5. Create new Pull Request (in your forked repository)
