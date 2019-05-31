part of '../custom_ui.dart';

class CustomButton extends StatelessWidget {

  CustomButton({
    @required this.child,
    @required this.onTap,
    this.color
  });

  final Widget child;
  final VoidCallback onTap;
  final Color color;

  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(12.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: this._borderRadius,
        onTap: this.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 6.0),
          child: this.child
        ),
      )
    );
  }
}