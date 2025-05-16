import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mal/Models/outside_loan_model.dart';
import 'package:mal/providers/coin_loan_provider.dart';
import 'package:provider/provider.dart';


class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key});

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OutsideLoanModel>?>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (snapshot.hasData) {
          final loans = snapshot.data!;
          return ListView.builder(
            itemCount: loans.length,
            itemBuilder: (context, index) {
              final loan = loans[index];
              return ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text(loan.giversName),
                  subtitle: Text(loan.takenDate),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$ ${loan.amount}",
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        "(${loan.interest})",
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                      ),
                    ],
                  ));
            },
          );
        } else {
          return const Center(
            child: Text("Issue"),
          );
        }
      }, future: context.read<CoinLoanProvider>().getCoinLoans(),
    );
  }
}
