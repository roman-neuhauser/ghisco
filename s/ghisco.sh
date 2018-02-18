#!/bin/sh

set -eu

cfg=

while getopts :hc:imn: opt; do
case $opt in
h) usage=0 ;;
c) have_c=:; cfg="$cfg --config $OPTARG" ;;
i) interact=: have_m= ;;
m) have_m=: interact= ;;
n) have_n=:; cfg="$cfg --netrc-file $OPTARG" ;;
?) usage=1 ;;
esac
done; shift $((OPTIND - 1))

[ -z "${usage-}" ] || {
  self="${0##*/}"
  printf -- "usage: %s %s\n" \
    "$self" "[-i] [-c CURLRC] [-n NETRC] ISSUE" \
    "$self" " -m  [-c CURLRC] [-n NETRC] ISSUE MESSAGE"
  [ 0 -ne "$usage" ] || {
    printf -- "%s\n" \
      "  -c CURLRC       see --config in curl(1)" \
      "  -i              prepare comment in editor" \
      "  -m              use MESSAGE for comment" \
      "  -n NETRC        see --netrc-file in curl(1)"
  }
  exit $usage
}

issue=$1
[ -z "${have_m-}" ] || msg=$2

curlcfg=~/.config/ghisco/curlrc
[ -n "${have_c-}" ] || [ ! -e $curlcfg ] || {
  cfg="--config $curlcfg $cfg"
}

[ -n "${have_n-}" ] || cfg="--netrc $cfg"

issue="${issue#https://github.com/}"
issue=$(sed 's:/pull/:/issues/:' <<EOF
$issue
EOF
)
url="https://api.github.com/repos/$issue/comments"

trap 'rm -f $tmpfiles' EXIT INT TERM
tmpfiles=
msgfile=$(mktemp); tmpfiles="$msgfile"
if [ -n "${interact-}" ]; then
  ${VISUAL:-${EDITOR:-vi}} $msgfile
elif [ -n "${msg-}" ]; then
  printf --> $msgfile "%s" "$msg"
else
  cat > $msgfile
fi

[ -s "$msgfile" ] || {
  printf -->&2 "%s: no comment!\n" "${0##*/}"
  exit 1
}

jsonfile=$(mktemp); tmpfiles="$tmpfiles $jsonfile"
jq -Rs '{ body: . }' < $msgfile > $jsonfile

response=$(mktemp); tmpfiles="$tmpfiles $response"

curl \
  $cfg \
  -LSfs \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  --data @- \
  --url "$url" \
  < $jsonfile \
  > $response

jq -r .html_url < $response
