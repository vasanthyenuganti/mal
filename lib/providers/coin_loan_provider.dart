import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mal/Models/outside_loan_model.dart';
import 'package:mal/utills/app_urls.dart';

class CoinLoanProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  double _cointotal = 0;
  double _coininterest = 0;
  double _coinamount = 0;
  final String _coinUrl = "${AppUrls.prodBaseUrl}/outside-loans";
  final _option = Options(headers: {'Content-Type': 'application/json'});

  double get coinTotal => _cointotal;
  double get coinAmount => _coinamount;
  double get coinInterest => _coininterest;

  Future<List<OutsideLoanModel>> getCoinLoans() async {
    final url = "$_coinUrl/68222ecee4d5d1d8d99e94fe";
    try {
      final response = await _dio.get(url, options: _option);
      if (response.statusCode == 200) {
        final List<dynamic> body = response.data;
        final results =
            body.map((item) => OutsideLoanModel.fromJson(item)).toList();
        if (results.isNotEmpty) {
          _coinamount = results.fold(0, (i, j) => (i + j.amount));
          _coininterest = results.fold(0, (i, j) => (i + j.interest!));
          _cointotal = _coinamount + _coininterest;
        }
        return results;
      }
      debugPrint(response.toString());
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<void> addCoinLoan(OutsideLoanModel loan) async {
    final Map<String, dynamic> payload = {
      "givers_name": loan.giversName,
      "amount": loan.amount,
      "interest_rate": loan.interestRate,
      "taken_date": loan.takenDate,
      "description": loan.description,
      "user_id": loan.userId,
    };

    try {
      final response = await _dio.post(
        _coinUrl,
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
