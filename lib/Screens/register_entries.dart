import 'package:factoryfeed/Screens/machine_breakdown_register.dart' as prefix0;
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import './conclude_shift.dart';
import './weight_entry.dart';
import './machine_breakdown_register.dart';

class Entries extends StatelessWidget {
  final String path;

  const Entries({Key key, this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(path);
    return SingleChildScrollView(
      child: Material(
              child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).accentColor,
                child: Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(3),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      new CustButton2(
                        'Weight Entry',
                        'images/weigh.png',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      new CustButton(
                          'Report Machine BreakDown',
                          'images/breakdown.png',
                          'Machine not Working?',
                          'describe the breakdown',
                          'DESCRIPTION'),
                      SizedBox(
                        height: 30,
                      ),
                      new CustButton(
                        'Report Power Failure',
                        'images/power_fail.png',
                        'Report Power-Cut?',
                        'how much time did it waste?',
                        'DURATION',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: RaisedButton(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text('Shift Completed'),
                  onPressed: () {

                    Map powerCutData={};
                    powerCutEntries.forEach((cut){
                    powerCutData[cut.time] = cut.desc;
                    });

                    Map machineFailData={};
                    breakdownEntries.forEach((fail){
                    machineFailData[fail.time] = fail.desc;
                    });

                    Map weightData={};
                    entries.forEach((weight){
                      weightData[weight.time]={
                        'unit':weight.unit,
                        'Weight':weight.wight,
                        'deviation':'${100-(((weight.wight)/20)*100)}% '
                      };
                    });
                    
                    DatabaseReference db = FirebaseDatabase.instance.reference();

                    db.child('$path/PowerCuts').set(powerCutData);
                    db.child('$path/MachineFailures').set(machineFailData);
                    db.child('$path/Production').set(weightData);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Conclude(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustButton extends StatefulWidget {
  final String imgLoc;
  final String headText;
  final String reportingFor;
  final String hintTxt;
  final String clm2;

  const CustButton(
    this.headText,
    this.imgLoc,
    this.reportingFor,
    this.hintTxt,
    this.clm2,
  );

  @override
  _CustButtonState createState() => _CustButtonState();
}

class _CustButtonState extends State<CustButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: RaisedButton(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.yellow[200],
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                widget.headText,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Image.asset(widget.imgLoc),
          ],
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MachinrBreakdown(
                        reportingFor: widget.reportingFor,
                        hintTxt: widget.hintTxt,
                        clm2: widget.clm2,
                      )));
        },
      ),
    );
  }
}

class CustButton2 extends StatefulWidget {
  final String imgLoc;
  final String headText;

  const CustButton2(
    this.headText,
    this.imgLoc,
  );

  @override
  _CustButton2State createState() => _CustButton2State();
}

class _CustButton2State extends State<CustButton2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: RaisedButton(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.yellow[200],
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                widget.headText,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Image.asset(widget.imgLoc),
          ],
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WeightTable()));
        },
      ),
    );
  }
}
