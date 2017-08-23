MY_LOCAL_PATH := $(call my-dir)

IGNORED_WARNINGS := -Wno-sign-compare -Wno-unused-parameter -Wno-sign-promo -Wno-error=return-type -Wno-error=non-virtual-dtor
COMMON_CFLAGS := \
	$(IGNORED_WARNINGS) \
	-DSPEECH_LOG_ANDROID \
	-DSPEECH_SDK_STREAM_QUEUE_TRACE \
	-DSPEECH_SDK_DETAIL_TRACE

include $(CLEAR_VARS)

LOCAL_MODULE := libspeech
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/include \
	$(MY_LOCAL_PATH)/proto \
	$(MY_LOCAL_PATH)/include \
	$(MY_LOCAL_PATH)/src/common

COMMON_SRC := \
	$(MY_LOCAL_PATH)/proto/speech.pb.cc \
	$(MY_LOCAL_PATH)/src/common/speech_config.cc \
	$(MY_LOCAL_PATH)/src/common/speech_config.h \
	$(MY_LOCAL_PATH)/src/common/log.cc \
	$(MY_LOCAL_PATH)/src/common/log.h \
	$(MY_LOCAL_PATH)/src/common/speech_connection.cc \
	$(MY_LOCAL_PATH)/src/common/speech_connection.h

TTS_SRC := \
	$(MY_LOCAL_PATH)/src/tts/tts_impl.cc \
	$(MY_LOCAL_PATH)/src/tts/tts_impl.h \
	$(MY_LOCAL_PATH)/src/tts/types.h

ASR_SRC := \
	$(MY_LOCAL_PATH)/src/asr/asr_impl.cc \
	$(MY_LOCAL_PATH)/src/asr/asr_impl.h \
	$(MY_LOCAL_PATH)/src/asr/types.h

SPEECH_SRC := \
	$(MY_LOCAL_PATH)/src/speech/speech_impl.cc \
	$(MY_LOCAL_PATH)/src/speech/speech_impl.h \
	$(MY_LOCAL_PATH)/src/speech/types.h

LOCAL_SRC_FILES := \
	$(COMMON_SRC) \
	$(TTS_SRC) \
	$(ASR_SRC) \
	$(SPEECH_SRC)

LOCAL_CFLAGS := $(COMMON_CFLAGS) \
	-std=c++11 -frtti -fexceptions
LOCAL_LDLIBS += -llog
LOCAL_SHARED_LIBRARIES := libpoco libcrypto libprotobuf-rokid-cpp-full

LOCAL_EXPORT_C_INCLUDES := $(MY_LOCAL_PATH)/include

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := roots.pem
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/etc
LOCAL_SRC_FILES := etc/$(LOCAL_MODULE)
#include $(BUILD_PREBUILT)