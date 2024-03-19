// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PagesScreen extends StatefulWidget {
  final String? tittle;
  final String? description;
  PagesScreen({Key? key, this.tittle, this.description}) : super(key: key);
  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  WebViewController controller = WebViewController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget3(text: widget.tittle),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Column(
              children: [
                Html(data: widget.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
