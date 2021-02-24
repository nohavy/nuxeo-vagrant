#!/bin/bash
export SOURCES_PATH=sources
export TMP_PATH=tmp
export PACKAGE_PATH=packages
export BASE_PATH=$(pwd)

# cleanup
rm -R $TMP_PATH
mkdir $TMP_PATH
rm -R $PACKAGE_PATH/*.zip

# Make sure sources folder exists
if [ ! -d "$SOURCES_PATH" ]; then
    echo "=> The folder $SOURCES_PATH does not exits then there are no sources to compile."
    exit 1
fi

# For each .zip file on the source folder
for file in $SOURCES_PATH/*.zip; do
    if file --mime-type "$file" | grep -q zip$; then
        export FILENAME=$(basename $file) # remove folder source prefix
        echo "=> $FILENAME is .zip type, going to unzip."
        export BASE_FILENAME=$(basename $FILENAME .zip) # remove .zip suffix

        # unzip the .zip to ./tmp folder
        unzip -q $file -d $TMP_PATH/$BASE_FILENAME

        # go to ./tmp/the_name_of_file
        pushd $TMP_PATH/$BASE_FILENAME
        if [[ -f "pom.xml" ]]; then
            echo "=> Haves pom.xml to be compiled by maven"
            mvn -B -nsu -V -DskipTests -DskipDocker install
        else
            echo "=> Does not have pom.xml no need to be compiled move to --> $PACKAGE_PATH"
            # copy .zip from source folder => to package folder
            cp $BASE_PATH/$SOURCES_PATH/$FILENAME $BASE_PATH/$PACKAGE_PATH
        fi
        popd
    else
        echo "=> $file != .zip type --> skiped..."
    fi
done

rm -R $TMP_PATH/*
exit 0
