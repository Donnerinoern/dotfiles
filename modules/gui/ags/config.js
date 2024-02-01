import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Gtk from 'gi://Gtk?version=3.0';
import { System } from './system.js';
import { FocusedTitle, Workspaces } from './hyprland.js';
import { DateTime } from './datetime.js';
import { NetworkBox } from './network.js';
import { Volume } from './volume.js';
// import { Volume } from './new_volume.js';
import Player from './media.js';
import { Power } from './power.js';
import NotificationPopup from './notification.js';

// const scss = '/home/donnan/nixos/modules/gui/ags/style.scss'; // TODO: Remove later when config is "done"
// const css = '/home/donnan/nixos/modules/gui/ags/style.css';

Gtk.IconTheme.get_default().append_search_path('/home/donnan/svg');

Utils.monitorFile(
    `${App.configDir}/style.scss`,

    function() {
        const scss = `${App.configDir}/style.scss`;
        const css = `${App.configDir}/style.css`;
        Utils.exec(`sass ${scss} ${css}`);
        App.resetCss();
        App.applyCss(css);
    },
    'file',
)
//

const SepIcon = () => Widget.Icon({
    class_name: 'sep',
    icon: 'media-record-symbolic'
});

const Left = (monitorID) => Widget.Box({
    name: 'leftbox',
    children: [
        Workspaces(monitorID),
        Widget.CenterBox({
            hexpand: true,
            center_widget: monitorID === 0 ? Player(monitorID) : Widget.Label({visible: false})
        })
    ],
});

const Center = () => Widget.Box({
    css: 'min-width: 237px',
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
        SepIcon(),
        NetworkBox(),
        SepIcon(),
        System(),
        SepIcon(),
        DateTime(),
        SepIcon(),
        Power()
    ],
});

const Bar = (monitor) => Widget.Window({
    name: `bar${monitor}`,
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
    style: `${App.configDir}/style.css`,
    windows: [
        Bar(0, 'mainBar'),
        Bar(1, 'altBar'),
        NotificationPopup(0)
    ]
};
