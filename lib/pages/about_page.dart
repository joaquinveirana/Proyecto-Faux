import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../widgets/other_widgets.dart';
import '../locale/app_localization.dart';
import '../styles/fonts.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final _otherWidgets = OtherWidgets();
  final _fonts = FontStyles();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:[
            Container(
              color: Colors.grey[200],
              child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black54,
                          width: 2
                      )
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(AppLocalization.of(context).translate("about_title"),
                              style: _fonts.openSansSemiBold(26, Colors.black)
                            )
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: RichText(
                                text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: AppLocalization.of(context).translate("about_text_1"), style: _fonts.openSans(17, Colors.black)),
                                      TextSpan(text: AppLocalization.of(context).translate("about_text_2"), style: _fonts.openSansBold(17, Colors.black)),
                                      TextSpan(text: AppLocalization.of(context).translate("about_text_3"), style: _fonts.openSans(17, Colors.black)),
                                    ]
                                )
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _launchOfficialSite(),
                              child: Container(
                                height: 100,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                    child: Text(AppLocalization.of(context).translate("about_link_text_1"),
                                        style: _fonts.openSansSemiBold(18, Colors.yellow),
                                        textAlign: TextAlign.center,)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _launchBGG(),
                              child: Container(
                                height: 100,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                    child: Text(AppLocalization.of(context).translate("about_link_text_2"),
                                      style: _fonts.openSansSemiBold(18, Colors.white),
                                      textAlign: TextAlign.center)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Text(
                              AppLocalization.of(context).translate("about_text_4"),
                              style: _fonts.openSans(17, Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Positioned(top: 20, left: 15, child: _otherWidgets.backButton(context,1))
          ]
        ),
      ),
    );
  }

  _launchBGG() async {
    const url = 'https://boardgamegeek.com/boardgame/135779/fake-artist-goes-new-york';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchOfficialSite() async {
    const url = 'https://oinkgames.com/en/games/analog/a-fake-artist-goes-to-new-york/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
