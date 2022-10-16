import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid/View/world_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DeatailsScreen extends StatefulWidget {
  String name,flag,cases,deaths,recovered,active,critical,todayDeaths,todayRecovered;
   DeatailsScreen({super.key,
     required this.name,
     required this.flag,
     required this.cases,
     required this.deaths,
     required this.recovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.todayDeaths,


   }) ;

  @override
  State<DeatailsScreen> createState() => _DeatailsScreenState();
}

class _DeatailsScreenState extends State<DeatailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name.toString()).text.bold.italic.make(),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(

              imageUrl: widget.flag,
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ).card.circular.make(),
          ),

          MyRow(title: "Total Cases", value: widget.cases),
          MyRow(title: "Active", value: widget.active),
          MyRow(title: "Recovered", value: widget.recovered),
          MyRow(title: "Deaths", value: widget.deaths),
          MyRow(title: "Today Recovered", value: widget.todayRecovered),
          MyRow(title: "Today  Deaths", value: widget.todayDeaths),

        ],
      ).p4().scrollVertical(),
    );
  }
}
