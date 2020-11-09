import '../../locale/app_localization.dart';
import 'package:flutter/material.dart';

class SearchBanner extends StatefulWidget {
  final Function _notifyParent;
  SearchBanner({notifyFunction: Function}) : this._notifyParent = notifyFunction;

  Function getNotifyFunction() {
    return this._notifyParent;
  }

  @override
  _SearchBannerState createState() => _SearchBannerState();
}

class _SearchBannerState extends State<SearchBanner> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      widget.getNotifyFunction()(_controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _parentWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(
              Icons.search,
              size: 26,
            ),
          ),
          Container(
            height: 35,
            width: _parentWidth - 130,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff33A3fC))
                ),
                hintText: AppLocalization.of(context).translate("game_settings_difficulty_search"),
                suffixIcon: IconButton(
                  onPressed: () {
                    _controller.text = '';
                    FocusScope.of(context).unfocus();
                  },
                  icon: Icon(Icons.clear, size: 15,),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
