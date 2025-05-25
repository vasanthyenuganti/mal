class BankLoanModel {
  final String? id;
  final String bankName;
  final double amount;
  final String loanType;
  final double interestRate;
  final String loanDate;
  final String? description;
  final String userId;
  final bool status;
  final double? interest;
  final String loanHolder;
  final DateTime? createdAt;

  BankLoanModel({
    this.id,
    required this.bankName,
    required this.amount,
    required this.loanType,
    required this.interestRate,
    required this.loanDate,
    this.description,
    required this.userId,
    required this.status,
    this.interest,
    required this.loanHolder,
    this.createdAt,
  });

  factory BankLoanModel.fromJson(Map<String, dynamic> json) {
    return BankLoanModel(
      id: json['_id'] as String?,
      bankName: json['bank_name'] as String,
      amount: (json['amount'] as num).toDouble(),
      loanType: json['loan_type'] as String,
      interestRate: (json['interest_rate'] as num).toDouble(),
      loanDate: json['loan_date'] as String,
      description: json['description'] as String?,
      userId: json['user_id'] as String,
      status: json['status'] as bool,
      interest:
          json['interest'] != null
              ? (json['interest'] as num).toDouble()
              : null,
      loanHolder: json['loan_holder'] as String,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
    );
  }
}
