import 'package:flutter/material.dart';

class MachinrBreakdown extends StatelessWidget {
  final String reportingFor;
  final String hintTxt;
  final String clm2;

  final TextEditingController _machineController = new TextEditingController();

  MachinrBreakdown({Key key, this.reportingFor, this.hintTxt, this.clm2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                reportingFor,
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new InputManager(
                    hintTxt: hintTxt, machineController: _machineController),
              ),
              SizedBox(
                height: 20,
              ),
              DataTable(
                columnSpacing: 20,
                columns: [
                  DataColumn(
                    label: Flexible(
                      child: Text(
                        'ENTRY TIME',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(clm2),
                  ),
                ],
                rows:(hintTxt=='how much time did it waste?'?powerCutEntries: breakdownEntries)
                    .map(
                      (entry) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              entry.time.toString(),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                entry.desc.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputManager extends StatefulWidget {
  final String hintTxt;
  InputManager({
    Key key,
    @required TextEditingController machineController,
    @required this.hintTxt,
  })  : _machineController = machineController,
        super(key: key);

  final TextEditingController _machineController;

  @override
  _InputManagerState createState() => _InputManagerState();
}

class _InputManagerState extends State<InputManager> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: widget._machineController,
            decoration: InputDecoration(
              labelText: widget.hintTxt == 'how much time did it waste?'
                  ? 'Duration'
                  : 'Discription',
              border: OutlineInputBorder(),
              hintText: widget.hintTxt,
            ),
            onFieldSubmitted: (val) {
              desVal = widget._machineController.text;
              FocusScope.of(context).unfocus();
              widget._machineController.clear();
            },
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              desVal = widget._machineController.text;
              widget._machineController.clear();
            },
            onChanged: (val) {
              desVal = val;
            },
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            color: Theme.of(context).accentColor.withAlpha(500),
            child: Text('Register report'),
            onPressed: () {
              FocusScope.of(context).unfocus();
              setState(() {
                addBreakDown(desVal, widget.hintTxt);
              });
            },
          )
        ],
      ),
    );
  }
}

String desVal;

class BreakdownEntries {
  final String desc;
  final String time;

  BreakdownEntries(this.desc, this.time);
}

List<BreakdownEntries> breakdownEntries = [];
List<BreakdownEntries> powerCutEntries = [];

void addBreakDown(String desc, String hint) {
  String time;

  time = DateTime.now().hour.toString() +
      ': ' +
      DateTime.now().minute.toString() +
      ': ' +
      DateTime.now().second.toString();
  hint == 'how much time did it waste?'
      ? powerCutEntries.add(
          BreakdownEntries(desc, time),
        )
      : breakdownEntries.add(
          BreakdownEntries(desc, time),
        );
}
