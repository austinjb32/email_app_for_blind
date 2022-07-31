import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('Welcome, User',
                style: GoogleFonts.ubuntu(
                    fontSize: 30,
                    color: Colors.black87
                )),
            Text('Team Twilio',
                style: GoogleFonts.ubuntu(
                    fontSize: 25,
                    color: Colors.black87
                )),
            Text("Hello We're Team Twilio, This is our first time building an app for the blind. There are so many limitations, but more and more updates will be brought in the near future."),
            Text("Our passion for providing the best quality end-to-end solutions from strategy to deployment and beyond has sustained the Tech Company’s sustainable growth since our founding. With a consistent retention rate and an uptime percentage that is as near perfect as you can get we believe our work speaks on our behalf"),
              Text("Our enterprise services span several corporate sectors and vertical markets, but we have achieved great success providing solutions in the Retail & Financial sectors specifically. Over time we have also invested and formed product relationships with large-scale software and product houses which enables us to translate value to our clients and provide best in market solutions"),
              Text("We have seen substantial growth in the past years, but our focus remains on serving our customers and providing the best solutions possible to them."),
          ],
        ),
      ),
    );
  }
}
