class ProfileModel {
  UserData? userData;
  Wallet? wallet;
  BankDetail? bankDetail;

  ProfileModel({this.userData, this.wallet, this.bankDetail});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
    wallet =
    json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    bankDetail = json['bank_detail'] != null
        ? BankDetail.fromJson(json['bank_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    if (bankDetail != null) {
      data['bank_detail'] = bankDetail!.toJson();
    }
    return data;
  }
}

class UserData {
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
  String? tpinRequest;
  int? transactionid;
  String? paymentStatus;
  int? plan;
  String? accountNumber;
  String? accountHolderName;
  String? ifscCode;
  String? status;
  String? totalMember;
  double? paidAmount;
  String? paymentDate;
  String? datecreated;
  String? dateupdated;

  UserData(
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
        this.tpinRequest,
        this.transactionid,
        this.paymentStatus,
        this.plan,
        this.accountNumber,
        this.accountHolderName,
        this.ifscCode,
        this.status,
        this.totalMember,
        this.paidAmount,
        this.paymentDate,
        this.datecreated,
        this.dateupdated});

  UserData.fromJson(Map<String, dynamic> json) {
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
    tpinRequest = json['tpin_request'];
    transactionid = json['transactionid'];
    paymentStatus = json['payment_status'];
    plan = json['plan'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
    ifscCode = json['ifsc_code'];
    status = json['status'];
    totalMember = json['total_member'];
    paidAmount = json['paid_amount'];
    paymentDate = json['payment_date'];
    datecreated = json['datecreated'];
    dateupdated = json['dateupdated'];
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
    data['tpin_request'] = tpinRequest;
    data['transactionid'] = transactionid;
    data['payment_status'] = paymentStatus;
    data['plan'] = plan;
    data['account_number'] = accountNumber;
    data['account_holder_name'] = accountHolderName;
    data['ifsc_code'] = ifscCode;
    data['status'] = status;
    data['total_member'] = totalMember;
    data['paid_amount'] = paidAmount;
    data['payment_date'] = paymentDate;
    data['datecreated'] = datecreated;
    data['dateupdated'] = dateupdated;
    return data;
  }
}

class Wallet {
  int? totalEarning;
  String? personalEarning;
  String? teamEarning;
  String? otherEarning;

  Wallet(
      {this.totalEarning,
        this.personalEarning,
        this.teamEarning,
        this.otherEarning});

  Wallet.fromJson(Map<String, dynamic> json) {
    totalEarning = json['total_earning'];
    personalEarning = json['personal_earning'];
    teamEarning = json['team_earning'];
    otherEarning = json['other_earning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_earning'] = totalEarning;
    data['personal_earning'] = personalEarning;
    data['team_earning'] = teamEarning;
    data['other_earning'] = otherEarning;
    return data;
  }
}

class BankDetail {
  String? accountNumber;
  String? accountHolderName;
  String? ifscCode;

  BankDetail({this.accountNumber, this.accountHolderName, this.ifscCode});

  BankDetail.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_number'] = accountNumber;
    data['account_holder_name'] = accountHolderName;
    data['ifsc_code'] = ifscCode;
    return data;
  }
}