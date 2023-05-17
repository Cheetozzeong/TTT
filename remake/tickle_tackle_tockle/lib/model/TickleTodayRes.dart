class TickleTodayRes {
  bool achieved;
  int habitId;
  String habitName;
  String executionTime;
  String emoji;

  TickleTodayRes({
    required this.achieved,
    required this.habitId,
    required this.habitName,
    required this.executionTime,
    required this.emoji,
  });

  factory TickleTodayRes.fromJson(Map<String, dynamic> json) {
    return TickleTodayRes(
      achieved: json['achieved'] as bool,
      habitId: json['habitId'] as int,
      habitName: json['habitName'] as String,
      executionTime: json['executionTime'] as String,
      emoji: json['emoji'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'achieved': achieved,
      'habitId': habitId,
      'habitName': habitName,
      'executionTime': executionTime,
      'emoji': emoji,
    };
    return data;
  }
}