setup::

  $ . $TESTDIR/setup

  $ fake -cb curl < curl.body

  $ mkdir .tmp
  $ export TMPDIR="$PWD/.tmp"


test::

  $ ghisco https://github.com/roman-neuhauser/ghisco/pull/1 <<\EOF
  > ```
  > she said: "hello world!"
  > that's what she said
  > ```
  > EOF
  curl --netrc -LSfs -H Content-Type: application/json -H Accept: application/json --data @- --url https://api.github.com/repos/roman-neuhauser/ghisco/issues/1/comments
  https://example.org/issue#comment

  $ ls -lA $TMPDIR
  total 0
