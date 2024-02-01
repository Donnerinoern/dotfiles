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
    const sec = sec1 > 0 ? sec1 : 0;
    const sec0 = sec < 10 ? '0' : '';
    return `${min}:${sec0}${sec}`;
}

const Player = player => {
    const img = Widget.Icon({
        size: 30,
        class_name: 'icon',
        icon: player.bind('cover_path'),
    });

    // const titleAndArtist = Widget.Label({
    //     setup: self => self.hook(Mpris, () => {
    //         self.label = `${player.bind('track_title') - ${player.bind('track_artists')}`}
    //     }, 'changed')
    // });

    const titleLabel = Widget.Label({
        label: player.bind('track_title')
    });

    const artistsLabel = Widget.Label({
        label: player.bind('track_artists').transform(a => a.join(', ') || '')
    });

    const positionSlider = Widget.Slider({
        class_name: 'position',
        draw_value: false,
        on_change: ({ value }) => player.position = value * player.length,
        setup: self => {
            const update = () => {
                if (self.dragging)
                    return;

                if (player.length > 0) {
                    self.visible = true;
                    self.value = player.position / player.length;
                } else {
                    self.visible = false;
                }
            };
            self.hook(player, update);
            self.hook(player, update, 'position');
            self.poll(1000, update);
        },
    });

    const positionLabel = Widget.Label({
        setup: self => {
            const update = (_, time) => {
                player.length > 0
                    ? self.label = lengthStr(time || player.position)
                    : self.visible = !!player;
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

    const playPauseButton = Widget.Button({
        child: Widget.Stack({
            transition: 'crossfade',
            items: [
                ['Playing', Widget.Icon({icon: PAUSE_ICON})],
                ['Paused', Widget.Icon({icon: PLAY_ICON})],
                ['Stopped', Widget.Icon({icon: PLAY_ICON})]
            ]
        }).bind('shown', player, 'play-back-status', p => `${p}`),
        on_clicked: () => player.playPause()
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
            // titleAndArtist,
            titleLabel,
            Widget.Label({label: '|'}),
            artistsLabel,

            sliderBox,
            Widget.Box({
                children: [
                    prev,
                    // playPause,
                    playPauseButton,
                    next,
                ],
            }),
        ],
    });
}

export default () => Widget.Box({
    visible: Mpris.bind('players').transform(p => p.length > 0),
    children: Mpris.bind('players').transform(ps => ps
        .filter(p => p.name === 'playerctld').map(Player)
    )
});
