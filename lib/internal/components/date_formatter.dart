import 'package:intl/intl.dart';

String dateConverter(int? date) {
  if (date != null) {
    var dt = DateTime.fromMillisecondsSinceEpoch(date);

    // 12 Hour format: // 12/31/2000, 10:00 PM
    var d12 = DateFormat('MM.dd.yyyy, hh:mm a').format(dt);

    // 24 Hour format: // 31/12/2000, 22:00
    var d24 = DateFormat('d MMM y').format(dt);

    print(d24);

    return d24;
  } else {
    return '-';
  }
}