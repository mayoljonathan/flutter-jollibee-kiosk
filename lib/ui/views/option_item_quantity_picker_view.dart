import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/widgets/quantity_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class OptionItemQuantityPickerView extends StatefulWidget {
  OptionItemQuantityPickerView({
    Key key,
    @required this.optionItem,
    this.initialQuantity = 1,
    this.maxQuantity = 1
  }) : super(key : key);

  final OptionItem optionItem;
  final int initialQuantity;
  final int maxQuantity;

  @override
  _OptionItemQuantityPickerViewState createState() => _OptionItemQuantityPickerViewState();
}

class _OptionItemQuantityPickerViewState extends State<OptionItemQuantityPickerView> {
  
  int _currentQuantity;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return FullscreenDialog(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildHeader(),
              SizedBox(height: 12.0),
              Row(
                children: <Widget>[
                  _buildItemImage(),
                  SizedBox(width: 24.0),
                  Expanded(child: _buildItemName()),
                ],
              ),
              SizedBox(height: 48.0),
              _buildFooter(context)
            ],
          )
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text('How many would you like?', style: TextStyle(
      fontSize: kTitleTextSize,
      fontWeight: FontWeight.bold
    ));
  }

  Widget _buildItemImage() {
    return Hero(
      tag: 'optionItem-${widget.optionItem.id}',
      child: FadeInImage.memoryNetwork(
        key: ValueKey(widget.optionItem.id),
        placeholder: kTransparentImage,
        image: widget.optionItem.image,
        fit: BoxFit.contain,
        width: (SizeConfig.blockSizeHorizontal * 30),
      ),
    );
  }

  Widget _buildItemName() {
    return Text(widget.optionItem.name, style: TextStyle(
      fontSize: kSubheadTextSize,
    ));
  }

  Widget _buildFooter(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text('Quantity', style: TextStyle(
              fontSize: kBodyTextSize
            )),
            SizedBox(height: 12.0),
            QuantityPicker(
              initialValue: _currentQuantity,
              minValue: 0,
              maxValue: widget.maxQuantity,
              onChanged: (int qty) => _currentQuantity = qty
            ),
          ],
        ),
        SizedBox(height: 24.0),
        _buildActionButtons(context)
      ],
    );
  }

  Widget _buildActionButtons(context) {
    return Row(
      children: <Widget>[
        Expanded(child: _buildActionButtonItem(context, text: 'Cancel')),
        SizedBox(width: 18.0),
        Expanded(
          child: _buildActionButtonItem(context, 
            text: 'Update', 
            color: kGreen,
            onTap: () => Navigator.of(context).pop(_currentQuantity)
          )
        ),
      ],
    );
  }

  Widget _buildActionButtonItem(BuildContext context, {@required String text, VoidCallback onTap, Color color = kRed}) {
    return CustomBouncingContainer(
      onTap: onTap == null ? () => Navigator.pop(context) : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: color,
        ),
        padding: const EdgeInsets.all(18.0),
        child: Text(text, 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: kActionButtonTextSize
          )
        )
      )
    );
  }
}