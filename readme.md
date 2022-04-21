# QProf

Quick and dirty flamegraph visualizations for ruby projects.

<img width="1196" alt="Screen Shot 2022-04-20 at 6 07 06 PM" src="https://user-images.githubusercontent.com/6063967/164351443-109e4b56-8212-4c16-bf22-c28ce7935d73.png">

## Dependencies

It has two dependencies which you probably already have installed:

- `git`, to pull [FlameGraph](https://github.com/brendangregg/FlameGraph)
- `perl`, to call `flamegraph.pl`

## Installation

`require 'qprof'` or `gem 'qprof'` in your gemfile

## Usage

```ruby
QProf.call { "...your code..." } # => opens a browser window
```
