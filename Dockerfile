FROM runmymind/docker-android-sdk:alpine-standalone

ENV GRADLE_BUILD_TASK build
ENV GRADLE_TEST_TASK test
ENV bamboo_buildNumber 1
ENV bamboo_buildResultKey ""
ENV bamboo_planRepository_1_branch ""

RUN apk -U add zip

ADD runbuild.sh /opt/runbuild.sh
RUN chmod a+x /opt/runbuild.sh

RUN mkdir -p /opt/src
RUN mkdir -p /opt/cache

CMD ["sh","/opt/runbuild.sh"]