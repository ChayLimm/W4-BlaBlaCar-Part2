import 'package:flutter/material.dart';
import 'package:refactor_pref_service/service/rides_service.dart';
import 'package:refactor_pref_service/theme/theme.dart';

class DetailCheckBox extends StatelessWidget {
  final RidesFilter? initRidesFilter;
  final Function(RidesFilter) onPressed;
  const DetailCheckBox({super.key,required this.onPressed,this.initRidesFilter});

  @override
  Widget build(BuildContext context) {

    bool isPetAccepted = initRidesFilter?.acceptPets ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: Text("Pets accepted"),
          value: isPetAccepted,
          activeColor: BlaColors.primary, // Set checkbox color
          onChanged: (bool? value) {
            if (value != null) {
              onPressed(RidesFilter(value));
            }
          },
        ),
      ],
    );
  }
}