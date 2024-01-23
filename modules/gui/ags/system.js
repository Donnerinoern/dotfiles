import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

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
            )*100
        ),
    ],
});

export const CPU = () => Widget.Box({
    spacing: 4,
    children: [
        Widget.Label({
            label: cpu.bind().transform(value => `${value.length > 3 ? value : " "+value}%`)
        }),
        Widget.Icon({
            icon: 'cpu-symbolic',
        }),
    ],
});

export const Memory = () => Widget.Box({
    spacing: 4,
    children: [
        Widget.Label({
            label: memory.bind().transform(value => ` ${value}%`)
        }),
        Widget.Icon({
            icon: 'memory-symbolic',
        }),
    ],
});

