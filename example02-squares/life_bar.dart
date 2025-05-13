import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum LifeBarPlacement { left, center, right }

class LifeBar extends PositionComponent {
  static const Color _redColor = Colors.red;
  static const Color _greenColor = Colors.green;

  static final Paint _backgroundFillColor =
      Paint()
        ..color = Colors.grey.withAlpha(185)
        ..style = PaintingStyle.fill;

  // the ourline of the bar color and style
  static final Paint _outlineColor =
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

  static const int _maxLife = 100;
  // default threshold separating a healthy bar from danger
  static const int _healthThreshold = 25;
  static const double _defaultBarOffset = 2;

  int _life = _maxLife;
  // the current color in the bar
  late Paint _color;
  // the set threshold for warning color to show up
  late int _warningThreshold;
  // the warning color being used
  late Paint _warningColorStyled;
  late Color _warningColor;
  // the hearlthy color being used
  late Paint _healthyColorStyled;
  late Color _healthyColor;
  // the size of this life bar
  late Vector2 _size;
  // the bounding rectangle for the parent's size
  late Vector2 _parentSize;
  // the number of pixels away form the parent's edge
  late double _barToParentOffset;
  // the placement of the bar in relation to the parent
  late LifeBarPlacement _placement;
  // the 3 rectangles that comprise the bar's rectangles
  List<RectangleComponent> _lifeBarElements = List<RectangleComponent>.filled(
    3,
    RectangleComponent(size: Vector2(1, 1)),
    growable: false,
  );

  LifeBar.initData(
    Vector2 parentSize, {
    int? warningThreshold,
    Color? warningColor,
    Color? healthyColor,
    Vector2? size,
    double? barOffset,
    LifeBarPlacement? placement,
  }) {
    _warningColor = warningColor ?? _redColor;
    _warningThreshold = warningThreshold ?? _healthThreshold;
    _healthyColor = healthyColor ?? _greenColor;
    _parentSize = parentSize;
    _size = size ?? Vector2(_parentSize.x, 5);
    _barToParentOffset = barOffset ?? _defaultBarOffset;
    _placement = placement ?? LifeBarPlacement.left;

    /// additional data
    ///
    anchor = Anchor.center;
    _healthyColorStyled =
        Paint()
          ..color = _healthyColor
          ..style = PaintingStyle.fill;
    _warningColorStyled =
        Paint()
          ..color = _warningColor
          ..style = PaintingStyle.fill;

    _updateCurrentColor();
  }

  int get currentLife {
    return _life;
  }

  set currentLife(int value) {
    if (value > _maxLife) {
      _life = _maxLife;
    } else if (value < 0) {
      _life = 0;
    } else {
      _life = value;
    }
  }

  void incrementCurrentLifeBy(int incrementValue) {
    currentLife = _life + incrementValue;
  }

  void decrementCurrentLifeBy(int decrementValue) {
    currentLife = max(0, _life - decrementValue);
  }

  Color get warningColor {
    return _warningColorStyled.color;
  }

  Color get healthyColor {
    return _healthyColorStyled.color;
  }

  void _updateCurrentColor() {
    if (_life < _warningThreshold) {
      _color = _warningColorStyled;
    } else {
      _color = _healthyColorStyled;
    }
  }

  Vector2 _calculateBarPosition() {
    Vector2 result;

    switch (_placement) {
      case LifeBarPlacement.left:
        {
          result = Vector2(0, -_size.y - _barToParentOffset);
        }
        break;
      case LifeBarPlacement.center:
        {
          result = Vector2(
            (_parentSize.x - _size.x) / 2,
            -_size.y - _barToParentOffset,
          );
        }
        break;
      case LifeBarPlacement.right:
        {
          result = Vector2(
            _parentSize.x - _size.x,
            -_size.y - _barToParentOffset,
          );
        }
        break;
    }

    return result;
  }

  @override
  Future<void>? onLoad() {
    _lifeBarElements = [
      // Fill
      RectangleComponent(
        position: _calculateBarPosition(),
        size: _size,
        angle: 0,
        paint: _backgroundFillColor,
      ),
      // Health
      RectangleComponent(
        position: _calculateBarPosition(),
        size: Vector2(10, _size.y),
        angle: 0,
        paint: _color,
      ),
      // Stroke
      RectangleComponent(
        position: _calculateBarPosition(),
        size: _size,
        angle: 0,
        paint: _outlineColor,
      ),
    ];
    addAll(_lifeBarElements);
    super.onLoad();
  }

  @override
  void update(double dt) {
    _updateCurrentColor();
    _lifeBarElements[1].paint = _color;
    _lifeBarElements[1].size.x = (_size.x / _maxLife) * _life;
    super.update(dt);
  }
}
