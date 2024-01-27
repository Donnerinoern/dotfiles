import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const dateTime = Variable('', {
    poll: [1000, ['date', '+%A\ \|\ %d/%m/%y\ \|\ %R']]
});

// const time = Variable('', {
//     poll: [1000, ['date', '+%T']]
// });

// const cal = Variable('', {
    // poll: [1000, ['cal']]
// });

// const getCal = () => {
    // print('wooho');
//     cal.setValue = execAsync('cal');
// }

export const DateTime = () => Widget.EventBox({
    // on_hover: () => {
    //     getCal();
    //     print('test');
    // },
    child: Widget.Label({
        class_name: 'clock',
        label: dateTime.bind(),
        // tooltip_text: time.bind()
        // tooltip_text: cal.bind()
    }),
});


