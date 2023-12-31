// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Lang extends StatefulWidget {
  const Lang({
    Key? key,
    this.tex,
  }) : super(key: key);
  final String? tex;

  @override
  State<Lang> createState() => _LangState();
}

class _LangState extends State<Lang> {
  final List<Map<String, dynamic>> locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'मराठी', 'locale': const Locale('mr', 'IN')},
  ];

  builddailog(BuildContext context) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          //  title: Text('Choose Language'),
          content: SizedBox(
            width: 50,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              updateLanguage(locale[index]['locale']);
                            });
                          });
                        },
                        child: Text(locale[index]['name'])),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.green,
                  );
                },
                itemCount: locale.length),
          ),
        );
      },
    );
  }

  updateLanguage(Locale locale) {
    Get.back();
    Future.microtask(() {
      if (mounted) {
        Get.updateLocale(locale);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    updateLanguage(locale[0]['locale']);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            builddailog(context);
          },
          child: Text(widget.tex.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ))),
    );
  }
}
