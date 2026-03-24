# BTG Capital — Gestión de Fondos de Inversión

Aplicación Flutter multiplataforma para la gestión de fondos de inversión FPV y FIC de clientes BTG. Compatible con **web**, **Android** e **iOS**.

---

## Tabla de Contenidos

1. [Descripción](#descripción)
2. [Arquitectura](#arquitectura)
3. [Stack Tecnológico](#stack-tecnológico)
4. [Prerrequisitos](#prerrequisitos)
5. [Instalación](#instalación)
6. [Ejecución en Web](#ejecución-en-web)
7. [Ejecución en Android](#ejecución-en-android)
8. [Ejecución en iOS](#ejecución-en-ios)
9. [Build de Producción](#build-de-producción)
10. [Tests](#tests)
11. [Fondos Disponibles](#fondos-disponibles)
12. [Decisiones Técnicas](#decisiones-técnicas)

---

## Descripción

BTG Capital permite a los usuarios:

- Visualizar fondos de inversión disponibles (FPV y FIC)
- Suscribirse a fondos cumpliendo el monto mínimo requerido
- Cancelar suscripciones y recuperar el saldo invertido
- Ver el historial completo de transacciones
- Seleccionar método de notificación (Email o SMS)
- Consultar el saldo disponible en tiempo real

El usuario inicia con un saldo de **COP $500.000**. Los datos se cargan desde `assets/mock/funds.json` simulando latencia de red (700 ms).

---

## Arquitectura

Se implementó **Clean Architecture** con separación estricta de capas:

```
lib/
├── main.dart
├── app/
│   ├── app.dart            → Raíz de la app (MaterialApp)
│   ├── router.dart         → Rutas con GoRouter
│   └── widgets/            → widgets de navegación y layout (sidebar / bottom nav)
├── core/
│   ├── constants/          → AppConstants (saldo inicial, símbolo de moneda)
│   ├── errors/             → Excepciones de dominio tipadas (AppException y subclases)
│   ├── theme/              → AppTheme (colores, tipografía)
│   └── utils/              → CurrencyFormatter, FadeInWrapper
└── features/
    └── funds/
        ├── data/
        │   ├── datasources/    → FundsLocalDatasource (lectura del JSON)
        │   ├── models/         → FundModel (serialización/deserialización)
        │   └── repositories/   → FundsRepositoryImpl
        ├── domain/
        │   ├── entities/       → FundEntity, TransactionEntity, PortfolioEntryEntity
        │   ├── enums/          → FundCategoryEnum, NotificationMethodEnum, TransactionTypeEnum
        │   ├── repositories/   → FundsRepository (contrato abstracto)
        │   └── usecases/       → GetFunds, SubscribeToFund, CancelFundSubscription, GetTransactions
        └── presentation/
            ├── providers/      → Riverpod: FundsRepositoryNotifier, PortfolioNotifier, fundsProvider
            ├── screens/        → Dashboard, Funds, Transactions, SubscribeScreen
            └── widgets/        → Componentes por feature (common/dashboard/funds/subscribe/transactions)
```

### Capas

| Capa | Responsabilidad |
|------|----------------|
| **Domain** | Entidades de negocio, contratos de repositorio, casos de uso con `Either<AppException, T>` |
| **Data** | Implementación del repositorio, datasources, serialización JSON |
| **Presentation** | Pantallas, widgets, estado reactivo con Riverpod |

### Flujo de datos

```
Presentation (Riverpod Notifiers)
    └── llama a → Use Cases (domain)
                    └── usa → FundsRepository (contrato)
                                └── implementado por → FundsRepositoryImpl (data)
                                                           └── depende de → FundsLocalDatasource
```

Los casos de uso retornan `Either<AppException, T>` de la librería `dartz`. Nunca se lanzan excepciones entre capas; los errores de negocio se representan como valores tipados.

---

## Stack Tecnológico

### Dependencias de producción

| Paquete | Versión | Uso |
|---------|---------|-----|
| `flutter_riverpod` | ^2.6.1 | Manejo de estado reactivo |
| `riverpod_annotation` | ^2.3.5 | Code generation para providers (`@Riverpod`) |
| `go_router` | ^14.8.1 | Navegación declarativa con `ShellRoute` |
| `dartz` | ^0.10.1 | Tipo `Either<L, R>` para manejo funcional de errores |
| `google_fonts` | ^6.2.1 | Tipografía Inter |
| `intl` | ^0.20.2 | Formato de moneda COP |

### Dependencias de desarrollo

| Paquete | Versión | Uso |
|---------|---------|-----|
| `mockito` | ^5.4.4 | Generación de mocks para tests unitarios |
| `build_runner` | ^2.4.11 | Generación de código (`@GenerateMocks`, `@Riverpod`) |
| `riverpod_generator` | ^2.4.3 | Genera `.g.dart` para providers con anotaciones |

---

## Prerrequisitos

### General

- **Flutter SDK >= 3.11.0**  
  Verificar con: `flutter --version`
- **Dart SDK >= 3.11.0** (incluido con Flutter)
- Git

### Para Web

- Navegador **Google Chrome** instalado

### Para Android

- **Android Studio** con el SDK de Android instalado  
  _(mínimo API 21 — Android 5.0)_
- Un dispositivo Android físico **con depuración USB habilitada**, o un **emulador** creado en Android Studio (AVD Manager)

### Para iOS _(solo macOS)_

- **macOS** como sistema operativo (iOS no puede compilarse en Windows/Linux)
- **Xcode >= 14** instalado desde la App Store
- **CocoaPods**: `sudo gem install cocoapods`
- Un dispositivo físico iOS o el **Simulador** de Xcode
- La carpeta `ios/` debe generarse antes de la primera ejecución (ver [Ejecución en iOS](#ejecución-en-ios))

> Verificar que todo esté configurado correctamente:
> ```bash
> flutter doctor
> ```
> Todos los ítems relevantes deben mostrar ✅ antes de continuar.

---

## Instalación

```bash
# 1. Clonar el repositorio
git clone <repo-url>
cd btg_capital

# 2. Instalar dependencias
flutter pub get
```

---

## Ejecución en Web

```bash
# Listar dispositivos disponibles (debe aparecer Chrome)
flutter devices

# Ejecutar en Chrome (modo debug con hot-reload)
flutter run -d chrome
```

La app se abrirá automáticamente en una ventana de Chrome en `http://localhost:<puerto>`.

> **Nota:** Si sirves el build manualmente con `flutter build web`, usa un servidor HTTP local. Abrir `index.html` directamente desde el sistema de archivos no funciona por restricciones de CORS del navegador.

---

## Ejecución en Android

### Con emulador

```bash
# 1. Crear y lanzar un AVD desde Android Studio:
#    Tools → Device Manager → Create Device → iniciar

# 2. Verificar que el emulador sea detectado
flutter devices

# 3. Ejecutar (reemplaza el device-id con el tuyo)
flutter run -d emulator-5554
```

### Con dispositivo físico

```bash
# 1. En el dispositivo: Ajustes → Acerca del teléfono
#    → tocar "Número de compilación" 7 veces para activar opciones de desarrollador
# 2. Ajustes → Opciones de desarrollador → habilitar "Depuración USB"
# 3. Conectar el dispositivo con cable USB y aceptar la solicitud de confianza

# 4. Verificar que sea detectado
flutter devices

# 5. Ejecutar
flutter run -d <device-id>
```

### Selección interactiva

Si hay múltiples dispositivos conectados, ejecuta simplemente:

```bash
flutter run
```

Flutter mostrará una lista numerada para elegir el destino.

---

## Ejecución en iOS _(solo macOS)_

### Generar la carpeta `ios/`

El proyecto no incluye la carpeta `ios/` en el repositorio (fue creado solo con soporte web/android).  
Antes de ejecutar en iOS debes generarla **desde macOS**:

```bash
# Asegurarse de estar en la raíz del proyecto
cd btg_capital

# Generar la carpeta ios/ con toda la configuración base
flutter create --platforms=ios .

# Instalar dependencias nativas de iOS
cd ios && pod install && cd ..
```

Esto crea automáticamente:
- `ios/Runner.xcworkspace` — proyecto de Xcode
- `ios/Runner/Info.plist` — configuración de la app (nombre, permisos, bundle ID)
- `ios/Runner/AppDelegate.swift` — punto de entrada nativo
- `ios/Podfile` — dependencias de CocoaPods

> **Nota:** este comando es seguro — no modifica nada dentro de `lib/`, `pubspec.yaml` ni el código existente.

---

### Con simulador

```bash
# 1. Abrir el simulador
open -a Simulator

# 2. Verificar que aparezca en la lista de dispositivos
flutter devices

# 3. Ejecutar (por nombre o device-id)
flutter run -d "iPhone 15 Pro"
```

### Con dispositivo físico

```bash
# 1. Conectar el iPhone con cable USB
# 2. En Xcode: abrir ios/Runner.xcworkspace
#    → Runner → Signing & Capabilities → seleccionar tu Team (Apple ID)
# 3. En el dispositivo: confiar en la computadora cuando se solicite

# 4. Ejecutar desde la terminal
flutter run -d <device-id>
```

> La primera compilación en iOS instala las dependencias nativas con CocoaPods automáticamente; puede tardar varios minutos.

---

## Build de Producción

### Web

```bash
flutter build web --release
# Resultado en: build/web/

# Servir localmente para verificar:
cd build/web && python -m http.server 8080
```

### Android — APK

```bash
flutter build apk --release
# APK en: build/app/outputs/flutter-apk/app-release.apk
```

### Android — App Bundle (Play Store)

```bash
flutter build appbundle --release
# AAB en: build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
flutter build ios --release
# Luego en Xcode: Product → Archive → Distribute App
```

---

## Tests

### Estructura

```
test/
├── helpers/
│   ├── pump_app.dart              → extensión pumpApp() con ProviderScope + localización
│   ├── fake_funds_repository.dart → FakeFundsRepository para tests de integración/notifiers
│   ├── test_data.dart             → fixtures reutilizables (kTestFundFpv, kTestTransaction…)
│   └── mocks.dart                 → @GenerateMocks centralizado (MockFundsRepository, MockFundsLocalDatasource)
├── unit/
│   ├── core/
│   │   └── currency_formatter_test.dart
│   └── features/funds/
│       ├── data/
│       │   ├── fund_model_test.dart
│       │   └── funds_repository_impl_test.dart
│       └── domain/
│           ├── get_funds_usecase_test.dart
│           ├── subscribe_to_fund_usecase_test.dart
│           ├── cancel_fund_subscription_usecase_test.dart
│           └── portfolio_notifier_test.dart
├── widget/
│   └── features/funds/
│       └── subscribe_screen_test.dart
└── golden/
    └── features/funds/
        └── app_breadcrumb_golden_test.dart
```

### Estrategia de mocks

- **`MockFundsRepository`** — se usa en los tests de casos de uso (`SubscribeToFundUseCase`, `CancelFundSubscriptionUseCase`, `GetFundsUseCase`) para aislar la lógica de negocio del acceso a datos.
- **`MockFundsLocalDatasource`** — se usa en `FundsRepositoryImpl` tests para aislar el repositorio del I/O real (archivo JSON / llamada a API).
- **`FakeFundsRepository`** — implementación en memoria de `FundsRepository` usada en tests de `PortfolioNotifier` vía `ProviderContainer(overrides: [...])`, evitando dependencias reales de Riverpod.

### Comandos

```bash
# Ejecutar todos los tests
flutter test

# Ejecutar una carpeta específica
flutter test test/unit/

# Regenerar mocks tras cambios en las interfaces
dart run build_runner build --delete-conflicting-outputs

# Actualizar imágenes de referencia para golden tests
flutter test test/golden/ --update-goldens

# Ver reporte de cobertura
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Casos de prueba incluidos

| Archivo | Qué prueba | Tests |
|---------|-----------|-------|
| `unit/core/currency_formatter_test.dart` | Formato COP con separadores de miles | 5 |
| `unit/features/funds/data/fund_model_test.dart` | `fromJson`, `toEntity`, `toJson`, mapeo de categoría | 7 |
| `unit/features/funds/data/funds_repository_impl_test.dart` | Delegación al datasource, estado en memoria (balance, portfolio, transacciones) | 12 |
| `unit/features/funds/domain/get_funds_usecase_test.dart` | Éxito, lista vacía, manejo de excepciones | 4 |
| `unit/features/funds/domain/subscribe_to_fund_usecase_test.dart` | Suscripción exitosa, saldo insuficiente, monto mínimo, fondo ya suscrito, método de notificación | 5 |
| `unit/features/funds/domain/cancel_fund_subscription_usecase_test.dart` | Cancelación exitosa, fondo no encontrado, ID correcto | 3 |
| `unit/features/funds/domain/portfolio_notifier_test.dart` | Estado inicial, suscripción, cancelación, errores, limpieza de error en reintento | 7 |
| `widget/features/funds/subscribe_screen_test.dart` | Monto pre-llenado, retorno de datos al confirmar | 2 |
| `golden/features/funds/app_breadcrumb_golden_test.dart` | Renderizado visual del breadcrumb | 1 |
| **Total** | | **46** |

---

## Fondos Disponibles

| ID | Nombre | Monto Mínimo | Categoría |
|----|--------|-------------|-----------|
| 1 | FPV_BTG_PACTUAL_RECAUDADORA | COP $75.000 | FPV |
| 2 | FPV_BTG_PACTUAL_ECOPETROL | COP $125.000 | FPV |
| 3 | DEUDAPRIVADA | COP $50.000 | FIC |
| 4 | FDO-ACCIONES | COP $250.000 | FIC |
| 5 | FPV_BTG_PACTUAL_DINAMICA | COP $100.000 | FPV |

---

## Decisiones Técnicas

1. **Riverpod con code generation:** Se usan las anotaciones `@Riverpod` y `@riverpod` junto con `riverpod_generator` para generar providers con tipado estricto en tiempo de compilación. `keepAlive: true` en el repositorio y el notifier de portafolio garantiza que el estado en memoria persista durante toda la sesión.

2. **`Either<AppException, T>` para manejo de errores:** Los casos de uso retornan `Either` de `dartz` en lugar de lanzar excepciones. Esto hace explícito en la firma del método que una operación puede fallar, fuerza al caller a manejar ambos caminos y elimina `try/catch` en la capa de presentación.

3. **`int` para montos monetarios:** Se evitan errores de punto flotante al representar pesos colombianos como enteros (los centavos no aplican en este dominio).

4. **Mock local con JSON:** Los fondos se cargan desde `assets/mock/funds.json` con un delay simulado de 700 ms, permitiendo probar estados de carga sin backend real. La interfaz `FundsRepository` desacopla la app de esta implementación; reemplazar por una API real solo requiere una nueva clase que implemente el contrato.

5. **Mockito sobre otras librerías de mocking:** Se eligió `mockito` con `@GenerateMocks` y `build_runner` porque el código generado es verificable en revisión de código, los errores de tipos se detectan en compilación y `verify`/`verifyNever` permite aserciones explícitas sobre el comportamiento (no solo el resultado).

6. **Tests de notifiers con `ProviderContainer` + overrides:** En lugar de usar el repositorio real en los tests de `PortfolioNotifier`, se inyecta un `FakeFundsRepository` a través de `fundsRepositoryNotifierProvider.overrideWith(...)`. Esto aísla el notifier de cualquier implementación concreta, siguiendo el mismo patrón que se usaría en producción con una API real.

7. **Diseño responsivo con `MediaQuery`:** Layout adaptativo con sidebar para pantallas > 800 px y barra de navegación inferior para móvil, con breakpoints en 600 px y 900 px.

8. **GoRouter con `ShellRoute`:** Mantiene el scaffold de navegación persistente entre rutas sin reconstruir la estructura de la pantalla en cada cambio de ruta.
