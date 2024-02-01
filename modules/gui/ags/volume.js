import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export const Volume = () => Widget.Box({
    class_name: 'volume',
    spacing: 4,
    children: [
        Widget.Icon().hook(Audio, self => {
            if (Audio.speaker.stream.is_muted) {
                self.icon = 'audio-volume-muted-symbolic';
                return;
            }

            const icon = [
                [101, 'audio-volume-overamplified-symbolic'],
                [67, 'audio-volume-high-symbolic'],
                [34, 'audio-volume-medium-symbolic'],
                [0, 'audio-volume-low-symbolic'],
            ].find(([threshold]) => threshold <= Audio.speaker.volume * 100)[1];

            self.icon = `${icon}`;
        }, 'speaker-changed'),
        Widget.Label().hook(Audio, self => {
            if (Audio.speaker.stream.is_muted) {
                self.label = '0%';
            } else {
                self.label = `${Math.round(Audio.speaker.volume * 100 || 0)}%`;
            }
        }, 'speaker-changed'),

        Widget.Icon().hook(Audio, self => {
            if (!Audio.microphone)
                return;
            if (Audio.microphone?.stream.is_muted) {
                self.icon = 'audio-input-microphone-muted-symbolic'
                return;
            }

            self.icon = Audio.microphone.volume * 100 >= 50 ? 'audio-input-microphone-high-symbolic' : 'audio-input-microphone-medium-symbolic';
        }, 'microphone-changed'),
        Widget.Label().hook(Audio, self => {
            if (Audio.microphone.is_muted) {
                self.label = '0%';
            } else {
                self.label = `${Math.round(Audio.microphone.volume * 100 || 0)}%`;
            }
        })
    ],
});
