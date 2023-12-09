import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodrecipe/model/team.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
HomePage({super.key});
  List<Team> teams = [];
  //get teams
  Future getTeams() async{
var response = await http.get(Uri.parse('https://www.balldontlie.io/api/v1/teams'));
    var jsonData =jsonDecode (response.body);

    for (var eachTeam in jsonData['data']) {
      final team = Team(
        abbreviation :eachTeam['abbreviation'],
        city:eachTeam['city'],
        full_name: eachTeam['full_name'],
      );
      teams.add(team);
    } 
    
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      appBar: AppBar(
        title:const Center(child:  Text('NBA TEAMS')),
        backgroundColor: Colors.grey[300],
      ),
      body: FutureBuilder(
        future: getTeams(),
         builder: (context,snapshot){

          //is it done eloading

          if(snapshot.connectionState==ConnectionState.done){
return ListView.builder(
   itemCount: teams.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
    child: ListTile(
      title:Text(teams[index].full_name),
      subtitle: Text(teams[index].city),
      leading:Text(teams[index].abbreviation),


      ),
                     ) );
},
);
          }

          else{
return const Center(child: CircularProgressIndicator(),);
          }
         })
    );
  }
}