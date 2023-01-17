import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:flutter_path_morph/flutter_path_morph.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> with SingleTickerProviderStateMixin {
  List<String> number_list = [
    "M32.7324 0.681641H34.8477C41.8984 2.24023 45.4238 5.76563 45.4238 11.2578V156.318C44.0879 163.666 40.3027 167.34 34.0684 167.34H33.2891C25.9414 165.781 22.2676 162.293 22.2676 156.875V28.1797C17.2949 29.8125 13.4727 30.6289 10.8008 30.6289C5.53125 30.6289 2.04297 27.1035 0.335938 20.0527V17.4922C0.335938 11.5547 6.83008 7.25 19.8184 4.57812L32.7324 0.681641Z",
    "M49,28 l46,-2 l5,66 l-50,1 l4,44 l45,-1 l-2,9 l-49,1 l-5,-62 l48,-1 l-3,-47 l-40,2 l2,-2 l-2,2",
    "M94.85833,59.00438c7.03244-5.62596,33.1449-27.77888,37.17535-5.61137c2.27786,12.52822,4.26015,31.51236-5.61137,41.38388-2.22088,2.22088-5.3173,4.6576-8.41706,5.61137-3.82516,1.17697-13.71398,4.98246-11.92417,1.40284c3.64579-7.29158,33.77806,1.21686,37.17535,6.3128c19.15223,28.72834-17.89041,64.87736-42.78672,39.98104",
    "M74.48747,62.18679c0,10.38155-2.01193,68.28315,3.41686,74.48747c4.466,5.104,28.93807,1.36674,35.53531,1.36674c4.0047,0,24.09716,2.38181,26.65148-.68337c3.82695-4.59234-13.55117-10.10085-15.71754-11.61731-2.19852-1.53896-19.179026-19.627286-19.1344-18.45103.094628,2.494201,4.410451,62.174353,0,73.1207334",
    "M148.97494,51.93622c-14.62165,0-28.50098,2.73349-43.05239,2.73349-1.36674,0-3.30583-1.11216-4.10023,0-2.09205,2.92887,3.41686,20.03654,3.41686,24.60137c0,2.72702-1.6782,25.12901,0,25.96811c7.14473,3.57236,36.4158-33.02149,56.03645,3.41686c11.7404,21.8036-25.19415,65.44631-47.83599,47.83599-3.5634-2.77154-4.97199-7.70547-8.20046-10.93394",
    "M62.18679,23.23462c-45.43066,15.14356-48.14739,88.58453-4.10023,92.25513c6.60044.55004,12.58567-1.32138,17.76765-5.46697C118.05424,76.26276,45.8558,58.42031,41.68565,79.27107",
  ];
  var _homePath = parseSvgPathData(
    "M49,28 l46,-2 l5,66 l-50,1 l4,44 l45,-1 l-2,9 l-49,1 l-5,-62 l48,-1 l-3,-47 l-40,2 l2,-2 l-2,2",
  );
  var _appleScaleMatrix4;
  late var _applePath;
  late final _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1));
      
  @override
  void initState() {
    super.initState();
    // _controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _controller.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _controller.forward();
    //   }
    // });
    // _controller.forward();
    _appleScaleMatrix4 = Matrix4.identity()..scale(0.2, 0.2);
    _applePath = parseSvgPathData(
      "M148.97494,51.93622c-14.62165,0-28.50098,2.73349-43.05239,2.73349-1.36674,0-3.30583-1.11216-4.10023,0-2.09205,2.92887,3.41686,20.03654,3.41686,24.60137c0,2.72702-1.6782,25.12901,0,25.96811c7.14473,3.57236,36.4158-33.02149,56.03645,3.41686c11.7404,21.8036-25.19415,65.44631-47.83599,47.83599-3.5634-2.77154-4.97199-7.70547-8.20046-10.93394",
    ).transform(_appleScaleMatrix4.storage);
  }

  int index = 0;
  TextEditingController number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: number,
                    decoration: InputDecoration(
                        labelText: "Enter your favourite number",
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        index = int.parse(value);
                        print(index);
                        print(number_list[index]);
                        _appleScaleMatrix4 = Matrix4.identity()
                          ..scale(0.2, 0.2);
                        _applePath = parseSvgPathData(
                          number_list[index],
                        ).transform(_appleScaleMatrix4.storage);
                      });
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // _applePath = parseSvgPathData(number_list[index]);
                            _controller.forward();
                            // _controller.reverse();
                          });
                        },
                        child: Text("Submit"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // _homePath = parseSvgPathData(number_list[index]);
                            // _controller.forward();
                            _controller.reverse();
                          });
                        },
                        child: Text("Back"),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 120, top: 50, left: 30),
                    child: MorphWidget(
                      controller: _controller,
                      path1: _homePath,
                      path2: _applePath,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
