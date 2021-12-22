import 'package:flutter/material.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        return const Card(
          elevation: 0,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Text(
                "12\n dec",
                textAlign: TextAlign.center,
              ),
            ),
            title: Text("Rs: 100000"),
            subtitle: Text("Travel"),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return const SizedBox(height: 10);
      },
      itemCount: 10,
    );
  }
}
