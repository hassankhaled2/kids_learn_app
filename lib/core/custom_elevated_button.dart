import 'package:flutter/material.dart';

Widget customElevatedButton({required String text,required VoidCallback  onPressed ,double minWidth =300,double maxHeight =60 } ){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        child: ConstrainedBox(
          constraints:  BoxConstraints(minWidth: minWidth, maxHeight: maxHeight),
          child: AspectRatio(
            aspectRatio: 1,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 20),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              onPressed:onPressed,
              child:  Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
