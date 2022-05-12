import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  Rating({
    Key? key,
    this.score = 0,
    this.stars = 5,
  })  : assert(
          stars >= 0 && stars <= 20,
          'stars should be between 0 and 20',
        ),
        assert(
          score >= 0 && score <= stars,
          'score should be between 0 and stars total',
        ),
        super(key: key);

  final double score;
  final int stars;

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late double _score = widget.score;
  late double _height = MediaQuery.of(context).size.width / widget.stars;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: _height,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(widget.stars, (index) {
              return Expanded(
                child: GestureDetector(
                  key: ValueKey(index + 1),
                  onTap: () {
                    setState(() {
                      _score = index + 1;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: _height,
                    height: _height,
                  ),
                ),
              );
            }),
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: SizedBox(
            height: _height,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.filled(
                widget.stars,
                Expanded(
                  child: Image.asset('images/star_grey.png'),
                ),
              ),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: SizedBox(
            height: _height,
            child: ClipRect(
              clipper: RatingClipper(
                _score,
                _height,
                widget.stars,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.filled(
                  widget.stars,
                  Expanded(
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
  final double height;
  final int stars;

  RatingClipper(this.score, this.height, this.stars);

  @override
  Rect getClip(Size size) {
    return const Offset(0, 0) & Size(size.width * score / stars, height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
