part of '../custom_ui.dart';

class CustomBouncingContainer extends StatefulWidget {
  CustomBouncingContainer({
    @required this.child,
    this.onTap,
    this.onLongPress,
    this.upperBound = 0.1
  });

  final Widget child;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final double upperBound;

  @override
  _CustomBouncingContainerState createState() => _CustomBouncingContainerState();
}

class _CustomBouncingContainerState extends State<CustomBouncingContainer> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    this._animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: widget.upperBound
    );
    this._animationController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    this._animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    double scale = 1 - _animationController.value;
    return GestureDetector(
      onTap: widget.onTap,
      onTapCancel: () {
        // print('onTapCancel');
        this._animationController.reverse();
      },
      onTapUp: (_) {
        // print('onTapUp');
        this._animationController.reverse();
      },
      onTapDown: (_) {
        // print('onTapDown');
        this._animationController.forward();
      },
      onLongPress: widget.onLongPress != null ? () {
        // print('onLongPress');
        this._animationController.forward();
        widget.onLongPress();
      } : null,
      onLongPressEnd: widget.onLongPress != null ? (_) {
        // print('onLongPressEnd');
        this._animationController.reverse();
      } : null,
      child: Transform.scale(
        scale: scale,
        child: widget.child
      ),
    );
  }
}