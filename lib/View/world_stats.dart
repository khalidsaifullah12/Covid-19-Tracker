import 'package:covid/Model/GetWorldData.dart';
import 'package:covid/View/countrie_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:velocity_x/velocity_x.dart';

import '../http/get_api_data.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> {
  final colorList= <Color>[
    const Color(0xff4205F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  GetCovidData worldData =GetCovidData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Covid - 19 Tracker"),
          centerTitle: true,),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                FutureBuilder(
                    future: worldData.getworldData(),
                    builder: (context,snapshot){
                  if (!snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CupertinoActivityIndicator(
                          radius: 10,
                        )),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const   SizedBox(height: 10,),
                        PieChart(
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                            decimalPlaces: 1,
                          ),
                          dataMap:  {
                          "Total": double.parse(snapshot.data!.cases.toString()),
                          "Recovered":double.parse(snapshot.data!.recovered.toString()),
                          "Death":double.parse(snapshot.data!.deaths.toString())
                        }
                          ,chartRadius: MediaQuery.of(context).size.width /3.2,
                          chartType: ChartType.ring,
                          colorList: colorList,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                        ).p4(),
                        const     SizedBox(
                          height: 40,
                        ),
                       MyRow(title: "Total Cases", value: snapshot.data!.cases.toString()),
                        MyRow(title: "Total Recovered", value: snapshot.data!.recovered.toString()),
                        MyRow(title: "Total Deaths", value: snapshot.data!.deaths.toString()),
                        MyRow(title: "Total Active Cases", value: snapshot.data!.active.toString()),
                        MyRow(title: "Total Critical Cases", value: snapshot.data!.critical.toString()),
                        MyRow(title: " Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                        MyRow(title: "Today Recovered Cases", value: snapshot.data!.todayRecovered.toString()),


                       InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (_){
                             return const CountrieView();
                           }));
                         },
                         child: Container(
                           color: Vx.fuchsia600,
                           height: 50,
                         width: 200,
                         child: "Find Your Country".text.makeCentered(),
                       ).card.makeCentered())
                      ],
                    );
                  }

                })
              ],
            )
          ),
        ));
  }
}
class MyRow extends StatelessWidget {
  String title , value;
   MyRow({required this.title,required this.value}) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:const EdgeInsets.all(10),

          child: Row(

            children: [
              Text(title).text.bold.italic.xl.make(),
              const     Spacer(),
              Text(value).text.bold.italic.xl.make(),
            ],
          ),
        ).card.make(),
        Divider(),
      ],
    );
  }
}
