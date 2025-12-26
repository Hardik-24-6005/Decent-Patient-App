import 'package:flutter/material.dart';
import 'package:hmz_patient/utils/colors.dart';
import '../home/widgets/bottom_navigation_bar.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import '../jitsi/jitsi.dart';
import '../auth/providers/auth.dart';
import 'appointment.dart';

import 'package:hmz_patient/l10n/app_localizations.dart';

class AppintmentDetails {
  final String? id;
  final String? patient_name;
  final String? doctor_name;
  final String? date;
  final String? start_time;
  final String? end_time;
  final String? status;
  final String? remarks;
  final String? payment;
  final String? jitsi_link;

  AppintmentDetails({
    this.id,
    this.patient_name,
    this.doctor_name,
    this.date,
    this.start_time,
    this.end_time,
    this.remarks,
    this.status,
    this.payment,
    this.jitsi_link,
  });
}

class ShowPatientAppointmentScreen extends StatefulWidget {
  static const routeName = '/showpatientappointmentlist';
  final String idd;
  final String useridd;
  ShowPatientAppointmentScreen(this.idd, this.useridd);
  @override
  ShowPatientAppointmentScreenState createState() =>
      ShowPatientAppointmentScreenState();
}

class ShowPatientAppointmentScreenState
    extends State<ShowPatientAppointmentScreen> {
  
  List<AppintmentDetails> _tempappointmentlistdata = [];
  List<AppintmentDetails> _appointmentlistdata = [];
  bool erroralllistdata = true;
  Future<List<AppintmentDetails>> _responseFuture() async {
    String patient_id = widget.idd;

    // var data = await http.get(Uri.parse(Auth().linkURL +
    //     "api/getMyAllAppoinmentList?group=patient&id=" +
    //     patient_id));

    final url = Auth().linkURL + "api/getMyAllAppoinmentList";

    try {
      final data = await http.post(
        Uri.parse(url),
        body: {
          'group': "patient",
          'id': patient_id,
        },
      );

      var jsondata = json.decode(data.body);

      for (var u in jsondata) {
        AppintmentDetails subdata = AppintmentDetails(
          id: u["id"]?.toString(),
          patient_name: u["patient_name"]?.toString(),
          doctor_name: u["doctor_name"]?.toString(),
          date: "${u["date"]}",
          start_time: u["start_time"]?.toString(),
          end_time: u["end_time"]?.toString(),
          remarks: u["remarks"]?.toString(),
          status: u["status"]?.toString(),
          payment: u["payment"]?.toString(),
          jitsi_link: u["jitsi_link"]?.toString(),
        );
        _appointmentlistdata.add(subdata);
      }
      if (mounted) {
        setState(() {
          _tempappointmentlistdata = _appointmentlistdata;
          erroralllistdata = false;
        });
      }

      return _appointmentlistdata;
    } catch (error) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();

    _responseFuture();
  }

  TextEditingController _searchappointment = TextEditingController();
  Future<String> searchallappointmentList(var appointmentdata) async {
    if (!mounted) return "error";
    setState(() {
      _tempappointmentlistdata = [];

      if (appointmentdata == "") {
        _tempappointmentlistdata = _appointmentlistdata;
      } else {
        for (var item in _appointmentlistdata) {
          if (item.doctor_name != null &&
              item.doctor_name!
                  .toLowerCase()
                  .contains(appointmentdata.toString().toLowerCase())) {
            _tempappointmentlistdata.add(item);
          }
        }
      }
    });
    return "as";
  }

  AppColor appcolor = new AppColor();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                  PatientAppointmentDetailsScreen.routeName);
            },
          )
        ],
        title: Text(
          AppLocalizations.of(context)!.appointmentList,
          style: TextStyle(
            color: appcolor.appbartext(),
            fontWeight: appcolor.appbarfontweight(),
            fontSize: 18,
            fontFamily: "Proxima Nova",
          ),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 45,
            color: Colors.blue,
          ),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
        centerTitle: false,
        backgroundColor: appcolor.appbarbackground(),
        elevation: 0.0,
        iconTheme: IconThemeData(color: appcolor.appbaricontheme()),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 25,
              left: 25,
              right: 25,
              bottom: 10,
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: double.infinity,
                child: TextFormField(
                  controller: _searchappointment,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: AppLocalizations.of(context)!.searchbydoctorname,
                    hintText: AppLocalizations.of(context)!.doctor,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, bottom: 20),
                      child: Icon(Icons.search),
                    ),
                  ),
                  onChanged: (value) {
                    searchallappointmentList(value);

                    return null;
                  },
                ),
              ),
            ),
          ),
          (erroralllistdata)
              ? Container(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Center(child: CircularProgressIndicator()))
              : (_tempappointmentlistdata.length == 0)
                  ? Container(
                      height: MediaQuery.of(context).size.height * .5,
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.nodatatoshow),
                      ),
                    )
                  : Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: _tempappointmentlistdata.length,
                          itemBuilder: (BuildContext context, int index) {
                            Color statusColor = Colors.grey;
                            if (_tempappointmentlistdata[index].status ==
                                "Confirmed") {
                              statusColor = Colors.green;
                            } else if (_tempappointmentlistdata[index].status ==
                                "Requested") {
                              statusColor = Colors.orange;
                            } else if (_tempappointmentlistdata[index].status ==
                                "Cancelled") {
                              statusColor = Colors.red;
                            } else if (_tempappointmentlistdata[index].status ==
                                "Treated") {
                              statusColor = Colors.indigo;
                            } else if (_tempappointmentlistdata[index].status ==
                                "Pending Confirmation") {
                              statusColor = Colors.orange;
                            }

                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue[300]!.withValues(alpha: 0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black12,
                                              child: Icon(
                                                Icons.person,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          (_tempappointmentlistdata[index]
                                                      .status ==
                                                  "Confirmed")
                                              ? Container(
                                                  width: 40,
                                                  height: 30,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        padding:
                                                            WidgetStateProperty.all(
                                                                EdgeInsets.only(
                                                                    top: 2,
                                                                    bottom: 2)),
                                                        backgroundColor:
                                                            WidgetStateProperty.all(
                                                                Colors.white),
                                                        shape: WidgetStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        10),
                                                                side: BorderSide(color: Colors.black12)))),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => Jitsi(
                                                                link: _tempappointmentlistdata[
                                                                        index]
                                                                    .jitsi_link ?? "",
                                                                p_name: _tempappointmentlistdata[
                                                                        index]
                                                                    .patient_name ?? "",
                                                                d_name:
                                                                    _tempappointmentlistdata[
                                                                            index]
                                                                        .doctor_name ?? "",
                                                                d_date:
                                                                    _tempappointmentlistdata[
                                                                            index]
                                                                        .date ?? "",
                                                                s_time: _tempappointmentlistdata[
                                                                        index]
                                                                    .start_time ?? "",
                                                                e_time: _tempappointmentlistdata[
                                                                        index]
                                                                    .end_time ?? "")),
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.video_call_rounded,
                                                      size: 25,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .50,
                                            child: Text(
                                              "${_tempappointmentlistdata[index].doctor_name}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontFamily: "Proxima Nova",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.event_note,
                                                  size: 16,
                                                  color: Colors.black12,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .50,
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.remarks}: ${_tempappointmentlistdata[index].remarks}",
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.event,
                                                  size: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .50,
                                                child: Text(
                                                  " ${_tempappointmentlistdata[index].date}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Icon(
                                                  Icons.access_time_sharp,
                                                  size: 0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .50,
                                                child: Text(
                                                  "     ${_tempappointmentlistdata[index].start_time} - ${_tempappointmentlistdata[index].end_time}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${_tempappointmentlistdata[index].status}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: statusColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(screenNum: 1),
    );
  }
}
