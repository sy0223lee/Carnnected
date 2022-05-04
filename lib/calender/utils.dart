import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final String time;
  const Event(this.title, this.time);

  @override
  String toString() => '$title';
}

late String test;
late Map<DateTime, dynamic> kEventSource = {};

final kEvents = LinkedHashMap(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(kEventSource);

// Map<DateTime, dynamic> _kEventSource = {
//   DateTime(2022, 4, 3): [Event('주유서비스예약', '3일 일요일 14:00')],
//   DateTime(2022, 4, 4): [Event('세차서비스예약', '4일 월요일 15:00')],
//   DateTime(2022, 4, 5): [
//     Event('정비서비스예약', '5일 화요일 11:00'),
//     Event('딜리버리서비스예약', '5일 화요일 17:00')
//   ],
// };

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class Event1 {
  final String id;
  final String number;
  final String tablename;
  final String time;
  Event1({
    required this.id,
    required this.number,
    required this.tablename,
    required this.time,
  });
  factory Event1.fromJson(Map<String, dynamic> json) {
    return Event1(
      id: json['id'],
      number: json['number'],
      tablename: json['tablename'],
      time: json['time'],
    );
  }

  @override
  String toString() => '$id $number $tablename $time';
}

Future<List> eventdata(String id) async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8080/calendar/$id'));
  late List<Event1> eventList = [];
  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);
    for (var i = 0; i < json.length; i++) {
      eventList.add(Event1.fromJson(json[i]));
    }
    return eventList;
  } else {
    throw Exception('Failed to load event data');
  }
}