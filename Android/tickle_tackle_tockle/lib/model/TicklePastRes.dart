class TicklePastRes {
  String habitName;
  String executionTime;
  String emoji;


  TicklePastRes({
    required this.habitName,
    required this.executionTime,
    required this.emoji,

  });

  factory TicklePastRes.fromJson(Map<String, dynamic> json) {
    return TicklePastRes(
      habitName: json['habitName'] as String,
      executionTime: json['executionTime'] as String,
      emoji: json['emoji'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['habitName'] = habitName;
    data['executionTime'] = executionTime;
    data['emoji'] = emoji;

    return data;
  }
}