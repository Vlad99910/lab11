import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RadiusProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Corner Radius',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Container Corner Radius')),
        body: RadiusConfigurationSection(),
      ),
    );
  }
}

class RadiusProvider with ChangeNotifier {
  double _topLeftRadius = 0;
  double _topRightRadius = 0;
  double _bottomLeftRadius = 0;
  double _bottomRightRadius = 0;

  double get topLeftRadius => _topLeftRadius;
  double get topRightRadius => _topRightRadius;
  double get bottomLeftRadius => _bottomLeftRadius;
  double get bottomRightRadius => _bottomRightRadius;

  void setTopLeftRadius(double newRadius) {
    _topLeftRadius = newRadius;
    notifyListeners();
  }

  void setTopRightRadius(double newRadius) {
    _topRightRadius = newRadius;
    notifyListeners();
  }

  void setBottomLeftRadius(double newRadius) {
    _bottomLeftRadius = newRadius;
    notifyListeners();
  }

  void setBottomRightRadius(double newRadius) {
    _bottomRightRadius = newRadius;
    notifyListeners();
  }
}


class RoundedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final radiusProvider = Provider.of<RadiusProvider>(context);

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusProvider.topLeftRadius),
          topRight: Radius.circular(radiusProvider.topRightRadius),
          bottomLeft: Radius.circular(radiusProvider.bottomLeftRadius),
          bottomRight: Radius.circular(radiusProvider.bottomRightRadius),
        ),
      ),
    );
  }
}

class RadiusConfigurationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedContainer(), 
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadiusSlider(
                    label: "TL",
                    getValue: (provider) => provider.topLeftRadius,
                    setValue: (provider, value) => provider.setTopLeftRadius(value),
                  ),
                  RadiusSlider(
                    label: "TR",
                    getValue: (provider) => provider.topRightRadius,
                    setValue: (provider, value) => provider.setTopRightRadius(value),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadiusSlider(
                    label: "BL",
                    getValue: (provider) => provider.bottomLeftRadius,
                    setValue: (provider, value) => provider.setBottomLeftRadius(value),
                  ),
                  RadiusSlider(
                    label: "BR",
                    getValue: (provider) => provider.bottomRightRadius,
                    setValue: (provider, value) => provider.setBottomRightRadius(value),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class RadiusSlider extends StatelessWidget {
  final String label;
  final double Function(RadiusProvider) getValue;
  final void Function(RadiusProvider, double) setValue;

  RadiusSlider({
    required this.label,
    required this.getValue,
    required this.setValue,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RadiusProvider>(
      builder: (context, radiusProvider, child) {
        double value = getValue(radiusProvider);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$label: ${value.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Slider(
              min: 0,
              max: 75,
              value: value,
              onChanged: (newRadius) => setValue(radiusProvider, newRadius),
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.deepPurple[100],
            ),
          ],
        );
      },
    );
  }
}
