import 'package:flutter/material.dart';
import 'package:mal/Models/bank_loan_model.dart';
import 'package:dio/dio.dart';
import 'package:mal/utills/app_urls.dart';

class BankLoanProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  double _banktotal = 0;
  double _bankinterest = 0;
  double _bankamount = 0;
  final String _bankUrl = "${AppUrls.prodBaseUrl}/bank-loans";
  final _option = Options(headers: {'Content-Type': 'application/json'});

  double get bankTotal => _banktotal;
  double get bankAmount => _bankamount;
  double get bankInterest => _bankinterest;

  Future<List<BankLoanModel>> getBankLoans() async {
    final url = "$_bankUrl/68222ecee4d5d1d8d99e94fe";
    try {
      final response = await _dio.get(url, options: _option);
      if (response.statusCode == 200) {
        final List<dynamic> body = response.data;
        final results =
            body.map((item) => BankLoanModel.fromJson(item)).toList();
        if (results.isNotEmpty) {
          _bankamount = results.fold(0, (i, j) => (i + j.amount));
          _bankinterest = results.fold(0, (i, j) => (i + j.interest!));
          _banktotal = _bankamount + _bankinterest;
        }
        return results;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> addBankLoan(BankLoanModel loan) async {
    final Map<String, dynamic> payload = {
      "bank_name": loan.bankName,
      "amount": loan.amount,
      "loan_type": loan.loanType,
      "interest_rate": loan.interestRate,
      "loan_date": loan.loanDate,
      "description": loan.description ?? "",
      "user_id": loan.userId,
      "loan_holder": loan.loanHolder,
    };

    try {
      final response = await _dio.post(
        _bankUrl,
        data: payload,
        options: _option,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Bank loan added successfully');
      } else {
        debugPrint('Failed to add bank loan: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error adding bank loan: $e');
      throw Exception('Failed to add bank loan');
    }
  }
}
