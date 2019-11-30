import 'package:flutter/material.dart';

import '../Services/dummy_data.dart';

class SelectMachine extends StatefulWidget {
  const SelectMachine({
    Key key,
  }) : super(key: key);

  @override
  _SelectMachineState createState() => _SelectMachineState();
}

class _SelectMachineState extends State<SelectMachine> {
  String selectedMachine;

  @override
  void initState() {
    super.initState();
    selectedMachine = '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
      child: Card(
        elevation: 0,
        color: Theme.of(context).accentColor,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Card(
            elevation: 20,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:12,bottom: 15,right: 14),
                  child: Text('Select Machine'),
                ),  
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.21,
                  child: ListView.builder(
                    itemCount: machineList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: RadioListTile(
                          title: Text(machineList[index].machineName),
                          value: 'mac ${machineList[index].machineID}',
                          groupValue: selectedMachine,
                          onChanged: (val) {
                            setState(() {
                              setState(() {
                                userData.selectedMachine.machineID = index + 1;
                                userData.selectedMachine.machineName = val;
                                selectedMachine = val;
                              });
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
