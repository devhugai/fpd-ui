# Flutter Pilot Dev - EXPERIMENTAL FPDUI 

**FPDUI** is a AI Development experiment to portof the [shadcn/ui](https://ui.shadcn.com/) ecosystem to Flutter. It aims to provide a set of re-usable, accessible, and customizable components that you can copy and paste into your apps or use as a library.

## 🚀 Features

- **Port of shadcn/ui**: Faithful recreation of the design system and components.
- **Flutter Native**: built on top of `ThemeData` and `ColorScheme` but extended where necessary.
- **Customizable**: Designed to be adapted to your brand's style.
- **Modern Stack**: Leverages `flutter_riverpod` for state management, `go_router` for routing, and `flutter_animate` for animations.

## 📦 Tech Stack

- **State Management**: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- **Routing**: [go_router](https://pub.dev/packages/go_router)
- **Icons**: [lucide_icons](https://pub.dev/packages/lucide_icons)
- **Typography**: [google_fonts](https://pub.dev/packages/google_fonts)
- **Animations**: [flutter_animate](https://pub.dev/packages/flutter_animate)
- **Layout**: [gap](https://pub.dev/packages/gap)

## 🛠️ Installation & Usage

Currently, this project is structured as a local package/monorepo.

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/flutterpilot/fpd-ui.git
    ```

2.  **Add dependency** (if using as a local package):
    ```yaml
    dependencies:
      fpdui:
        path: ./path/to/fpdui
    ```

3.  **Import and use**:
    ```dart
    import 'package:fpdui/fpdui.dart';

    // Use components
    Button(
      label: Text('Click me'),
      onPressed: () {},
    )
    ```

## 🧩 Components

The library includes a wide range of components implemented in phases:

### Primitives
- **Button** (Default, Secondary, Destructive, Outline, Ghost, Link)
- **Badge**
- **Avatar**
- **Card**
- **Separator**
- **Skeleton**
- **Label**

### Inputs & Forms
- **Input** (TextField)
- **Textarea**
- **Checkbox**
- **Switch**
- **RadioGroup**
- **Slider**
- **Progress**
- **Form** (Validation & Layout)

### Overlays & Feedback
- **Dialog**
- **AlertDialog**
- **Sheet** (Side Drawer)
- **Popover**
- **Tooltip**
- **Sonner** (Toast)
- **ContextMenu**
- **DropdownMenu**

### Navigation & Layout
- **Accordion**
- **Collapsible**
- **Tabs**
- **ScrollArea**
- **Resizable**
- **Sidebar**
- **NavigationMenu**
- **Breadcrumb**

### Data Display & Complex
- **Table** (DataTable)
- **Command** (Command Palette)
- **Calendar**
- **Carousel**
- **Chart**

## 🎨 Theming

We use a **Hybrid Approach**:
1.  **Standard Material**: We map shadcn tokens to standard Flutter `ColorScheme` conventions (e.g., `primary`, `error` as `destructive`).
2.  **Theme Extensions**: Custom tokens (like `ring`, `radius`, `muted`) are handled via `FpduiTheme` extensions to ensure complete design fidelity.

## 📂 Project Structure

```text
lib/
├── components/   # Individual UI components
├── theme/        # Theme definitions & extensions
├── pages/        # Documentation & Showcase pages
├── routes/       # GoRouter configuration
└── utils/        # Internal helpers
```

## 🤝 Contributing

Contributions are welcome! Please follow the `master_plan.md` and adhere to the project's coding standards.

1.  Follow the [Conventional Commits](https://www.conventionalcommits.org/) style.
2.  Ensure linting passes with `flutter_lints`.

## 📄 License

This project is licensed under the MIT License.

---

**Flutter Pilot Dev** | [flutterpilot.dev](https://flutterpilot.dev) | contact: dash@flutterpilot.dev
