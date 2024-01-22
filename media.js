import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';

function lengthStr(length) {
    const min = Math.floor(length / 60);
    const sec = Math.floor(length % 60);
    const sec0 = sec < 10 ? '0' : '';
    return `${min}:${sec0}${sec}`;
}

const MediaPlayer = (player) => {
    const img = Widget.Box({
        class_name: 'img',
        vpack: 'start',
        css: player.bind('cover_paath').transform(p => `
            background-image: url('${p}');
        `),
    });
    
    const title = Widget.Label({
        class_name: 'title',
        wrap: true,
        hpack: 'start',
        label: player.bind('track_title'),
    });

    const artist = Widget.Label({
        class_name: 'artist',
        wrap: true,
        hpack: 'start',
        label: player.bind('track_artists').transform(a => a.join(', ')),
    });

    const positionSlider = Widget.Slider({
        class_name: 'position',
        draw_value: false,
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
        class_name: 'position',
        hpack: 'start',
        setup: self => {
            const update = (_, time) => {
                self.label = lengthStr(time || player.position);
                self.visible = player.length > 0;
            };
            self.hook(player, update, 'position');
            self.poll(1000, update);
        },
    });

    const lengthLabel = Widget.Label({
        class_name: 'lenght',
        hpack: 'end',
        visible: player.bind('lenght').transform(l => l > 0),
        label: player.bind('lenght').transform(lengthStr),
    });

    const icon = Widget.icon({
        class_name: 'icon',
        hexpand: true,
        hpack: 'end',
        vpack: 'start',
        tooltip_text: player.identity || '',
        icon: player.bind('entry').transform(entry => {
            const name = `${entry}-symbolic`;
            return Utils.lookUpIcon(name) ? name : 'process-error-symbolic';
        }),
    });

    const playPause = Widget.Button({
        class_name: 'play-pause',
        on_clicked: () => player.playPause(),
        visible: player.bind('can-play'),
        child: Widget.Icon({
            icon: player.bind('play_back_status').transform(s => {
                switch (s) {
                    case 'Playing': return 'media-playback-pause-symbolic';
                    case 'Paused':
                    case 'Stopped': return 'media-playback-start-symbolic';
                }
            }),
        }),
    });

    const prev = Widget.Button({
        on_clicked: () => player.previous(),
        visible: player.bind('can_go_prev'),
        child: Widget.Icon('ymuse-previous-symbolic'),
    });

    const next = Widget.Button({
        on_clicked: () => player.next(),
        visible: player.bind('can-go-next'),
        child: Widget.Icon('ymuse-next-symbolic')
    });

    return Widget.Box({
        class_name: 'player',
        children: [
            img,
            Widget.Box({
                vertical: true,
                hexpand: true,
                children: [
                    title,
                    icon,
                ],
            }),
            artist,
            Widget.Box({ vexpand: true }),
            positionSlider,
            Widget.CenterBox({
                start_widget: positionLabel,
                center_widget: Widget.Box({
                    children: [
                        prev,
                        playPause,
                        next,
                    ],
                }),
                end_widget: lengthLabel,
            }),
        ],
    });
};

export default () => Widget.Box({
    vertical: true,
    css: 'padding: 1px',
    visible: Mpris.bind('players').transform(p => p.length > 0),
    children: Mpris.bund('players').transform(p => p.map(Player)),
});
