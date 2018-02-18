setup::

  $ . $TESTDIR/setup

  $ fake curl
  $ fake -cvx 111 vi
  $ unset EDITOR
  $ unset VISUAL

  $ mkdir .tmp
  $ export TMPDIR="$PWD/.tmp"


test default::

  $ ghisco -i roman-neuhauser/ghisco/issues/1
  vi /* (glob)
  [111]

  $ ls -lA $TMPDIR
  total 0


test $EDITOR use::

  $ fake -cvx 69 fubar
  $ export EDITOR=fubar

  $ ghisco -i roman-neuhauser/ghisco/issues/1
  fubar /* (glob)
  [69]


test $VISUAL preference over $EDITOR::

  $ fake -cvx 42 snafu
  $ export VISUAL=snafu

  $ ghisco -i roman-neuhauser/ghisco/issues/1
  snafu /* (glob)
  [42]


test empty file aborts::

  $ fake -cv rofl
  $ export VISUAL=rofl

  $ ghisco -i roman-neuhauser/ghisco/issues/1
  rofl /* (glob)
  ghisco: no comment!
  [1]


test successful edit::

  $ fake -cb curl <<\CURL
  > #!/bin/sh
  > sed 's@^@INPUT: @' >&2
  > CURL

  $ fake -cb rofl <<\ROFL
  > #!/bin/sh
  > echo cannot reproduce > $1
  > ROFL

  $ export VISUAL=rofl

  $ ghisco -i roman-neuhauser/ghisco/issues/1
  INPUT: {
  INPUT:   "body": "cannot reproduce\n"
  INPUT: }

  $ ls -lA $TMPDIR
  total 0
