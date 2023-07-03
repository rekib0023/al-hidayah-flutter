import 'package:al_hidayah/features/expenses/bloc/expenses_bloc.dart';
import 'package:al_hidayah/features/expenses/data_domain/expense.dart';
import 'package:al_hidayah/styles/colors.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:al_hidayah/widgets/App_Bar.dart';
import 'package:al_hidayah/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final ExpensesBloc bloc = ExpensesBloc();

  @override
  void initState() {
    bloc.add(ExpensesInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Expenses"),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocConsumer<ExpensesBloc, ExpensesState>(
          bloc: bloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case ExpensesLoadedSuccessState:
                final successState = state as ExpensesLoadedSuccessState;
                List<ExpensesModel> expenses = successState.expenses;
                return ListView(
                  children: [
                    _buildExpensesList(expenses),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: "Add Expense",
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: CreateExpense(bloc: bloc),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildDailyExpense(ExpenseData? expenseData) {
    List<Expense> expenses = expenseData!.expense!;

    return Column(
      children: [
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
          child: _buildExpenseRow(
            text: "Daily Expense",
            showData: _showDailyExpenses,
            expenseData: expenseData,
          ),
        ),
        if (_showDailyExpenses)
          SingleChildScrollView(
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
              rows: expenses.map((expense) {
                int index = expenses.indexOf(expense) + 1;
                return DataRow(
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(expense.title!)),
                    DataCell(Text(expense.amount!.toString())),
                    DataCell(
                      Text(
                        DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(expense.date!),
                        ),
                      ),
                    ),
                    DataCell(Text(expense.description!)),
                  ],
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildHouseRentExpense(ExpenseData? expenseData) {
    List<Expense> expenses = expenseData!.expense!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
          child: _buildExpenseRow(
            text: "House Rent",
            showData: _showHouseRent,
            expenseData: expenseData,
          ),
        ),
        if (_showHouseRent)
          SingleChildScrollView(
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
              rows: expenses.map((expense) {
                int index = expenses.indexOf(expense) + 1;
                return DataRow(
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(expense.amount!.toString())),
                    DataCell(
                      Text(
                        DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(expense.date!),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildSalaryExpense(ExpenseData? expenseData) {
    List<Expense> expenses = expenseData!.expense!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
          child: _buildExpenseRow(
            text: "Salary",
            showData: _showSalary,
            expenseData: expenseData,
          ),
        ),
        if (_showSalary)
          SingleChildScrollView(
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
              rows: expenses.map((expense) {
                int index = expenses.indexOf(expense) + 1;
                return DataRow(
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(expense.staffName!)),
                    DataCell(Text(expense.amount!.toString())),
                    DataCell(
                      Text(
                        DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(expense.date!),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildElectricityExpense(ExpenseData? expenseData) {
    List<Expense> expenses = expenseData!.expense!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
          child: _buildExpenseRow(
            text: "Electricity",
            showData: _showElectricity,
            expenseData: expenseData,
          ),
        ),
        if (_showElectricity)
          SingleChildScrollView(
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
              rows: expenses.map((expense) {
                int index = expenses.indexOf(expense) + 1;
                return DataRow(
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(expense.amount!.toString())),
                    DataCell(
                      Text(
                        DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(expense.date!),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Text _buildExpenseTotal(ExpenseData expenseData) {
    return Text(
      '\u{20B9} ${expenseData.totalAmount}',
      style: AppTextStyles.title,
    );
  }

  Row _buildExpenseRow(
      {required String text,
      required bool showData,
      ExpenseData? expenseData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(text, style: AppTextStyles.title),
            Icon(showData ? Icons.expand_less : Icons.expand_more)
          ],
        ),
        if (expenseData != null) _buildExpenseTotal(expenseData)
      ],
    );
  }

  Widget _buildExpensesList(List<ExpensesModel> expenses) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: expenses.map((expense) {
        String? expenseType = expense.expenseType;
        ExpenseData? expenseData = expense.expenseData;
        switch (expenseType) {
          case "Daily Expense":
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildDailyExpense(expenseData),
            );
          case "House Rent":
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildHouseRentExpense(expenseData),
            );
          case "Electricity":
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildElectricityExpense(expenseData),
            );
          case "Salary":
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildSalaryExpense(expenseData),
            );
          default:
            return const SizedBox();
        }
      }).toList(),
    );
  }
}

class CreateExpense extends StatefulWidget {
  const CreateExpense({super.key, required this.bloc});
  final ExpensesBloc bloc;

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
                labelText: 'Expense Type',
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
                    onPressed: _createExpense,
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

  void _createExpense() {
    Expense expense = Expense(
      title: _titleController.text,
      description: _descriptionController.text,
      amount: int.parse(_amountController.text).toDouble(),
      date: _dateController.text,
      staffName: _staffNameController.text,
      expenseType: _selectedExpenseType,
    );
    widget.bloc.add(ExpensesCreateEvent(expense));
    Navigator.pop(context);
  }
}
