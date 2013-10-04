#!/bin/bash

source libs/util.sh
source libs/log-util.sh

TEST_HOME=`echo $PWD`
SDK_DOWNLOAD_DIR="$TEST_HOME/sdk-directories"
SAVED_ENV_FILE="$TEST_HOME/saved-env.txt"
MACHINE_NAMES="am335x-evm"
TEST_DIR=$TEST_HOME/sdk-test
TEST_LOGS_DIR=$TEST_HOME/test-logs/

MAX_LENGTH="100"
RANDOM_STRING="89fj3289rij89ij2f8j293jnf289f832qnf98q23j9f2j3q98rjnfv3q8nf29q8nfn98q2n3f829nf8923nf2389qnf23f2qio09jweew9j0ewiojwaiofj93j829hj3829n83972hd782h37823h7832h378h278h7328h7328h3872h389h392h3892h3892h3928h329"
RANDOM_STRING_SPACES="8je8wrj398 q38j384jr934jr 32  j9834j2r89324jr324    j89423jr9324jrj423   j23894rj23984rj324     j8923jr98324jr84239j   832j49rj2389 r38j 89j92r3 r23 j9832j4r8j 234 823jr8j3"



# Values (EXHAUSTIVE 4,NORMAL 2,SANITY 0)
EXHAUSTIVE=4
NORMAL=2
SANITY=0
TEST_TYPE=2

TEST_SDK_VARIATION="false"
log_prefix=""


download_sdks()
{
    if [ -d $SDK_DOWNLOAD_DIR ]
    then
        rm -rf $SDK_DOWNLOAD_DIR
    fi

    mkdir $SDK_DOWNLOAD_DIR
}

bitbake_test()
{

    sdk_path=$1

    create_header "Bitbake Test"


    if [ "$TEST_TYPE" -lt "$EXHAUSTIVE" ]
    then 
        skip_test "Skipping Bitbake tests"
        return 0
    fi
    

    cd "$sdk_path"

    toolchain_path=`source linux-devkit/environment-setup; which $CXX`
    toolchain_path=`dirname "$toolchain_path"`

    git clone git://arago-project.org/git/projects/oe-layersetup.git &>> $TEST_LOGS_DIR/$log_prefix-bitbake-test.txt
    cd oe-layersetup
    ./oe-layertool-setup.sh -f configs/amsdk/amsdk-07.00.00.00-config.txt -d /home/downloads &>> "$TEST_LOGS_DIR/$log_prefix-bitbake-test.txt"


    cd build 
    source conf/setenv
    export PATH=$toolchain_path:$PATH
    MACHINE=am335x-evm bitbake arago-base-image &>> $TEST_LOGS_DIR/$log_prefix-bitbake-test.txt

    create_test_row "Bitbake arago-base-image" $? "$log_prefix-bitbake-test.txt"

    reload_default_env

}

makefile_test()
{
    sdk_path=$1

    create_header "Makefile Tests"


    mkdir -p "$TEST_LOGS_DIR/make"

    result="Failed"
    cd "$sdk_path"

    install_list=`cat Makefile | grep "^install:\ " | cut -c 10-`
    make_list=`cat Makefile | grep "^all:\ " | cut -c 6-`
    clean_list=`cat Makefile | grep "^clean:\ " | cut -c 8-`

    create_header "Make build Tests"
    
    for make_program in $make_list
    do
        make $make_program &> "$TEST_LOGS_DIR/make/$log_prefix-make-$make_program-test.txt"
        result=`echo $?`

        create_test_row "Make $make_program" $result "/make/$log_prefix-make-$make_program-test.txt"
    done

    create_header "Make install Tests"

    for install_program in $install_list
    do
        make $install_program &> "$TEST_LOGS_DIR/make/$log_prefix-make-$install_program-test.txt"
        result=`echo $?`

        create_test_row "Make $install_program" $result "/make/$log_prefix-make-$install_program-test.txt"
    done


    create_header "Make clean Tests"

    for clean_program in $clean_list
    do
       
        make $clean_program &> "$TEST_LOGS_DIR/make/$log_prefix-make-$clean_program-test.txt"
        result=`echo $?`
        
        create_test_row "Make $clean_program" $result "/make/$log_prefix-make-$clean_program-test.txt"

    done

    cd -


}

toolchain_test()
{

    create_header "Toolchain Test"

    cd "$sdk_path"
    # Gaps
    # insure all software in SDK have proper makefiles. Testing of individual makefile targets.

    source linux-devkit/environment-setup

    # Insure GDB with python support exist.
    ${TOOLCHAIN_PREFIX}gdb --quiet --command=$META_HOME/scripts/gdb-python-test | grep -o ^hello\ world$ &> "$TEST_LOGS_DIR/$log_prefix-gdb-test.txt"

    create_test_row "GDB with python support" $? "$log_prefix-gdb-test.txt"


    reload_default_env


}

sdk_installation()
{
    bin_path=$1
    install_path=$2
    install_name=$3

    create_header "SDK Installation"

    echo "Installing SDK $install_name"
    echo "at"
    echo "$install_path"

    chmod 755 $bin_path &> /dev/null


    echo "Installing sdk $bin_path" > "$TEST_LOGS_DIR/$log_prefix-sdk-install-test.txt"
    echo "at" >> "$TEST_LOGS_DIR/$log_prefix-sdk-install-test.txt"
    echo "$install_path/$install_name" >> "$TEST_LOGS_DIR/$log_prefix-sdk-install-test.txt"

    "$bin_path" --prefix "$install_path/$install_name" --mode unattended &>> "$TEST_LOGS_DIR/$log_prefix-sdk-install-test.txt"

    result=`echo $?`

    

    if [ -d "$install_path/$install_name/linux-devkit" ]
    then
        echo ""
    else
        result="1"
    fi


    create_test_row "SDK installation test" $result "$log_prefix-sdk-install-test.txt"

    if [ "$result" == "0" ]
    then

        sed -i -e "s#__DESTDIR__#\"$TEST_DIR/$default_name/targetNFS\"#" "$install_path/$install_name/Rules.make"
        mkdir "$install_path/$install_name/targetNFS"

        return 0
    else
        return 1
    fi

    

}

