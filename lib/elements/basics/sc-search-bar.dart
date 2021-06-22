import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/exchange/blood/filter.dart';
import 'package:sihaclik/pages/exchange/book/filter.dart';
import 'package:sihaclik/pages/exchange/material/filter.dart';
import 'package:sihaclik/pages/exchange/medicine/filter.dart';
import 'package:sihaclik/pages/medicine/details.dart';
import 'package:sihaclik/pages/professional/details.dart';
import 'package:sihaclik/pages/search/sc-search-delegate.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/pages/search/sc-search.dart';
import 'package:sihaclik/store/models/medicine.dart';
import 'package:sihaclik/store/models/professional.dart';

class SCSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final void Function(String) onSubmitted;
  final String title;
  final bool sliver;
  final bool smaller;
  final SCSearchTypes type;
  SCSearchBar({
    Key key,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.onSubmitted,
    this.title,
    this.sliver = true,
    this.smaller = false,
    @required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return sliver
        ? SliverToBoxAdapter(
            child: SearchBarInner(
              key: key,
              controller: controller,
              focusNode: focusNode,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              title: title,
              type: type,
              smaller: smaller,
            ),
          )
        : SearchBarInner(
            key: key,
            controller: controller,
            focusNode: focusNode,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            title: title,
            type: type,
            smaller: smaller,
          );
  }
}

class SearchBarInner extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final void Function(String) onSubmitted;
  final SCSearchTypes type;
  final String title;
  final bool smaller;
  SearchBarInner({
    Key key,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.onSubmitted,
    this.title,
    this.smaller = false,
    this.type,
  }) : super(key: key);

  @override
  _SearchBarInnerState createState() => _SearchBarInnerState();
}

class _SearchBarInnerState extends State<SearchBarInner> {
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode == null ? FocusNode() : widget.focusNode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Directionality.of(context) == TextDirection.rtl
          ? EdgeInsets.only(right: 20, bottom: widget.smaller ? 15 : 25)
          : EdgeInsets.only(left: 20, bottom: widget.smaller ? 15 : 25),
      color: Theme.of(context).colorScheme.primary,
      height: widget.smaller ? 60 : 70,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: Directionality.of(context) == TextDirection.rtl
              ? const BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: focusNode,
                textInputAction: widget.textInputAction,
                keyboardType: widget.keyboardType,
                onSubmitted: widget.onSubmitted,
                onTap: widget.onSubmitted != null
                    ? null
                    : () async {
                        focusNode.unfocus();

                        final result = await showSCSearch(
                          context: context,
                          title: widget.title,
                          type: widget.type,
                          delegate: SCSearchDelegate(
                            type: widget.type,
                          ),
                        );

                        if (result != null && result is Medicine) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MedicineDetailsPage(),
                            ),
                          );
                        } else if (result != null && result is Professional) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProfessionalDetailsPage(),
                            ),
                          );
                        }
                      },
                decoration: InputDecoration(
                  hintText: context.translate('search'),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.onSubmitted != null
                  ? () => focusNode.requestFocus()
                  : () {
                      focusNode.unfocus();
                      showSCSearch(
                        context: context,
                        title: widget.title,
                        type: widget.type,
                        delegate: SCSearchDelegate(
                          type: widget.type,
                        ),
                      );
                    },
              child: Image.asset(
                "assets/icons/search.png",
                width: Theme.of(context).textTheme.headline5.fontSize,
                height: Theme.of(context).textTheme.headline5.fontSize,
              ),
            ),
            SizedBox(width: 10),
            if ([
              SCSearchTypes.Professional,
              SCSearchTypes.Medicine,
              SCSearchTypes.ExchangeBlood,
              SCSearchTypes.ExchangeMedicine,
              SCSearchTypes.ExchangeBook,
              SCSearchTypes.ExchangeMaterial,
            ].contains(widget.type))
              Center(
                child: Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius:
                        Directionality.of(context) == TextDirection.rtl
                            ? const BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4),
                              ),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      switch (widget.type) {
                        case SCSearchTypes.ExchangeMedicine:
                          SCModal.scShowModalBottomSheet(
                            context,
                            builder: (_) => MedicineFilterPage(),
                          );
                          break;
                        case SCSearchTypes.ExchangeMaterial:
                          SCModal.scShowModalBottomSheet(
                            context,
                            builder: (_) => MaterialFilterPage(),
                          );
                          break;
                        case SCSearchTypes.ExchangeBook:
                          SCModal.scShowModalBottomSheet(
                            context,
                            builder: (_) => BookFilterPage(),
                          );
                          break;
                        case SCSearchTypes.ExchangeBlood:
                          SCModal.scShowModalBottomSheet(
                            context,
                            builder: (_) => BloodFilterPage(),
                          );
                          break;
                        default:
                      }
                    },
                    child: Text(
                      context.translate('filter'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
