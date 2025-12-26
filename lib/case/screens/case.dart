import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hmz_patient/auth/providers/auth.dart';
import 'package:hmz_patient/dashboard/dashboard.dart';
import 'package:provider/provider.dart';
import '../../home/widgets/app_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:hmz_patient/l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:hmz_patient/utils/colors.dart';

class Case {
  final String? id;
  final String? title;
  final String? description;
  final String? date;

  Case({
    this.id,
    this.title,
    this.description,
    this.date,
  });

  factory Case.fromJson(Map<String, dynamic> json) {
    var timestamp = int.tryParse(json["date"]?.toString() ?? '0') ?? 0;
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formattedDate = DateFormat("d MMMM, y").format(date);
    return Case(
      id: json["id"]?.toString(),
      title: json["title"]?.toString(),
      description: json["description"]?.toString(),
      date: formattedDate,
    );
  }
}

class CaseList extends StatefulWidget {
  static const routeName = '/caseList';
  final String idd;
  final String useridd;

  CaseList(this.idd, this.useridd);

  @override
  _CaseListState createState() => _CaseListState();
}

class _CaseListState extends State<CaseList> {
  List<Case> cases = [];
  List<Case> filteredCases = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCases();
    searchController.addListener(_filterCases);
  }

  Future<void> _fetchCases() async {
    final url = Auth().linkURL + "api/getCaseByPatientIonId";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {'user_ion_id': widget.useridd},
      );
      var jsondata = json.decode(response.body) as List;
      List<Case> tempCases =
          jsondata.map((data) => Case.fromJson(data)).toList();
      if (mounted) {
        setState(() {
          cases = tempCases;
          filteredCases = tempCases;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      print('Failed to fetch data: $e');
    }
  }

  void _filterCases() {
    List<Case> _results = [];
    if (searchController.text.isEmpty) {
      _results = cases;
    } else {
      _results = cases
          .where((caseItem) => (caseItem.title ?? '')
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredCases = _results;
    });
  }

  AppColor appcolor = new AppColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.case_history,
          style: TextStyle(
            color: appcolor.appbartext(),
            fontWeight: appcolor.appbarfontweight(),
          ),
        ),
        centerTitle: true,
        backgroundColor: appcolor.appbarbackground(),
        elevation: 0.0,
        iconTheme: IconThemeData(color: appcolor.appbaricontheme()),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 45,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.of(context)
              .pushReplacementNamed(DashboardScreen.routeName),
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredCases.length,
                      itemBuilder: (context, index) {
                        Case caseItem = filteredCases[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, bottom: 10),
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.file_copy,
                                      size: 40, color: Colors.grey),
                                  title: Text(
                                    caseItem.title ?? '',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Proxima Nova'),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(height: 5),
                                    SizedBox(width: 25),
                                    Container(
                                      child: Icon(Icons.event_note,
                                          size: 16, color: Colors.black12),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .45,
                                      child: Text(
                                        "${AppLocalizations.of(context)!.date}: ${caseItem.date ?? ''}",
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 30),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .70,
                                      child: Html(
                                        data: caseItem.description,
                                        style: {
                                          "html": Style(
                                            fontSize: FontSize(12),
                                            color: Color(0xFF757575),
                                          )
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(width: 8),
                                    Divider(height: 20),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
