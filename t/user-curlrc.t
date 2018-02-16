setup::

  $ . $TESTDIR/setup

  $ fake -cb curl < curl.body

  $ export HOME="$PWD"
  $ mkdir -p "$HOME/.config/ghisco"
  $ touch ~/.config/ghisco/curlrc

test::

  $ ghisco roman-neuhauser/ghisco/pull/1 <<\EOF
  > ```
  > she said: "hello world!"
  > that's what she said
  > ```
  > EOF
  curl --netrc --config /*/.config/ghisco/curlrc -LSfs -H Content-Type: application/json -H Accept: application/json --data @- --url https://api.github.com/repos/roman-neuhauser/ghisco/issues/1/comments (glob)
  https://example.org/issue#comment


test explicit curlrc::

  $ ghisco -c ../somewhere/a-file roman-neuhauser/ghisco/pull/1 <<\EOF
  > ```
  > she said: "hello world!"
  > that's what she said
  > ```
  > EOF
  curl --netrc --config ../somewhere/a-file -LSfs -H Content-Type: application/json -H Accept: application/json --data @- --url https://api.github.com/repos/roman-neuhauser/ghisco/issues/1/comments (glob)
  https://example.org/issue#comment


test explicit netrc::

  $ ghisco -n ../somewhere/a-file roman-neuhauser/ghisco/pull/1 <<\EOF
  > ```
  > she said: "hello world!"
  > that's what she said
  > ```
  > EOF
  curl --config /*/.config/ghisco/curlrc --netrc-file ../somewhere/a-file -LSfs -H Content-Type: application/json -H Accept: application/json --data @- --url https://api.github.com/repos/roman-neuhauser/ghisco/issues/1/comments (glob)
  https://example.org/issue#comment


test explicit both curl and netrc::

  $ ghisco -c ../somewhere/a-file -n elsewhere/another roman-neuhauser/ghisco/pull/1 <<\EOF
  > ```
  > she said: "hello world!"
  > that's what she said
  > ```
  > EOF
  curl --config ../somewhere/a-file --netrc-file elsewhere/another -LSfs -H Content-Type: application/json -H Accept: application/json --data @- --url https://api.github.com/repos/roman-neuhauser/ghisco/issues/1/comments (glob)
  https://example.org/issue#comment
