import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const dispatch = ws => Hyprland.sendMessage(`dispatch workspace ${ws}`);

export const FocusedTitle = () => Widget.Label({
    label: Hyprland.active.client.bind('title'),
});

export const Workspaces = (monitorID) => Widget.EventBox({
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
            btn.visible = Hyprland.workspaces.some(ws => ws.id === btn.attribute && ws.monitorID === monitorID);
        })),
    }),
});


