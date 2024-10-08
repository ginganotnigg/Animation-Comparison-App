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

  void _onButtonPressed() {
    if (_onClick != null) {
      _onClick!.fire();
    }

    setState(() {
      _scale = 1.1;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }

  // Hàm khởi tạo điều khiển Rive
  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
        artboard, 'State Machine 1'); // Tên state machine
    if (controller != null) {
      artboard.addController(controller);
      _onClick = controller.findInput('Button_Click')
          as SMITrigger?; // Input từ state machine
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.useBuiltIn
            ? Transform.scale(
                scale: _scale,
                child: ElevatedButton(
                  onPressed: _onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 64, vertical: 32),
                  ),
                  child: const Text(
                    'Flutter Button',
                    style: TextStyle(fontSize: 36),
                  ),
                ),
              )
            : GestureDetector(
                onTap: _onButtonPressed,
                child: RiveAnimation.asset(
                  'lib/assets/rive/button_press.riv',
                  fit: BoxFit.cover,
                  onInit: _onRiveInit,
                ),
              ),
      ),
    );
  }
}
