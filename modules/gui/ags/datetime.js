import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const dateTime = Variable('', {
    poll: [1000, ['date', '+%A\ \|\ %d/%m/%y\ \|\ %R']]
});

export const DateTime = () => Widget.Label({
    class_name: 'clock',
    label: dateTime.bind()
});


