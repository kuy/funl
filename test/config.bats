#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$HOME"
}

@test "no config raises error" {
  run funl config "ticket" "src"
  [ "$status" -ne 0 ]
  [ "$output" == "funl: config not found" ]
}

@test "no arguments print defined placeholders" {
  cat <<CONF > "$HOME/.funlrc"
apple.src: bla bla bla
banana.src: foo bar 2000
banana.post: foo bar 2000
cherry.src :aaa bbb ccc
CONF

  run funl config
  [ "$status" -eq 0 ]
  [ "$output" == "apple banana cherry" ]
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

@test "invalid type parameter raises error" {
  touch "$HOME/.funlrc"
  run funl config "ticket" "hoge"
  [ "$status" -ne 0 ]
  [ "$output" == "funl: invalid type: 'hoge'" ]
}

@test "source definition is required" {
  cat <<CONF > "$HOME/.funlrc"
nyan.src: bla bla bla
CONF
  run funl config "seq" "src"
  [ "$status" -ne 0 ]
  [ "$output" == "funl: 'src' definition is required (missing 'seq.src')" ]
}

@test "post definition is optional" {
  cat <<CONF > "$HOME/.funlrc"
lang.src: de en ja
CONF
  run funl config "lang" "post"
  [ "$status" -eq 0 ]
  [ -z "$output" ]
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
