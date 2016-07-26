valid() {
    if [ ! -n "$WERCKER_IDOBATA_NOTIFY_TOKEN" ]; then
        echo 'Please specify token property.'
        exit 1
    fi

    if [ "$WERCKER_IDOBATA_NOTIFY_ON" = "failed" ]; then
        echo "Skipping..."
        exit 1
    fi
}

repository() {
    echo "$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY"
}

branch() {
    echo "$WERCKER_GIT_BRANCH"
}

commit() {
    echo ${WERCKER_GIT_COMMIT:0:7}
}

build_result() {
    result=$(tr '[a-z]' '[A-Z]' `$WERCKER_RESULT`)
    if [ "$WERCKER_RESULT" = "passed" ]; then
        echo "<span class=\"label label-success\">$result</span>"
    else
        echo "<span class=\"label label-danger\">$result</span>"
    fi
}

job_id() {
    if [ "$CI" = "true" ]; then
        echo "<a href=\"$WERCKER_BUILD_URL\">#$WERCKER_BUILD_ID</a>"
    elif [ "$DEPLOY" = "true" ]; then
        echo "<a href=\"$WERCKER_DEPLOY_URL\">#$WERCKER_DEPLOY_ID</a>"
    fi
}

git_log(){
    echo $(git log -1 --pretty='%an: %s')
}

deploy_target() {
    echo "$WERCKER_DEPLOYTARGET_NAME"
}

message() {
    if [ "$CI" = "true" ]; then
        echo "<span class=\"label label-info\">BUILD</span> $(build_result) $(repository)$(job_id) ($(branch) - $(commit))<br />$(git_log)"
    elif [ "$DEPLOY" = "true" ]; then
        echo "<span class=\"label label-info\">DEPLOY</span> $(build_result) $(repository)$(job_id) ($(branch) - $(commit)) to $(deploy_target)<br />$(git_log)"
    fi
}
