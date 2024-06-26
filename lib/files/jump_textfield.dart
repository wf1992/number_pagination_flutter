import 'package:flutter/material.dart';

class JumpTextfield extends StatelessWidget {
  /// Spacing between button groups, default is 10.0
  final double groupSpacing;

  /// placeholder for textfeild, always be page , default is 1
  final int placeHolderPage;

  ///Color of background. default is white.
  final Color colorBackGround;

  ///Color of title. default is white.
  final Color colorPrimary;

  ///title of confirmButton.
  final String confirmTitle;

  ///clicked confirmButton, callback context and input index
  final Function(BuildContext context,int index) tappedJump;

  ///you can pass in confirm widget
  final Widget? confirmWidget;

  ///Color of background. default is grey.
  final Color backgroundColor;

  ///Color of border. default is grey.
  final Color borderColor;

  ///width of border. default is 1.0.
  final double borderWidth;

  ///radius of border. default is 5.0.
  final double borderRadius;

  JumpTextfield({Key? key,required this.tappedJump,this.groupSpacing = 10, this.placeHolderPage = 1,this.colorBackGround = Colors.blue,this.confirmTitle = "确定"
    ,this.confirmWidget,this.colorPrimary = Colors.white,this.backgroundColor = Colors.white54,this.borderColor = Colors.grey,this.borderWidth = 1.0,this.borderRadius = 5.0}) : super(key: key);

  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Row(
        children: [
          SizedBox(width: groupSpacing),
          Container(
            width: 50,
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(
                  color: borderColor,
                  width: borderWidth,
                ),
                borderRadius: BorderRadius.circular(borderRadius)),
            child: TextField(
              controller: numberController,
              autofocus: false,
              enabled: true,
              maxLines: 1,//限制行数
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,//数字模式
              style: const TextStyle(fontSize: 14, color: Colors.black),
              decoration: InputDecoration.collapsed(
                hintText: "$placeHolderPage",
                hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
              ),
            ),
          ),
          SizedBox(width: groupSpacing),
          confirmWidget!=null ? confirmWidget! : ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              surfaceTintColor: Colors.transparent,
              padding: EdgeInsets.zero,
              minimumSize: Size(72, 48),
              backgroundColor: colorBackGround,
              foregroundColor: colorPrimary,
              disabledBackgroundColor: colorBackGround,
              disabledForegroundColor: colorPrimary,
            ),
            onPressed: (){
              if(numberController.text.isNotEmpty) {
                tappedJump(context,int.parse(numberController.text.trim()));
              }
            },
            child: Text(confirmTitle,style: TextStyle(fontSize: 16, color: colorPrimary),),
          )
        ],
      ),
    );
  }

  doNothing(){

  }
}
