

import 'TicklePastRes.dart';

class TickleCategoryPastRes {
  int categoryId;
  String categoryName;
  List<TicklePastRes> tickles;

  TickleCategoryPastRes({
    required this.categoryId,
    required this.categoryName,
    required this.tickles,
  });

  factory TickleCategoryPastRes.fromJson(Map<String, dynamic> json) {
    return TickleCategoryPastRes(
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      tickles: List<TicklePastRes>.from(json['tickles'].map((item) => TicklePastRes.fromJson(item))),
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