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
  late bool wakeLock;
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    wakeLock = true;
    selectedColor = ref.watch(colorProvider).color;
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
              enableFeedback: true,
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
                              setState(() {
                                selectedColor = value;
                              });
                            },
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            final container = ProviderContainer();
                            container
                                .read(colorProvider.notifier)
                                .changeColor(selectedColor);
                            container.dispose();
                            Navigator.of(context).pop();
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
              value: wakeLock,
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    wakeLock = val;
                    Wakelock.toggle(enable: val);
                  });
                }
              },
              title: const Text('Vibrate on keypress'),
            )
          ],
        ),
      ),
    );
  }
}
