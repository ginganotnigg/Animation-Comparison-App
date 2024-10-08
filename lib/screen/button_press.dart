import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ButtonPressScreen extends StatefulWidget {
  final bool useBuiltIn;

  const ButtonPressScreen({super.key, required this.useBuiltIn});

  @override
  State<ButtonPressScreen> createState() => _ButtonPressScreenState();
}

class _ButtonPressScreenState extends State<ButtonPressScreen>
    with SingleTickerProviderStateMixin {
  SMITrigger? _onClick;
  double _scale = 1.0;
  double _shadowBlur = 0.0;

  void _onButtonPressed() {
    if (_onClick != null) {
      _onClick!.fire();
    }

    setState(() {
      _scale = 0.8;
      _shadowBlur = 70.0;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
        _shadowBlur = 0.0; // Reset the shadow after the effect
      });
    });
  }

  // Initialize Rive state machine
  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
        artboard, 'State Machine 1'); // State machine name
    if (controller != null) {
      artboard.addController(controller);
      _onClick = controller.findInput('CLICK') as SMITrigger?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.useBuiltIn
            // Flutter Button
            ? AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2895FF),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: const Color(0xFF8EC6FF),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: _shadowBlur,
                        spreadRadius: _shadowBlur,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Flutter Button',
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            :
            // Rive Button
            GestureDetector(
                onTap: _onButtonPressed,
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: RiveAnimation.asset(
                    'lib/assets/rive/button_press.riv',
                    fit: BoxFit.cover,
                    onInit: _onRiveInit, // Initialize the Rive animation
                  ),
                ),
              ),
      ),
    );
  }
}
