import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const Workspaces = () => Widget.Box({
    
});

const ClockAndDate = () => Widget.Label({
    class_name: 'clock',
    setup: self => self
        .poll(1000, self => execAsync(['date', '+%A\ \|\ %D\ \|\ %R'])
            .then(date => self.label = date)),
});

const Volume = () => Widget.Box({
    class_name: 'volume',
    css: 'min-width: 180px',
    children: [
        Widget.Icon().hook(Audio, self => {
            if (!Audio.speaker)
                return;

            const category = {
                101: 'overamplified',
                67: 'high',
                34: 'medium',
                1: 'low',
                0: 'muted',
            };

            const icon = Audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
                threshold => threshold <= Audio.speaker.volume * 100);

            self.icon = `audio-volume-${category[icon]}-symbolic`;
        }, 'speaker-changed'),
        Widget.Slider({
            hexpand: true,
            draw_value: false,
            on_change: ({ value }) => Audio.speaker.volume = value,
            setup: self => self.hook(Audio, () => {
                self.value = Audio.speaker?.volume || 0;
            }, 'speaker-changed'),
        }),
        // Widget.Label({
        //     setup: self => self.hook(Audio, () => {
        //         self.label = Audio.speaker?.volume.toString() || 0;
        //     }, 'speaker-changed'),
        // }),
    ],
});

const Left = () => Widget.Box({
    spacing: 8,
    children: [

    ],
});

const Center = () => Widget.Box({
    spacing: 8,
    children: [

    ],
});

const Right = () => Widget.Box({
    spacing: 8,
    children: [
        Volume(),
        ClockAndDate(),
    ],
});

const Bar = (monitor = 0) => Widget.Window({
    name: `bar`,
    anchor: ['top', 'left', 'right'],
    child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
    // child: Widget.Label().bind('label', date),
});

export default { windows: [Bar()] };
