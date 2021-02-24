#!/bin/bash
export SOURCES_PATH=sources
export TMP_PATH=tmp
export PACKAGE_PATH=packages
export CURRENT_PATH=$(pwd)

rm -R $TMP_PATH/*
rm -R $PACKAGE_PATH/*

if [ ! -d "$SOURCES_PATH" ]; then
  echo "=> The folder $SOURCES_PATH does not exits then there are no sources to compile."
  exit 1
fi

mkdir $TMP_PATH
mkdir $PACKAGE_PATH

for file in $SOURCES_PATH/*.zip; do
    if file --mime-type "$file" | grep -q zip$; then
        export FILENAME=$(basename $file)
        echo "=> $FILENAME is .zip type, going to unzip."
        unzip -q $file -d $TMP_PATH/$(basename $FILENAME .zip)
        pushd $TMP_PATH/$(basename $FILENAME .zip)
            if [[ -f "pom.xml" ]]; then
                echo "=> Haves poml.xml to be compiled by maven"
                mvn -B -nsu -V -DskipTests -DskipDocker install
            else
                echo "=> Does not have poml.xml no need to be compiled move to --> $PACKAGE_PATH"
                cp $CURRENT_PATH/$SOURCES_PATH/$FILENAME $CURRENT_PATH/$PACKAGE_PATH
            fi
        popd
    else
        echo "=> $file != .zip type --> skiped..."
    fi
done


exit 0

