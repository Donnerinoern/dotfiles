import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
import Notification from './aylnot.js';

const Popups = parent => {
    const map = new Map();

    const onDismissed = (_, id, force = false) => {
        if (!id || !map.has(id))
            return;

        if (map.get(id).isHovered() && !force)
            return;

        if (map.size - 1 === 0)
            parent.reveal_child = false;

        Utils.timeout(200, () => {
            map.get(id)?.destroy();
            map.delete(id);
        });
    };

    const onNotified = (box, id) => {
        if (!id || Notifications.dnd)
            return;

        const n = Notifications.getNotification(id);
        if (!n)
            return;

        map.delete(id);
        map.set(id, Notification(n));
        box.children = Array.from(map.values()).reverse();
        Utils.timeout(10, () => {
            parent.reveal_child = true;
        });
    };

    return Widget.Box({ vertical: true })
        .hook(Notifications, onNotified, 'notified')
        .hook(Notifications, onDismissed, 'dismissed')
        .hook(Notifications, (box, id) => onDismissed(box, id, true), 'closed');
};

const PopupList = (transition = 'slide_right') => Widget.Box({
    css: 'padding: 1px',
    children: [
        Widget.Revealer({
            transition,
            setup: self => self.child = Popups(self),
        }),
    ],
    // visibility: TODO: Fix
});

export default monitor => Widget.Window({
    monitor,
    margins: [0, 0, 16, 16],
    name: 'notifications',
    anchor: ['bottom', 'left'],
    child: PopupList(),
});
