import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';


class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.lato(),
        ),
        foregroundColor: Colors.black87,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      ),
      body:Center(
        child:Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              child: Column(
                children: [
                  Text('About Us',
                      style: GoogleFonts.ubuntu(
                          fontSize: 30,
                          color: Colors.black87
                      )),
                  Image.asset('assets/images/About.png'),
                  SizedBox(height: 10.0),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Team Twilio',
                      style: GoogleFonts.ubuntu(
                          fontSize: 40,
                          color: Colors.black87
                      )),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12.0),
                    child: Column(
                      children:[SizedBox(height:20),
                        Text("Hello, We're Team Twilio, This is our first time building an app for the blind. There are so many limitations, but more and more updates will be brought in the near future.",
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                    fontStyle:FontStyle.italic,
                      )),

                      SizedBox(height:20),
                      Text("Our passion for providing the best quality end-to-end solutions from strategy to deployment and beyond has sustained the Tech Company’s sustainable growth since our founding. Please wait for our future update.",
                      style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontStyle:FontStyle.italic,
                            )),
                            SizedBox(height: 10.0),
                        TextButton(onPressed: () async =>{ await speak("Hello, We're Team Twilio, This is our first time building an app for the blind. There are so many limitations, but more and more updates will be brought in the near future.")},  child: Icon(Icons.volume_up_outlined,color:Color(0xffF9AA33)))
                    ],
                    ),
                  ),
                ],
              ),
            ),
        ],
        ),
      ),
    );
  }
  speak(String text) async {
    flutterTts.setLanguage("en-Us");
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.35);
    await flutterTts.setPitch(0.4);
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.speak(text);
  }
}
