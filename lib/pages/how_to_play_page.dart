import 'package:flutter/material.dart';
import '../locale/app_localization.dart';
import '../styles/fonts.dart';
import '../widgets/other_widgets.dart';

class HowToPlay extends StatefulWidget {
  @override
  _HowToPlayState createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
  final FontStyles _fontStyles = FontStyles();
  final OtherWidgets _otherWidgets = OtherWidgets();

  @override
  Widget build(BuildContext context) {
    final double _safePadding = MediaQuery.of(context).padding.top;
    final double _heightTotal =
        MediaQuery.of(context).size.height - _safePadding;
    return SafeArea(
        child: Scaffold(
            body: Stack(
              children: [
                Container(
                    height: _heightTotal,
                    color: Colors.grey[200],
                    child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black54, width: 2)),
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              width: double.infinity,
                              height: 2500,
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_title'), style: _fontStyles.openSansSemiBold(26, Colors.black),)
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        margin: EdgeInsets.all(20),
                                        child: Text(AppLocalization.of(context).translate('how_to_play_content_01'), style: _fontStyles.openSans(17, Colors.black),)
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(AppLocalization.of(context).translate('how_to_play_content_02'), style: _fontStyles.openSans(17, Colors.black),)
                                    ),
                                  ),
                                  Container(
                                      child: Text("- "+AppLocalization.of(context).translate('how_to_play_content_03'), style: _fontStyles.openSans(17, Colors.black),)
                                  ),
                                  Container(
                                      child: Text("      - " + AppLocalization.of(context).translate('how_to_play_content_04'), style: _fontStyles.openSans(17, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(20),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_sub_title_1'), style: _fontStyles.openSansSemiBold(26, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_content_1'), style: _fontStyles.openSans(17, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(20),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_sub_title_2'), style: _fontStyles.openSansSemiBold(26, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_content_2'), style: _fontStyles.openSans(17, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_content_3'), style: _fontStyles.openSans(17, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: RichText(
                                          text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(text:AppLocalization.of(context).translate('how_to_play_list_11'), style: _fontStyles.openSansSemiBold(17, Colors.green)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_list_12"), style: _fontStyles.openSans(17, Colors.black)),
                                              ]
                                          )
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: RichText(
                                          text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(text:AppLocalization.of(context).translate('how_to_play_list_21'), style: _fontStyles.openSansSemiBold(17, Colors.red)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_list_22"), style: _fontStyles.openSans(17, Colors.black)),
                                              ]
                                          )
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(20),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_sub_title_3'), style: _fontStyles.openSansSemiBold(26, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: RichText(
                                          text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(text:AppLocalization.of(context).translate('how_to_play_content_4'), style: _fontStyles.openSans(17, Colors.black)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_41"), style: _fontStyles.openSansSemiBold(17, Colors.red)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_42"), style: _fontStyles.openSans(17, Colors.black)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_43"), style: _fontStyles.openSansSemiBold(17, Colors.red)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_44"), style: _fontStyles.openSans(17, Colors.black)),
                                              ]
                                          )
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_content_5'), style: _fontStyles.openSans(17, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(20),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_sub_title_4'), style: _fontStyles.openSansSemiBold(26, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: Text(AppLocalization.of(context).translate('how_to_play_content_6'), style: _fontStyles.openSans(17, Colors.black),)
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: RichText(
                                          text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(text:AppLocalization.of(context).translate('how_to_play_content_71'), style: _fontStyles.openSans(17, Colors.black)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_72"), style: _fontStyles.openSansSemiBold(17, Colors.red)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_73"), style: _fontStyles.openSans(17, Colors.black)),
                                              ]
                                          )
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: RichText(
                                          text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(text:AppLocalization.of(context).translate('how_to_play_content_81'), style: _fontStyles.openSans(17, Colors.black)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_82"), style: _fontStyles.openSansSemiBold(17, Colors.red)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_83"), style: _fontStyles.openSans(17, Colors.black)),
                                              ]
                                          )
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                                      child: RichText(
                                          text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(text:AppLocalization.of(context).translate('how_to_play_content_91'), style: _fontStyles.openSans(17, Colors.black)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_92"), style: _fontStyles.openSansSemiBold(17, Colors.red)),
                                                TextSpan(text: AppLocalization.of(context).translate("how_to_play_content_93"), style: _fontStyles.openSans(17, Colors.black)),
                                              ]
                                          )
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    )
                ),
                Positioned(top: 20, left: 15, child: _otherWidgets.backButton(context))
              ]
            )
        )
    );
  }
}
