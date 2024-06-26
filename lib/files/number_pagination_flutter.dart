library number_pagination;

import 'package:flutter/material.dart';

import 'control_button.dart';
import 'jump_textfield.dart';
import 'number_button.dart';
import 'page_number_provider.dart';

class NumberPaginationFlutter extends StatelessWidget {
  /// Creates a NumberPaginationFlutter
  NumberPaginationFlutter({
    required this.onPageChanged,
    required this.pageTotal,
    this.threshold = 10,
    this.pageInit = 1,
    this.colorPrimary = Colors.black,
    this.colorBackGround = Colors.white,
    this.controlButton,
    this.iconToFirst = const Icon(Icons.first_page),
    this.iconPrevious = const Icon(Icons.keyboard_arrow_left),
    this.iconNext = const Icon(Icons.keyboard_arrow_right),
    this.iconToLast = const Icon(Icons.last_page),
    this.fontSize = 15,
    this.fontFamily,
    this.buttonElevation = 5,
    this.buttonRadius = 10,
    this.buttonSpacing = 4.0,
    this.groupSpacing = 10.0,
    this.canJump = true,
  });

  ///Trigger when page changed
  final Function(int) onPageChanged;

  ///End of numbers.
  final int pageTotal;

  ///Page number to be displayed first, default is 1.
  final int pageInit;

  ///Numbers to show at once. default is 10.
  final int threshold;

  ///Color of numbers. default is black.
  final Color colorPrimary;

  ///Color of background. default is white.
  final Color colorBackGround;

  ///to First, to Previous, to next, to Last Button UI.
  final Widget? controlButton;

  ///The icon of button to first.
  final Widget iconToFirst;

  ///The icon of button to previous.
  final Widget iconPrevious;

  ///The icon of button to next.
  final Widget iconNext;

  ///The icon of button to last.
  final Widget iconToLast;

  ///The size of numbers. default is 15.
  final double fontSize;

  ///The fontFamily of numbers.
  final String? fontFamily;

  ///The elevation of the buttons.
  final double buttonElevation;

  ///The Radius of the buttons.
  final double buttonRadius;

  // Spacing between buttons, default is 4.0
  final double buttonSpacing;

  // Spacing between button groups, default is 10.0
  final double groupSpacing;

  // can jump to page you wanted index ,default is open
  final bool canJump;

  @override
  Widget build(BuildContext context) {
    final pageService = NumberPageService(pageInit);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: NumberPageContainer(
        pageService: pageService,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListenableBuilder(
              listenable: pageService,
              builder: (_, __) => Row(
                children: [
                  ControlButton(
                    buttonElevation,
                    buttonRadius,
                    colorPrimary,
                    colorBackGround,
                    iconToFirst,
                    pageService.currentPage != 1,
                    (c) => _changePage(c, 1),
                  ),
                  SizedBox(width: buttonSpacing),
                  ControlButton(
                    buttonElevation,
                    buttonRadius,
                    colorPrimary,
                    colorBackGround,
                    iconPrevious,
                    pageService.currentPage != 1,
                    (c) => _changePage(c, pageService.currentPage - 1),
                  ),
                ],
              ),
            ),
            SizedBox(width: groupSpacing),
            Flexible(
              fit: FlexFit.loose,
              child: ListenableBuilder(
                listenable: pageService,
                builder: (context, child) {
                  final currentPage = pageService.currentPage;

                  final rangeStart = currentPage % threshold == 0
                      ? currentPage - threshold
                      : (currentPage ~/ threshold) * threshold;

                  final rangeEnd = rangeStart + threshold > pageTotal
                      ? pageTotal
                      : rangeStart + threshold;

                  return Row(mainAxisSize: MainAxisSize.min, children: [
                    for (var i = rangeStart; i < rangeEnd; i++)
                      NumberButton(
                        i + 1,
                        buttonElevation,
                        buttonRadius,
                        colorPrimary,
                        colorBackGround,
                        fontSize,
                        fontFamily ?? '',
                        (c, number) {
                          _changePage(c, number);
                        },
                      )
                  ]);
                },
              ),
            ),
            SizedBox(width: groupSpacing),
            ListenableBuilder(
              listenable: pageService,
              builder: (_, __) => Row(
                children: [
                  ControlButton(
                    buttonElevation,
                    buttonRadius,
                    colorPrimary,
                    colorBackGround,
                    iconNext,
                    pageService.currentPage != pageTotal,
                    (c) => _changePage(c, pageService.currentPage + 1),
                  ),
                  SizedBox(width: buttonSpacing),
                  ControlButton(
                    buttonElevation,
                    buttonRadius,
                    colorPrimary,
                    colorBackGround,
                    iconToLast,
                    pageService.currentPage != pageTotal,
                    (c) {
                      _changePage(c, pageTotal);
                    },
                  ),
                  SizedBox(width: groupSpacing),
                  Visibility(
                      visible: canJump,
                      child: JumpTextfield(tappedJump: (context,index){
                        if(index>0 && index<=pageTotal) {
                          _changePage(context , index);
                        }else {
                          print('please enter a valid number');
                        }
                      },groupSpacing: 10,placeHolderPage: pageService.currentPage,)),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _changePage(BuildContext context, targetPage) {
    int newPage = targetPage.clamp(1, pageTotal);

    if (NumberPageContainer.of(context).currentPage != newPage) {
      NumberPageContainer.of(context).currentPage = newPage;
      onPageChanged(newPage);
    }
  }
}

class NumberPageContainer extends InheritedWidget {
  final NumberPageService pageService;

  const NumberPageContainer({required this.pageService, required super.child});

  @override
  bool updateShouldNotify(covariant NumberPageContainer oldWidget) {
    return oldWidget.pageService != pageService;
  }

  static NumberPageService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NumberPageContainer>()!
        .pageService;
  }
}
