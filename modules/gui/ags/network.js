import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Network from 'resource:///com/github/Aylur/ags/service/network.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const ipAddr = Variable(0, { // TODO: Change to hook on Network.connectivity
    poll: [
        60000,
        'nmcli device show enp5s0',
        out => out
            .split('\n')
            .find(line => line.includes("IP4.ADDRESS"))
            .split(/\s+/)[1]
            .replace('/24', ''),
    ],
});

export const NetworkBox = () => Widget.Box({
    spacing: 4,
    children: [
        Widget.Label().bind('label', ipAddr),
        Widget.Icon({
            icon: Network.wired.bind('icon-name'),
        }),
    ],
});
