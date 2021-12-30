import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = "add-transaction";
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryMOdel? _selectedCategoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                // purpose
                decoration: const InputDecoration(
                  hintText: 'Purpose',
                ),
              ),
              TextField(
                // amount
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                ),
              ),

              TextButton.icon(
                // calender
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(
                      _selectedDateTemp.toString(),
                    );
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _selectedDate == null
                      ? "Select Date"
                      : _selectedDate!.toString(),
                ),
              ),

              // category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: CategoryType.income,
                        onChanged: (newValue) {},
                      ),
                      Text("Income"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: CategoryType.expense,
                        onChanged: (newValue) {},
                      ),
                      Text("Expense"),
                    ],
                  ),
                ],
              ),
              // category type
              DropdownButton(
                hint: const Text("Select Category"),
                items: CategoryDB.instance.incomeCategoryListLisener.value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                },
              ),
              // submit
              ElevatedButton(
                onPressed: () {},
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
