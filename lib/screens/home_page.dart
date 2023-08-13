import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void _generateCodeByColorCodes() async {
    var loopCodeDark = '';
    var loopCodeLight = '';

    for (final colorObj in darkColorObjList) {
      loopCodeDark =
          '${loopCodeDark}static final ${colorObj.colorName} = Color(int.parse(\'${colorObj.color.value}\'));\n';
    }

    for (final colorObj in lightColorObjList) {
      loopCodeLight =
          '${loopCodeLight}static final ${colorObj.colorName} = Color(int.parse(\'${colorObj.color.value}\'));\n';
    }

    // debugPrint(loopCodeDark, wrapWidth: 1024);
    // debugPrint(loopCodeLight, wrapWidth: 1024);

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


@immutable
class AppColors {
  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.lightSeedColor,
    brightness: Brightness.light,
  );
  
  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.darkSeedColor,
    brightness: Brightness.dark,
  );

  static final lightSeedColor = Color(
        int.parse(
          '${lightHexController.text}'.removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
  static final darkSeedColor = Color(
        int.parse(
          '${darkHexController.text}'.removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );

  $loopCodeLight

  $loopCodeDark
  
  const AppColors._();
}
  ''';

    await Clipboard.setData(ClipboardData(text: _code));
    // debugPrint(_code, wrapWidth: 1024);
  }

  void _generateCodeByColorSchemeProperties() async {
    var loopCodeDark = '';
    var loopCodeLight = '';

    for (final colorObj in darkColorObjList) {
      loopCodeDark =
          '${loopCodeDark}static final ${colorObj.colorName} = darkColorScheme.${colorObj.colorType.name};\n';
    }

    for (final colorObj in lightColorObjList) {
      loopCodeLight =
          '${loopCodeLight}static final ${colorObj.colorName} = lightColorScheme.${colorObj.colorType.name};\n';
    }

    debugPrint(loopCodeDark, wrapWidth: 1024);
    debugPrint(loopCodeLight, wrapWidth: 1024);

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


@immutable
class AppColors {
  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.lightSeedColor,
    brightness: Brightness.light,
  );
  
  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.darkSeedColor,
    brightness: Brightness.dark,
  );

  static final lightSeedColor = Color(
        int.parse(
          '${lightHexController.text}'.removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
  static final darkSeedColor = Color(
        int.parse(
          '${darkHexController.text}'.removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );

  $loopCodeLight

  $loopCodeDark
  
  const AppColors._();
}
  ''';

    await Clipboard.setData(ClipboardData(text: _code));
    debugPrint(_code, wrapWidth: 1024);
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

    return LayoutBuilder(
      builder: (context, constraints) {
        'constraints.maxHeight = ${constraints.maxHeight}'.log();
        'constraints.minHeight = ${constraints.minHeight}'.log();
        'constraints.maxWidth = ${constraints.maxWidth}'.log();
        'constraints.minWidth = ${constraints.minWidth}'.log();

        final width = constraints.minWidth;
        final height = constraints.minHeight -
            MediaQuery.of(context).padding.vertical -
            kToolbarHeight;

        height.log();

        final int smallScreenCrossAxisCount;
        final int largeScreenCrossAxisCount;

        if (width < 900 && width > 785) {
          smallScreenCrossAxisCount = 4;
        } else if (width <= 785 && width > 630) {
          smallScreenCrossAxisCount = 3;
        } else if (width <= 630) {
          smallScreenCrossAxisCount = 2;
        } else {
          smallScreenCrossAxisCount = 3;
        }

        if (width >= 900 && width < 1150) {
          largeScreenCrossAxisCount = 2;
        } else {
          largeScreenCrossAxisCount = 3;
        }

        if (width >= 900) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('App Color Picker'),
              actions: [
                const Text('Generate Code by'),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _generateCodeByColorCodes,
                  icon: const Icon(Icons.code),
                  label: const Text('Color Codes (Recommended)'),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _generateCodeByColorSchemeProperties,
                  icon: const Icon(Icons.code_off),
                  label: const Text('Color Scheme Properties'),
                ),
                const SizedBox(width: 10),
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
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
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: largeScreenCrossAxisCount,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                              ),
                              itemBuilder: (context, index) {
                                return ColorGridTile(
                                  colorObj: darkColorObjList[index],
                                  onPressed: () {
                                    _showDialogDark(
                                        darkColorObjList[index], context);
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
                              Expanded(
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
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: largeScreenCrossAxisCount,
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
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('App Color Picker'),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Generate Code by'),
                      const SizedBox(width: 10),
                      TextButton.icon(
                        onPressed: _generateCodeByColorCodes,
                        icon: const Icon(Icons.code),
                        label: Text(width < 600 ? '' : 'Color Codes'),
                      ),
                      const SizedBox(width: 10),
                      TextButton.icon(
                        onPressed: _generateCodeByColorSchemeProperties,
                        icon: const Icon(Icons.code_off),
                        label: Text(width < 600 ? '' : 'Color Scheme'),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
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
                            const SizedBox(
                              height: 36,
                            ),
                            SizedBox(
                              height: height - 200,
                              child: GridView.builder(
                                itemCount: colorClass.darkColorList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: smallScreenCrossAxisCount,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return ColorGridTile(
                                    colorObj: darkColorObjList[index],
                                    onPressed: () {
                                      _showDialogDark(
                                          darkColorObjList[index], context);
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
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
                            const SizedBox(
                              height: 36,
                            ),
                            SizedBox(
                              height: height - 200,
                              child: GridView.builder(
                                itemCount: colorClass.lightColorList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: smallScreenCrossAxisCount,
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
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
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
