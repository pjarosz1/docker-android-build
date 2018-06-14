#!/usr/bin/env bash

cd /opt/src

echo $bamboo_buildNumber
echo $bamboo_buildResultKey
echo $bamboo_planRepository_1_branch
echo $GRADLE_BUILD_TASK
echo $GRADLE_TEST_TASK

RETRIES=0

until ./gradlew $GRADLE_BUILD_TASK --continue -i
do
    if [ $RETRIES -gt 4 ]; then
        break
    fi
    
    echo "Retrying build"
    RETRIES=`expr $RETRIES + 1`
done

find . -name "*.apk" -exec cp {} /opt/output \;

if [ $result -eq 0 ]; then
    set +e
    ./gradlew $GRADLE_TEST_TASK --continue
    set -e
fi

mkdir -p /opt/output/build
cp -R ma-app/build/* /opt/output/build
ls -lat /opt/output

FILENAME=$(ls /opt/output/*-App_*)

zip -d $FILENAME META-INF/* -x META-INF/services/\*

exit $result
