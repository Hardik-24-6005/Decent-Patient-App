import 'package:flutter/material.dart';
import 'package:hmz_patient/utils/colors.dart';
import '../home/widgets/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'addPayment.dart';
import '../auth/providers/auth.dart';

import 'package:hmz_patient/l10n/app_localizations.dart';

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

class DepositPayment extends StatefulWidget {
  static const routeName = '/depositpayment';
  final String id;
  final String userid;
  const DepositPayment(this.id, this.userid, {super.key});

  @override
  DepositPaymentState createState() => DepositPaymentState();
}

class DepositPaymentState extends State<DepositPayment> {
  String? total;
  String? deposit;
  String? due;

  Future<List<DepositedAmount>> getPatientdeposit() async {
    String posturl = Auth().linkURL + "api/getPatientDeposit";

    final res = await http.post(
      Uri.parse(posturl),
      body: {
        'id': widget.id,
        'ion_id': widget.userid,
      },
    );

    var jsondata = json.decode(res.body);
    List<DepositedAmount> _depositedamount = [];

    for (var u in jsondata) {
      var timestamp = int.parse(u["date"]);
      var datess = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      var datesss = "${datess.day}-${datess.month}-${datess.year}";

      DepositedAmount subdata = DepositedAmount(
        id: u["id"]?.toString(),
        patient_id: u["patient"]?.toString(),
        deposited_amount: u["deposited_amount"]?.toString(),
        date: datesss,
        payment_id: u["payment_id"]?.toString(),
      );
      _depositedamount.add(subdata);
    }

    return _depositedamount;
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

  AppColor appcolor = AppColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.deposit,
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
        child: FutureBuilder<List<DepositedAmount>>(
          future: getPatientdeposit(),
          builder: (BuildContext context, AsyncSnapshot<List<DepositedAmount>> response2) {
            if (response2.data == null) {
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
                                  "${this.total}",
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
                                  "${this.deposit}",
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
                                  "${this.due}",
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
                        itemCount: response2.data!.length,
                        itemBuilder: (BuildContext context, int index2) {
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
                                            "${response2.data![index2].date}",
                                            style: TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                    Flexible(
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Text(
                                            "${response2.data![index2].deposited_amount}",
                                            style: TextStyle(fontSize: 14),
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
                                            Text("Deposit Id: "),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${response2.data![index2].id}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text("Patient Id: "),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${response2.data![index2].patient_id}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text("Deposited Amount: "),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${response2.data![index2].deposited_amount}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text("Payment Id:"),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${response2.data![index2].payment_id}")),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 50),
                                        title: Row(
                                          children: [
                                            Text("Date:"),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "${response2.data![index2].date}")),
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
