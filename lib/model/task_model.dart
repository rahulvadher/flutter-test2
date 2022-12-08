class TaskModel {
  List<Data>? data;

  TaskModel({this.data});

  TaskModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? image;
  String? startTime;
  String? endTime;
  String? status;
  String? datecreated;
  String? dateupdated;
  String? imageMin;

  Data(
      {this.id,
        this.name,
        this.image,
        this.startTime,
        this.endTime,
        this.status,
        this.datecreated,
        this.dateupdated,
        this.imageMin});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    datecreated = json['datecreated'];
    dateupdated = json['dateupdated'];
    imageMin = json['image_min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['datecreated'] = datecreated;
    data['dateupdated'] = dateupdated;
    data['image_min'] = imageMin;
    return data;
  }
}