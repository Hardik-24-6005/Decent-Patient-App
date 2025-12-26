import 'package:flutter/material.dart';
import 'package:hmz_patient/utils/colors.dart';
import 'dart:io';
import 'lib.dart';

import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

import 'package:hmz_patient/l10n/app_localizations.dart';

class Jitsi extends StatefulWidget {
  static const routeName = '/jitsi';
  final String? link;
  final String? p_name;
  final String? d_name;
  final String? d_date;
  final String? s_time;
  final String? e_time;
  const Jitsi(
      {Key? key,
      this.p_name,
      this.link,
      this.d_name,
      this.d_date,
      this.s_time,
      this.e_time}) : super(key: key);
  @override
  JitsiState createState() => JitsiState();
}

class JitsiState extends State<Jitsi> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "");
  final subjectText = TextEditingController(text: "");
  final doctorName = TextEditingController(text: "");
  final patientname = TextEditingController(text: "");
  final emailText = TextEditingController(text: "fake@email.com");
  var isAudioOnly = false;
  var isAudioMuted = false;
  var isVideoMuted = false;

  @override
  void initState() {
    super.initState();
    patientname.text = widget.p_name ?? '';
    roomText.text = widget.link ?? '';
    subjectText.text = "${widget.d_date ?? ''} - ${widget.s_time ?? ''} to ${widget.e_time ?? ''}";
    doctorName.text = widget.d_name ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  AppColor appcolor = new AppColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.videoAppointment,
          style: TextStyle(
              color: appcolor.appbartext(),
              fontWeight: appcolor.appbarfontweight()),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 45,
            color: Colors.blue,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: appcolor.appbarbackground(),
        elevation: 0.0,
        iconTheme: IconThemeData(color: appcolor.appbaricontheme()),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 24.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: doctorName,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.doctorName,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: subjectText,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.appointmentTime,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: patientname,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.patientName,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              CheckboxListTile(
                title: Text(AppLocalizations.of(context)!.audioOnly),
                value: isAudioOnly,
                onChanged: _onAudioOnlyChanged,
              ),
              SizedBox(
                height: 16.0,
              ),
              CheckboxListTile(
                title: Text(AppLocalizations.of(context)!.audioMuted),
                value: isAudioMuted,
                onChanged: _onAudioMutedChanged,
              ),
              SizedBox(
                height: 16.0,
              ),
              CheckboxListTile(
                title: Text(AppLocalizations.of(context)!.videoMuted),
                value: isVideoMuted,
                onChanged: _onVideoMutedChanged,
              ),
              Divider(
                height: 48.0,
                thickness: 2.0,
              ),
              SizedBox(
                height: 64.0,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    _joinMeeting();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.joinMeeting,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value ?? false;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value ?? false;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value ?? false;
    });
  }

  _joinMeeting() async {
    String? serverUrl =
        serverText.text.trim().isEmpty ? null : serverText.text;

    try {
      var options = JitsiMeetConferenceOptions(
        room: roomText.text,
        serverURL: serverUrl,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "subject": subjectText.text,
        },
        featureFlags: {
          "welcomepage.enabled": false,
          "invite.enabled": false,
          "add-people.enabled": false,
          "meeting-password.enabled": true,
          "pip.enabled": Platform.isAndroid ? true : false,
          "call-integration.enabled": Platform.isAndroid ? false : true,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: patientname.text,
          email: emailText.text,
        ),
      );

      await JitsiMeet().join(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }



//  Widget build(BuildContext context) {

//   }
}
