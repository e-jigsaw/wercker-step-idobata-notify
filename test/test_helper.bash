export PATH="$BATS_TEST_DIRNAME/..:$PATH"

if [ ! -n "$WERCKER" ]; then
    export WERCKER_GIT_DOMAIN="github.com"
    export WERCKER_GIT_OWNER="1syo"
    export WERCKER_GIT_REPOSITORY="wercker-step-idobata-notify"
    export WERCKER_GIT_BRANCH="master"
    export WERCKER_GIT_COMMIT="aff2f780d59346c0386d59db6aac62e02be2005a"
    export WERCKER_STARTED_BY="TAKAHASHI Kazunari"
    export WERCKER_APPLICATION_ID="5253e1053673929130009361"
    export WERCKER_APPLICATION_NAME="wercker-step-idobata-notify"
    export WERCKER_APPLICATION_OWNER_NAME="1syo"
    export WERCKER_APPLICATION_URL="https://app.wercker.com/#applications/5253e1053673929130009361"
    export WERCKER_STEP_ROOT="."
    export WERCKER_STEP_TEMP=$BATS_TMPDIR
fi

success() {
    echo $1
}

fail() {
    echo $1
    exit 1
}

warn() {
    echo $1
}

info() {
    echo $1
}

debug() {
    echo $1
}

setMessage() {
    echo $1
}

export -f success
export -f fail
export -f warn
export -f info
export -f debug
export -f setMessage

stub() {
    local cmd=$1
    local ret=$2
    eval "$(echo -e "${cmd}() {\n echo $ret\n}")"
    export -f ${cmd}
}

unstub() {
    local cmd=$1
    unset -f "$cmd"
}
