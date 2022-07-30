import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:email_project/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'compose_mail.dart';


class Album {
  final String from;
  final String date;
  final String subject;
  final String body;
  final String from_one;
  final String date_one;
  final String subject_one;
  final String body_one;
  final String from_two;
  final String date_two;
  final String subject_two;
  final String body_two;
  final String from_three;
  final String date_three;
  final String subject_three;
  final String body_three;
  final String from_four;
  final String date_four;
  final String subject_four;
  final String body_four;

  const Album({
    required this.from,
    required this.date,
    required this.subject,
    required this.body,
    required this.from_one,
    required this.date_one,
    required this.subject_one,
    required this.body_one,
    required this.from_two,
    required this.date_two,
    required this.subject_two,
    required this.body_two,
    required this.from_three,
    required this.date_three,
    required this.subject_three,
    required this.body_three,
    required this.from_four,
    required this.date_four,
    required this.subject_four,
    required this.body_four,
  });

  factory Album.fromJson(List<dynamic> json) {
    return Album(
      from: json[json.length-1]['from'],
      date: json[json.length-1]['date'],
      subject: json[json.length-1]['subject'],
      body: json[json.length-1]['body'],
        from_one:json[json.length-2]['from'],
      date_one: json[json.length-2]['date'],
      subject_one: json[json.length-2]['subject'],
      body_one: json[json.length-2]['body'],
    from_two: json[json.length-3]['from'],
        date_two: json[json.length-3]['date'],
        subject_two: json[json.length-3]['subject'],
        body_two: json[json.length-3]['body'],
        from_three: json[json.length-4]['from'],
        date_three: json[json.length-4]['date'],
        subject_three: json[json.length-4]['subject'],
        body_three: json[json.length-4]['body'],
        from_four: json[json.length-5]['from'],
        date_four: json[json.length-5]['date'],
        subject_four: json[json.length-5]['subject'],
        body_four: json[json.length-5]['body'],
    );
  }
}

    class mailScreen extends StatefulWidget {
      const mailScreen({Key? key}) : super(key: key);



      @override
      State<mailScreen> createState() => _mailScreenState();
    }

    class _mailScreenState extends State<mailScreen> {



      Future<Album> fetchAlbum() async {
        final response= await http.get(Uri.parse('https://fathomless-coast-00802.herokuapp.com/returnjson'));
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          return Album.fromJson(jsonDecode(response.body));
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load the json');
        }
      }

      late Future<Album> futureAlbum;


      @override
      void initState() {
        super.initState();
        futureAlbum = fetchAlbum();
      }
    // ·

      Widget build(BuildContext context) {

        return MaterialApp(
              home: Scaffold(
              appBar: AppBar(
              title: const Text('Inbox'),
              backgroundColor: Colors.indigo,
        ),
        body:Container(
            child: SingleChildScrollView(
            child:Column(
              children: [
                Center(
                  child:Card(
                    margin: EdgeInsets.all(15.0),
                    elevation: 8,
                    shadowColor: Colors.grey,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.indigo)),
                    child:FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                       return( ListTile(
                         title: Text(snapshot.data!.from),
                           subtitle:Text('${snapshot.data!.date}\n${snapshot.data!.subject}\n${snapshot.data!.body}'),
                       ));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                  )
                ),
                Card(
                  margin: EdgeInsets.all(15.0),
                  elevation: 4,
                  shadowColor: Colors.grey,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo)),
                  child:FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return( ListTile(
                          title: Text(snapshot.data!.from_one),
                          subtitle:Text('${snapshot.data!.date_one}\n${snapshot.data!.subject_one}\n${snapshot.data!.body_one}'),
                        ));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(15.0),
                  elevation: 4,
                  shadowColor: Colors.grey,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo)),
                  child:FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return( ListTile(
                          title: Text(snapshot.data!.from_two),
                          subtitle:Text('${snapshot.data!.date_two}\n${snapshot.data!.subject_two}\n${snapshot.data!.body_two}'),
                        ));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(15.0),
                  elevation: 4,
                  shadowColor: Colors.grey,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo)),
                  child:FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return( ListTile(
                          title: Text(snapshot.data!.from_three),
                          subtitle:Text('${snapshot.data!.date_three}\n${snapshot.data!.subject_three}\n${snapshot.data!.body_three}'),
                        ));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(15.0),
                  elevation: 4,
                  shadowColor: Colors.grey,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo)),
                  child:FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return( ListTile(
                          title: Text(snapshot.data!.from_four),
                          subtitle:Text('${snapshot.data!.date_four}\n${snapshot.data!.subject_four}\n${snapshot.data!.body_four}'),
                        ));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),

        ]
        )
        )
        )
        )
        );
      }
    }
