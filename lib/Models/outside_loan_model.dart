class OutsideLoanModel {
  final String id;
  final String giversName;
  final double amount;
  final double interestRate;
  final String takenDate;
  final bool status;
  final String description;
  final String userId;
  final double interest;
  final DateTime createdAt;

  OutsideLoanModel({
    required this.id,
    required this.giversName,
    required this.amount,
    required this.interestRate,
    required this.takenDate,
    required this.status,
    required this.description,
    required this.userId,
    required this.interest,
    required this.createdAt
  });

  factory OutsideLoanModel.fromJson(Map<String, dynamic> json) {
    return OutsideLoanModel(
      id: json['_id'] as String,
      giversName: json['givers_name'] as String,
      amount: (json['amount'] as num).toDouble(),
      interestRate: (json['interest_rate'] as num).toDouble(),
      takenDate: json['taken_date'] as String,
      status: json['status'] as bool,
      description: json['description'] as String,
      userId: json['user_id'] as String,
      interest: (json['interest'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'])
    );
  }
}
