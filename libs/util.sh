save_default_env()
{
    export | sed  's/declare -x/export/g' > $SAVED_ENV_FILE
}

reload_default_env()
{
    PWD=`echo $PWD`
    
    #Wipe all environment variables
    unset `env | awk -F= '/^\w/ {print $1}' | xargs`

    source $SAVED_ENV_FILE

    export PWD="$PWD"
}

parse_config_file() {
    inputfile="$1"
    if [ ! -e "$inputfile" ]
    then
        echo "Input configuration file $inputfile does not exist"
        exit 1
    fi

    while read line
    do
        # Skip empty lines
        if [ "x$line" = "x" ]
        then
            continue
        fi

        # Skip comment lines
        echo $line | grep -e "^#" > /dev/null
        if [ "$?" = "0" ]
        then
            continue
        fi

        # This is a real variable so set the value
        # Trim trailing spaces for variables
        var=`echo $line | cut -d= -f1 | tr -d '[:space:]'`
        # Trim leading spaces for the variable value
        val=`echo $line | cut -d= -f2 | sed -e 's/^[ ]*//'`
        eval $var=$val
    done < $inputfile
}

