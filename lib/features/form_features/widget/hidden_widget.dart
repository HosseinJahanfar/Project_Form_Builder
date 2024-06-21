import 'package:flutter/cupertino.dart';

class HiddenWidget extends StatelessWidget {
  const HiddenWidget({super.key, required this.name, required this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(visible: false, child: Text(name)),
        Visibility(visible: false, child: Text(value)),
      ],
    );
  }
}
