import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

ValueNotifier<CategoryType> selctedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: InputDecoration(
                hintText: "Category Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(type: CategoryType.income, title: "Income"),
                  RadioButton(type: CategoryType.expense, title: "Expense"),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final _name = _nameEditingController.text.trim();
                if (_name.isEmpty) {
                  return;
                }
                final _type = selctedCategoryNotifier.value;
                final _category = CategoryMOdel(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  name: _name,
                  type: _type,
                ); 
                CategoryDB.instance.insertCategory(_category);
                Navigator.of(ctx).pop();
              },
              child: Text("Add"),
            ),
          ),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    Key? key,
    required this.type,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selctedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selctedCategoryNotifier.value = value;
                selctedCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
