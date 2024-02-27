class PaymentMethod {
  int? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodTitle;
  String? paymentMethodType;
  int? paymentMethodStatus;
  int? paymentMethodEnvironment;
  int? paymentMethodDefault;

  PaymentMethod(
      {this.paymentMethodId,
        this.paymentMethodName,
        this.paymentMethodTitle,
        this.paymentMethodType,
        this.paymentMethodStatus,
        this.paymentMethodEnvironment,
        this.paymentMethodDefault});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['payment_method_id'];
    paymentMethodName = json['payment_method_name'];
    paymentMethodTitle = json['payment_method_title'];
    paymentMethodType = json['payment_method_type'];
    paymentMethodStatus = json['payment_method_status'];
    paymentMethodEnvironment = json['payment_method_environment'];
    paymentMethodDefault = json['payment_method_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method_id'] = this.paymentMethodId;
    data['payment_method_name'] = this.paymentMethodName;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['payment_method_type'] = this.paymentMethodType;
    data['payment_method_status'] = this.paymentMethodStatus;
    data['payment_method_environment'] = this.paymentMethodEnvironment;
    data['payment_method_default'] = this.paymentMethodDefault;
    return data;
  }
}