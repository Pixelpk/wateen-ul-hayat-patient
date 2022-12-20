// Project imports:
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swift_care/constants/colors.dart';

class CustomLoader {
  static CustomLoader? _loader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_loader != null) {
      return _loader!;
    } else {
      _loader = CustomLoader._createObject();
      return _loader!;
    }
  }

  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: buildLoader(),
              color: Colors.black.withOpacity(.3),
            )
          ],
        );
      },
    );
  }

  show(context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState!.insert(_overlayEntry!);
  }

  hide() {
    try {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
    } catch (_) {}
  }

  buildLoader({isTransparent: false}) {
    return Center(
      child: Container(
        color: isTransparent ? Colors.transparent : Colors.transparent,
        child: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor)

            )), //CircularProgressIndicator(),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  static OverlayEntry? _currentLoader;

  Loader._(this._progressIndicator, this._themeData);

  final Widget _progressIndicator;
  final ThemeData _themeData;

  static OverlayState? _overlayState;

  static void show(var context,
      {Widget? progressIndicator,
        bool isAppbarOverlay = false,
        bool isBottomBarOverlay = true}) {
    _overlayState = Overlay.of(context);
    if (_currentLoader == null) {
      _currentLoader = new OverlayEntry(builder: (context) {
        return Stack(
          children: <Widget>[
            SafeArea(
              child: Container(
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
            Center(
                child: Loader._(
                  progressIndicator ??
                      Center(child: SpinKitFadingCircle(color: COLOR_middleblue)),
                  ThemeData.dark(),
                )),
          ],
        );
      });
      try {
        WidgetsBinding.instance?.addPostFrameCallback(
                (_) => _overlayState?.insertAll([_currentLoader!]));
      } catch (e) {}
    }
  }

  static void hide() {
    if (_currentLoader != null) {
      try {
        _currentLoader?.remove();
      } catch (e) {
      } finally {
        _currentLoader = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Theme(data: _themeData, child: _progressIndicator));
  }
}
