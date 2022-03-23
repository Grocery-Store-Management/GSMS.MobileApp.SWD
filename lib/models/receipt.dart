class Receipt {
  String? id;
  String? customerId;
  String? employeeId;
  String? storeId;
  String? createdDate;
  bool? isDeleted;

  Receipt(
      {this.id,
        this.customerId,
        this.employeeId,
        this.storeId,
        this.createdDate,
        this.isDeleted,});

  Receipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    employeeId = json['employeeId'];
    storeId = json['storeId'];
    createdDate = json['createdDate'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['employeeId'] = this.employeeId;
    data['storeId'] = this.storeId;
    data['createdDate'] = this.createdDate;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}