import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:get/get.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';
import 'package:tickle_tackle_tockle/controller/page_change_controller.dart';
import '../../const/serveraddress.dart';
import '../../controller/loading_controller.dart';
import '../../controller/theme_controller.dart';
import 'package:http/http.dart' as http;

import '../../model/TickleCategoryPastRes.dart';
import '../../model/TickleCategoryRes.dart';
import '../../model/TickleCountNameRes.dart';
import '../../model/TicklePastRes.dart';
import '../../model/TickleReq.dart';
import '../../model/TickleTodayRes.dart';

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
  PageChangeController pageChangeController = Get.put(PageChangeController());

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // postDeviceToken();
      });
    }
  }

  Future<http.Response> checkDeviceTokenRequest() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    String deviceToken = pref.getString('deviceToken')!;
    var url = Uri.parse('${ServerUrl}/fcmtoken');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      },
      body: jsonEncode(<String, String>{
        'fcmToken': deviceToken,
      }),
    );
    return response;
  }

  Future<void> postDeviceToken() async {
    final response = await checkDeviceTokenRequest();
    if (response.statusCode == 200) {
      print('Token send successFully: ${response.statusCode}');
    } else {
      print('Device Token send failed with status: ${response.statusCode}');
    }
  }

  buildTickleListTile(String category, DateTime selectedDateTime, List<Object> ticklesList) {
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

      for(TickleTodayRes todayRes in ticklesList as List<TickleTodayRes>) {
        tickleList.add(SizedBox(height: 20,));
        tickleList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(todayRes.emoji, style: TextStyle(fontSize: 20,),),
            Column(
              children: [
                Text(todayRes.habitName, style: TextStyle(fontSize: 15,),),
                SizedBox(height: 5,),
                Text(todayRes.executionTime, style: TextStyle(fontSize: 10, color: TTTGrey),),
              ],
            ),
            GetBuilder<ThemeController>(
                builder: (_) {
                  return ElevatedButton(
                    onPressed: () {
                      TickleReq req = new TickleReq(habitId: todayRes.habitId, executionDay: reqDateTime, executionTime: todayRes.executionTime);

                      if(todayRes.achieved) {
                        deleteTickle(req).then((value) => pageChangeController.rebuildPage());
                      } else {
                        createTickle(req).then((value) => pageChangeController.rebuildPage());
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(todayRes.achieved ? themeController.selectedPrimaryColor : TTTGrey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                      ),
                    ),
                    child: todayRes.achieved ? Text('달성') : Text('미달성'),
                  );
                }
            ),
          ],
        ));
      }
    } else if(selectedDateTime.compareTo(DateTime.now()) == -1) {
      // 과거 => 달성 표시가 되어있고 달성/미달성 토글이 불가능한 일정 위젯을 반환

      for(TicklePastRes pastRes in ticklesList as List<TicklePastRes>) {
        tickleList.add(SizedBox(height: 20,));
        tickleList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(pastRes.emoji, style: TextStyle(fontSize: 20,),),
            Column(
              children: [
                Text(pastRes.habitName, style: TextStyle(fontSize: 15,),),
                SizedBox(height: 5,),
                Text(pastRes.executionTime, style: TextStyle(fontSize: 10, color: TTTGrey),),
              ],
            ),
            GetBuilder<ThemeController>(
                builder: (_) {
                  return Text('클리어!', style: TextStyle(fontSize: 15, color: themeController.selectedPrimaryColor),);
                }
            ),
          ],
        ));
      }
    } else if(selectedDateTime.compareTo(DateTime.now()) == 1) {
      // 미래 => 미달성 표시가 되어있고 달성/미달성 토글이 불가능한 일정 위젯을 반환

      for(TickleTodayRes futureRes in ticklesList as List<TickleTodayRes>) {
        tickleList.add(SizedBox(height: 20,));
        tickleList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(futureRes.emoji, style: TextStyle(fontSize: 20,),),
            Column(
              children: [
                Text(futureRes.habitName, style: TextStyle(fontSize: 15,),),
                SizedBox(height: 5,),
                Text(futureRes.executionTime, style: TextStyle(fontSize: 10, color: TTTGrey),),
              ],
            ),
            GetBuilder<ThemeController>(
                builder: (_) {
                  return Text('커밍순!', style: TextStyle(fontSize: 15, color: TTTGrey),);
                }
            ),
          ],
        ));
      }
    }

    return tickleList;
  }

  buildTickleListCart(String category, DateTime selectedDateTime, List<Object> ticklesList) {
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
          children: buildTickleListTile(category, selectedDateTime, ticklesList),
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

  Future<http.Response> makeSchedule(String strDate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('${ServerUrl}/tickle/schedule?targetDate=$strDate');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accesstoken' :  accessToken,

      },
    );
    return response;
  }

  Future<List<TickleCategoryRes>> getSchedule(String strDate) async {
    final response = await makeSchedule(strDate);
    List<TickleCategoryRes> tickleList = [];

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      tickleList = List<TickleCategoryRes>.from(data.map((item) => TickleCategoryRes.fromJson(item)));

      for(int i=0;i<tickleList.length;i++){
        List<TickleTodayRes> convertedTickles = tickleList[i].tickles.map((item) => item as TickleTodayRes).toList();
        for(int j=0;j<convertedTickles.length;j++){
          convertedTickles[j].habitName = utf8.decode(convertedTickles[j].habitName.runes.toList());
        }
      }


    } else if(response.statusCode == 401){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refreshToken = pref.getString('refreshToken')!;
      String accessToken = pref.getString('accessToken')!;
      var url = Uri.parse('${ServerUrl}/tickle/past?targetDate=$strDate');
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
      tickleList = List<TickleCategoryRes>.from(data.map((item) => TickleCategoryRes.fromJson(item)));

    } else {
      print('Login failed with status: ${response.statusCode}');
    }
    return tickleList;
  }


  Future<http.Response> pastSchedule(String strDate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('${ServerUrl}/tickle/past?targetDate=$strDate');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accesstoken' :  accessToken,

      },
    );
    return response;
  }

  Future<List<TickleCategoryPastRes>> getPastSchedule(String strDate) async {
    final response = await pastSchedule(strDate);
    List<TickleCategoryPastRes> tickleList = [];

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      tickleList = List<TickleCategoryPastRes>.from(data.map((item) => TickleCategoryPastRes.fromJson(item)));

      for(int i=0;i<tickleList.length;i++){
        List<TicklePastRes> convertedTickles = tickleList[i].tickles.map((item) => item as TicklePastRes).toList();
        for(int j=0;j<convertedTickles.length;j++){
          convertedTickles[j].habitName = utf8.decode(convertedTickles[j].habitName.runes.toList());
        }
      }


    } else if(response.statusCode == 401){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refreshToken = pref.getString('refreshToken')!;
      String accessToken = pref.getString('accessToken')!;
      var url = Uri.parse('${ServerUrl}/tickle/past?targetDate=$strDate');
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
      tickleList = List<TickleCategoryPastRes>.from(data.map((item) => TickleCategoryPastRes.fromJson(item)));

    } else {
      print('Login failed with status: ${response.statusCode}');
    }
    return tickleList;
  }






  Future<http.Response> RemoveHabit (int habitId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('${ServerUrl}/habit/quit/{$habitId}');

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accesstoken' :  accessToken,
      },
    );
    return response;
  }

  Future<void> sendRemoveHabit(int habitId) async {

    final response = await RemoveHabit(habitId);

    if (response.statusCode == 200) {
      print('삭제');
    }else if(response.statusCode == 401){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refreshToken = pref.getString('refreshToken')!;
      String accessToken = pref.getString('accessToken')!;
      var url = Uri.parse('${ServerUrl}/habit/quit/{$habitId}');
      var response = await http.patch(
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

    }else print('Login failed with status: ${response.statusCode}');
  }


  Future<http.Response> sendTickle(TickleReq tickleReq) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('${ServerUrl}/tickle');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accesstoken' :  accessToken,
      },
      body: json.encode(tickleReq.toJson()),
    );
    return response;
  }

  Future<void> createTickle(TickleReq tickleReq) async {

    final response = await sendTickle(tickleReq);

    if (response.statusCode == 200) {
      print('성공했지로옹');
    }else if(response.statusCode == 401){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refreshToken = pref.getString('refreshToken')!;
      String accessToken = pref.getString('accessToken')!;
      var url = Uri.parse('${ServerUrl}/tickle');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accesstoken' : accessToken,
          'refreshtoken' :  refreshToken,
        },
        body: json.encode(tickleReq.toJson()),
      );
      final headers = response.headers;
      final accesstoken = headers['accesstoken'];
      final refreshtoken = headers['refreshtoken'];
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('accessToken', accesstoken!);
      sharedPreferences.setString('refreshToken', refreshtoken!);
    }else print('Login failed with status: ${response.statusCode}');

  }

  Future<http.Response> deleteSendTickle(TickleReq tickleReq) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('${ServerUrl}/tickle/delete');

    var response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accesstoken' :  accessToken,
      },
      body: json.encode(tickleReq.toJson()),
    );
    return response;
  }

  Future<void> deleteTickle(TickleReq tickleReq) async {

    final response = await deleteSendTickle(tickleReq);

    if (response.statusCode == 200) {
      print('삭제 성공했지로옹');
    }else if(response.statusCode == 401){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refreshToken = pref.getString('refreshToken')!;
      String accessToken = pref.getString('accessToken')!;
      var url = Uri.parse('${ServerUrl}/tickle/delete');
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accesstoken' : accessToken,
          'refreshtoken' :  refreshToken,
        },
        body: json.encode(tickleReq.toJson()),
      );
      final headers = response.headers;
      final accesstoken = headers['accesstoken'];
      final refreshtoken = headers['refreshtoken'];
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('accessToken', accesstoken!);
      sharedPreferences.setString('refreshToken', refreshtoken!);
    }else print('Login failed with status: ${response.statusCode}');

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    String strSelectedDate = _selectedDay!.year.toString() + _selectedDay!.month.toString().padLeft(2, '0') + _selectedDay!.day.toString().padLeft(2, '0');
    bool isCurrentOrFuture = false;
    if(isSameDay(_selectedDay, DateTime.now()) || _selectedDay!.compareTo(DateTime.now()) == 1) {
      isCurrentOrFuture = true;
    }

    return GetBuilder<PageChangeController>(
      builder: (_) {
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
                                      // postDeviceToken();
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
                  isCurrentOrFuture ? FutureBuilder(
                    future: getSchedule(strSelectedDate),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if(snapshot.hasError) {
                        return Container();
                      }

                      List<TickleCategoryRes>? listAlltickle = snapshot.data;
                      if(listAlltickle == null) {
                        return Container();
                      }

                      List<List<TickleTodayRes>> ticklesList = [];

                      for(TickleCategoryRes tickles in listAlltickle) {
                        ticklesList.add(tickles.tickles);
                      }

                      return Column(
                        children: [
                          ticklesList[0].length == 0 ? Container() : buildTickleListCart('금전', _selectedDay!, ticklesList[0]),
                          ticklesList[1].length == 0 ? Container() : buildTickleListCart('운동', _selectedDay!, ticklesList[1]),
                          ticklesList[2].length == 0 ? Container() : buildTickleListCart('학습', _selectedDay!, ticklesList[2]),
                          ticklesList[3].length == 0 ? Container() : buildTickleListCart('관계', _selectedDay!, ticklesList[3]),
                          ticklesList[4].length == 0 ? Container() : buildTickleListCart('생활', _selectedDay!, ticklesList[4]),
                          ticklesList[5].length == 0 ? Container() : buildTickleListCart('기타', _selectedDay!, ticklesList[5]),
                        ],
                      );
                    }
                  ) : FutureBuilder(
                    future: getPastSchedule(strSelectedDate),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if(snapshot.hasError) {
                        return Container();
                      }

                      List<TickleCategoryPastRes>? listAlltickle = snapshot.data;
                      if(listAlltickle == null) {
                        return Container();
                      }

                      List<List<TicklePastRes>> ticklesList = [];

                      for(TickleCategoryPastRes tickles in listAlltickle) {
                        ticklesList.add(tickles.tickles);
                      }

                      return Column(
                        children: [
                          ticklesList[0].length == 0 ? Container() : buildTickleListCart('금전', _selectedDay!, ticklesList[0]),
                          ticklesList[1].length == 0 ? Container() : buildTickleListCart('운동', _selectedDay!, ticklesList[1]),
                          ticklesList[2].length == 0 ? Container() : buildTickleListCart('학습', _selectedDay!, ticklesList[2]),
                          ticklesList[3].length == 0 ? Container() : buildTickleListCart('관계', _selectedDay!, ticklesList[3]),
                          ticklesList[4].length == 0 ? Container() : buildTickleListCart('생활', _selectedDay!, ticklesList[4]),
                          ticklesList[5].length == 0 ? Container() : buildTickleListCart('기타', _selectedDay!, ticklesList[5]),
                        ],
                      );

                    },
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          ),
        );
      }
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