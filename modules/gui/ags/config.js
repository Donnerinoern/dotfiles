import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
// import App from 'resource:///com/github/Aylur/ags/app.js';
import { CPU, Memory } from './system.js';
import { FocusedTitle, Workspaces } from './hyprland.js';
import { DateTime } from './datetime.js';
import { NetworkBox } from './network.js';
import { Volume } from './volume.js';
import Player from './media.js';

// const scss = `${App.configDir}/style.scss`;
// const css = `${App.configDir}/style.css`;
const scss = '/home/donnan/nixos/modules/gui/ags/style.scss'; // TODO: Remove later when config is "done"
const css = '/home/donnan/nixos/modules/gui/ags/style.css';
Utils.exec(`sass ${scss} ${css}`);

const Left = (monitorID) => Widget.Box({
    name: 'leftbox',
    children: [
        Workspaces(monitorID),
    ],
});

const Center = () => Widget.Box({
    children: [
        FocusedTitle(),
    ],
});

const Right = () => Widget.Box({
    name: 'rightbox',
    hpack: 'end',
    spacing: 8,
    children: [
        Player(),
        Volume(),
        NetworkBox(),
        CPU(),
        Memory(),
        DateTime(),
    ],
});

const Bar = (monitor = 0, name) => Widget.Window({
    name: name,
    monitor,
    margins: [8, 8, 0, 8],
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        start_widget: Left(monitor),
        center_widget: Center(),
        end_widget: Right(),
    }),
});

export default { 
    style: css,
    windows: [
        Bar(0, 'mainBar'),
        Bar(1, 'altBar')
    ]
};
