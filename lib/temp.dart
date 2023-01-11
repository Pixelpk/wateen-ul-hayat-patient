import 'package:swift_care/utils/projectutils/base_constant.dart';

import 'export.dart';

class Temp extends StatefulWidget {
  const Temp({Key? key}) : super(key: key);

  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              cbtnElevatedButton(onPressed: () {}, label: elevatedButton),
              cbtnElevatedButtonWithIcon(
                  onPressed: () {}, label: elevatedButton, icon: Icons.ac_unit),
              cbtnTextButton(onPressed: () {}, label: elevatedButton),
              cbtnTextButtonWithIcon(
                  onPressed: () {}, label: elevatedButton, icon: Icons.ac_unit),
              cbtnOutlinedButton(onPressed: () {}, label: elevatedButton),
              cbtnOutlinedButtonWithIcon(
                  onPressed: () {}, label: elevatedButton, icon: Icons.ac_unit),
            ],
          ),
        ),
      ),
    );
  }
}
