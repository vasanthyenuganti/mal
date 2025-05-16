import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mal/providers/bank_loan_provider.dart';
import 'package:mal/providers/coin_loan_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int? touchedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            _indications(),
            const SizedBox(
              height: 24,
            ),
            // _statsTileView(
            //     "Bank", context.read<BankLoanProvider>().getBankStats()),
            // const SizedBox(
            //   height: 24,
            // ),
            // _statsTileView(
            //     "Coin", context.read<CoinLoanProvider>().getCoinStats())
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getSections(
      double amount, double interest, double total) {
    return [
      PieChartSectionData(
        value: amount,
        color: Colors.blue,
        title: ((amount / total) * 100).toStringAsFixed(0),
        radius: 35,
        titleStyle: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: interest,
        color: Colors.red,
        title: ((interest / total) * 100).toStringAsFixed(0),
        radius: 35,
        titleStyle: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  Widget _statsTileView(String name, Stream<Map<String, num>> stream) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 12,
        ),
        _statsTitle(name),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          height: 100,
          width: 100,
          child: StreamBuilder<Map<String, num>>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Icon(Icons.error));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;
                return PieChart(
                  PieChartData(
                      sections: _getSections(
                          double.parse(data['amount']!.toStringAsFixed(2)),
                          double.parse(data['interest']!.toStringAsFixed(2)),
                          double.parse(data['total']!.toStringAsFixed(2))),
                      centerSpaceRadius: 35,
                      sectionsSpace: 2,
                      borderData: FlBorderData(show: false),
                      pieTouchData: PieTouchData(
                          enabled: true, touchCallback: (fl, pi) {})),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        name.toUpperCase() == "BANK" ? _bankChipStats() : _coinChipStats(),
        const SizedBox(
          width: 12,
        ),
      ],
    );
  }

  Widget _statsTitle(String title) {
    return RotatedBox(
      quarterTurns: 3,
      child: Text(
        title,
        style: const TextStyle(fontSize: 32, color: Colors.grey),
      ),
    );
  }

  Widget _bankChipStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Chip(
          avatar: const Icon(
            Icons.circle_rounded,
            color: Colors.blue,
          ),
          label: Consumer<BankLoanProvider>(
            builder: (context, value, child) => Text(
              value.bankAmount.toStringAsFixed(2),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        Chip(
          avatar: const Icon(
            Icons.circle_rounded,
            color: Colors.red,
          ),
          label: Consumer<BankLoanProvider>(
            builder: (context, value, child) => Text(
              value.bankInteresr.toStringAsFixed(2),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        Chip(
          avatar: const Icon(
            Icons.circle_rounded,
            color: Colors.grey,
          ),
          label: Consumer<BankLoanProvider>(
            builder: (context, value, child) => Text(
              value.bankTotal.toStringAsFixed(2),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          backgroundColor: Colors.transparent,
        )
      ],
    );
  }

  Widget _coinChipStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Chip(
          avatar: const Icon(
            Icons.circle_rounded,
            color: Colors.blue,
          ),
          label: Consumer<CoinLoanProvider>(
            builder: (context, value, child) => Text(
              value.coinAmount.toStringAsFixed(2),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        Chip(
          avatar: const Icon(
            Icons.circle_rounded,
            color: Colors.red,
          ),
          label: Consumer<CoinLoanProvider>(
            builder: (context, value, child) => Text(
              value.coinInterest.toStringAsFixed(2),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        Chip(
          avatar: const Icon(
            Icons.circle_rounded,
            color: Colors.grey,
          ),
          label: Consumer<CoinLoanProvider>(
            builder: (context, value, child) => Text(
              value.coinTotal.toStringAsFixed(2),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          backgroundColor: Colors.transparent,
        )
      ],
    );
  }

  Widget _indications() {
    return const SizedBox(
      height: 32,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Chip(
            avatar: Icon(
              Icons.circle_rounded,
              color: Colors.blue,
            ),
            label: Text(
              "Amount",
              style: TextStyle(fontSize: 15),
            ),
            backgroundColor: Colors.transparent,
          ),
          Chip(
            avatar: Icon(
              Icons.circle_rounded,
              color: Colors.red,
            ),
            label: Text(
              "Interest",
              style: TextStyle(fontSize: 15),
            ),
            backgroundColor: Colors.transparent,
          ),
          Chip(
            avatar: Icon(
              Icons.circle_rounded,
              color: Colors.grey,
            ),
            label: Text(
              "Total",
              style: TextStyle(fontSize: 15),
            ),
            backgroundColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}
