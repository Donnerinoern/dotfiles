import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import {execAsync} from 'resource:///com/github/Aylur/ags/utils.js';

const Reboot = () => Widget.Button({
    child: Widget.Icon({icon: 'system-reboot-symbolic'}),
    on_clicked: () => execAsync('reboot')
});

const PowerOff = () => Widget.Button({
    child: Widget.Icon({icon: 'system-shutdown-symbolic'}),
    on_clicked: () => execAsync('shutdown now')
});

export const Power = () => Widget.Box({
    children: [
        Reboot(),
        PowerOff()
    ]
});
