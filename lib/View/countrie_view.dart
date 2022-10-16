import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid/View/deatails_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';


import '../http/get_api_data.dart';

class CountrieView extends StatefulWidget {
  const CountrieView({Key? key}) : super(key: key);

  @override
  State<CountrieView> createState() => _CountrieViewState();
}

class _CountrieViewState extends State<CountrieView> {
  GetCovidData worldData =GetCovidData();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
       Padding(
        padding: EdgeInsets.all(13),
        child: VxTextField(
     controller: searchController,
          hint: "Search with country name",
          borderType: VxTextFieldBorderType.roundLine,
          onChanged: (value){

         setState(() {

         });
          },

        ),
      ),

            Expanded(
              child: FutureBuilder(
                  future: worldData.getcuntrieData(),
                  builder: (context ,AsyncSnapshot<List<dynamic>>snapshot){
                  if (!snapshot.hasData) {
                 return   ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index){
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Column(
                            children: [
                              ListTile(
                                leading:  Container(height: 50 , width: 50, color: Colors.white,),
                                title:  Container(
                                  width: 100,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                subtitle:  Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ),

                            ],
                          ),
                        );
                      },

                    );
                  } else {
                    return  ListView.builder(
                        itemCount: snapshot.data!.length ,
                        itemBuilder: (context ,index){
                          String name = snapshot.data![index]['country'].toString();
                          if (searchController.text.isEmpty) {
                            return  InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> DeatailsScreen(
                                    name: snapshot.data![index]['country'].toString(),
                                    flag: snapshot.data![index]['countryInfo']['flag'],
                                    cases: snapshot.data![index]['cases'].toString(),
                                    deaths: snapshot.data![index]['deaths'].toString(),
                                    recovered: snapshot.data![index]['recovered'].toString(),
                                    active: snapshot.data![index]['active'].toString(),
                                    todayDeaths: snapshot.data![index]['todayDeaths'].toString()
                                    ,todayRecovered: snapshot.data![index]['todayRecovered'].toString(),
                                    critical: snapshot.data![index]['recovered'].toString())));
                              },
                              child: ListTile(

                                leading:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    height: 50,
                                    width: 100,
                                    imageUrl: snapshot.data![index]['countryInfo']['flag'],
                                    placeholder: (context, url) => const CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                                title: Text(snapshot.data![index]['country'].toString()),
                                subtitle: Text("Total Cases = ${snapshot.data![index]['cases']}"),

                              ),
                            );
                          } else if(name.toLowerCase().contains(searchController.text.toLowerCase())) {
                            return  InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> DeatailsScreen(
                                    name: snapshot.data![index]['country'].toString(),
                                    flag: snapshot.data![index]['countryInfo']['flag'],
                                    cases: snapshot.data![index]['cases'].toString(),
                                    deaths: snapshot.data![index]['deaths'].toString(),
                                    recovered: snapshot.data![index]['recovered'].toString(),
                                    active: snapshot.data![index]['active'].toString(),
                                    todayDeaths: snapshot.data![index]['todayDeaths'].toString()
                                    ,todayRecovered: snapshot.data![index]['todayRecovered'].toString(),
                                    critical: snapshot.data![index]['recovered'].toString())));
                              },
                              child: ListTile(

                                leading:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    height: 50,
                                    width: 100,
                                    imageUrl: snapshot.data![index]['countryInfo']['flag'],
                                    placeholder: (context, url) => const CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                                title: Text(snapshot.data![index]['country'].toString()),
                                subtitle: Text("Total Cases = ${snapshot.data![index]['cases']}"),

                              ),
                            );
                          } else{
                            return Container();
                          }


                        });
                  }


              }),
            )

          ],
        ),
      ),
    );
  }
}
