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
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasData) {
          final loans = snapshot.data!;
          return ListView.separated(
            itemCount: loans.length,
            itemBuilder: (context, index) {
              final loan = loans[index];
              return ListTile(
                onTap: () {
                  showCoinDetailsBottomSheet(context, loan);
                },
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(
                  loan.giversName,
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  loan.takenDate,
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$ ${loan.amount}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      "(${loan.interest})",
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
          );
        } else {
          return const Center(child: Text("Issue"));
        }
      },
      future: context.read<CoinLoanProvider>().getCoinLoans(),
    );
  }

  void showCoinDetailsBottomSheet(BuildContext context, OutsideLoanModel loan) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AppBar(
                leadingWidth: 0,
                centerTitle: false,
                backgroundColor: Colors.transparent,
                // leading: Icon(Icons.near_me),
                automaticallyImplyLeading: false,
                title: const Text(
                  "Coin Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  CupertinoSwitch(value: loan.status, onChanged: (val) {}),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    color: Colors.black,
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    color: Colors.red,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
              // ListTile(
              //   minLeadingWidth: 0,
              //   leading: Icon(Icons.near_me),
              //   title: const Text(
              //     "Coin Details",
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   visualDensity: VisualDensity(vertical: -4, horizontal: -4),
              //   trailing: IconButton(
              //     onPressed: () {},
              //     icon: const Icon(Icons.edit_outlined),
              //   ),
              // ),
              const SizedBox(height: 8),
              buildDetailRow("Giver Name", loan.giversName),
              buildDetailRow("Amount", "\$${loan.amount}"),
              buildDetailRow("Interest Rate", "${loan.interestRate}%"),
              buildDetailRow("Loan Date", loan.takenDate),
              buildDetailRow("Description", loan.description ?? "None"),
              buildDetailRow("Status", loan.status ? "Active" : "Inactive"),
              const SizedBox(height: 16),
              const Divider(thickness: 2, height: 2),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${double.parse(loan.amount.toString())} + ${double.parse(loan.interest.toString()).toStringAsFixed(0)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "= ${double.parse(loan.amount.toString()) + double.parse(loan.interest.toString())}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              // const SizedBox(height: 16),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: ElevatedButton(
              //     onPressed: () => Navigator.pop(context),
              //     child: const Text("Close"),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: Text("$title :")),
          Expanded(flex: 7, child: Text(value)),
        ],
      ),
    );
  }
}
