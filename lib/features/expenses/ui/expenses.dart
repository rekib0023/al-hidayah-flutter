import 'package:al_hidayah/styles/colors.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:al_hidayah/widgets/App_Bar.dart';
import 'package:al_hidayah/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  bool _showDailyExpenses = true;
  bool _showSalary = false;
  bool _showHouseRent = false;
  bool _showElectricity = false;

  double _totalDailyExpenses = 0.0;
  double _totalSalary = 0.0;
  double _totalHouseRent = 0.0;
  double _totalElectricity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Expenses"),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            expensesList(),
            PrimaryButton(
              text: "Add Expense",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: CreateExpense(),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget expensesList() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            setState(() {
              _showDailyExpenses = !_showDailyExpenses;
              _showSalary = false;
              _showHouseRent = false;
              _showElectricity = false;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Daily Expense",
                    style: AppTextStyles.title,
                  ),
                  Icon(_showDailyExpenses
                      ? Icons.expand_less
                      : Icons.expand_more)
                ],
              ),
              Text(
                '\u{20B9} $_totalDailyExpenses',
                style: AppTextStyles.title,
              ),
            ],
          ),
        ),
        _showDailyExpenses
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text("ID"),
                      numeric: true,
                    ),
                    DataColumn(label: Text("Title")),
                    DataColumn(label: Text("Amount")),
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Description")),
                  ],
                  rows: [],
                ),
              )
            : Container(),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            setState(() {
              _showHouseRent = !_showHouseRent;
              _showDailyExpenses = false;
              _showSalary = false;
              _showElectricity = false;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "House Rent",
                    style: AppTextStyles.title,
                  ),
                  Icon(_showHouseRent ? Icons.expand_less : Icons.expand_more)
                ],
              ),
              Text(
                '\u{20B9} $_totalHouseRent',
                style: AppTextStyles.title,
              ),
            ],
          ),
        ),
        _showHouseRent
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text("ID"),
                      numeric: true,
                    ),
                    DataColumn(label: Text("Amount")),
                    DataColumn(label: Text("Date")),
                  ],
                  rows: [],
                ),
              )
            : Container(),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();

            setState(() {
              _showHouseRent = false;
              _showDailyExpenses = false;
              _showSalary = false;
              _showElectricity = !_showElectricity;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Electricity",
                    style: AppTextStyles.title,
                  ),
                  Icon(_showElectricity ? Icons.expand_less : Icons.expand_more)
                ],
              ),
              Text(
                '\u{20B9} $_totalElectricity',
                style: AppTextStyles.title,
              ),
            ],
          ),
        ),
        _showElectricity
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text("ID"),
                      numeric: true,
                    ),
                    DataColumn(label: Text("Amount")),
                    DataColumn(label: Text("Date")),
                  ],
                  rows: [],
                ),
              )
            : Container(),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();

            setState(() {
              _showHouseRent = false;
              _showDailyExpenses = false;
              _showSalary = !_showSalary;
              _showElectricity = false;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Salary",
                    style: AppTextStyles.title,
                  ),
                  Icon(_showSalary ? Icons.expand_less : Icons.expand_more)
                ],
              ),
              Text(
                '\u{20B9} $_totalSalary',
                style: AppTextStyles.title,
              ),
            ],
          ),
        ),
        _showSalary
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text("ID"),
                      numeric: true,
                    ),
                    DataColumn(label: Text("Staff Name")),
                    DataColumn(label: Text("Amount")),
                    DataColumn(label: Text("Date")),
                  ],
                  rows: [],
                ),
              )
            : Container(),
        const SizedBox(height: 20),
      ],
    );
  }
}

class CreateExpense extends StatefulWidget {
  const CreateExpense({super.key});

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _staffNameController = TextEditingController();

  String? _selectedExpenseType;

  List<String> expenseTypeDropdown = [
    "Daily Expense",
    "House Rent",
    "Electricity",
    "Salary"
  ];

  @override
  void initState() {
    _selectedExpenseType = expenseTypeDropdown[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Create Expense",
              style: AppTextStyles.title,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedExpenseType,
              onChanged: (value) {
                setState(() {
                  _selectedExpenseType = value;
                });
              },
              items: expenseTypeDropdown
                  .map((entry) => DropdownMenuItem<String>(
                        value: entry,
                        child: Text(entry),
                      ))
                  .toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Repeat',
              ),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: _selectedExpenseType == "Daily Expense",
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Visibility(
              visible: _selectedExpenseType == "Salary",
              child: Column(
                children: [
                  TextFormField(
                    controller: _staffNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Staff Name',
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dateController,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  _dateController.text = DateFormat.yMd().format(selectedDate);
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Date',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {},
                    text: "Create",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SecondaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Cancel",
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
