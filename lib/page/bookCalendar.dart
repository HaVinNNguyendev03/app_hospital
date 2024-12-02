import 'package:app_hospital/theme.dart';
import 'package:app_hospital/widget/ButtonwidgetIntro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class BookCalendar extends StatefulWidget {
  const BookCalendar({Key? key}) : super(key: key);

  @override
  State<BookCalendar> createState() => _BookCalendarState();
}

class Event {
  final String title;

  Event(this.title);

  @override
  String toString() => title;
}

class _BookCalendarState extends State<BookCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;

  // Dữ liệu sự kiện
  final Map<DateTime, List<Event>> _events = {};

  // Danh sách giờ trống
  final List<String> _availableTimes = [
    '06:00 AM',
    '07:00 AM',
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '02:00 PM',
    '03:00 PM'
  ];

  // Lấy danh sách sự kiện cho một ngày
  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  // kiểm tra khung giờ khám trùng nhau
  bool isEventDuplicate(DateTime date, String time) {
  final events = _getEventsForDay(date);

  // Kiểm tra xem có sự kiện trùng giờ không
  return events.any((event) {
    // Lấy thời gian từ tiêu đề sự kiện
    final eventTime = event.title.replaceFirst("Lịch khám lúc ", "").trim();
    return eventTime == time;
  });
}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Đặt Lịch Khám",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Lịch
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    TableCalendar<Event>(
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2100, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      eventLoader:
                          _getEventsForDay, // Hàm trả về danh sách sự kiện cho ngày
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle: TextStyle(color: Colors.black),
                      ),
                      headerStyle: HeaderStyle(
                        leftChevronIcon:
                            Icon(Icons.chevron_left, color: Colors.white),
                        rightChevronIcon:
                            Icon(Icons.chevron_right, color: Colors.white),
                        titleTextStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: BoxDecoration(color: Colors.green),
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          // Lấy danh sách sự kiện của ngày
                          final events = _getEventsForDay(day);

                          if (events.isNotEmpty) {
                            // Kiểm tra số lượng sự kiện và chọn màu nền
                            Color backgroundColor;
                            if (events.length <= 2) {
                              backgroundColor =
                                  Colors.yellow; // ≤2 sự kiện -> Vàng
                            } else if (events.length <= 4) {
                              backgroundColor =
                                  Colors.orange; // ≤4 sự kiện -> Cam
                            } else {
                              backgroundColor = Colors.red; // >4 sự kiện -> Đỏ
                            }

                            return Container(
                              margin: EdgeInsets.all(
                                  6), // Khoảng cách giữa các ngày
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}', // Số ngày
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }

                          // Giao diện mặc định nếu không có sự kiện
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Danh sách sự kiện
                    Expanded(
                      child: ListView(
                        children: _getEventsForDay(_selectedDay ?? _focusedDay)
                            .map((event) => ListTile(
                                  title: Text(event.title),
                                  leading: const Icon(
                                    Icons.event,
                                    color: Colors.green,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Danh sách thời gian trống
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Thời gian bác sĩ trống lịch',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _availableTimes.map((time) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              label: Text(
                                time,
                                style: TextStyle(
                                  color: _selectedTime == time
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              selected: _selectedTime == time,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedTime = selected ? time : null;
                                });
                              },
                              selectedColor: Colors.green,
                              backgroundColor: Colors.grey[200],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Nút đặt lịch
                    Buttonwidget(
                      textbutton: 'Đặt Lịch',
                      paddinghorizontal: 0, // Điều chỉnh nếu cần
                      paddingvertical: 15,
                      height: 50, // Chiều cao nút
                      width: double.infinity, // Chiều rộng nút
                      onPressed: () {
                        if (_selectedDay != null && _selectedTime != null) {
                          // Kiểm tra sự kiện trùng
                          if (isEventDuplicate(_selectedDay!, _selectedTime!)) {
                            // Hiển thị thông báo nếu sự kiện trùng
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Lỗi!'),
                                content: Text(
                                    'Đã có lịch khám vào lúc $_selectedTime. Vui lòng chọn giờ khác.'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Đóng'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            // Thêm sự kiện mới vào danh sách
                            setState(() {
                              final events = _getEventsForDay(_selectedDay!);
                              events.add(Event('Lịch khám lúc $_selectedTime'));
                              _events[_selectedDay!] = events;
                            });

                            // Hiển thị thông báo thành công
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Đặt lịch thành công!'),
                                content: Text(
                                  'Ngày: ${_selectedDay?.toLocal().toString().split(' ')[0]}\nGiờ: $_selectedTime',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Đóng'),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          // Hiển thị cảnh báo nếu chưa chọn ngày hoặc giờ
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Lỗi!'),
                              content: const Text(
                                  'Vui lòng chọn ngày và giờ để đặt lịch.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Đóng'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
