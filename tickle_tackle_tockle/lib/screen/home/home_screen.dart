import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:get/get.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';
import '../../controller/loading_controller.dart';
import '../../controller/theme_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  buildMoneyListCard() {
    //선택된 날짜의 금전 티끌이 있는지 확인
    bool isExist = true;

    if(isExist) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('금전', style: TextStyle(fontSize: 23,)),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.ac_unit_outlined),
                  Column(
                    children: [
                      Text('산책하기'),
                      Text('오전 06:00', style: TextStyle(fontSize: 10, color: TTTGrey),),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(TTTPrimary1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                    child: Text('달성'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  buildExerciseListCard() {
    return Container();
  }

  buildStudyListCard() {
    return Container();
  }

  buildRelationshipListCard() {
    return Container();
  }

  buildLifeListCard() {
    return Container();
  }

  buildEtcListCard() {
    return Container();
  }

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    LoadingController loadingController = Get.put(LoadingController());
    ThemeController themeController = Get.put(ThemeController());

    final myController = TextEditingController();

    return Scaffold(
      appBar: CommonAppBar(appBarType: AppBarType.homePageAppBar, title: '틱택톡'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: GetBuilder<ThemeController>(
                    builder: (_) {
                      return TableCalendar<Event>(
                        locale: 'ko_KR',
                        calendarBuilders: CalendarBuilders(
                          dowBuilder: (context, day) {
                            if (day.weekday == DateTime.sunday) {
                              return const Center(child: Text('일', style: TextStyle(color: Colors.red),),);
                            } else if(day.weekday == DateTime.saturday) {
                              return const Center(child: Text('토', style: TextStyle(color: Colors.red),),);
                            }
                          },
                          markerBuilder: (context, day, events) {
                            if(events.isNotEmpty) {
                              return Positioned(
                                right: 1,
                                bottom: 1,
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset('assets/images/tockles/toc_00.png'),
                                ),
                                /*child: CircleAvatar(
                                  backgroundColor: TTTPrimary1,
                                  maxRadius: 10,
                                  child: Text(events.length.toString(), style: TextStyle(color: TTTWhite)),
                                ),*/
                              );
                            }
                          },
                        ),
                        firstDay: DateTime.utc(2023, 1, 1),
                        lastDay: DateTime.utc(2100, 12, 31),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        calendarFormat: CalendarFormat.month,
                        rangeSelectionMode: RangeSelectionMode.disabled,
                        eventLoader: _getEventsForDay,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          rangeStartDecoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            color: themeController.selectedPrimaryColor,
                          ),
                          selectedDecoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            color: themeController.selectedPrimaryColor,
                          ),
                          todayDecoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            color: themeController.selectedPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                        onDaySelected: _onDaySelected,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          headerPadding: EdgeInsets.fromLTRB(0, 0.0, 0.0, 20.0),
                          titleCentered: true,
                        ),
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      );
                    }
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Column(
             children: [
               buildMoneyListCard(),
               buildExerciseListCard(),
               buildStudyListCard(),
               buildRelationshipListCard(),
               buildLifeListCard(),
               buildEtcListCard(),
             ],
            ),
            const SizedBox(height: 50.0),
            /*Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
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
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class Event {
  //이모지 산책하기 오전 08:00 달성미달성
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  DateTime(2023, 5, 1) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 2) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 3) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 4) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 5) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 6) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 7) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 8) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 9) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 10) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 11) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 12) : [Event('밥먹기'), Event('저녁먹기')],
  DateTime(2023, 5, 13) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 14) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 15) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 16) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 17) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 18) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 19) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 20) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 21) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 22) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 23) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 24) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 25) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
  DateTime(2023, 5, 26) : [Event('밥먹기'), Event('저녁먹기'), Event('아침먹기')],
};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);