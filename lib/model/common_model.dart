class CommonModel {
  Data? data;

  CommonModel({this.data});

  CommonModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? status;
  String? message,content;

  Data({this.status, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['content'] = content;
    return data;
  }
}