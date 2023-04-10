import 'package:flutter/material.dart';


class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  const OptionTile(
      {super.key,
      required this.option,
      required this.description,
      required this.correctAnswer,
      required this.optionSelected});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color:   widget.description == widget.optionSelected 
               ? widget.optionSelected == widget.correctAnswer
                  ? Colors.green.withOpacity(0.7)
                  : Colors.red.withOpacity(0.7)
                  :Colors.white,
              border: Border.all(
                 color:
               widget.description == widget.optionSelected 
               ? widget.optionSelected == widget.correctAnswer
                  ? Colors.green.withOpacity(0.7)
                  : Colors.red.withOpacity(0.7)
                  :Colors.grey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(30))
            ),
            child: Center(
              child: Text(
                widget.option,
                style: TextStyle(
                  color:widget.optionSelected == widget.description ?
                   widget.correctAnswer == widget.optionSelected ?
                   Colors.black: 
                   Colors.black
                   :Colors.black54 
                  
                  ),
              ),
            ), 
          ),
          const SizedBox(width: 8,),
          Text(widget.description,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black54
          ),)
        ],
      ),
    );
  }
}


