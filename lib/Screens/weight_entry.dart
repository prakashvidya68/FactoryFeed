import 'package:flutter/material.dart';

class WeightTable extends StatefulWidget {
  @override
  _WeightTableState createState() => _WeightTableState();
}

class _WeightTableState extends State<WeightTable> {
  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double wai8 = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Output Entry'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Wrap(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      width: 130,
                      child: new TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Weight',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          wai8 = double.parse(val);
                        },
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (val) {
                          setState(() {
                            addEntry(unit, wai8);
                          });
                          _controller.clear();
                          print(unit);
                        },
                        onEditingComplete: () {
                          wai8 = double.parse(_controller.text);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    new SelectUnit()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text('Add Entry'),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      addEntry(unit, wai8);
                      _controller.clear();
                    });
                  },
                ),
              ),
              DataTable(
                columnSpacing: 10,
                rows: entries
                    .map((entry) => DataRow(cells: [
                          DataCell(
                            Text(entry.wight.toString() + '  ' + entry.unit),
                          ),
                          DataCell(
                            Text(entry.time + '  hrs'),
                          ),
                          DataCell(
                            Text(entry.perError.toString() + '  %           '),
                          )
                        ]))
                    .toList(),
                columns: <DataColumn>[
                  DataColumn(
                    numeric: false,
                    label: Expanded(
                        flex: 1,
                        child: Text(
                          'WEIGHT',
                          softWrap: true,
                          textAlign: TextAlign.center,
                        )),
                    tooltip: 'entered weights',
                  ),
                  DataColumn(
                    numeric: true,
                    label: Flexible(
                      flex: 2,
                      child: Text(
                        'TIME OF ENTRY',
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    tooltip: 'entered weights',
                  ),
                  DataColumn(
                    numeric: true,
                    label: Expanded(
                      flex: 3,
                      child: Text(
                        'PERCENTAGE DEVIATION',
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    tooltip: 'entered weights',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String unit;

class SelectUnit extends StatefulWidget {
  const SelectUnit({
    Key key,
  }) : super(key: key);

  @override
  _SelectUnitState createState() => _SelectUnitState();
}

class _SelectUnitState extends State<SelectUnit> {
  @override
  void initState() {
    super.initState();
    unit = 'Kg';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Select Unit'),
        SizedBox(
          width: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Radio(
                value: 'Kg',
                groupValue: unit,
                onChanged: (val) {
                  setState(() {
                    unit = val;
                  });
                },
              ),
              Text('Kg'),
              SizedBox(
                width: 25,
              ),
              Radio(
                value: 'grm',
                groupValue: unit,
                onChanged: (val) {
                  setState(() {
                    unit = val;
                  });
                },
              ),
              Text('grm'),
            ],
          ),
        )
      ],
    );
  }
}

class WeightEntries {
  final double wight;
  final String unit;
  final double perError;
  final String time;

  WeightEntries(
    this.wight,
    this.unit,
    this.perError,
    this.time,
  );
}

List<WeightEntries> entries = [];

void addEntry(String unit, double weight) {
  double error = 0;
  WeightEntries entry;
  double percent;
  DateTime time = DateTime.now();

  String timeE = time.hour.toString() +
      ':' +
      time.minute.toString() +
      ':' +
      time.second.toString();

  if (unit == 'Kg')
    error = weight - 20.0;
  else if (unit == 'grm') error = (weight / 1000) - 20.00;
  percent = (error / 20) * 100;

  entry = WeightEntries(weight, unit, percent, timeE);

  entries.add(entry);
}
