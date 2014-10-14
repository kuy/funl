FUNL_TEST_DIR="${BATS_TMPDIR}/funl"

if [ "$HOME" != "${FUNL_TEST_DIR}/home" ]; then
  export FUNL_ROOT=$(cd "${BATS_TEST_DIRNAME}/.."; pwd)
  export FUNL_HOOKS="$FUNL_TEST_DIR/hooks"
  export HOME="$FUNL_TEST_DIR/home"

  PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
  PATH="${FUNL_ROOT}/bin:$PATH"
  PATH="${FUNL_HOOKS}:$PATH"
  export PATH
fi

teardown() {
  rm -rf "$FUNL_TEST_DIR"
}
