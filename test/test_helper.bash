FUNL_TEST_DIR="${BATS_TMPDIR}/funl"

if [ "$HOME" != "${FUNL_TEST_DIR}/home" ]; then
  export FUNL_ROOT=$(cd "${BATS_TEST_DIRNAME}/.."; pwd)
  export FUNL_HOOKS="$FUNL_TEST_DIR/hooks"
  export FUNL_STUB_BIN="${FUNL_TEST_DIR}/bin"
  export HOME="$FUNL_TEST_DIR/home"

  PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
  PATH="${FUNL_STUB_BIN}:$PATH"
  PATH="${FUNL_ROOT}/bin:$PATH"
  export PATH
fi

teardown() {
  rm -rf "$FUNL_TEST_DIR"
}

eval_funl_init() {
  eval "$(funl init)"
}

stub_command() {
  local cmd_path="$FUNL_STUB_BIN/$1"
  cat <<SH > "$cmd_path"
#!/usr/bin/env bash
echo "$1: \$@"
SH
  chmod +x "$cmd_path"
}

stub_peco() {
  local peco_path="$FUNL_STUB_BIN/peco"
  cat <<SH > "$peco_path"
#!/usr/bin/env bash
if [[ $1 -lt 1 ]]; then
  exit 1
else
  head -n $1 < /dev/stdin | tail -n 1
fi
SH
  chmod +x "$peco_path"
}
