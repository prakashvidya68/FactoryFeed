import 'package:flutter/material.dart';
import '../Services/dummy_data.dart';

class ShiftSelect extends StatefulWidget {
  const ShiftSelect({
    Key key,
  }) : super(key: key);

  @override
  _ShiftSelectState createState() => _ShiftSelectState();
}
class _ShiftSelectState extends State<ShiftSelect> {
  int selectedShift;

  @override
  void initState() {
    super.initState();
    selectedShift = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: selectedShift,
              onChanged: (val) {
                setState(() {
                  selectedShift = val;
                  userData.selectedShift= 'Morning';
                });
              },
            ),
            SizedBox(
              height: 45,
              child: Image.asset('images/morning.png'),
            ),
            Text('Morning'),
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
              value: 2,
              groupValue: selectedShift,
              onChanged: (val) {
                setState(() {
                  selectedShift = val;
                  userData.selectedShift= 'Night';
                });
              },
            ),
            SizedBox(
              height: 35,
              child: Image.asset('images/night_sky.png'),
            ),
            Text('Night'),
          ],
        )
      ],
    );
  }
}