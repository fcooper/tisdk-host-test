#!/bin/bash

display_section()
{

cat << EOM >> $TEST_LOGS_DIR/results.html
$1
<br>
<table>
EOM

}

end_section()
{
cat << EOM >> $TEST_LOGS_DIR/results.html
</table>
<br>
EOM
}

create_test_row()
{
    testname=$1
    testresult=$2
    testresultfile=$3

    if [ "$testresult" == "0" ]
    then
        echo "$testname passed"
        testresult="Passed"
    else
        echo "$testname failed"
        testresult="Failed"
    fi

cat << EOM >> $TEST_LOGS_DIR/results.html
<tr><td>$testname Test</td><td>$testresult</td><td><a href = "$TEST_LOGS_DIR/$testresultfile">View Log</a></td></tr>
EOM



}

skip_test()
{
cat << EOM >> $TEST_LOGS_DIR/results.html
<tr><td colspan = "3" align="center">$1</td></tr>
EOM

}

create_header()
{
cat << EOM >> $TEST_LOGS_DIR/results.html
<tr><td colspan="3" align="center">$1</td></tr>
EOM
}
