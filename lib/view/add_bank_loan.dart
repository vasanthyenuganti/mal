// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddLoanRecordScreen extends StatefulWidget {
  const AddLoanRecordScreen({super.key});

  @override
  _AddLoanRecordScreenState createState() => _AddLoanRecordScreenState();
}

class _AddLoanRecordScreenState extends State<AddLoanRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _loanTypeController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _loanDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _holderNameController = TextEditingController();
  bool _isLoading = false;

  final List<String> _loanTypes = [
    'Home Loan',
    'Personal Loan',
    'Car Loan',
    'Education Loan',
    'Business Loan',
    'Gold Loan',
    'Mortgage Loan',
    'Consumer Loan',
    'Agricultural Loan',
    'Two-Wheeler Loan',
    'Loan Against Property',
    'Small Loan',
    'Cash Credit Loan',
    'Vehicle Loan',
    'Startup Loan',
  ];

  final List<String> _bankNames = [
    'State Bank of India',
    'HDFC Bank',
    'ICICI Bank',
    'Punjab National Bank',
    'Axis Bank',
    'Bank of Baroda',
    'Kotak Mahindra Bank',
    'Canara Bank',
    'Bank of India',
    'Union Bank of India',
    'IndusInd Bank',
    'IDFC First Bank',
    'YES Bank',
    'Federal Bank',
    'RBL Bank',
    'South Indian Bank',
    'Central Bank of India',
    'Bank of Maharashtra',
    'Indian Bank',
    'Bajaj Finserv',
    'Shivalik Mercantile Co-Op Bank',
    'Tamilnad Mercantile Bank',
    'IDBI Bank',
    'Corporation Bank',
    'Dena Bank',
    'Vijaya Bank',
    'Saraswat Bank',
    'Lakshmi Vilas Bank',
    'Jammu & Kashmir Bank',
    'Karnataka Bank',
    'Indian Overseas Bank',
    'Oriental Bank of Commerce',
    'Corporation Bank',
    'Andhra Pragathi Grameena Bank', // Added Andhra Pragathi Grameena Bank
  ];

  Future<void> addLoanRecord() async {
    if (_formKey.currentState!.validate()) {
      // Collect data from the text fields
      setState(() {
        _isLoading = true;
      });

      try {
        // Insert the data into the Supabase table
        final date = _loanDateController.text.trim().split("-");
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _selectLoanDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set initial date to today
      firstDate: DateTime(2000), // Earliest date that can be selected
      lastDate: DateTime.now(), // Latest date that can be selected
    );

    if (selectedDate != null) {
      setState(() {
        // Format the selected date as YYYY-MM-DD and set it in the controller
        _loanDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bank Loan'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  // Return matching bank names based on the typed text
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _bankNames.where((bank) => bank
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  // Handle the selection
                  _bankNameController.text = selection;
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onEditingComplete) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Bank Name',
                      prefixIcon:
                          Icon(Icons.account_balance_outlined), // Bank icon
                    ),
                    onEditingComplete: onEditingComplete,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the bank name';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              // Row to place Amount and Interest Rate side by side
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        prefixIcon: Icon(Icons.money_outlined), // Currency icon
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the loan amount';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                      width: 16), // Add spacing between the two fields
                  Expanded(
                    child: TextFormField(
                      controller: _interestRateController,
                      decoration: const InputDecoration(
                        labelText: 'Interest Rate',
                        prefixIcon:
                            Icon(Icons.percent_outlined), // Percentage icon
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the interest rate';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.tryParse(value) != null &&
                            double.tryParse(value)! > 100) {
                          return 'Please enter less than 100';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  // Return matching loan types based on the typed text
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _loanTypes.where((loanType) => loanType
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  // Handle the selection
                  _loanTypeController.text = selection;
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onEditingComplete) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Loan Type',
                      prefixIcon: Icon(Icons.assignment_outlined), // Loan icon
                    ),
                    onEditingComplete: onEditingComplete,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the loan type';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _loanDateController,
                decoration: const InputDecoration(
                  labelText: 'Loan Date (YYYY-MM-DD)',
                  prefixIcon:
                      Icon(Icons.calendar_today_outlined), // Calendar icon
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the loan date';
                  }
                  final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                  if (!dateRegex.hasMatch(value)) {
                    return 'Please enter a valid date in YYYY-MM-DD format';
                  }
                  return null;
                },
                readOnly: true, // Make the TextFormField read-only
                onTap: () =>
                    _selectLoanDate(context), // Open date picker when tapped
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _holderNameController,
                decoration: const InputDecoration(
                  labelText: 'Holder Name',
                  prefixIcon: Icon(Icons.person_outline), // Notes icon
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a holder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.notes_outlined), // Notes icon
                ),
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(height: 32), // Add spacing before the button
              Center(
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: _isLoading
                      ? const Center(child: CupertinoActivityIndicator())
                      : ElevatedButton(
                          onPressed: addLoanRecord,
                          child: const Text(
                            'Add Loan',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
