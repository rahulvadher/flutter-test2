class AccountModel {
  Data? data;

  AccountModel({this.data});

  AccountModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? parentId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? dob;
  String? referralCode;
  String? dailyCode;
  String? username;
  String? password;
  String? tpin;
  double? transactionid;
  String? paymentStatus;
  double? plan;
  double? AccountModelNumber;
  double? AccountModelHolderName;
  double? ifscCode;
  dynamic status;
  String? totalMember;
  double? paidAmount;
  String? paymentDate;
  String? datecreated;
  String? dateupdated;
  String? message;

  Data(
      {this.id,
        this.parentId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.dob,
        this.referralCode,
        this.dailyCode,
        this.username,
        this.password,
        this.tpin,
        this.transactionid,
        this.paymentStatus,
        this.plan,
        this.AccountModelNumber,
        this.AccountModelHolderName,
        this.ifscCode,
        this.status,
        this.totalMember,
        this.paidAmount,
        this.paymentDate,
        this.datecreated,
        this.dateupdated,
        this.message,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    dob = json['dob'];
    referralCode = json['referral_code'];
    dailyCode = json['daily_code'];
    username = json['username'];
    password = json['password'];
    tpin = json['tpin'];
    transactionid = json['transactionid'];
    paymentStatus = json['payment_status'];
    plan = json['plan'];
    AccountModelNumber = json['AccountModel_number'];
    AccountModelHolderName = json['AccountModel_holder_name'];
    ifscCode = json['ifsc_code'];
    status = json['status'];
    totalMember = json['total_member'];
    paidAmount = json['paid_amount'];
    paymentDate = json['payment_date'];
    datecreated = json['datecreated'];
    dateupdated = json['dateupdated'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['dob'] = dob;
    data['referral_code'] = referralCode;
    data['daily_code'] = dailyCode;
    data['username'] = username;
    data['password'] = password;
    data['tpin'] = tpin;
    data['transactionid'] = transactionid;
    data['payment_status'] = paymentStatus;
    data['plan'] = plan;
    data['AccountModel_number'] = AccountModelNumber;
    data['AccountModel_holder_name'] = AccountModelHolderName;
    data['ifsc_code'] = ifscCode;
    data['status'] = status;
    data['total_member'] = totalMember;
    data['paid_amount'] = paidAmount;
    data['payment_date'] = paymentDate;
    data['datecreated'] = datecreated;
    data['dateupdated'] = dateupdated;
    data['message'] = message;
    return data;
  }
}