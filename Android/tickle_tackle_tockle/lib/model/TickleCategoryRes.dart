import 'TickleTodayRes.dart';

class TickleCategoryRes {
  int categoryId;
  String categoryName;
  List<TickleTodayRes> tickles;

  TickleCategoryRes({
    required this.categoryId,
    required this.categoryName,
    required this.tickles,
  });

  factory TickleCategoryRes.fromJson(Map<String, dynamic> json) {
    return TickleCategoryRes(
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      tickles: List<TickleTodayRes>.from(json['tickles'].map((item) => TickleTodayRes.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['tickles'] = tickles.map((item) => item.toJson()).toList();
    return data;
  }
}