onExit() {
        [ $DONE  -eq 1 ] \
        && printInfo "run completed, status OK" && RET=0
        [ $DONE  -ne 1 ] \
        && printErr "run $$ incomplete, examine log files ($LOGDIR) and start again" && RET=1
	
	exit $RET
}

onErr() {
	LASTLINE=$1
	LASTErrCode=$2
	printErr "LASTLINE=$LASTLINE, LASTErrCode=$LASTErrCode"
}

exitOK() {
	DONE=(-1)
	printErr "run $$ dropped, contex problems"
	printInfo "run $$ dropped, contex problems"
	exit 1
}
function printErr() {
        MSG=$1
        echo "ERROR: $(date) $MYNAME $$: $MSG" >&9
	echo "ERROR: $(date) $MYNAME $$: $MSG" >>$GLOB_ERR_LOG
}

function printInfo() {
        MSG=$1
        echo "INFO:  $(date) $MYNAME $$: $MSG" >&8
}

trap 'onExit' EXIT
trap 'onErr ${LINENO} $?' ERR

