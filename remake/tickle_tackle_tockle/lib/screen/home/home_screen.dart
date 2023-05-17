import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:get/get.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';
import '../../const/serveraddress.dart';
import '../../controller/loading_controller.dart';
import '../../controller/theme_controller.dart';
import 'package:http/http.dart' as http;

import '../../model/TickleCountNameRes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  ThemeController themeController = Get.put(ThemeController());

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  buildTickleListTile(String category, DateTime selectedDateTime) {
    List<Widget> tickleList = [];
    tickleList.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(category, style: const TextStyle(fontSize: 20,)),
      ],
    ));
    tickleList.add(const SizedBox(height: 20,),);

    //요청하는 날짜 YYYYMMDD
    String reqDateTime = selectedDateTime.year.toString() + selectedDateTime.month.toString().padLeft(2, '0') + selectedDateTime.day.toString().padLeft(2, '0');
    //요청하는 카테고리 이름 : category

    if(isSameDay(DateTime.now(), selectedDateTime)) {
      // 오늘 => 달성/미달성 토글이 가능한 일정 위젯을 반환

      tickleList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('😀', style: TextStyle(fontSize: 20,),),
          Column(
            children: [
              Text('산책하기', style: TextStyle(fontSize: 15,),),
              SizedBox(height: 5,),
              Text('오전 06:00', style: TextStyle(fontSize: 10, color: TTTGrey),),
            ],
          ),
          GetBuilder<ThemeController>(
            builder: (_) {
              return ElevatedButton(
                onPressed: () {

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(themeController.selectedPrimaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                child: Text('달성'),
              );
            }
          ),
        ],
      ));

    } else if(selectedDateTime.compareTo(DateTime.now()) == -1) {
      // 과거 => 달성 표시가 되어있고 달성/미달성 토글이 불가능한 일정 위젯을 반환


    } else if(selectedDateTime.compareTo(DateTime.now()) == 1) {
      // 미래 => 미달성 표시가 되어있고 달성/미달성 토글이 불가능한 일정 위젯을 반환


    }

    return tickleList;
  }

  buildTickleListCart(String category, DateTime selectedDateTime) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
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
          children: buildTickleListTile(category, selectedDateTime),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    //_selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  Future<http.Response> sendAccessToken(String strDate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('${ServerUrl}/tickle/month?targetDate=$strDate');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accesstoken' :  accessToken,

      },
    );
    return response;
  }

  Future<List<String>> checkAccessToken(String strDate) async {
    final response = await sendAccessToken(strDate);
    List<String> tickleList = [];

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      tickleList = List<String>.from(data.map((item) => item.toString()));
      print('${tickleList.length} 몇개임');
      for(int i=0;i<tickleList.length;i++){
        print(tickleList[i].toString()+" 투스트링");
      }
    } else if(response.statusCode == 401){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refreshToken = pref.getString('refreshToken')!;
      String accessToken = pref.getString('accessToken')!;
      var url = Uri.parse('${ServerUrl}/tickle/month?targetDate=$strDate');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accesstoken' : accessToken,
          'refreshtoken' :  refreshToken,
        },
      );
      final headers = response.headers;
      final accesstoken = headers['accesstoken'];
      final refreshtoken = headers['refreshtoken'];
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('accessToken', accesstoken!);
      sharedPreferences.setString('refreshToken', refreshtoken!);
      List<dynamic> data = jsonDecode(response.body);
      tickleList = List<String>.from(data.map((item) => item.toString()));


    } else {
      print('Login failed with status: ${response.statusCode}');
    }
    return tickleList;
  }



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    Future<http.Response> sendAccessToken(String targetMonth) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String accessToken = sharedPreferences.getString('accessToken')!;
      var url = Uri.parse('${ServerUrl}/tickle/month');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': accessToken,
          'targetDate': targetMonth,
        },
      );
      return response;
    }

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.homePageAppBar, title: '틱택톡'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: checkAccessToken(_focusedDay.year.toString() + _focusedDay.month.toString().padLeft(2, '0')),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  if(snapshot.hasError) {
                    return Container();
                  }

                  List<String>? inputList = snapshot.data;
                  if(inputList == null) {
                    return Container();
                  }

                  _kEventSource.clear();
                  for(int listIdx = 0; listIdx < inputList.length; listIdx++) {
                    int year = int.parse(inputList[listIdx].substring(0, 4));
                    int month = int.parse(inputList[listIdx].substring(4, 6));
                    int day = int.parse(inputList[listIdx].substring(6, 8));

                    _kEventSource[DateTime(year, month, day)] = Event(date: DateTime(year, month, day));
                  }

                  return Padding(
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
                                markerBuilder: (context, date, events) {
                                  DateTime _date = DateTime(date.year, date.month, date.day);

                                  if(isSameDay(_date, _kEventSource[_date]?.date)) {
                                    return Positioned(
                                      right: 1,
                                      bottom: 1,
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset('assets/images/tockles/toc_00.png'),
                                      ),
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
                              startingDayOfWeek: StartingDayOfWeek.sunday,
                              availableGestures: AvailableGestures.none,
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
                                setState(() {
                                  _focusedDay = focusedDay;
                                });
                              },
                            );
                          }
                      ),
                    ),
                  );
                }
              ),
              const SizedBox(height: 8.0),
              Column(
                children: [
                  buildTickleListCart('금전', _selectedDay!),
                  buildTickleListCart('운동', _selectedDay!),
                  buildTickleListCart('학습', _selectedDay!),
                  buildTickleListCart('관계', _selectedDay!),
                  buildTickleListCart('생활', _selectedDay!),
                  buildTickleListCart('기타', _selectedDay!),
                ],
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}

class Event {
  final DateTime date;

  Event({required this.date});
}

final kEvents = LinkedHashMap<DateTime, Event>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final Map<DateTime, Event> _kEventSource = {};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000;
}