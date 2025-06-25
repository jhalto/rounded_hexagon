A lightweight and customizable Flutter widget that displays a **hexagon with rounded corners**. Great for avatars, badges, buttons, and more.

## Features

- Draws a perfect hexagon with customizable rounded corners
- Easily place any widget inside (e.g., text, icon, image)
- Adjustable size, color, and corner radius
- Simple and reusable API

## Getting started

### 1. Install

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  rounded_hexagon: ^0.0.1
```
## Usage
```dart
import 'package:rounded_hexagon/rounded_hexagon.dart';

RoundedHexagon(
  size: 60,
  color: Colors.teal,
  radius: 12,
  child: Icon(Icons.star, color: Colors.white),
)
```
## Additional information
