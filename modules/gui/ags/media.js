import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';

const FALLBACK_ICON = 'audio-x-generic-symbolic';
const PLAY_ICON = 'media-playback-start-symbolic';
const PAUSE_ICON = 'media-playback-pause-symbolic';
const PREV_ICON = 'media-skip-backward-symbolic';
const NEXT_ICON = 'media-skip-forward-symbolic';

function lengthStr(length) {
    const min1 = Math.floor(length / 60);
    const min = min1 > 0 ? min1 : '0';
    const sec1 = Math.floor(length % 60);
    const sec = sec1 > 0 ? sec1 : '0';
    const sec0 = sec < 10 ? '0' : '';
    return `${min}:${sec0}${sec}`;
}

const Player = player => {
    const img = Widget.Icon({
        size: 24,
        class_name: 'icon',
        icon: player.bind('cover_path'),
    });

    const titleAndArtist = Widget.Label({
        setup: self => self.hook(Mpris, () => {
            self.label = `${player.track_title} - ${player.track_artists} | `
        }, 'changed')
    });

    const positionSlider = Widget.Slider({
        class_name: 'position',
        draw_value: false,
        // hexpand: true,
        on_change: ({ value }) => player.position = value * player.length,
        setup: self => {
            const update = () => {
                self.visible = player.length > 0;
                self.value = player.position / player.length;
            };
            self.hook(player, update);
            self.hook(player, update, 'position');
            self.poll(1000, update);
        },
    });

    const positionLabel = Widget.Label({
        setup: self => {
            const update = (_, time) => {
                self.label = lengthStr(time || player.position)
                self.visible = player.length > 0;
            };
            self.hook(player, update, 'position');
            self.poll(1000, update);
        },
    });

    const lengthLabel = Widget.Label({
        visible: player.bind('length').transform(l => l > 0),
        label: player.bind('length').transform(lengthStr),
    });

    const sliderBox = Widget.Box({
        css: 'min-width: 260px',
        visible: player.bind('length').transform(l => l > 0),
        children: [
            positionLabel,
            positionSlider,
            lengthLabel
        ]
    })

    const icon = Widget.Icon({
        class_name: 'icon',
        size: 16,
        tooltip_text: player.identity || '',
        icon: player.bind('identity').transform(entry => {
            if (entry.toLowerCase() === 'mozilla firefox') {
                entry = entry.toLowerCase().split(' ')[1];
            }
            const name = `${entry.toLowerCase()}-symbolic`;
            return Utils.lookUpIcon(name) ? name : FALLBACK_ICON;
        }),
    });

    const playPause = Widget.Button({
        on_clicked: (self) => {
            player.playPause();
            // self.class_name = 'focused';
        },
        visible: player.bind('can_play'),
        child: Widget.Icon({
            icon: player.bind('play_back_status').transform(s => {
                switch (s) {
                    case 'Playing': return PAUSE_ICON;
                    case 'Paused':
                    case 'Stopped': return PLAY_ICON;
                }
            }),
        }),
    });

    const prev = Widget.Button({
        class_name: 'playerButton',
        on_clicked: () => player.previous(),
        visible: player.bind('can_go_prev'),
        child: Widget.Icon(PREV_ICON),
    });

    const next = Widget.Button({
        class_name: 'playerButton',
        on_clicked: () => player.next(),
        visible: player.bind('can_go_next'),
        child: Widget.Icon(NEXT_ICON),
    });

    return Widget.Box({
        class_name: 'player',
        spacing: 4,
        children: [
            icon,
            img,
            titleAndArtist,
            sliderBox,
            Widget.Box({
                children: [
                    prev,
                    playPause,
                    next,
                ],
            }),
        ],
    });
}

export default () => Widget.Box({
    setup: self => self.hook(Mpris, () => {
        self.child = Player(Mpris.getPlayer('playerctld'));
    }, 'player-changed')
});
