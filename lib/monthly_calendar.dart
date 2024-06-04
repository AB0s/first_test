import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'yearly_calendar.dart';

class MonthlyCalendar extends StatefulWidget {
  @override
  _MonthlyCalendarState createState() => _MonthlyCalendarState();
}

class _MonthlyCalendarState extends State<MonthlyCalendar> {
  late final ValueNotifier<DateTime> _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(DateTime.now());
    _selectedDay = DateTime.now();
    initializeDateFormatting('ru', null);
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Календарь'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_view_month),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => YearlyCalendar()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          locale: 'ru',
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay.value,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay.value = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay.value = focusedDay;
          },
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            formatButtonShowsNext: false,
          ),
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Color(0xFFFF8702),
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Color(0xFFFF8702).withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