function qt_build_test()
{
    sdk_path="$1"

    reload_default_env

    create_header "Qt Build Test"

   
    cp -r "$META_HOME/toolchain-test/qt-sources" "$sdk_path"
    

    cd "$sdk_path/qt-sources"

    source "$sdk_path/linux-devkit/environment-setup"

    directories=`find . -maxdepth 1 -mindepth 1 -type d -printf '%f '`  

    for directory in $directories
    do
        cd $directory 
    
        qmake &> "$TEST_LOGS_DIR/$log_prefix-qt-build-$directory-test.txt"
        
        result=`echo $?`

        if [ "$result" == "0" ]
        then
            
            make &>> "$TEST_LOGS_DIR/$log_prefix-qt-build-$directory-test.txt"
            result=`echo $?`
        fi

        create_test_row "Qt app build $directory" $result "$log_prefix-qt-build-$directory-test.txt"


        # Maybe check the binary?

        cd -
        
    done


    reload_default_env
}

function run_sdk_tests()
{
    sdk_path="$1"
    toolchain_test $sdk_path

    makefile_test $sdk_path

    bitbake_test $sdk_path

    qt_build_test $sdk_path
}




# Do not allow calling this script without passing the config file option
if [ "$*" = "" ]
then
    echo "You must specify at least one option on the command line"
    exit 1
fi

# Parse input options
while getopts :f: arg
do
    case $arg in
        f ) inputfile="$OPTARG";;
    esac
done


if [ "X$inputfile" == "X" ]
then
    echo "Inputfile required"
    exit 1
fi



# Parse the input config file to set the required build variables
parse_config_file $inputfile

set -x

mkdir -p $TEST_HOME


set +x
save_default_env




# This code should download/copy the SDKs locally for this script to use.
# Assume for now that this is already done for us
#download_sdks

if [ -d $TEST_DIR ]
then
    rm -rf $TEST_DIR
fi

mkdir $TEST_DIR

if [ -d $TEST_LOGS_DIR ]
then
    rm -rf $TEST_LOGS_DIR
fi

mkdir -p $TEST_LOGS_DIR

cat << EOM >> $TEST_LOGS_DIR/results.html
<html>
<head></head>
<body>
EOM


for machine in $MACHINE_NAMES
do
    # Current assumes only 1 sdk is found and matched although for some crazy reason this may not be the case.
    current_sdk=`find $SDK_DOWNLOAD_DIR/ -name *$machine*`


    ##Create long SDK name
    current_length=`expr length "$TEST_DIR/$machine-evm-sdk-"`
    remaining_length=`expr $MAX_LENGTH - $current_length`
    remainder_string=`echo $RANDOM_STRING | cut -c -$remaining_length`
    long_string="$TEST_DIR/$machine-evm-sdk-$remainder_string"

    # Create spaces SDK name
    current_length=`expr length "$TEST_DIR/$machine-evm-sdk-"`
    remaining_length=`expr $MAX_LENGTH - $current_length`
    remainder_string=`echo "$RANDOM_STRING_SPACES" | cut -c -$remaining_length`
    spaces_string="$TEST_DIR/$machine-evm-sdk-$remainder_string"


    if [ "$?" == 1 ]
    then
        echo "No SDK for $machine was found"
        continue

    fi

    #Currently assumes an SDK IS indeed found

    default_name=`echo $current_sdk | grep -oh ti-sdk-.*-L | rev | cut -c 3- | rev`

    display_section "Normal SDK Test: $default_name"

    log_prefix="$machine-normal"
    if sdk_installation "$current_sdk" "$TEST_DIR" "$default_name"
    then
        run_sdk_tests "$TEST_DIR/$default_name"
    fi

    end_section

    if [ "$TEST_SDK_VARIATION" == "true" ]
    then

        default_name="$machine-j89j4289j3489j238j29j832"

        display_section "Weird SDK Name SDK Test: $default_name"

        log_prefix="$machine-weird"
        if sdk_installation "$current_sdk" "$TEST_DIR" "$default_name"
        then
            run_sdk_tests "$TEST_DIR/$default_name"
        fi

        end_section


        default_name=`basename "$long_string"`
        dir_name=`dirname "$long_string"`


        display_section "Long SDK Test: $default_name"

        log_prefix="$machine-long"
        if sdk_installation "$current_sdk" "$dir_name" "$default_name"
        then
            run_sdk_tests "$long_string"
        fi

        end_section



        default_name=`basename "$spaces_string"`
        dir_name=`dirname "$spaces_string"`

        display_section "Long Spaces SDK Test: $default_name"

        log_prefix="$machine-long-spaces"
        if sdk_installation "$current_sdk" "$dir_name" "$default_name"
        then
            run_sdk_tests "$spaces_string"
        fi

        end_section
    fi

done

exit 0


cat << EOM >> $TEST_LOGS_DIR/results.html
</body>
</html>
EOM
