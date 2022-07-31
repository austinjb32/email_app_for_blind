import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class SpeechSampleApp extends StatefulWidget {
  @override
  _SpeechSampleAppState createState() => _SpeechSampleAppState();
}

/// An example that demonstrates the basic functionality of the
/// SpeechToText plugin for using the speech recognition capability
/// of the underlying platform.
class _SpeechSampleAppState extends State<SpeechSampleApp> {
  bool _hasSpeech = false;
  bool _logEvents = false;
  final TextEditingController _pauseForController =
  TextEditingController(text: '3');
  final TextEditingController _listenForController =
  TextEditingController(text: '30');
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
  }

  /// This initializes SpeechToText. That only has to be done
  /// once per application, though calling it again is harmless
  /// it also does nothing. The UX of the sample app ensures that
  /// it can only be called once.
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Compose Mail"),
          foregroundColor: Colors.black87,
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        ),
        body: Container(
          height: double.infinity,
          child:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
              children: [
              HeaderWidget(),
              Container(
                child: Column(
                  children: <Widget>[
                    InitSpeechWidget(_hasSpeech, initSpeechState),
                    SessionOptionsWidget(
                      _currentLocaleId,
                      _switchLang,
                      _localeNames,
                      _logEvents,
                      _switchLogging,
                      _pauseForController,
                      _listenForController,
                    ),


                    // SpeechStatusWidget(speech: speech),

                  ],
                ),
              ),
              Container(
                child: RecognitionResultsWidget(lastWords: lastWords, level: level),
              ),
              SpeechControlWidget(_hasSpeech, speech.isListening,
                  startListening, stopListening, cancelListening),
              ErrorWidget(lastError: lastError),
        ]),
            ),
          ),
      );
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    final pauseFor = int.tryParse(_pauseForController.text);
    final listenFor = int.tryParse(_listenForController.text);
    // Note that `listenFor` is the maximum, not the minimun, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: listenFor ?? 30),
        pauseFor: Duration(seconds: pauseFor ?? 3),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords}';
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }

}



TextEditingController emailController = new TextEditingController();
TextEditingController senderController = new TextEditingController();
TextEditingController subjectController = new TextEditingController();
TextEditingController bodyController = new TextEditingController();

List <String> data =[];
/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  RecognitionResultsWidget({
    Key? key,
    required this.lastWords,
    required this.level,
  }) : super(key: key);

  final String lastWords;
  final double level;
  final TextEditingController _controller = TextEditingController();

  void initState() {
    _controller.addListener(() {
      _controller.value = _controller.value.copyWith(
        text: "hello",
        selection:
        TextSelection(baseOffset: lastWords.length, extentOffset: lastWords.length),
        composing: TextRange.empty,
      );
    });

  }





  @override
  void dispose() {
    _controller.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            // Container(
            //   margin: EdgeInsets.only(top:10.0,bottom: 20.0),
            //   child: Center(
            //     child: Text(
            //       lastWords,
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top:40.0,left: 10.0,right: 10.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    child: Column(
                      children:<Widget>[
                       TextField(
                         style: TextStyle(color: Colors.white),
                          autofocus: true,
                          controller: senderController,
                          decoration: InputDecoration(
                              labelText: "From",
                              hintText: "From",
                              suffixIcon: Icon(Icons.mail),
                              border: OutlineInputBorder(),
                          ),
                        ),SizedBox(
                          height: 10.0,
                          ),TextField(
                          style: TextStyle(color: Colors.white),
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: "To",
                              hintText: "To",
                              suffixIcon: Icon(Icons.outgoing_mail),
                              border: OutlineInputBorder()
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: subjectController,
                          decoration: InputDecoration(
                              labelText: "Subject",
                              hintText: "Subject",
                              suffixIcon: Icon(Icons.note),
                              border: OutlineInputBorder()

                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: bodyController..text = lastWords,
                          onSubmitted: (text) => {},
                          style: TextStyle(color: Colors.white),
                          showCursor: true,
                          readOnly: true,
                          maxLines: 5,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              labelText: "Body",
                              hintText: "Body",
                              suffixIcon: Icon(Icons.description),
                              border: OutlineInputBorder()
                          ),
                        ),],)

                  // width: 40,
                  // height: 40,
                  // alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //   boxShadow: [
                  //     BoxShadow(
                  //         blurRadius: .26,
                  //         spreadRadius: level * 1.5,
                  //         color: Colors.black.withOpacity(.05))
                  //   ],
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.all(Radius.circular(50)),
                  // ),
                  // child: IconButton(
                  //   icon: Icon(Icons.mic),
                  //   onPressed: () => null,
                  // ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

  }
}


