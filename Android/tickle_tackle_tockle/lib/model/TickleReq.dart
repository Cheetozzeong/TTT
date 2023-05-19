class TickleReq {
  int habitId;
  String executionDay;
  String executionTime;


  TickleReq({
    required this.habitId,
    required this.executionDay,
    required this.executionTime,

  });

  factory TickleReq.fromJson(Map<String, dynamic> json) {
    return TickleReq(
      habitId: json['habitId'] as int,
      executionDay: json['executionDay'] as String,
      executionTime: json['executionTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['habitId'] = habitId;
    data['executionDay'] = executionDay;
    data['executionTime'] = executionTime;

    return data;
  }
}