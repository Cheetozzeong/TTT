import 'package:flutter/material.dart';


class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    Key? key,
    this.value,
    this.enableColor,
    this.disableColor,
    this.switchHeight,
    this.switchWidth,
    this.onChanged,
  }) : super(key: key);

  final bool? value;
  final Color? enableColor;
  final Color? disableColor;
  final double? switchHeight;
  final double? switchWidth;
  final ValueChanged<bool>? onChanged;

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
        begin: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
        end: widget.value! ? Alignment.centerLeft :Alignment.centerRight).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false ? widget.onChanged!(true) : widget.onChanged!(false);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation.value ==  Alignment.centerLeft ? widget.disableColor : widget.enableColor,),
            child: Padding(padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child:  Container(
                alignment: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: widget.switchWidth ?? 20.0,
                  height: widget.switchHeight ?? 20.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}