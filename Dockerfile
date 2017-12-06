FROM openjdk:8-jdk

MAINTAINER tvblack <github@tvblack.com>

ENV ANDROID_COMPILE_SDK "20"
ENV ANDROID_BUILD_TOOLS "24.0.0"
ENV ANDROID_SDK_TOOLS "24.4.1"
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/platform-tools

RUN set -xe \
	&& apt-get update -y \
	&& apt-get install -y wget tar unzip ant\
	&& cd /tmp \
	&& wget --quiet --output-document=/tmp/android-sdk.tgz https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz \
	&& tar --extract --gzip --file=/tmp/android-sdk.tgz \
	&& mv android-sdk-linux $ANDROID_HOME \
	&& echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_COMPILE_SDK} \
	&& echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter platform-tools \
	&& echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS} \
	&& echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository \
	&& echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services \
	&& echo y | $ANDROID_HOME/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository \
	&& apt-get clean && apt-get autoremove

CMD ["/bin/bash"]