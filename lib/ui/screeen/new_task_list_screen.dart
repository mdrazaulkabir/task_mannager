import 'package:flutter/material.dart';

import '../widgets/default_task_count_summary_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 26,vertical: 6),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                 return DefaultTaskCountSummaryCard(
                 title: "cancled",
                 count: 19,);
                 },
              separatorBuilder: (context, index) => SizedBox(width: 35,),
              itemCount: 4),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 10, 
              itemBuilder: (context,index){
              return Card(
                elevation: 0,
                  color: Colors.greenAccent,
                  child: Padding(padding: EdgeInsets.all(10),child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Title",style:Theme.of(context).textTheme.titleLarge,),
                        Text("Description",style:Theme.of(context).textTheme.titleSmall,),
                        const SizedBox(height: 5,),
                        Text("Date",style:Theme.of(context).textTheme.titleSmall,),
                        const SizedBox(height: 5,),
                        Row(children: [
                          Chip(label: Text("new"),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),),
                          Spacer(),
                          IconButton(onPressed: (){}, icon:Icon(Icons.edit)),
                          const SizedBox(width: 3,),
                          IconButton(onPressed: (){}, icon:Icon(Icons.delete)),

                        ],)
                      ],
                  ),),
              );

          }),
        )
      ],
    );
  }
}


