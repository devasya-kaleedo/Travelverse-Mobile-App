import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  DateTime dateTime =
      DateTime.parse(dateTimeString).toLocal(); // Convert to local time
  return DateFormat('d MMM hh:mm a').format(dateTime);
}
