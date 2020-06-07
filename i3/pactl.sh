pactl load-module module-detect
# Adds missing builtin speaker as following
# alsa_output.0.analog-stereo module-alsa-sink.c s16le 2ch 44100Hz
# But this says WD15 Dock

# Restarts pulse audio
pulseaudio -k

pacmd unload-module module-udev-detect && pacmd load-module module-udev-detect

# After running pulseaudio -k && pactl load-module module-detect without WD15 Dock,
# also_output.0.analog-streo became HDA Intel PCH Built-in Auido Analog Streo
# Still volume too low


# Tried configuring using gnome-control-centr
env XDG_CURRENT_DESKTOP=GNOME gnome-control-center
# It also had application specific volume setting
# Following is the diff from working setting
Sink #6
	State: RUNNING
	Name: alsa_output.pci-0000_00_1f.3.analog-stereo
	Description: Built-in Audio Analog Stereo
	Driver: module-alsa-card.c
	Sample Specification: s16le 2ch 44100Hz
	Channel Map: front-left,front-right
	Owner Module: 7
	Mute: no
	Volume: front-left: 80295 / 123% / 5.29 dB,   front-right: 80295 / 123% / 5.29 dB
	        balance 0.00
	Base Volume: 65536 / 100% / 0.00 dB
	# Monitor Source: alsa_output.0.analog-stereo.monitor
	Monitor Source: alsa_output.pci-0000_00_1f.3.analog-stereo.monitor
	# Latency: 0 usec, configured 0 usec
	Latency: 5679 usec, configured 5000 usec
	# Flags: HARDWARE DECIBEL_VOLUME LATENCY
	Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY
	Properties:
		alsa.resolution_bits = "16"
		device.api = "alsa"
		device.class = "sound"
		alsa.class = "generic"
		alsa.subclass = "generic-mix"
		alsa.name = "ALC3246 Analog"
		alsa.id = "ALC3246 Analog"
		alsa.subdevice = "0"
		alsa.subdevice_name = "subdevice #0"
		alsa.device = "0"
		alsa.card = "0"
		alsa.card_name = "HDA Intel PCH"
		alsa.long_card_name = "HDA Intel PCH at 0xdc428000 irq 145"
		alsa.driver_name = "snd_hda_intel"
		device.bus_path = "pci-0000:00:1f.3"
		sysfs.path = "/devices/pci0000:00/0000:00:1f.3/sound/card0"
		device.bus = "pci"
		device.vendor.id = "8086"
		device.vendor.name = "Intel Corporation"
		device.product.id = "9d71"
		device.product.name = "Sunrise Point-LP HD Audio"
		device.form_factor = "internal"
		device.string = "front:0"
		device.buffering.buffer_size = "65536"
		device.buffering.fragment_size = "32768"
		device.access_mode = "mmap+timer"
		device.profile.name = "analog-stereo"
		device.profile.description = "Analog Stereo"
		device.description = "Built-in Audio Analog Stereo"
		alsa.mixer_name = "Realtek ALC3246"
		alsa.components = "HDA:10ec0256,1028082a,00100002 HDA:8086280b,80860101,00100000"
		# Missing
		module-udev-detect.discovered = "1"
        # audio-card-analog-pci
		device.icon_name = "audio-card-pci"
    # Missing
	Ports:
		analog-output-speaker: Speakers (priority: 10000)
		analog-output-headphones: Headphones (priority: 9000, not available)
    # Missing
	Active Port: analog-output-speaker
	Formats:
		pcm

