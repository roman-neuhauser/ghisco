setup::

  $ . $TESTDIR/setup

  $ fake curl


test::

  $ ghisco -h
  usage: ghisco [-i] [-c CURLRC] [-n NETRC] ISSUE
  usage: ghisco  -m  [-c CURLRC] [-n NETRC] ISSUE MESSAGE
    -c CURLRC       see --config in curl(1)
    -i              prepare comment in editor
    -m              use MESSAGE for comment
    -n NETRC        see --netrc-file in curl(1)
