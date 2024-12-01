class OrderObject {
  final String id;
  // Client Details
  final String clientName;
  final String clientGender;
  final String clientAddress;
  final int clientPhoneNumber;

  // Cloth Details
  final String clothId;
  final String clothCategoryId;
  final String? clothPic;
  final String? clothCategoryPic;

  // Delivery and Measurement Details
  final bool markUrgent;
  final bool measurementDressGiven;
  final String deliveryDate;
  final String reminderDate;

  // Upper Measurements
  final double upperLength;
  final double shoulder;
  final double chest;
  final double upperWaist;
  final double upperHip;
  final double gher;
  final double armLength;
  final String armLengthType;
  final double aroundArm;
  final double wrist;
  final double collarFront;
  final double collarBack;

  // Lower Measurements
  final double lowerLength;
  final double lowerWaist;
  final double lowerHip;
  final double aroundLeg;
  final double mori;

  // Payment Status
  final double totalAmount;
  final double advancedAmount;
  final double dueAmount;

  // Special Instructions
  final String? specialInstruction;

  // Constructor
  OrderObject({
    required this.id,
    required this.clientName,
    required this.clientGender,
    required this.clientAddress,
    required this.clientPhoneNumber,
    required this.clothId,
    required this.clothCategoryId,
    this.clothPic,
    this.clothCategoryPic,
    required this.markUrgent,
    required this.measurementDressGiven,
    required this.deliveryDate,
    required this.reminderDate,
    required this.upperLength,
    required this.shoulder,
    required this.chest,
    required this.upperWaist,
    required this.upperHip,
    required this.gher,
    required this.armLength,
    required this.armLengthType,
    required this.aroundArm,
    required this.wrist,
    required this.collarFront,
    required this.collarBack,
    required this.lowerLength,
    required this.lowerWaist,
    required this.lowerHip,
    required this.aroundLeg,
    required this.mori,
    required this.totalAmount,
    required this.advancedAmount,
    required this.dueAmount,
    this.specialInstruction,
  });

  // Method to display the object as a map (useful for JSON conversion)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_name': clientName,
      'client_gender': clientGender,
      'client_address': clientAddress,
      'client_phone_number': clientPhoneNumber,
      'cloth_id': clothId,
      'cloth_category_id': clothCategoryId,
      'cloth_pic': clothPic,
      'cloth_category_pic': clothCategoryPic,
      'mark_urgent': markUrgent,
      'measurement_dress_given': measurementDressGiven,
      'delivery_date': deliveryDate,
      'reminder_date': reminderDate,
      'upper_length': upperLength,
      'shoulder': shoulder,
      'chest': chest,
      'upper_waist': upperWaist,
      'upper_hip': upperHip,
      'gher': gher,
      'arm_length': armLength,
      'arm_length_type': armLengthType,
      'around_arm': aroundArm,
      'wrist': wrist,
      'collar_front': collarFront,
      'collar_back': collarBack,
      'lower_length': lowerLength,
      'lower_waist': lowerWaist,
      'lower_hip': lowerHip,
      'around_leg': aroundLeg,
      'mori': mori,
      'total_amount': totalAmount,
      'advanced_amount': advancedAmount,
      'due_amount': dueAmount,
      'special_instruction': specialInstruction,
    };
  }

  // Factory method to create an object from JSON
  factory OrderObject.fromJson(Map<String, dynamic> json) {
    return OrderObject(
      id: json['id'],
      clientName: json['client_name'],
      clientGender: json['client_gender'],
      clientAddress: json['client_address'],
      clientPhoneNumber: json['client_phone_number'],
      clothId: json['cloth_id'],
      clothCategoryId: json['cloth_category_id'],
      clothPic: json['cloth_pic'],
      clothCategoryPic: json['cloth_category_pic'],
      markUrgent: json['mark_urgent'],
      measurementDressGiven: json['measurement_dress_given'],
      deliveryDate: json['delivery_date'],
      reminderDate: json['reminder_date'],
      upperLength: json['upper_length'].toDouble(),
      shoulder: json['shoulder'].toDouble(),
      chest: json['chest'].toDouble(),
      upperWaist: json['upper_waist'].toDouble(),
      upperHip: json['upper_hip'].toDouble(),
      gher: json['gher'].toDouble(),
      armLength: json['arm_length'].toDouble(),
      armLengthType: json['arm_length_type'],
      aroundArm: json['around_arm'].toDouble(),
      wrist: json['wrist'].toDouble(),
      collarFront: json['collar_front'].toDouble(),
      collarBack: json['collar_back'].toDouble(),
      lowerLength: json['lower_length'].toDouble(),
      lowerWaist: json['lower_waist'].toDouble(),
      lowerHip: json['lower_hip'].toDouble(),
      aroundLeg: json['around_leg'].toDouble(),
      mori: json['mori'].toDouble(),
      totalAmount: json['total_amount'].toDouble(),
      advancedAmount: json['advanced_amount'].toDouble(),
      dueAmount: json['due_amount'].toDouble(),
      specialInstruction: json['special_instruction'],
    );
  }
}
