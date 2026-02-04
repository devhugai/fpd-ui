# Master Plan: Porting shadcn/ui to Flutter

This document outlines the systematic approach to replicating the `shadcn/ui` ecosystem in Flutter. The goal is to provide a feature-complete port including the design system, components, routing, and a showcase application.

## 1. Project Setup & Foundation

### 1.1 Initialization
- [x] Initialize Flutter project in `F:\Proyectos\FlutterPilot.dev\fpd-ui\fpdui`.
- [x] Configure `pubspec.yaml` with essential dependencies:
  - `flutter_riverpod` (State Management)
  - `go_router` (Routing)
  - `flutter_animate` (Animations)
  - `google_fonts` (Typography)
  - `lucide_icons` (Iconography)
  - `intl` (Localization/Formatting)
  - `gap` (Layout spacing)

### 1.2 Architecture
- [x] Establish directory structure:
  ```
  lib\
  ├── components\   # Individual UI components (shadcn equivalents)
  ├── theme\        # Theme extensions and token definitions
  ├── pages\        # Documentation/Showcase pages
  ├── routes\       # GoRouter configuration
  ├── utils\        # Helper functions
  └── main.dart     # Entry point
  ```

### 1.3 Theming System (Hybrid Approach)
We will leverage Flutter's native `ThemeData` and `ColorScheme` as the foundation, mapping shadcn tokens to standard Material properties where possible. We will ONLY use `ThemeExtension` for shadcn-specific concepts that fit awkwardly into Material Design.

- [x] **Standard Mapping**: Map shadcn colors to `ColorScheme` (e.g., `primary` -> `primary`, `destructive` -> `error`, `background` -> `surface`).
- [x] **Extension for Gaps**: Create `FpduiTheme` extension for specific tokens lacking direct equivalents:
  - `muted`, `accent`, `popover`, `card` (if specific styling needed), `border`, `input`, `ring`.
  - `radius` values.
- [x] Implement Light/Dark mode toggling using `Riverpod`.
- [x] Configure `GoogleFonts` (Inter or Geist equivalent) as the default text theme.

## 2. Component Implementation Roadmap

Components will be built in phases, starting from primitives used by others.

### Phase 2.1: Primitives & Base
- [x] `Button` (Variants: Default, Secondary, Destructive, Outline, Ghost, Link).
- [x] `Badge` (Variants match Button).
- [x] `Avatar` (Image, Fallback).
- [x] `Card` (Header, Title, Description, Content, Footer).
- [x] `Separator`.
- [x] `Skelton` (Loading states).
- [x] `Label`.

### Phase 2.2: Inputs & Forms
- [x] `Input` (TextField styling). <!-- id: 24 -->
- [x] `Textarea` (Input with multiline). <!-- id: 25 -->
- [x] `Checkbox`. <!-- id: 26 -->
- [x] `Switch`. <!-- id: 27 -->
- [x] `RadioGroup`. <!-- id: 28 -->
- [x] `Slider`. <!-- id: 29 -->
- [x] `Progress`. <!-- id: 30 -->
- [x] `Form` (Layout wrapper `FpduiFormItem`). <!-- id: 31 -->

### Phase 2.3: Overlays & Feedback
- [x] `Dialog` (Modal).
- [x] `AlertDialog`.
- [x] `Sheet` (Side Drawer).
- [x] `Popover` (Anchor-based overlay).
- [x] `Tooltip`.
- [x] `Sonner/Toast` (SnackBar replacement).
- [x] `Context Menu`.2
- [x] `Dropdown Menu`.

### Phase 2.4: Navigation & Layout
- [x] `Accordion`.
- [x] `Collapsible`.
- [ ] `Tabs` (Underlined active state).
- [ ] `ScrollArea` (Custom scrollbar styling).
- [ ] `Resizable` (Split view panel).
- [ ] `Sidebar` (Complex responsive sidebar with collapse/expand).
- [ ] `NavigationMenu` (Header navigation).
- [ ] `Breadcrumb`.

### Phase 2.5: Complex Data & Visuals
- [ ] `Table` (DataTable with custom styling).
- [ ] `Command` (Command Palette - Search interface).
- [ ] `Calendar` (DatePicker).
- [ ] `Carousel`.
- [ ] `Chart` (Wrapper around `fl_chart` to match Shadcn style).

## 3. Showcase Application (Documentation Site)

Replicate the `apps/v4` documentation site to demonstrate the components.

- [ ] Create generic `ComponentPage` layout.
- [ ] Implement `Route` structure matching the web:
  - `/docs/components/button`
  - `/docs/components/card`
  - etc.
- [ ] Create a "Sink" page (Kitchen Sink) to view all components at once for theming tests.
- [ ] Implement Theme Configurator (Color picker, Radius picker) similar to the website.

## 4. Verification & Testing

- [ ] Widget Tests for each primitive ensuring variant styling (visual regression or property checks).
- [ ] Integration Test for the Command Palette and Navigation flows.
- [ ] Manual verification via the Showcase App.

## 5. Next Steps

1.  Initialize the project.
2.  Set up the Theme System (This is the blocker for all components).
3.  Begin Phase 2.1 (Primitives).
