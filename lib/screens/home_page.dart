import 'package:app_color_picker/extensions/string/remove_all.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:app_color_picker/extensions/string/as_html_color_to_color.dart';
import 'package:app_color_picker/utils/show_snack_bar.dart';
import 'package:app_color_picker/models/color_obj.dart';
import 'package:app_color_picker/models/colors_class.dart';
import 'package:app_color_picker/utils/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final darkHexController = TextEditingController();
  final lightHexController = TextEditingController();

  final dialogTextController = TextEditingController();

  late ColorClass colorClass;

  late List<ColorObj> darkColorObjList;

  late List<ColorObj> lightColorObjList;

  late Set<ColorObj> grossColorObjList;

  late String _code;

  @override
  void initState() {
    super.initState();
    if (darkHexController.text.isEmpty) {
      darkHexController.text = '#C792EA';
    }

    colorClass = ColorClass(darkHexController.text.htmlColorToColor());

    darkColorObjList = [
      for (final colorMapEntry in colorClass.darkColorMap.entries)
        ColorObj(
          color: colorMapEntry.key,
          colorType: colorMapEntry.value,
          colorName: '${colorMapEntry.value.name}DarkMode',
        )
    ];

    if (lightHexController.text.isEmpty) {
      lightHexController.text = '#C792EA';
    }

    colorClass = ColorClass(lightHexController.text.htmlColorToColor());

    lightColorObjList = [
      for (final colorMapEntry in colorClass.lightColorMap.entries)
        ColorObj(
          color: colorMapEntry.key,
          colorType: colorMapEntry.value,
          colorName: '${colorMapEntry.value.name}LightMode',
        )
    ];
  }

  void _generateCode() {
    var loopCode = '';

    for (final colorObj in darkColorObjList) {
      loopCode = loopCode +
          'static const ${colorObj.colorName} = \'${colorObj.color.value}\'.htmlColorToColor();\n';
    }

    log(loopCode);
    debugPrint(loopCode, wrapWidth: 1024);

    _code = '''
import 'package:flutter/material.dart'
    show immutable, Color, ColorScheme, Brightness;

extension RemoveAll on String {
  String removeAll(Iterable<String> values) => values.fold(
      this,
      (
        String result,
        String pattern,
      ) =>
          result.replaceAll(pattern, ''));
}

extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
        int.parse(
          removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}


@immutable
class AppColors {
  static final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.lightSeedColor,
    brightness: Brightness.light,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.darkSeedColor,
    brightness: Brightness.dark,
  );

  static const lightSeedColor = Color(
        int.parse(
          '${lightHexController.text}'.removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
  static const darkSeedColor = Color(
        int.parse(
          '${darkHexController.text}'.removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );

  static const smallTextColor = Color.fromARGB(190, 198, 138, 59);
  static final darkBackgroundColor = darkColorScheme.background;
  static final lightPinkColor = darkColorScheme.error;
  static final darkRedColor = darkColorScheme.errorContainer;
  static final lightBrownColor = darkColorScheme.inversePrimary;
  static final whiteColor = darkColorScheme.inverseSurface;
  static final greyColor = darkColorScheme.onInverseSurface;
  static final darkBrownColor = darkColorScheme.onPrimary;
  static final brightCreamColor = darkColorScheme.onPrimaryContainer;
  static final dullBrownColor = darkColorScheme.onSecondary;
  static final dullWhiteColor = darkColorScheme.onSurfaceVariant;
  static final darkGreenColor = darkColorScheme.onTertiary;
  static final brightGreenColor = darkColorScheme.tertiary;
  static final lightBrownGreyColor = darkColorScheme.outline;
  static final darkBrownGreyColor = darkColorScheme.outlineVariant;
  static final primaryDarkModeColor = darkColorScheme.primary;
  static final primaryLightModeColor = colorScheme.primary;
  static final brownColor = darkColorScheme.primaryContainer;
  static final blackColor = darkColorScheme.scrim;
  static final creamColor = darkColorScheme.secondary;
  static final brightBrownColor = darkColorScheme.surfaceTint;
  static final lightGreenColor = darkColorScheme.tertiaryContainer;
  static final color2 = darkColorScheme.onBackground;

  const AppColors._();
}

''';
  }

  void _submitDark() {
    try {
      colorClass = ColorClass(darkHexController.text.htmlColorToColor());

      setState(() {
        darkColorObjList = [
          for (final colorMapEntry in colorClass.darkColorMap.entries)
            ColorObj(
              color: colorMapEntry.key,
              colorType: colorMapEntry.value,
              colorName: '${colorMapEntry.value.name}DarkMode',
            )
        ];
      });
    } catch (e) {
      showSnackBar(
          context, 'Please type correct hex code in dark mode text field.');
      return;
    }
  }

  void _submitLight() {
    try {
      colorClass = ColorClass(lightHexController.text.htmlColorToColor());

      setState(() {
        lightColorObjList = [
          for (final colorMapEntry in colorClass.lightColorMap.entries)
            ColorObj(
              color: colorMapEntry.key,
              colorType: colorMapEntry.value,
              colorName: '${colorMapEntry.value.name}LightMode',
            )
        ];
      });
    } catch (e) {
      showSnackBar(
          context, 'Please type correct hex code in light mode text field.');
      return;
    }
  }

  void _showDialogDark(ColorObj colorObj, BuildContext context) async {
    dialogTextController.text = colorObj.colorName;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Give a name to the color .${colorObj.colorType.name}',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Make sure you name the color using camel case naming convention.'),
              TextField(
                controller: dialogTextController,
                decoration: const InputDecoration(
                  hintText: 'Give a custom name to color',
                  labelText: 'Color Name',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _changeDarkColorName(colorObj, context);
              },
              child: const Text('Okay'),
            )
          ],
        );
      },
    );
  }

  void _showDialogLight(ColorObj colorObj, BuildContext context) async {
    dialogTextController.text = colorObj.colorName;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Give a name to the color .${colorObj.colorType.name}',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Make sure you name the color using camel case naming convention.'),
              TextField(
                controller: dialogTextController,
                decoration: const InputDecoration(
                  hintText: 'Give a custom name to color',
                  labelText: 'Color Name',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _changeLightColorName(colorObj, context);
              },
              child: const Text('Okay'),
            )
          ],
        );
      },
    );
  }

  void _changeDarkColorName(ColorObj colorObj, BuildContext context) {
    final index = darkColorObjList.indexOf(colorObj);

    darkColorObjList[index].log();

    final newColorObj = darkColorObjList.elementAt(index).copyWith(
          colorName: dialogTextController.text,
        );
    setState(() {
      darkColorObjList.removeAt(index);
      darkColorObjList.insert(index, newColorObj);
    });

    darkColorObjList[index].log();
    Navigator.pop(context);
  }

  void _changeLightColorName(ColorObj colorObj, BuildContext context) {
    final index = lightColorObjList.indexOf(colorObj);

    lightColorObjList[index].log();

    final newColorObj = lightColorObjList.elementAt(index).copyWith(
          colorName: dialogTextController.text,
        );
    setState(() {
      lightColorObjList.removeAt(index);
      lightColorObjList.insert(index, newColorObj);
    });

    lightColorObjList[index].log();
    Navigator.pop(context);
  }

  void _combineLightAndDark() {
    grossColorObjList.addAll([...darkColorObjList]);
    grossColorObjList.addAll([...lightColorObjList]);
  }

  @override
  Widget build(BuildContext context) {
    '4293113343'.htmlColorToColor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Color Picker'),
        actions: [
          IconButton(
            onPressed: _generateCode,
            icon: const Icon(Icons.code),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 36,
        ),
        child: Row(
          children: [
            Container(
              height: 200,
              width: 200,
              color: Color(int.parse(
                '4294948011'.removeAll(['0x', '#']).padLeft(8, 'ff'),
                radix: 32,
              )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350,
                          child: TextField(
                            controller: darkHexController,
                            decoration: const InputDecoration(
                                labelText:
                                    'Hex code of seed color of dark theme'),
                          ),
                        ),
                        const SizedBox(width: 50),
                        IconButton(
                          onPressed: _submitDark,
                          icon: const Icon(Icons.check),
                        )
                      ],
                    ),
                    const SizedBox(height: 36),
                    Expanded(
                      child: GridView.builder(
                        itemCount: colorClass.darkColorList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return ColorGridTile(
                            colorObj: darkColorObjList[index],
                            onPressed: () {
                              _showDialogDark(darkColorObjList[index], context);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const VerticalDivider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350,
                          child: TextField(
                            controller: lightHexController,
                            decoration: const InputDecoration(
                                labelText:
                                    'Hex code of seed color of light theme'),
                          ),
                        ),
                        const SizedBox(width: 50),
                        IconButton(
                          onPressed: _submitLight,
                          icon: const Icon(Icons.check),
                        )
                      ],
                    ),
                    const SizedBox(height: 36),
                    Expanded(
                      child: GridView.builder(
                        itemCount: colorClass.lightColorList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return ColorGridTile(
                            colorObj: lightColorObjList[index],
                            onPressed: () {
                              _showDialogLight(
                                  lightColorObjList[index], context);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorGridTile extends StatelessWidget {
  const ColorGridTile({
    Key? key,
    required this.colorObj,
    required this.onPressed,
  }) : super(key: key);

  final ColorObj colorObj;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: colorObj.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Text(
                colorObj.colorType.name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Text(
                colorObj.colorName,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
