import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListLisener,
        builder: (BuildContext ctx, List<CategoryMOdel> newList, Widget? _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final Category = newList[index];
              return Card(
                child: ListTile(
                  title: Text(Category.name),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDB.instance.deleteCategory(Category.id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemCount: newList.length,
          );
        });
  }
}
