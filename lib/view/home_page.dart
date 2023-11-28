import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  Color _selectedColor = Colors.black;
  String userText = '';
  double _fontSize = 16.0;

  Offset _ofset = const Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Style your Text'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, Constraints) {
                    return Stack(
                      children: [
                        Positioned(
                          left: _ofset.dx,
                          top: _ofset.dy,
                          child: LongPressDraggable(
                            feedback: Text(
                              userText,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: _fontSize,
                              ),
                            ),
                            child: Text(
                              userText,
                              style: TextStyle(
                                color: _selectedColor,
                                fontSize: _fontSize,
                              ),
                            ),
                            onDragEnd: (details) {
                              setState(() {
                                double adjestMent =
                                    MediaQuery.of(context).size.height -
                                        Constraints.maxHeight;
                                _ofset = Offset(details.offset.dx,
                                    details.offset.dy - adjestMent);
                              });
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 270,
                  child: Slider(
                      min: 5,
                      max: 200,
                      value: _fontSize,
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                      }),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: const Text(
                              'Pick Color',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            children: [
                              ColorPicker(
                                  pickerColor: _selectedColor,
                                  onColorChanged: (Color) {
                                    _selectedColor = Color;
                                    setState(() {});
                                  }),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Colors.purple,
                                child: const Text(
                                  'Select Color',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: _selectedColor,
                        borderRadius: BorderRadius.circular(18)),
                  ),
                )
              ],
            ),
            FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            SizedBox(
                              width: 350,
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                    label: const Text('Add Text'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    userText = textController.text;
                                  });
                                },
                                child: const Text('Add'))
                          ],
                        ));
              },
              child: const Text(
                'Text',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
