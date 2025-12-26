import 'package:flutter/material.dart';
import 'package:hmz_patient/utils/colors.dart';
import '../home/widgets/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import '../jitsi/jitsi.dart';
import 'addPayment.dart';
import '../auth/providers/auth.dart';

import 'package:hmz_patient/l10n/app_localizations.dart';

class PaymentDetails {
  final String? id;
  final String? patient_name;
  final String? doctor_name;
  final String? date;
  final String? start_time;
  final String? end_time;
  final String? status;
  final String? remarks;
  final String? jitsi_link;

  PaymentDetails({
    this.id,
    this.patient_name,
    this.doctor_name,
    this.date,
    this.start_time,
    this.end_time,
    this.remarks,
    this.status,
    this.jitsi_link,
  });
}

class DepositedAmount {
  final String? id;
  final String? patient_id;
  final String? deposited_amount;
  final String? date;
  final String? payment_id;

  DepositedAmount({
    this.id,
    this.patient_id,
    this.deposited_amount,
    this.date,
    this.payment_id,
  });
}

class AllInvoicePayment extends StatefulWidget {
  static const routeName = '/allinvoicepayment';
  final String id;
  final String userid;
  const AllInvoicePayment(this.id, this.userid, {super.key});

  @override
  AllInvoicePaymentState createState() =>
      AllInvoicePaymentState();
}

class AllInvoicePaymentState extends State<AllInvoicePayment> {
  String? total;
  String? deposit;
  String? due;

  Future<List<PaymentDetails>> _responseFuture() async {
    final patient_id = widget.id;
    // final patient_userid = widget.userid; // Unused

    var data = await http.get(
        Uri.parse(Auth().linkURL + "api/patientAllInvoices?id=${patient_id}"));

    // final url = Auth().linkURL + "api/patientAllInvoices";
    // var data = await http.post(
    //   Uri.parse(url),
    //   body: {
    //     'id': patient_id,
    //   },
    // );

    var jsondata = json.decode(data.body);
    List<PaymentDetails> _lcdata = [];

    for (var u in jsondata) {
      PaymentDetails subdata = PaymentDetails(
        id: u["id"]?.toString(),
        patient_name: u["patient_name"]?.toString(),
        doctor_name: u["doctor_name"]?.toString(),
        date: u["date_string"]?.toString(),
        start_time: u["amount"]?.toString(),
        end_time: u["hospital_amount"]?.toString(),
        remarks: u["doctor_amount"]?.toString(),
        status: u["deposit_type"]?.toString(),
        jitsi_link: u["patient_phone"]?.toString(),
      );
      _lcdata.add(subdata);
    }
    return _lcdata;
  }

  Future gettotalamount() async {
    String posturl = Auth().linkURL + "api/totalAmountPatient";

    final res = await http.post(
      Uri.parse(posturl),
      body: {
        'id': widget.id,
        'ion_id': widget.userid,
      },
    );

    var jsondata = json.decode(res.body);

    if (mounted) {
      setState(() {
        var ss = jsondata["total"];
        var ss2 = jsondata["deposit"];
        var ss3 = jsondata["due"];
        this.total = "$ss";
        this.deposit = "$ss2";
        this.due = "$ss3";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gettotalamount();
  }

  AppColor appcolor = new AppColor();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.allInvoices,
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
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
        centerTitle: true,
        backgroundColor: appcolor.appbarbackground(),
        elevation: 0.0,
        iconTheme: IconThemeData(color: appcolor.appbaricontheme()),
        actions: <Widget>[
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPaymentScreen(widget.id)));
            },
            icon: Icon(
              Icons.add_rounded,
            ),
            label: Text(""),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<PaymentDetails>>(
          future: _responseFuture(),
          builder: (BuildContext context, AsyncSnapshot<List<PaymentDetails>> response) {
            if (response.data == null) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return ListView(
                children: [
                  GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(10),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      crossAxisCount: 3,
                      childAspectRatio: (50 / 50),
                      children: <Widget>[
                        Container(
                          color: Colors.orange,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.blue.withValues(alpha: .5)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.totalAmount,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                                Padding(padding: EdgeInsets.all(2)),
                                Text(
                                  "${total ?? '0'}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          color: Colors.orange,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.blue.withValues(alpha: .5)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.totalDeposit,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                                Padding(padding: EdgeInsets.all(2)),
                                Text(
                                  "${deposit ?? '0'}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          color: Colors.orange,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.blue.withValues(alpha: .5)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.totalDue,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                                Padding(padding: EdgeInsets.all(2)),
                                Text(
                                  "${due ?? '0'}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ]),
                  Divider(),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: response.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = response.data![index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: ExpansionTile(
                              title: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Text(
                                            "${item.date}",
                                            style: TextStyle(fontSize: 14),
                                          )),
                                    ),
                                    Flexible(
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Text(
                                            "${item.id}",
                                            style: TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                    Flexible(
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Text(
                                            "${item.patient_name}",
                                            style: TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Color.fromRGBO(0, 13, 79, 1),
                                            width: 0.2)),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!
                                                .invoiceId),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${item.id}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!
                                                .patientName),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${item.patient_name}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!
                                                .doctorName),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${item.doctor_name}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!
                                                .date),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${item.date}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!
                                                .amount),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${item.start_time}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!
                                                .depositType),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${item.status}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!
                                                .patientPhone),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${item.jitsi_link}")),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
