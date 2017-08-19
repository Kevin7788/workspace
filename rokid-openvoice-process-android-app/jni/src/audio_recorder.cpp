#include "audio_recorder.h"

#include "VoiceService.h"
#include "opensl_io.h"
#include "log.h"

#include <string.h>

siren_t _siren;
siren_proc_callback_t event_callback;

siren_input_if_t siren_input = { init_input, release_input, start_input,
		stop_input, read_input, on_err_input };

siren_state_changed_callback_t siren_state_change = { state_changed_callback };

bool init(void*token, on_voice_event_t callback) {
	event_callback.voice_event_callback = callback;
	_siren = init_siren(token, NULL, &siren_input);
	return true;
}

void _start_siren_process_stream() {
	start_siren_process_stream(_siren, &event_callback);
}

void _stop_siren_process_stream() {
	stop_siren_process_stream(_siren);
}

void set_siren_state_change(int state) {
	set_siren_state(_siren, state, &siren_state_change);
}

int init_input(void *token) {
	return 0;
}

void release_input(void *token) {
}

int start_input(void *token) {
	return 1;
}

void stop_input(void *token) {
	LOGV("%s", __FUNCTION__);
}

int read_input(void *token, char *buff, int frame_cnt) {
	//return mic_array_device->read_stream(mic_array_device, buff, frame_cnt);
	return -1;
}

int find_card(const char *snd) {
	return -1;
}

void on_err_input(void *token) {
	LOGV("%s", __FUNCTION__);
}

void state_changed_callback(void *token, int state) {
	LOGV("%s : %d", __FUNCTION__, state);
}

