#!/bin/bash -l

set -exo pipefail

CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOP_DIR=${CWDIR}/../../../
pushd ${TOP_DIR}/plr_src
    PLR_VERSION=$(git describe | awk -F. '{printf("%d.%d.%d", $1, $2, $3)}')
popd

function release_gpdb4() {
    case "$OSVER" in
    suse11)
        cp bin_plr/plr-*.gppkg plr_gppkg/plr-$PLR_VERSION-$GPDBVER-sles11-x86_64.gppkg
      ;;
    centos5)
        cp bin_plr/plr-*.gppkg plr_gppkg/plr-$PLR_VERSION-$GPDBVER-rhel5-x86_64.gppkg
      ;;
    centos6)
        cp bin_plr/plr-*.gppkg plr_gppkg/plr-$PLR_VERSION-$GPDBVER-rhel6-x86_64.gppkg
      ;;
    *) echo "Unknown OS: $OSVER"; exit 1 ;;
    esac
}

function _main() {
    time release_gpdb4
}

_main "$@"
