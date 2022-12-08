class MemberModel {
  Data? data;

  MemberModel({this.data});

  MemberModel.fromJson(Map<String, dynamic> json) {
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
  String? companyTatistics;
  String? joiningDate;
  String? totalMember;
  String? totalActiveMember;

  Data(
      {this.companyTatistics,
        this.joiningDate,
        this.totalMember,
        this.totalActiveMember});

  Data.fromJson(Map<String, dynamic> json) {
    companyTatistics = json['company_tatistics'];
    joiningDate = json['joining_date'];
    totalMember = json['total_member'];
    totalActiveMember = json['total_active_member'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_tatistics'] = companyTatistics;
    data['joining_date'] = joiningDate;
    data['total_member'] = totalMember;
    data['total_active_member'] = totalActiveMember;
    return data;
  }
}

