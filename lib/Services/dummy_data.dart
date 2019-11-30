class DummyMachine {
  int machineID;
  String machineName;

  DummyMachine(this.machineID, this.machineName);
}

final List<DummyMachine> machineList = [
  DummyMachine(1, 'machine 1'),
  DummyMachine(2, 'machine 2'),
  DummyMachine(3, 'machine 3'),
  DummyMachine(4, 'machine 4'),
  DummyMachine(5, 'machine 5'),
  DummyMachine(6, 'machine 6'),
];

class UserData{
  final DummyMachine selectedMachine ;
  String selectedShift;
  String batchCode;
  String selectedItem;

  UserData(this.selectedMachine, this.selectedShift,this.batchCode,this.selectedItem);
}

UserData userData= UserData(DummyMachine(0,''),'','','');
