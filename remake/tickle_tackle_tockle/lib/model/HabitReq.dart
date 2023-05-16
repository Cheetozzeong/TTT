class HabitReq {
  int categoryId;
  String name;
  String emoji;
  String startTime;
  String endTime;
  String term;
  String repeatDay;

  HabitReq({
    required this.categoryId,
    required this.name,
    required this.emoji,
    required this.startTime,
    required this.endTime,
    required this.term,
    required this.repeatDay,
  });

  factory HabitReq.fromJson(Map<String, dynamic> json) {
    return HabitReq(
      categoryId: json['categoryId'] as int,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      term: json['term'] as String,
      repeatDay: json['repeatDay'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['name'] = name;
    data['emoji'] = emoji;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['term'] = term;
    data['repeatDay'] = repeatDay;
    return data;
  }
}