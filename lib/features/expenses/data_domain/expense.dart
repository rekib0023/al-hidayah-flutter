class ExpensesModel {
  String? expenseType;
  ExpenseData? expenseData;

  ExpensesModel({this.expenseType, this.expenseData});

  ExpensesModel.fromJson(Map<String, dynamic> json) {
    expenseType = json['expenseType'];
    expenseData = json['expenseData'] != null
        ? ExpenseData.fromJson(json['expenseData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expenseType'] = expenseType;
    if (expenseData != null) {
      data['expenseData'] = expenseData!.toJson();
    }
    return data;
  }
}

class ExpenseData {
  double? totalAmount;
  List<Expense>? expense;

  ExpenseData({this.totalAmount, this.expense});

  ExpenseData.fromJson(Map<String, dynamic> json) {
    dynamic value = json['totalAmount'];

    if (value.runtimeType == int) {
      totalAmount = value.toDouble();
    } else if (value.runtimeType == double) {
      totalAmount = value;
    }
    if (json['expense'] != null) {
      expense = <Expense>[];
      json['expense'].forEach((v) {
        expense!.add(Expense.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAmount'] = totalAmount;
    if (expense != null) {
      data['expense'] = expense!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Expense {
  String? sId;
  String? title;
  String? description;
  double? amount;
  String? date;
  String? staffName;
  String? expenseType;

  Expense({
    this.sId,
    this.title,
    this.description,
    this.amount,
    this.date,
    this.staffName,
    this.expenseType,
  });

  Expense.fromJson(Map<String, dynamic> json) {
    dynamic value = json['amount'];

    if (value.runtimeType == int) {
      amount = value.toDouble();
    } else if (value.runtimeType == double) {
      amount = value;
    }
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    staffName = json['staffName'];
    expenseType = json['expenseType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['amount'] = amount;
    data['date'] = date;
    data['staffName'] = staffName;
    data['expenseType'] = expenseType;
    return data;
  }
}
