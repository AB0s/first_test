import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class YearlyCalendar extends StatefulWidget {
  @override
  _YearlyCalendarState createState() => _YearlyCalendarState();
}

class _YearlyCalendarState extends State<YearlyCalendar> {
  late PageController _pageController;
  late int initialPage;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru', null);
    final year = DateTime.now().year;
    initialPage = year - 2020; // Calculate the initial page based on the current year
    currentPage = initialPage;
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentYearIndex = DateTime.now().year - 2020;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _buildYearIndicator(currentYearIndex),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final firstDayOfYear = DateTime(2020 + index, 1, 1);
                return _buildYearCalendar(firstDayOfYear);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearIndicator(int currentYearIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: currentPage > 0
                ? () {
              _pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
                : null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(11, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPage == index
                      ? Color(0xFFFF8702)
                      : (index == currentYearIndex
                      ? Color(0xFFFF8702).withOpacity(0.3)
                      : Colors.grey[300]),
                ),
              );
            }),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: currentPage < 10
                ? () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildYearCalendar(DateTime firstDayOfYear) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            DateFormat.y('ru').format(firstDayOfYear),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.58,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final month = DateTime(firstDayOfYear.year, index + 1, 1);
                return _buildMonthCalendar(month);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthCalendar(DateTime month) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat.MMMM('ru').format(month),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: TableCalendar(
            locale: 'ru',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: month,
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.none,
            headerVisible: false,
            daysOfWeekVisible: false,
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, date, events) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8702).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${date.day}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              selectedBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8702),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${date.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
              defaultTextStyle: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
