import 'dart:ui' as ui;

import '../export.dart';

class CustomSlider extends StatefulWidget {
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double sliderValue = 1.0;
  ui.Image? customImage;
  ImageInfo? imageInfo;

  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 15,
      targetWidth: 50,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  Future<ImageInfo> getImageInfo(BuildContext context) async {
    AssetImage assetImage = AssetImage("assets/icons/thumb.png");
    ImageStream stream =
        assetImage.resolve(createLocalImageConfiguration(context));
    Completer<ImageInfo> completer = Completer();
    stream.addListener(ImageStreamListener((ImageInfo imageInfo, _) {
      return completer.complete(imageInfo);
    }));
    return completer.future;
  }

  Future<void> loadImageInfo() async {
    Future.delayed(Duration.zero, () async {
      imageInfo = await getImageInfo(context);
      setState(() {});
    });
  }

  @override
  void initState() {
    loadImageInfo();
    load('assets/icons/thumb.png').then((image) {
      setState(() {
        customImage = image;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getImageInfo(context).then((value) {
      setState(() {});
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return imageInfo != null
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: hMargin),
            child: SliderTheme(
              data: SliderThemeData(
                trackShape: RectangularSliderTrackShape(),
                activeTrackColor: buttonColor,
                inactiveTrackColor: lDropDownColor,
                thumbShape: SliderThumbImage(imageInfo!, sliderValue),
                // trackShape: RoundedRectSliderTrackShape(),

                trackHeight: 10,
                overlayShape: SliderComponentShape.noThumb,

                // overlayShape: RoundSliderOverlayShape(
                //   overlayRadius: 12,
                // ),
                overlayColor: Colors.transparent,
              ),
              child: Slider(
                onChanged: (value) {
                  sliderValue = value;
                  setState(() {});
                },
                value: sliderValue,
                min: 1,
                max: 10,
              ),
            ),
          )
        : Container();
  }
}

const thumbSideLength = 50.0;

class SliderThumbImage extends SliderComponentShape {
  // final ui.Image image;
  final ImageInfo myImageInfo;
  final double sliderValue;
  SliderThumbImage(this.myImageInfo, this.sliderValue);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(0, 0);
  }

  @override
  void paint(PaintingContext context, ui.Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required ui.TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required ui.Size sizeWithOverflow}) {
    print('DX $sliderValue $value ${center.dx}');
    paintImage(
      canvas: context.canvas,
      rect: Rect.fromCenter(
        center: ui.Offset(center.dx, center.dy),
        width: (myImageInfo.image.width.toDouble() * 0.25) / myImageInfo.scale,
        height:
            (myImageInfo.image.height.toDouble() * 0.25) / myImageInfo.scale,
      ),
      image: myImageInfo.image, // <- the loaded image
      filterQuality: FilterQuality.high,
    );
  }
}
