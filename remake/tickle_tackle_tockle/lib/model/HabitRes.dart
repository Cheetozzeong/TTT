import 'dart:convert';

class HabitRes {
  int id; // 생성 req면 0으로 올거고
  int categoryId;
  String name;
  String emoji;
  String startTime;
  String endTime;
  String term;
  String repeatDay;
  int tickleCount;

  HabitRes({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.emoji,
    required this.startTime,
    required this.endTime,
    required this.term,
    required this.repeatDay,
    required this.tickleCount,
  });

  factory HabitRes.fromJson(Map<String, dynamic> json) {
    return HabitRes(
      id: json['id'] as int,
      categoryId: json['categoryId'] as int,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      term: json['term'] as String,
      repeatDay: json['repeatDay'] as String,
        tickleCount: json['tickleCount'] as int,
    );
  }
}
List<HabitRes> parseHabitList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<HabitRes>((json) => HabitRes.fromJson(json))
      .toList();
}

