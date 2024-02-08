import 'package:calculator_app/contants/wakelockprovider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/provider/theme_provider.dart';
// import 'package:color_picker_field/color_picker_field.dart';
import 'package:wakelock/wakelock.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends ConsumerState<SettingScreen> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = ref.read(colorProvider).color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "COLOR CUSTOMIZATION",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            ListTile(
              leading: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              title: const Text('Customize color'),
              onTap: () async {
                // Wait for the dialog to return color selection result.
                final Color newColor = await showColorPickerDialog(
                  context,
                  selectedColor,
                  width: 70,
                  elevation: 4,
                  height: 40,
                  spacing: 2,
                  runSpacing: 2,
                  borderRadius: 15,
                  showColorCode: true,
                  colorCodeHasColor: true,
                  pickersEnabled: <ColorPickerType, bool>{
                    ColorPickerType.wheel: true,
                  },
                  copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                    copyButton: true,
                    pasteButton: true,
                  ),
                  actionButtons: const ColorPickerActionButtons(
                    okButton: true,
                    closeButton: true,
                    dialogActionButtons: false,
                  ),
                  constraints: const BoxConstraints(
                      minHeight: 480, minWidth: 180, maxWidth: 380),
                );
                // We update the dialogSelectColor, to the returned result
                // color. If the dialog was dismissed it actually returns
                // the color we started with. The extra update for that
                // below does not really matter, but if you want you can
                // check if they are equal and skip the update below.
                setState(() {
                  selectedColor = newColor;
                  ref.read(colorProvider).changeColor(newColor);
                });
              },
            ),
            const Divider(),
            CheckboxListTile.adaptive(
              value: wakeLockConst,
              onChanged: (val) {
                if (val != null) {
                  wakeLockConst = val;
                  setState(() {
                    Wakelock.toggle(enable: wakeLockConst);
                  });
                  // print("WAKE LOCK VALUE : $wakeLock");
                }
              },
              title: const Text(
                'Prevent phone from sleep while the app is in foreground',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              activeColor: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
