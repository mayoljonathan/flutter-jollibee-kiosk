import 'dart:async';

import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:jollibee_kiosk/core/viewmodels/item_detail_model.dart';
import 'package:jollibee_kiosk/ui/views/base_view.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:after_layout/after_layout.dart';

import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';

import 'item_options.dart';

class OptionItemTileList extends StatefulWidget {
  OptionItemTileList({
    Key key,
    this.itemOption,
    this.optionCategory,
    this.optionController,
    this.maxDrinkSelection = 1,
    this.maxAddOnSelection = 1,
  }) : super(key:key);

  final ItemOption itemOption;
  final OptionCategory optionCategory;
  final StreamController<DateTime> optionController;
  final int maxDrinkSelection;
  final int maxAddOnSelection;

  @override
  OptionItemTileListState createState() => OptionItemTileListState();
}

class OptionItemTileListState extends State<OptionItemTileList> with AfterLayoutMixin<OptionItemTileList> {

  final double _optionItemTileHeight = 200;
  ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) => setState(() {});
  void _onScroll() => setState(() {});

  bool _shouldArrowLeftShow(bool arrowLeft) {
    if (_scrollController.hasClients) {
      if (arrowLeft) {
        return _scrollController.offset <= 50;
      } else {
        return _scrollController.offset >= (_scrollController.position.maxScrollExtent - 25);
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemDetailModel>(
      builder: (context, model, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
            child: Container(
            height: _optionItemTileHeight,
            color: kCanvasColor,
              child: Stack(
                children: <Widget>[
                  ListView.separated(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.optionCategory.items.length,
                    itemBuilder: (BuildContext context, int i) => OptionItemTile(
                      key: ValueKey(widget.optionCategory.items[i].id),
                      optionItem: widget.optionCategory.items[i],
                      onTap: () => model.onOptionItemTileTap(context, widget.itemOption, widget.optionCategory.items[i]),
                      selectedCount: model.getOptionItemSelectedCount(widget.itemOption, widget.optionCategory.items[i]),
                    ),
                    separatorBuilder: (BuildContext context, int i) => SizedBox(width: 6.0),
                  ),
                  Positioned(
                    left: 0,
                    height: _optionItemTileHeight,
                    child: Align(
                      alignment: Alignment.center,
                      child: IgnorePointer(
                        ignoring: _shouldArrowLeftShow(true),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: !_shouldArrowLeftShow(true) ? 1 : 0,
                          child: _buildArrowLeft(true),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    height: _optionItemTileHeight,
                    child: Align(
                      alignment: Alignment.center,
                      child: IgnorePointer(
                        ignoring: _shouldArrowLeftShow(false),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: !_shouldArrowLeftShow(false) ? 1 : 0,
                          child: _buildArrowLeft(false),
                        ),
                      ),
                    ),
                  )
                ],
              ),
          ),
        );  
      },
    );
  }

  Widget _buildArrowLeft(bool arrowLeft) {
    IconData icon = arrowLeft ? EvaIcons.arrowCircleLeft : EvaIcons.arrowCircleRight;
    EdgeInsets padding = arrowLeft ? EdgeInsets.only(left: 12) : EdgeInsets.only(right: 12);
    return CustomBouncingContainer(
      onTap: () {
        double itemSize = _scrollController.position.maxScrollExtent / widget.optionCategory.items.length;
        double positionOffset = _scrollController.offset - (itemSize * 3); // Defaults to arrowLeft
        if (!arrowLeft) positionOffset = _scrollController.offset + (itemSize * 3);
        _scrollController.animateTo(positionOffset, duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
      },
      child: Padding(
        padding: padding,
        child: Icon(icon, size: SizeConfig.blockSizeHorizontal * 5),
      ),
    );
  }

}

class OptionItemTile extends StatelessWidget {
  OptionItemTile({
    Key key,
    this.optionItem,
    this.selectedCount = 0,
    this.onTap,
  }) : super(key: key);
  
  final OptionItem optionItem;
  final int selectedCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 23,
      // padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CustomBouncingContainer(
        upperBound: 0.25,
        onTap: onTap,
        child: Container(
          decoration: getOptionItemTileDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: SizeConfig.blockSizeHorizontal * 15,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: 'optionItem-${optionItem.id}',
                        placeholderBuilder: (context, widget) => widget,
                        child: FadeInImage.memoryNetwork(
                          key: ValueKey(optionItem.id),
                          placeholder: kTransparentImage,
                          image: optionItem.image,
                          fit: BoxFit.contain
                        ),
                      ),
                    ),
                    optionItem.price != null ? Align(
                      alignment: Alignment.bottomRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(3.0),
                          bottomRight: Radius.circular(3.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6.0),
                          color: kRed,
                          child: Text('add ${optionItem.priceToString()}' , style: TextStyle(
                            color: Colors.white,
                            fontSize: kOverlineTextSize,
                            fontWeight: FontWeight.bold
                          ))
                        ),
                      )
                    ) : Container()
                  ],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                optionItem.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: kCaptionTextSize,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(selectedCount.toString())
            ],
          ),
        ),
      )
    );
  }

  BoxDecoration getOptionItemTileDecoration() {
    if (selectedCount <= 0) return null;

    return BoxDecoration(
      border: Border.all(
        color: kRed,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12.0)
    );
  }
}

class OptionItemCart {
  String id;
  int quantity;
  double price;

  OptionItemCart({this.id, this.quantity, this.price});
}