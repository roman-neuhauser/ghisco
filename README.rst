========================================================================
                         Github Issue Commenter
========================================================================


`ghisco` lets you comment on github issues / pull requests from
the comfort of your shell.


synopsis
========

::

  % ghisco -h
  usage: ghisco [-i] [-c CURLRC] [-n NETRC] ISSUE
  usage: ghisco  -m  [-c CURLRC] [-n NETRC] ISSUE MESSAGE
    -c CURLRC       see --config in curl(1)
    -i              prepare comment in editor
    -m MESSAGE      use MESSAGE for comment
    -n NETRC        see --netrc-file in curl(1)


`ghisco` posts its stdin (by default), or it second operand (if `-m`),
or the result of running your editor (if `-i`).
by default, `ghisco` uses `~/.netrc` and `~/.config/ghisco/curlrc`.
if you use `-c`, it will ignore `~/.config/ghisco/curlrc`.
if you use `-n`, it will ignore `~/.netrc`.
you can use any number of `-c` and `-n` options, `ghisco` will use
them all, in the given order.


github credentials
==================

using `~/.netrc`::

  % touch ~/.netrc
  % chmod 600 ~/.netrc
  % cat >> ~/.netrc
  machine api.github.com login YOURNAME password YOURPASS
  ^D

replace `YOURNAME` with your github username and `YOURPASS`
with your password or personal access token.

using `~/.config/ghisco/curlrc`::

  % umask 077
  % mkdir -p ~/.config/ghisco
  % cat > ~/.config/ghisco/curlrc
  --user YOURNAME:YOURPASS
  ^D

using `~/.config/ghisco/curlrc`, using SAML SSO::

  % umask 077
  % mkdir -p ~/.config/ghisco
  % cat > ~/.config/ghisco/curlrc
  --header "Authorization: token TOKEN"
  ^D


examples
========

::

  % ghisco roman-neuhauser/ghisco/pull/1
  lgtm
  ^D

  % ghisco roman-neuhauser/ghisco/issues/1
  me too!
  ^D

  % ghisco https://github.com/roman-neuhauser/ghisco/issues/1
  yeah, me too!
  ^D


runtime requirements
====================

* POSIX-compliant /bin/sh
* curl__
* jq__

.. __: https://curl.haxx.se/
.. __: https://stedolan.github.io/jq/


license
=======

Published under the `MIT license`__, see `LICENSE file`__.

.. __: https://opensource.org/licenses/MIT
.. __: LICENSE
