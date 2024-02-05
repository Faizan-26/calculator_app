import 'package:calculator_app/contants/wakelockprovider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/provider/theme_provider.dart';
import 'package:color_picker_field/color_picker_field.dart';
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Customize color'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Select a color'),
                          ColorPicker(
                            currentColor: selectedColor,
                            onChange: (value) {
                              selectedColor = value;
                            },
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            ref.read(colorProvider).changeColor(selectedColor);
                          },
                          child: const Text('Select'),
                        ),
                      ],
                    );
                  },
                );
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
