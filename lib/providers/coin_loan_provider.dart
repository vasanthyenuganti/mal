import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mal/Models/outside_loan_model.dart';

class CoinLoanProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final double _cointotal = 0;
  final double _coininterest = 0;
  final double _coinamount = 0;

  double get coinTotal => _cointotal;
  double get coinAmount => _coinamount;
  double get coinInterest => _coininterest;


  Future<List<OutsideLoanModel>?> getCoinLoans() async {
    final url =
        "${dotenv.env["SUPABASE_PRO_URL"]!}/outside-loans/68222ecee4d5d1d8d99e94fe";
    try {
      final response = await _dio.get(url);
      final List<dynamic> body = response.data;
      final results = body.map((item) => OutsideLoanModel.fromJson(item)).toList();
      return results;
    } catch (e) {
      return [];
    }
  }

}
