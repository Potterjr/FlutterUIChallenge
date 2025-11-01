# Flutter UI Challenge - Shopping App
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/Potterjr/FlutterUIChallenge)

This repository contains a Flutter-based shopping application UI, developed as a coding challenge. The app showcases a clean, responsive interface for a modern e-commerce experience, complete with product browsing, a persistent shopping cart, a favorites list, and a mock checkout process.

## Features

- **Product Catalog**: Browse a grid of products fetched from a mock data source, with elegant loading skeletons displayed while data is being fetched.
- **Product Details**: Tap on any product to view its details on a dedicated screen, featuring a smooth `Hero` animation for the product image.
- **Persistent Shopping Cart**: Add products to a shopping cart that persists across app sessions using `shared_preferences`. Users can adjust item quantities or remove items with a swipe-to-delete action.
- **Favorites Management**: Mark products as favorites, and view them in a dedicated "Saved" section. Favorite items are also persisted locally.
- **QR Code Checkout**: A simplified checkout process that generates a unique QR code for payment based on the total cart value.
- **Responsive UI**: The layout is designed to adapt to both mobile and tablet screen sizes.
- **State Management**: Built using the GetX framework for efficient state management, navigation, and dependency injection.
- **Environment Flavors**: Configured with `staging` and `production` environments to manage different configurations, such as API URLs.

## Application Screens

The application is composed of several key screens that provide a complete, albeit simplified, shopping flow:

- **Home Screen**: The main screen that presents a grid of available products. From here, users can navigate to product details or add items to their favorites.
- **Product Detail Screen**: A detailed view of a single product, showing a larger image, name, price, and an "Add to Cart" button.
- **Favorites Screen**: A list of all products that the user has marked as a favorite.
- **Cart Screen**: Displays all items currently in the shopping cart. It allows for quantity adjustments and item removal. It also shows the subtotal and a a "Checkout" button.
- **Checkout Screen**: The final step where the app generates a scannable QR code for the total payment amount, simulating a "Scan and Pay" feature.

## Project Structure

The project follows a modular architecture to keep the codebase organized and scalable.

```
lib/
├── config/
│   ├── api/          # API setup, environment loading, and endpoints
│   └── routes/       # Application routes and navigation
├── modules/
│   ├── checkout/     # Checkout screen, controller, and related logic
│   ├── home/         # Home, Favorites, and Cart screens, models, and controller
│   └── productdetail/# Product detail screen and controller
├── service/
│   ├── deviceutility.dart
│   ├── localstorage.dart # Service for Shared Preferences (cart/favorites)
│   └── networkservice.dart # Service for network requests using Dio
└── widget/
    ├── button/       # Custom button widgets
    └── card/         # Custom card widgets for products and cart items
```

## Getting Started

### Prerequisites
- Flutter SDK (version 3.35.0 or higher)
- A configured IDE (like VS Code or Android Studio)

### Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/potterjr/flutteruichallenge.git
   ```
2. Navigate to the project directory:
   ```sh
   cd flutteruichallenge
   ```
3. Install the dependencies:
   ```sh
   flutter pub get
   ```

### Running the Application
The application is configured with two build flavors: `staging` and `production`.

**To run the default `staging` flavor:**
```sh
flutter run
```

**To run the `production` flavor:**
```sh
flutter run --flavor production --dart-define=FLAVOR=production
```

## Key Dependencies
This project utilizes several key packages from the Flutter ecosystem:

- `get`: For state management, navigation, and dependency injection.
- `dio`: A powerful HTTP client for making network requests.
- `shared_preferences`: For persisting cart and favorite data locally on the device.
- `flutter_dotenv`: To manage environment variables across different build flavors.
- `qr_flutter`: For generating the payment QR code on the checkout screen.
- `skeletonizer`: To display animated loading skeletons while data is being fetched.
- `flutter_slidable`: To implement swipe-to-delete functionality for cart items.
- `auto_size_text`: For creating text that automatically resizes to fit its container.
- `device_preview`: To preview the app's UI on various device sizes and orientations.
