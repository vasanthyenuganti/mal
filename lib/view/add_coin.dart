// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mal/services/outside_loan_service.dart';

class AddCoinRecordScreen extends StatefulWidget {
  const AddCoinRecordScreen({super.key});

  @override
  _AddCoinRecordScreenState createState() => _AddCoinRecordScreenState();
}

class _AddCoinRecordScreenState extends State<AddCoinRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _giverNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _takenDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  Future<void> addCoinRecord() async {
    if (_formKey.currentState!.validate()) {
      // Collect data from the text fields

      setState(() {
        _isLoading = true;
      });

      try {
        // Insert the data into the Supabase table
        final date = _takenDateController.text.trim().split("-");
        
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
        _takenDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Coin Record'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _giverNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Giver Name',
                  prefixIcon: Icon(Icons.monetization_on_outlined), // Bank icon
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Giver name';
                  }
                  return null;
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
                        labelText: 'Interest Rupee',
                        prefixIcon:
                            Icon(Icons.currency_rupee), // Percentage icon
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the interest rupee';
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
              TextFormField(
                controller: _takenDateController,
                decoration: const InputDecoration(
                  labelText: 'Taken Date (YYYY-MM-DD)',
                  prefixIcon:
                      Icon(Icons.calendar_today_outlined), // Calendar icon
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the taken date';
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
                          onPressed: addCoinRecord,
                          child: const Text(
                            'Add Coin',
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
