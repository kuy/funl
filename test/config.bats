#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$HOME"
}

HELP_CONTENT="$(cat <<USAGE
Usage: funl config [-1]

Show available placeholder and alias names.
If '-1' option is specified, funl lists one name per one line.
USAGE
)"

@test "no config raises error" {
  run funl config "ticket" "src"
  [ "$status" -ne 0 ]
  [ "$output" == "funl: config not found" ]
}

@test "'-h' or '--help' options print usage" {
  run funl config -h
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]

  run funl config --help
  [ "$status" -eq 0 ]
  [ "$output" == "$HELP_CONTENT" ]
}

@test "no arguments print placeholder and alias names" {
  cat <<CONF > "$HOME/.funlrc"
cherry.src :aaa bbb ccc
b: &banana
banana.src: foo bar 2000
banana.post: foo bar 2000
apple.src: bla bla bla
a: &apple
CONF

  run funl config
  echo "$status: $output"
  [ "$status" -eq 0 ]
  [ "$output" == "apple banana cherry a b" ]
}

@test "'-1' option prints line by line" {
  cat <<CONF > "$HOME/.funlrc"
cherry.src :aaa bbb ccc
b: &banana
banana.src: foo bar 2000
banana.post: foo bar 2000
apple.src: bla bla bla
a: &apple
CONF

  run funl config -1
  echo "$status: $output"
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat <<OUTPUT
apple
banana
cherry
a
b
OUTPUT
  )" ]
}

@test "only 1 placeholder" {
  cat <<CONF > "$HOME/.funlrc"
apple.src: bla bla bla
CONF

  run funl config
  echo "$status: $output"
  [ "$status" -eq 0 ]
  [ "$output" == "apple" ]
}

@test "wrong arguments raise error" {
  touch "$HOME/.funlrc"

  run funl config "ticket"
  [ "$status" -ne 0 ]
  [ -z "$output" ]

  run funl config "ticket" "src" "post"
  [ "$status" -ne 0 ]
  [ -z "$output" ]
}

@test "source definition is required" {
  cat <<CONF > "$HOME/.funlrc"
nyan.src: bla bla bla
CONF

  run funl config "seq" "src"
  [ "$status" -ne 0 ]
  [ "$output" == "funl: 'seq.src' definition not found" ]
}

@test "post definition is optional" {
  cat <<CONF > "$HOME/.funlrc"
lang.src: de en ja
CONF

  run funl config "lang" "post"
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test "invalid type parameter raises error" {
  touch "$HOME/.funlrc"

  run funl config "ticket" "hoge"
  [ "$status" -ne 0 ]
  [ "$output" == "funl: invalid type: 'hoge'" ]
}

@test "prints matched config" {
  cat <<CONF > "$HOME/.funlrc"
nyan.src: bla bla bla
seq.src: foo bar 2000
seq.post :aaa bbb ccc
CONF

  run funl config "seq" "src"
  [ "$status" -eq 0 ]
  [ "$output" == "foo bar 2000" ]

  run funl config "seq" "post"
  [ "$status" -eq 0 ]
  [ "$output" == "aaa bbb ccc" ]
}

@test "supports alias" {
  cat <<CONF > "$HOME/.funlrc"
co.src: hoge hoge hoge
color.src: red green blue
color.post: R G B
c: &color
CONF

  run funl config "c" "src"
  [ "$status" -eq 0 ]
  [ "$output" == "red green blue" ]

  run funl config "c" "post"
  [ "$status" -eq 0 ]
  [ "$output" == "R G B" ]
}

@test "invalid alias" {
  cat <<CONF > "$HOME/.funlrc"
c: &color
CONF

  run funl config "c" "src"
  echo "$status: $output"
  [ "$status" -ne 0 ]
  [ "$output" == "funl: 'color.src' definition not found" ]
}
