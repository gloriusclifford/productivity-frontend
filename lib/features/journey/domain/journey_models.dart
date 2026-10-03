enum Mood {
  low('😔', 'Low'),
  off('🙁', 'Off'),
  okay('😐', 'Okay'),
  good('🙂', 'Good'),
  wonderful('😊', 'Wonderful');

  const Mood(this.emoji, this.label);
  final String emoji;
  final String label;
}

class Reflection {
  const Reflection({
    required this.date,
    required this.mood,
    required this.title,
    required this.content,
  });

  final DateTime date;
  final Mood mood;
  final String title;
  final String content;
}

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];
const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

extension JourneyDateFormat on DateTime {
  /// "Oct 8, 2026"
  String get shortDate => '${_months[month - 1]} $day, $year';

  /// "Mon", "Tue", ...
  String get weekdayShort => _weekdays[weekday - 1];

  DateTime get dateOnly => DateTime(year, month, day);
}