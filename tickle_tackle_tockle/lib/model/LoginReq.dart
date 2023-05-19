class LoginReq {
  String idToken;

  LoginReq({required this.idToken});

  factory LoginReq.fromJson(Map<String, dynamic> json) {
    return LoginReq(idToken: json['idToken'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idToken'] = idToken;
    return data;
  }
}