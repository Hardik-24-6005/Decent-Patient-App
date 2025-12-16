import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hmz_patient/auth/providers/auth.dart';
import 'package:hmz_patient/dashboard/dashboard.dart';
import '../../home/widgets/app_drawer.dart';
import 'package:open_file/open_file.dart';

class Document {
  final String id;
  final String title;
  final String url;
  final String date;
  Document({this.id, this.title, this.url, this.date});
  factory Document.fromJson(Map<String, dynamic> json) {
    var timestamp = int.parse(json['date']);
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formattedDate = DateFormat('d MMMM, y').format(date);
    return Document(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        date: formattedDate);
  }
}

class DocumentList extends StatefulWidget {
  static const routeName = '/documentList';
  final String idd;
  final String useridd;
  DocumentList(this.idd, this.useridd);
  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  TextEditingController _searchController = TextEditingController();
  List<Document> _documents = [];
  List<Document> _filteredDocuments = [];
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: selectNotification);
    _fetchDocuments();
  }

  Future selectNotification(String payload) async {
    await OpenFile.open(payload);
  }

  Future<void> _fetchDocuments() async {
    print('User ID: ${widget.useridd}');
    final url = Auth().linkURL + 'api/getDocumentByPatientIonId';
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({'user_ion_id': widget.useridd}));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print(jsonData ?? 'No data found');
        _documents = [for (var u in jsonData) Document.fromJson(u)];
        _filteredDocuments = List.from(_documents);
        setState(() {});
      } else {
        print('Server error: ${response.statusCode}');
        print('Server response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _filterDocuments(String query) {
    if (query.isNotEmpty) {
      _filteredDocuments = _documents
          .where((doc) => doc.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      _filteredDocuments = List.from(_documents);
    }
    setState(() {});
  }

  Future<void> downloadFile(String url, String fileName) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      Dio dio = Dio();
      Directory dir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      String savePath = "${dir.path}/$fileName";
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          int progress = ((received / total) * 100).toInt();
          _showProgressNotification(0, progress, fileName);
        }
      });
      _showCompleteNotification(0, fileName, savePath);
    } else {
      print("Storage permission not granted");
    }
  }

  void _showProgressNotification(int id, int progress, String fileName) {
    var androidChannelSpecifics = AndroidNotificationDetails(
        'download_channel', 'Downloads', 'Download notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        onlyAlertOnce: false,
        showProgress: true,
        maxProgress: 100,
        progress: progress);
    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
    flutterLocalNotificationsPlugin.show(id, 'Downloading $fileName',
        'Download progress: $progress%', platformChannelSpecifics);
  }

  void _showCompleteNotification(int id, String fileName, String path) {
    var androidChannelSpecifics = AndroidNotificationDetails(
        'download_channel', 'Downloads', 'Download notifications',
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        autoCancel: true);
    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
    flutterLocalNotificationsPlugin.show(id, '$fileName Download Complete',
        'Tap to open', platformChannelSpecifics,
        payload: path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).document),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(DashboardScreen.routeName)),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(hintText: 'Search...'),
              onChanged: _filterDocuments,
            ),
          ),
          Expanded(
            child: _filteredDocuments.isNotEmpty
                ? ListView.builder(
                    itemCount: _filteredDocuments.length,
                    itemBuilder: (context, index) {
                      var doc = _filteredDocuments[index];
                      return ListTile(
                        title: Text(doc.title),
                        subtitle: Text(doc.date),
                        trailing: IconButton(
                          icon: Icon(Icons.download),
                          onPressed: () {
                            String fileExtension = doc.url.split('.').last;
                            String fileName =
                                "${doc.title.replaceAll(' ', '_')}_${doc.id}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension";
                            downloadFile(Auth().linkURL + doc.url, fileName);
                          },
                        ),
                      );
                    },
                  )
                : Center(child: Text('No documents found')),
          ),
        ],
      ),
    );
  }
}
