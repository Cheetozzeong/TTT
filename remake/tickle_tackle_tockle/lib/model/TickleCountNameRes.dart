import 'dart:convert';

class TickleCountNameRes {
  int categoryId;
  String categoryName;
  int count;

  TickleCountNameRes({
    required this.categoryId,
    required this.categoryName,
    required this.count,
  });

  factory TickleCountNameRes.fromJson(Map<String, dynamic> json) {
    return TickleCountNameRes(
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      count: json['count'] as int,
    );
  }
}

List<TickleCountNameRes> parseTickleCountNameResList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<TickleCountNameRes>((json) => TickleCountNameRes.fromJson(json))
      .toList();
}