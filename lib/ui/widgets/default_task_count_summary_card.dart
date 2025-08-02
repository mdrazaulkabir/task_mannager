import 'package:flutter/material.dart';
class DefaultTaskCountSummaryCard extends StatelessWidget {
  const DefaultTaskCountSummaryCard({
    super.key, required this.title, required this.count,
  });
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Center(
        child: Card(
          elevation: 4,
          color: Colors.greenAccent,
          child: Padding(padding: EdgeInsets.all(12),child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$count",style: Theme.of(context).textTheme.titleLarge,),
              Text(title,style: TextStyle(color:Colors.grey,fontSize: 14),)
            ],
          ),),
        ),
      ),
    );
  }
}