class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Text(
      //   'Speech recognition available',
      //   style: TextStyle(fontSize: 22.0),
      // ),
    );
  }
}

/// Display the current error status from the speech
/// recognizer
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.lastError,
  }) : super(key: key);

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Center(
        //   child: Text(
        //     'Error Status',
        //     style: TextStyle(fontSize: 22.0),
        //   ),
        // ),
        Center(
          child: Text(lastError),
        ),
      ],
    );
  }
}

var dio = Dio();
/// Controls to start and stop speech recognition
class SpeechControlWidget extends StatelessWidget {
  const SpeechControlWidget(this.hasSpeech, this.isListening,
      this.startListening, this.stopListening, this.cancelListening,
      {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final bool isListening;
  final void Function() startListening;
  final void Function() stopListening;
  final void Function() cancelListening;



  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top:15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton.large(
            onPressed: !hasSpeech || isListening ? null:startListening,
            child: Icon(Icons.mic),
          ),
          FloatingActionButton.large(
            child: Icon(Icons.send),
            onPressed: () async{
      dio.options.contentType= Headers.formUrlEncodedContentType;
//or works once
      await dio.post(
      'https://fathomless-coast-00802.herokuapp.com/compose',
      data: {
        "from":senderController.text.toString(),
        "to":emailController.text.toString(),
        "subject":subjectController.text.toString(),
        "body":bodyController.text.toString(),
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      }
          )
        ],
      ),
    );
  }
}

class SessionOptionsWidget extends StatelessWidget {
  const SessionOptionsWidget(
      this.currentLocaleId,
      this.switchLang,
      this.localeNames,
      this.logEvents,
      this.switchLogging,
      this.pauseForController,
      this.listenForController,
      {Key? key})
      : super(key: key);

  final String currentLocaleId;
  final void Function(String?) switchLang;
  final void Function(bool?) switchLogging;
  final TextEditingController pauseForController;
  final TextEditingController listenForController;
  final List<LocaleName> localeNames;
  final bool logEvents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
                margin: EdgeInsets.only(top:20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color:Colors.transparent, //background color of dropdown button
                    border: Border.all(color: Colors.transparent, width:3), //border of dropdown button
                    borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                ),
                  child:Padding(
                    padding: EdgeInsets.only(left:5, right:5),
                child:DropdownButton<String>(

                onChanged: (selectedVal) => switchLang(selectedVal),
                value: currentLocaleId,
                items: localeNames
                    .map(
                      (localeName) => DropdownMenuItem(
                    value: localeName.localeId,
                    child: Text(localeName.name),
                  ),
                )
                    .toList(),
                  icon: Padding( //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left:5),
                      child:Icon(Icons.arrow_circle_down_sharp)
                  ), //Icon color
                  style: TextStyle(  //te
                      color: Colors.blueGrey, //Font color
                      fontSize: 17 //font size on dropdown button
                  ),
                ),
              )))
          // Row(
          //   children: [
          //     Text('pauseFor: '),
          //     Container(
          //         padding: EdgeInsets.only(left: 8),
          //         width: 80,
          //         child: TextFormField(
          //           controller: pauseForController,
          //         )),
          //     Container(
          //         padding: EdgeInsets.only(left: 16),
          //         child: Text('listenFor: ')),
          //     Container(
          //         padding: EdgeInsets.only(left: 8),
          //         width: 80,
          //         child: TextFormField(
          //           controller: listenForController,
          //         )),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Text('Log events: '),
          //     Checkbox(
          //       value: logEvents,
          //       onChanged: switchLogging,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class InitSpeechWidget extends StatelessWidget {
  const InitSpeechWidget(this.hasSpeech, this.initSpeechState, {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final Future<void> Function() initSpeechState;

  @override
  Widget build(BuildContext context) {
    initSpeechState();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // TextButton(
        //   onPressed: hasSpeech ? initSpeechState:null,
        //   child: Text('Initialize'),
        // ),
      ],
    );
  }
}


/// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key? key,
    required this.speech,
  }) : super(key: key);

  final SpeechToText speech;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: speech.isListening
            ? Text(
          "I'm listening...",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
            : Text(
          'Not listening',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}