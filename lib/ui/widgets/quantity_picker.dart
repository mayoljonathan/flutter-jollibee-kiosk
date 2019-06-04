import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';

class QuantityPicker extends StatefulWidget {
  QuantityPicker({
    this.initialValue = 1,
    this.minValue = 1,
    this.maxValue = 99,
    this.onChanged
  });

  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged; 

  @override
  _QuantityPickerState createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {

  int _currentValue;

  @override
  void initState() {
    super.initState();
    this._currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // final double _opacity = _currentValue > 1 ? 1.0 : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildIncDecButton(
          icon: EvaIcons.minus,
          onTap: _currentValue > widget.minValue ? () => setState(() {
            _currentValue--;
            widget.onChanged(_currentValue);
          }) : null,
          isDisabled: _currentValue == widget.minValue
        ),
        _buildQuantityText(),
        _buildIncDecButton(
          icon: EvaIcons.plus,
          onTap: _currentValue < widget.maxValue ? () => setState(() {
            _currentValue++;
            widget.onChanged(_currentValue);
          }) : null,
          isDisabled: _currentValue == widget.maxValue
        ),
      ],
    );
  }

  Widget _buildQuantityText() {
    return SizedBox(
      width: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          child: Text(_currentValue.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 3
            )
          ),
        ),
      ),
    );
  }

  Widget _buildIncDecButton({@required IconData icon, @required VoidCallback onTap, bool isDisabled}) {
    return CustomBouncingContainer(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: !isDisabled ? kRed : kRed.withOpacity(0.3),
        ),
        padding: const EdgeInsets.all(6.0),
        child: Icon(icon, 
          color: Colors.white, 
          size: SizeConfig.blockSizeHorizontal * 5
        ),
      )
    );
  }
}