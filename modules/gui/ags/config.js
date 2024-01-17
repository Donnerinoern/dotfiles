import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

const FocusedTitle = () => Widget.Label({
    label: Hyprland.active.client.bind('title'),
});

const dispatch = ws => Hyprland.sendMessage(`dispatch workspace ${ws}`);

const Workspaces = () => Widget.EventBox({
    onScrollUp: () => dispatch('+1'),
    onScrollDown: () => dispatch('-1'),
    class_name: 'workspaces',
    child: Widget.Box({
        children: Array.from({ length: 10}, (_, i) => i + 1).map(i => Widget.Button({
            attribute: i,
            label: `${i}`,
            onClicked: () => dispatch(i),
        })),
        setup: self => self.hook(Hyprland, () => self.children.forEach(btn => {
            btn.className = btn.attribute === Hyprland.active.workspace.id ? "focused" : "";
            btn.visible = Hyprland.workspaces.some(ws => ws.id === btn.attribute);
        })),
    }),
});

const ClockAndDate = () => Widget.Label({
    class_name: 'clock',
    setup: self => self
        .poll(1000, self => execAsync(['date', '+%A\ \|\ %D\ \|\ %R'])
            .then(date => self.label = date)),
});

const Volume = () => Widget.Box({
    class_name: 'volume',
    spacing: 4,
    children: [
        Widget.Label().hook(Audio, self => {
            if (!Audio.speaker)
                return;

            const icon = [
                [101, '\ue98e'],
                [67, '\ue050'],
                [34, '\ue04d'],
                [1, '\ue04e'],
                [0, '\ue710'],
            ].find(([threshold]) => threshold <= Audio.speaker?.volume * 100)[1];

            self.label = `${icon}`;
            self.class_name = 'icon';
        }, 'speaker-changed'),
        Widget.Label().hook(Audio, self => {
            self.label = `${Math.round(Audio.speaker?.volume * 100 || 0)}%`;
        }, 'speaker-changed'),
    ],
});

const ipAddr = Variable(0, {
    poll: [
        2000,
        'nmcli device show enp5s0',
        out => out
            .split('\n')
            .find(line => line.includes("IP4.ADDRESS"))
            .split(/\s+/)[1]
            .replace('/24', ''),
    ],
});

const Network = () => Widget.Label().bind('label', ipAddr)

const divide = ([total, free]) => free / total;

const cpu = Variable(0, {
    poll: [
        2000,
        "top -b -n 1",
        out => out
            .split('\n')
            .find(line => line.includes('Cpu(s)'))
            .split(/\s+/)[1]
            .replace(',', '.'),
    ],
});

const memory = Variable(0, {
    poll: [
        2000,
        "free",
        out => Math.round(
            divide(
                out
                    .split('\n')
                    .find(line => line.includes('Mem:'))
                    .split(/\s+/)
                    .splice(1, 2),
            )*100),
    ],
});

const CPU = () => Widget.Box({
    spacing: 4,
    children: [
        Widget.Label({
            label: cpu.bind().transform(value => `${value}%`)
        }),
        Widget.Label({
            label: '\ue30d',
            class_name: 'icon'
        }),
    ],
});

const Memory = () => Widget.Box({
    spacing: 4,
    children: [
        Widget.Label({
            label: memory.bind().transform(value => `${value}%`)
        }),
        // Widget.Label({
        //     label: '\ue322',
        //     class_name: 'icon'
        // }),
        Widget.Label({
            label: '\uf7a3',
            class_name: 'icon'
        }),
    ],
});

const Left = () => Widget.Box({
    name: 'leftbox',
    spacing: 8,
    children: [
        Workspaces(),
    ],
});

const Center = () => Widget.Box({
    spacing: 8,
    children: [
        FocusedTitle(),
    ],
});

const Right = () => Widget.Box({
    name: 'rightbox',
    hpack: 'end',
    spacing: 8,
    children: [
        Volume(),
        Network(),
        CPU(),
        Memory(),
        ClockAndDate(),
    ],
});

const Bar = (monitor = 0) => Widget.Window({
    name: 'bar',
    monitor,
    margins: [8, 8, 0, 8],
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
});

export default { 
    style: '/home/donnan/nixos/modules/gui/ags/style.css',
    windows: [Bar()] 
};
