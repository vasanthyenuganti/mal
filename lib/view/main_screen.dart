// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:mal/providers/bank_loan_provider.dart';
import 'package:mal/providers/coin_loan_provider.dart';
import 'package:mal/view/add_bank_loan.dart';
import 'package:mal/view/add_coin.dart';
import 'package:mal/view/bank_screen.dart';
import 'package:mal/view/coin_screen.dart';
import 'package:mal/view/dashboard_screen.dart';
import 'package:mal/view/auth/login_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = const [
    DashboardScreen(),
    BankScreen(),
    CoinScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _currentIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Monitor Assets & Liabilities"),
          actions: [
            IconButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                icon: const Icon(Icons.settings_outlined))
          ],
          bottom: TabBar(
              onTap: (i) {
                setState(() {
                  _currentIndex = i;
                });
              },
              indicatorWeight: 5,
              tabs: const [
                Tab(
                  icon: Icon(Icons.dashboard_outlined),
                  text: "Dashboard",
                ),
                Tab(
                  icon: Icon(Icons.account_balance_outlined),
                  text: "Bank",
                ),
                Tab(
                  icon: Icon(Icons.monetization_on_outlined),
                  text: "Coin",
                ),
              ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_currentIndex == 0) {
              updateHomeWidget();
            }
            if (_currentIndex == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddLoanRecordScreen()));
            }
            if (_currentIndex == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddCoinRecordScreen()));
            }
          },
          child: Icon(_currentIndex == 0 ? Icons.widgets_outlined : Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Chip(
                avatar: const Icon(
                  Icons.circle_rounded,
                  color: Colors.blue,
                ),
                label: Consumer2<BankLoanProvider, CoinLoanProvider>(
                    builder: (context, value, value2, child) => Text(
                        _currentIndex == 0
                            ? (value.bankAmount + value2.coinAmount)
                                .toStringAsFixed(2)
                            : _currentIndex == 1
                                ? (value.bankAmount).toStringAsFixed(2)
                                : (value2.coinAmount).toStringAsFixed(2))),
                backgroundColor: Colors.transparent,
              ),
              Chip(
                avatar: const Icon(
                  Icons.circle_rounded,
                  color: Colors.red,
                ),
                label: Consumer2<BankLoanProvider, CoinLoanProvider>(
                    builder: (context, value, value2, child) => Text(
                        _currentIndex == 0
                            ? (value.bankInteresr + value2.coinInterest)
                                .toStringAsFixed(2)
                            : _currentIndex == 1
                                ? (value.bankInteresr).toStringAsFixed(2)
                                : (value2.coinInterest).toStringAsFixed(2))),
                backgroundColor: Colors.transparent,
              ),
              Chip(
                avatar: const Icon(
                  Icons.circle_rounded,
                  color: Colors.grey,
                ),
                label: Consumer2<BankLoanProvider, CoinLoanProvider>(
                    builder: (context, value, value2, child) => Text(
                        _currentIndex == 0
                            ? (value.bankTotal + value2.coinTotal)
                                .toStringAsFixed(2)
                            : _currentIndex == 1
                                ? (value.bankTotal).toStringAsFixed(2)
                                : (value2.coinTotal).toStringAsFixed(2))),
                backgroundColor: Colors.transparent,
              )
            ],
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _tabs,
        ),
      ),
    );
  }

  void updateHomeWidget() {
    final bank = Provider.of<BankLoanProvider>(context, listen: false);
    final coin = Provider.of<CoinLoanProvider>(context, listen: false);
    HomeWidget.saveWidgetData<String>(
        'appwidget_text', (bank.bankTotal + coin.coinTotal).toStringAsFixed(0));
    HomeWidget.updateWidget(
      androidName: "MalHomeWidget",
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text(
                      'vasanthyenuganti',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  // ListTile(
                  //     leading: const Icon(Icons.brightness_6),
                  //     title: const Text('Switch Theme'),
                  //     trailing: Consumer<ThemeProvider>(
                  //       builder: (context, value, child) => CupertinoSwitch(
                  //         value: value.isDarkTheme,
                  //         onChanged: (value) {
                  //           context.read<ThemeProvider>().toggleTheme();
                  //         },
                  //       ),
                  //     )),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () async {
                      // await Supabase.instance.client.auth
                      //     .signOut(scope: SignOutScope.local);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
