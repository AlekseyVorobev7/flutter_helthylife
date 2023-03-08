import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MainTasksSlider extends StatefulWidget {
  const MainTasksSlider({super.key});

  @override
  State<MainTasksSlider> createState() => _MainTasksSliderState();
}

class _MainTasksSliderState extends State<MainTasksSlider> {
  double _water = 0;
  bool _isWater = false;
  bool _isWaterDone = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple,  Colors.deepPurple],
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              // ignore: prefer_const_constructors
              Align(
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: AutoSizeText(
                    'Выпей 2 литра воды за день',
                    maxFontSize: 22,
                    minFontSize: 8,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Font Awesome 5 Brands',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: AutoSizeText(
                  '$_water литра / 2 литров',
                  maxLines: 1,
                  maxFontSize: 18,
                  minFontSize: 6,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Font Awesome 5 Brands',
                  ),
                ),
              ),
              Slider(
                thumbColor: Colors.black,
                inactiveColor: Colors.transparent,
                activeColor: Colors.black,
                value: _water,
                max: 2,
                divisions: 4,
                onChanged: (double value) {
                  setState(
                    () {
                      _water = value;
                      if (_water == 2.0) {
                        _isWater = true;
                      } else {
                        _isWater = false;
                      }
                    },
                  );
                },
              ),
              Visibility(
                visible: _isWater,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                  child: OutlinedButton(
                    onPressed: _isWaterDone ? null : null,
                    style: OutlinedButton.styleFrom(
                      elevation: 0,
                      minimumSize: const Size(200, 45),
                      backgroundColor: const Color.fromARGB(255, 59, 238, 65),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      //padding: const EdgeInsets.all(15),
                      // ignore: prefer_const_constructor
                    ),
                    child: const Text(
                      'Забрать награду',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
