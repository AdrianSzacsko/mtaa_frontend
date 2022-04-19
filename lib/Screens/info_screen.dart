import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mtaa_frontend/Screens/components/sign_up_form.dart';
import 'package:mtaa_frontend/Screens/profile_screen.dart';
//import 'package:flutter/rendering.dart';
import 'package:mtaa_frontend/UI/inputField.dart';
import 'package:mtaa_frontend/Screens/search_screen.dart';
import 'package:mtaa_frontend/Screens/sign_in_screen.dart';
import 'package:mtaa_frontend/webrtc/call_sample/call_sample.dart';
import 'package:video_player/video_player.dart';

import '../UI/appbar.dart';
import '../constants.dart';



class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  //SearchScreen({Key key}) : super(key: key);

  @override
  InfoScreenState createState() => InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  static const routeName = '/info-screen';
  late VideoPlayerController _controller;
  var tapped = false;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://archive.org/download/Rick_Astley_Never_Gonna_Give_You_Up/Rick_Astley_Never_Gonna_Give_You_Up.mp4')
      ..initialize().then((_) {
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  Widget createCard(){
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            elevation:10,
            shadowColor: primaryColor[300],
            child:
            Column(
              children: [
                Center(
                  child:
                  Padding(
                      padding: const EdgeInsets.only(top: defaultPadding * 2),
                      child: Image.asset('assets/Images/puzzle.png',
                        height: 80.0,
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                const SizedBox(height: defaultPadding * 2),
                Center(
                  child:
                  Padding(
                      padding: const EdgeInsets.only(top: defaultPadding * 2),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Aca",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 40)),
                          TextSpan(
                              text: "Rate",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 40)),
                        ]),
                      )
                  ),
                ),
                const SizedBox(height: defaultPadding * 0.5),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: defaultPadding * 2),
                    child: Text("An app made for an assignment in MTAA"),
                  ),
                ),
                const SizedBox(height: defaultPadding * 1),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: defaultPadding),
                    child: Text("Made by: Marko Stahovec, Adrian Szacsko",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                const SizedBox(height: 20,)

              ],
            ),
          ),
          /*Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            ),
          elevation:10,
          shadowColor: secondaryColor[300],
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
            padding: EdgeInsets.only(left: defaultPadding * 2, top: defaultPadding),
            child: Column(
              children: const [
                Text("Special thanks to...",
                  style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text("Ing. Marek Galinski, PhD.")
              ],
            ),
            ),
          ),
          ),*/
        ],
      ),


    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context),
        bottomNavigationBar: myBottomAppBar(context),
        body: !tapped ? Center(
          child: _controller.value.isInitialized
          ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
          )
          : Container(),
    ) :
            createCard(),
      floatingActionButton: !tapped ? FloatingActionButton(
        heroTag: null,
        onPressed: () {
            _controller.pause();
          setState(() {
            tapped = true;
          });
          /*setState(() {
            _controller.play();
          });*/
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ) : null,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}