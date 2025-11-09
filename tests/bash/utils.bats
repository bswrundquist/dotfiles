#!/usr/bin/env bats

setup() {
  # shellcheck disable=SC1090
  . "$PWD/config/bash/aliases.sh"
}

@test "urlencode and urldecode roundtrip" {
  encoded=$(echo -n 'a b+c&d' | urlencode)
  decoded=$(printf '%s' "$encoded" | urldecode)
  [ "$decoded" = "a b+c&d" ]
}


