class UserSleepReq {
  String sleepStartTime;
  String sleepEndTime;

  UserSleepReq({required this.sleepStartTime, required this.sleepEndTime});

  factory UserSleepReq.fromJson(Map<String, dynamic> json) {
    return UserSleepReq(
      sleepStartTime: json['sleepStartTime'] as String,
      sleepEndTime: json['sleepEndTime'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'sleepStartTime': sleepStartTime,
      'sleepEndTime': sleepEndTime,
    };
  }
}