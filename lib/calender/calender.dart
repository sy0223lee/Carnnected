import 'package:flutter/material.dart';
import 'package:mosigg/history/history.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mosigg/calender/utils.dart';

class Calenderpage extends StatefulWidget {
  const Calenderpage({Key? key}) : super(key: key);

  @override
  State<Calenderpage> createState() => _CalenderpageState();
}

class _CalenderpageState extends State<Calenderpage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('일정', 18.0, FontWeight.w500, Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            child: TableCalendar<Event>(
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  headerPadding: EdgeInsets.zero,
                  titleTextStyle: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500)),
              calendarStyle: CalendarStyle(
                markersAnchor: 1.3,
                markerSizeScale: 0.18,
                isTodayHighlighted: true,
                outsideDaysVisible: true,
                cellMargin: EdgeInsets.all(0.0),
                weekendTextStyle: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
                holidayTextStyle: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
                selectedDecoration: BoxDecoration(
                    color: Color(0xff001a5d), shape: BoxShape.rectangle),
                todayDecoration: BoxDecoration(
                    color: Color(0xff001a5d), shape: BoxShape.rectangle),
              ),
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onRangeSelected: _onRangeSelected,
              onDaySelected: _onDaySelected,
              selectedDayPredicate: (DateTime date) {
                return isSameDay(_selectedDay, date);
              },
              firstDay: DateTime.utc(2020, 01, 01),
              lastDay: DateTime.utc(2032, 12, 31),
              focusedDay: _focusedDay,
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
