import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/color_utils.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'button.dart';
import 'input.dart';

/// A comprehensive color picker with advanced editing capabilities.
///
/// Features:
/// - Saturation/Value Picker
/// - Hue Slider
/// - Hex Input with Copy
/// - Editable RGB, CMYK, HSV, HSL info
/// - Preset list
class FpdColorPicker extends StatefulWidget {
  const FpdColorPicker({
    super.key,
    required this.colors,
    this.selectedColor,
    required this.onColorChanged,
  });

  /// The list of preset colors to display.
  final List<Color> colors;

  /// The currently selected color.
  final Color? selectedColor;

  /// Callback called when a color is selected or changed.
  final ValueChanged<Color> onColorChanged;

  @override
  State<FpdColorPicker> createState() => _FpdColorPickerState();
}

class _FpdColorPickerState extends State<FpdColorPicker> {
  late HSVColor _currentHsv;
  TextEditingController _hexController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateColor(widget.selectedColor ?? Colors.blue);
  }

  @override
  void didUpdateWidget(FpdColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedColor != null && widget.selectedColor != oldWidget.selectedColor) {
       // Only update if external change is significantly different
       if (widget.selectedColor!.value != _currentHsv.toColor().value) {
           _updateColor(widget.selectedColor!);
       }
    }
  }

  void _updateColor(Color color) {
    setState(() {
      _currentHsv = HSVColor.fromColor(color);
      _hexController.text = ColorUtils.toHex(color);
    });
  }
  
  void _onHsvChanged(HSVColor hsv) {
      setState(() {
          _currentHsv = hsv;
          _hexController.text = ColorUtils.toHex(hsv.toColor());
      });
      widget.onColorChanged(hsv.toColor());
  }

  void _onExternalColorChanged(Color color) {
    // Called when sub-widgets (like RGB/CMYK fields) change the color
    setState(() {
      _currentHsv = HSVColor.fromColor(color);
      _hexController.text = ColorUtils.toHex(color);
    });
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _currentHsv.toColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Saturation/Value Box
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _SaturationValuePicker(
                hsvColor: _currentHsv,
                onChanged: _onHsvChanged,
            ),
          ),
        ),
        const Gap(16),
        
        // Hue Slider
        _HueSlider(
            hsvColor: _currentHsv, 
            onChanged: _onHsvChanged,
        ),
        
        const Gap(16),

        // Hex Input Row
        Row(
            children: [
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
                    ),
                ),
                const Gap(12),
                Expanded(
                    child: FpduiInput(
                        controller: _hexController,
                        hintText: 'HEX',
                        onChanged: (value) {
                            if (value.startsWith('#') && value.length == 7 || value.length == 6) {
                                final newColor = ColorUtils.fromHex(value);
                                if (newColor != null) {
                                    setState(() {
                                        _currentHsv = HSVColor.fromColor(newColor);
                                    });
                                    widget.onColorChanged(newColor);
                                }
                            }
                        },
                    ),
                ),
                const Gap(8),
                _CopyButton(value: _hexController.text),
            ],
        ),

        const Gap(16),

        // Editable Color Info
        _ColorInfoEditor(
          color: color, 
          onChanged: _onExternalColorChanged,
        ),

        const Gap(24),
        const Text("Presets", style: TextStyle(fontWeight: FontWeight.w600)),
        const Gap(8),

        // Presets
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.colors.map((c) {
            final isSelected = c.value == color.value;
            return GestureDetector(
              onTap: () {
                 _updateColor(c);
                 widget.onColorChanged(c);
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 16, color: c.computeLuminance() > 0.5 ? Colors.black : Colors.white)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SaturationValuePicker extends StatelessWidget {
  const _SaturationValuePicker({required this.hsvColor, required this.onChanged});
  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanDown: (details) => _handleInput(details.localPosition, constraints.biggest),
          onPanUpdate: (details) => _handleInput(details.localPosition, constraints.biggest),
          child: Stack(
            children: [
              // Base Hue
              Container(color: HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor()),
              // Saturation Gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.transparent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              // Value Gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Selector
              Positioned(
                left: hsvColor.saturation * constraints.maxWidth - 10,
                top: (1 - hsvColor.value) * constraints.maxHeight - 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: hsvColor.toColor(),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleInput(Offset position, Size size) {
    double saturation = (position.dx / size.width).clamp(0.0, 1.0);
    double value = 1.0 - (position.dy / size.height).clamp(0.0, 1.0);
    onChanged(hsvColor.withSaturation(saturation).withValue(value));
  }
}

class _HueSlider extends StatelessWidget {
  const _HueSlider({required this.hsvColor, required this.onChanged});
  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanDown: (details) => _handleInput(details.localPosition, constraints.biggest),
            onPanUpdate: (details) => _handleInput(details.localPosition, constraints.biggest),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF0000), Color(0xFFFFFF00), Color(0xFF00FF00),
                    Color(0xFF00FFFF), Color(0xFF0000FF), Color(0xFFFF00FF), Color(0xFFFF0000)
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                    Positioned(
                        left: (hsvColor.hue / 360) * constraints.maxWidth - 10,
                        child: Container(
                            width: 20,
                            height: 20,
                             decoration: BoxDecoration(
                                color: HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor(),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                            ),
                        ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

   void _handleInput(Offset position, Size size) {
    double hue = ((position.dx / size.width) * 360).clamp(0.0, 360.0);
    onChanged(hsvColor.withHue(hue));
  }
}

class _ColorInfoEditor extends StatefulWidget {
  const _ColorInfoEditor({required this.color, required this.onChanged});
  final Color color;
  final ValueChanged<Color> onChanged;

  @override
  State<_ColorInfoEditor> createState() => _ColorInfoEditorState();
}

class _ColorInfoEditorState extends State<_ColorInfoEditor> {
  late TextEditingController _rgbController;
  late TextEditingController _cmykController;
  late TextEditingController _hsvController;
  late TextEditingController _hslController;
  
  Color? _lastColor;

  @override
  void initState() {
    super.initState();
    _rgbController = TextEditingController();
    _cmykController = TextEditingController();
    _hsvController = TextEditingController();
    _hslController = TextEditingController();
    _updateControllers(widget.color);
  }

  @override
  void didUpdateWidget(_ColorInfoEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != oldWidget.color && widget.color != _lastColor) {
       _updateControllers(widget.color);
    }
  }

  void _updateControllers(Color color) {
     final rgb = ColorUtils.getRGB(color);
     final cmyk = ColorUtils.getCMYK(color);
     final hsv = ColorUtils.getHSV(color);
     final hsl = ColorUtils.getHSL(color);

     _rgbController.text = '${rgb['r']}, ${rgb['g']}, ${rgb['b']}';
     _cmykController.text = '${cmyk['c']}, ${cmyk['m']}, ${cmyk['y']}, ${cmyk['k']}';
     _hsvController.text = '${hsv['h']}, ${hsv['s']}, ${hsv['v']}';
     _hslController.text = '${hsl['h']}, ${hsl['s']}, ${hsl['l']}';
  }

  void _notifyChange(Color newColor) {
      _lastColor = newColor;
      widget.onChanged(newColor);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
                _EditableColorField(
                  label: 'RGB', 
                  controller: _rgbController, 
                  onChanged: (val) {
                    final color = ColorUtils.fromRGB(val);
                    if (color != null) _notifyChange(color);
                  },
                ),
                _EditableColorField(
                  label: 'CMYK', 
                  controller: _cmykController,
                  onChanged: (val) {
                    final color = ColorUtils.fromCMYK(val);
                    if (color != null) _notifyChange(color);
                  },
                ),
                _EditableColorField(
                  label: 'HSV', 
                  controller: _hsvController,
                  onChanged: (val) {
                    final color = ColorUtils.fromHSV(val);
                    if (color != null) _notifyChange(color);
                  },
                ),
                _EditableColorField(
                  label: 'HSL', 
                  controller: _hslController,
                  onChanged: (val) {
                    final color = ColorUtils.fromHSL(val);
                    if (color != null) _notifyChange(color);
                  },
                ),
            ],
        );
    });
  }
}

class _EditableColorField extends StatelessWidget {
    const _EditableColorField({
      required this.label, 
      required this.controller,
      required this.onChanged,
    });
    final String label;
    final TextEditingController controller;
    final ValueChanged<String> onChanged;

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context);
        return Container(
            width: (MediaQuery.of(context).size.width > 600) ? 200 : 140, // Responsive width
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(label, style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurface.withValues(alpha: 0.6), fontWeight: FontWeight.bold)),
                    const Gap(4),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 36,
                            child: FpduiInput(
                              controller: controller,
                              onChanged: onChanged,
                              hintText: label,
                            ),
                          ),
                        ),
                        const Gap(4),
                        _CopyButton(value: controller.text),
                      ],
                    ),
                ],
            ),
        );
    }
}

class _CopyButton extends StatelessWidget {
  const _CopyButton({required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: IconButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: value));
        },
        icon: const Icon(LucideIcons.copy, size: 16),
        tooltip: 'Copy',
        padding: EdgeInsets.zero,
      ),
    );
  }
}
