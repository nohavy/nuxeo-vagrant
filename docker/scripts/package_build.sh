#!/bin/bash



export SOURCES_PATH=sources
export TMP_PATH=tmp
export PACKAGE_PATH=packages

if [ ! -d "$SOURCES_PATH" ]; then
  echo "The folder $SOURCES_PATH does not exits then there are no sources to compile."
  exit 1
fi

mkdir $TMP_PATH ||:
mkdir $PACKAGE_PATH ||:

for file in $SOURCES_PATH/*.zip; do
    if file --mime-type "$file" | grep -q zip$; then
        export FILENAME=$(basename $file)
        echo "$FILENAME is .zip type, going to unzip."
        unzip -q $file -d $TMP_PATH
        pushd $TMP_PATH/$(basename $FILENAME .zip)
            mvn -B -nsu -V -DskipTests -DskipDocker install
        popd
    else
        echo "$file is not .zip type, skiped."
    fi
done

# rm -R $TMP_PATH/*
exit 0

