setup::

  $ . $TESTDIR/setup

  $ fake -cb curl < curl.body


test::

  $ ghisco https://github.com/roman-neuhauser/ghisco/issues/1 <<\EOF
  > ```
  > she said: "hello world!"
  > that's what she said
  > ```
  > EOF
  curl --netrc -LSfs -H Content-Type: application/json -H Accept: application/json --data @- --url https://api.github.com/repos/roman-neuhauser/ghisco/issues/1/comments
  https://example.org/issue#comment


test explicit curlrc::

  $ ghisco -c ../somewhere/a-file https://github.com/roman-neuhauser/ghisco/issues/1 <<\EOF
  > ```
  > she said: "hello world!"
  > that's what she said
  > ```
  > EOF
  curl --netrc --config ../somewhere/a-file -LSfs -H Content-Type: application/json -H Accept: application/json --data @- --url https://api.github.com/repos/roman-neuhauser/ghisco/issues/1/comments
  https://example.org/issue#comment


test explicit netrc::

  $ ghisco -n ../somewhere/a-file https://github.com/roman-neuhauser/ghisco/issues/1 <<\EOF
  > ```
  > she said: "hello world!"
  > that's what she said
  > ```
  > EOF
  curl --netrc-file ../somewhere/a-file -LSfs -H Content-Type: application/json -H Accept: application/json --data @- --url https://api.github.com/repos/roman-neuhauser/ghisco/issues/1/comments
  https://example.org/issue#comment


test explicit both curl and netrc::

  $ ghisco -c ../somewhere/a-file -n elsewhere/another https://github.com/roman-neuhauser/ghisco/issues/1 <<\EOF
  > ```
  > she said: "hello world!"
  > that's what she said
  > ```
  > EOF
  curl --config ../somewhere/a-file --netrc-file elsewhere/another -LSfs -H Content-Type: application/json -H Accept: application/json --data @- --url https://api.github.com/repos/roman-neuhauser/ghisco/issues/1/comments
  https://example.org/issue#comment
