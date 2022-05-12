import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  Rating({
    Key? key,
    this.score = 0,
  }) : super(key: key);

  final double score;

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late double _score = widget.score;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 50.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(
              5,
              (index) {
                return GestureDetector(
                  key: ValueKey(index + 1),
                  onTap: () {
                    setState(() {
                      _score = index + 1;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 50.0,
                    height: 50.0,
                  ),
                );
              },
            ),
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: SizedBox(
            height: 50.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.filled(
                5,
                Container(
                  child: Image.asset('images/star_grey.png'),
                ),
              ),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: SizedBox(
            height: 50.0,
            child: ClipRect(
              clipper: RatingClipper(_score),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.filled(
                  5,
                  Container(
                    child: Image.asset('images/star.png'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RatingClipper extends CustomClipper<Rect> {
  final double score;

  RatingClipper(this.score);

  @override
  Rect getClip(Size size) {
    return const Offset(0, 0) & Size(size.width * score * 0.2, 50.0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
