import 'package:flutter/material.dart';

enum DotType { circle, icon }

class Loader extends StatefulWidget {
  final List<Color> colors;
  final Duration duration;
  final DotType dotType;
  final Icon dotIcon;

  const Loader(
      {super.key,
      this.colors = const [
        Color.fromARGB(255, 32, 101, 158),
        Color.fromARGB(255, 13, 95, 76),
        Color.fromARGB(255, 39, 142, 201),
        Color.fromARGB(255, 38, 229, 229)
      ],
      this.duration = const Duration(milliseconds: 1000),
      this.dotType = DotType.circle,
      this.dotIcon = const Icon(Icons.blur_on)});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late List<Animation<double>> animations;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    animations = getAnimations();

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.colors.length, (i) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0.0,
                -60 *
                    (animations[i].value <= 0.50
                        ? animations[i].value
                        : 1.0 - animations[i].value),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Dot(
                  radius: 20.0,
                  color: widget.colors[i],
                  type: widget.dotType,
                  icon: widget.dotIcon,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  List<Animation<double>> getAnimations() {
    List<Animation<double>> list = [];
    int len = widget.colors.length;
    for (int i = 0; i < widget.colors.length; i++) {
      list.add(Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.1 * i, 1.1 - 0.2 * (len - i), curve: Curves.ease),
        ),
      ));
    }
    return list;
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;
  final DotType? type;
  final Icon? icon;

  const Dot({super.key, this.radius, this.color, this.type, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: type == DotType.icon
          ? Icon(
              icon!.icon,
              color: color,
              size: 1.3 * radius!,
            )
          : Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
    );
  }
}
