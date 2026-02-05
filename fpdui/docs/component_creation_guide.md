# Guía de Creación de Componentes FPD UI

Esta guía establece las prácticas obligatorias para crear nuevos componentes en `fpdui` manteniendo la consistencia visual y de arquitectura del sistema.

## 1. Principios Generales

*   **Prefijo:** Todos los componentes deben llevar el prefijo `Fpdui` (ej. `FpduiCard`, `FpduiButton`).
*   **Archiv:** Nombres en snake_case (ej. `my_component.dart`).
*   **Ubicación:** `lib/components/`.

## 2. Uso del Tema (`FpduiTheme`)

Nunca utilices valores "hardcodeados" para colores, bordes o radios. Debes consumir el tema extendido.

```dart
final theme = Theme.of(context);
final fpduiTheme = theme.extension<FpduiTheme>()!;
```

### Colores
Usa los colores semánticos definidos en `FpduiTheme` y `ColorScheme`:

*   **Fondo:** `theme.colorScheme.background`
*   **Texto Principal:** `theme.colorScheme.onBackground`
*   **Primario:** `fpduiTheme.primary` / `fpduiTheme.primaryForeground`
*   **Secundario:** `fpduiTheme.secondary` / `fpduiTheme.secondaryForeground`
*   **Muted (Deshabilitado/Sutil):** `fpduiTheme.muted` / `fpduiTheme.mutedForeground`
*   **Bordes:** `fpduiTheme.border` o `fpduiTheme.input`

### Dimensiones (Radio)
Usa los tokens de radio para consistencia:

*   **Estándar:** `fpduiTheme.radius` (Por defecto para botones, inputs, etc.)
*   **Pequeño:** `fpduiTheme.radiusSm` (Checkboxes, badges, elementos internos)
*   **Grande:** `fpduiTheme.radiusLg` (Dialogs, Modals)
*   **Extra Grande (Card):** `fpduiTheme.radiusXl` (Cards, contenedores grandes)

## 3. Tipografía

**NO** uses `fontSize` fijo. Usa la escala tipográfica de Material 3 adaptada:

| Contexto | Estilo Recomendado | Ejemplo |
| :--- | :--- | :--- |
| **Párrafo / Input / Botón** | `bodyMedium` | 14px Regular/Medium |
| **Texto Pequeño / Badge** | `labelSmall` | 11/12px Medium |
| **Título Pequeño / Label** | `titleSmall` o `labelLarge` | 14px Medium |
| **Título Tarjeta / Sección** | `titleLarge` | 22px Regular |
| **Encabezado** | `headlineSmall` | 24px Regular |

**Ejemplo de implementación correcta:**
```dart
Text(
  'Mi Texto',
  style: theme.textTheme.bodyMedium?.copyWith(
    color: fpduiTheme.mutedForeground,
    fontWeight: FontWeight.w500,
  ),
)
```

## 4. Plantilla de Componente

Usa esta estructura base para nuevos componentes:

```dart
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiMyComponent extends StatelessWidget {
  const FpduiMyComponent({
    super.key,
    required this.child,
    this.variant = FpduiMyComponentVariant.defaultVariant,
  });

  final Widget child;
  final FpduiMyComponentVariant variant;

  @override
  Widget build(BuildContext context) {
    // 1. Acceder al tema
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // 2. Determinar estilos dinámicos
    Color backgroundColor;
    switch (variant) {
      case FpduiMyComponentVariant.defaultVariant:
        backgroundColor = fpduiTheme.primary;
        break;
      case FpduiMyComponentVariant.secondary:
        backgroundColor = fpduiTheme.secondary;
        break;
    }

    // 3. Construir widget usando tokens
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
        border: Border.all(color: fpduiTheme.border),
      ),
      child: DefaultTextStyle(
        style: theme.textTheme.bodyMedium!.copyWith(
          color: fpduiTheme.primaryForeground,
        ),
        child: child,
      ),
    );
  }
}

enum FpduiMyComponentVariant { defaultVariant, secondary }
```

## 5. Checklist de Verificación
Antes de finalizar un componente:
- [ ] ¿Soporta Light y Dark mode automáticamente? (Sin `if (isDark)` manuales, usando tokens).
- [ ] ¿El texto escala si cambio el tamaño de fuente del sistema? (Uso de `textTheme`).
- [ ] ¿Los radios de borde usan `fpduiTheme.radius*`?
- [ ] ¿El componente es `const` si es posible?
