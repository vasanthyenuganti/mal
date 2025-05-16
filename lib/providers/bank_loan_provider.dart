import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mal/Models/bank_loan_model.dart';
import 'package:dio/dio.dart';

class BankLoanProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final double _banktotal = 0;
  final double _bankinterest = 0;
  final double _bankamount = 0;

  double get bankTotal => _banktotal;
  double get bankAmount => _bankamount;
  double get bankInteresr => _bankinterest;

  Future<List<BankLoanModel>?> getBankLoans() async {
    final url =
        "${dotenv.env["SUPABASE_PRO_URL"]!}/bank-loans/68222ecee4d5d1d8d99e94fe";
    try {
      final response = await _dio.get(url);
      final List<dynamic> body = response.data;
      final results = body.map((item) => BankLoanModel.fromJson(item)).toList();
      return results;
    } catch (e) {
      return [];
    }
  }
}
