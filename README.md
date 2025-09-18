# ahwa_app_new

# Smart Ahwa Manager App 🍵

A Flutter application designed for managing customer orders in traditional Egyptian cafés (Ahwa). Built with SOLID principles and modern Flutter best practices.

## 📱 Features

- **Order Management**: Add customer orders with name, drink type, and special instructions
- **Pending Orders**: View and manage all pending orders in real-time
- **Order History**: Track completed orders for better record keeping
- **Daily Reports**: Generate reports showing top-selling drinks and total orders served
- **Persistent Storage**: All data is saved locally using SharedPreferences

## 🏗️ Architecture

This app demonstrates the implementation of SOLID principles in Flutter:

### Single Responsibility Principle (SRP)
- `OrderManager`: Handles all order-related data operations
- `CustomFormField`: Manages form input UI only
- Each screen focuses on its specific functionality

### Open-Closed Principle (OCP)
- Easy to extend with new drink types or order features
- No need to modify existing code when adding new functionality

### Dependency Inversion Principle (DIP)
- UI components depend on `OrderManager` abstraction
- Screens are not tightly coupled to specific data implementations

## 🛠️ Technical Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: StatefulWidget with setState
- **Local Storage**: SharedPreferences
- **Architecture Pattern**: Service-based architecture following SOLID principles

## 📁 Project Structure

```
lib/
├── main.dart                     # App entry point
├── models/
│   └── order_model.dart         # Order data model
├── screens/
│   ├── order_screen.dart        # Main dashboard
│   ├── pending_screen.dart      # Pending orders management
│   ├── orders_history_screen.dart # Order history view
│   └── reports_screen.dart      # Daily reports and analytics
├── services/
│   └── order_manager.dart       # Core business logic and data management
└── widgets/
    ├── custom_bottom_sheet.dart # Order input modal
    └── custom_form_field.dart   # Reusable form input component
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (2.17.0 or higher)
- Android Studio / VS Code
- Android/iOS emulator or physical device

### Installation

1. Clone the repository
```bash
git clone https://github.com/zicoovic/ahwa_app_new.git
```

2. Navigate to project directory
```bash
cd ahwa_app_new
```

3. Get dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## 📸 Screenshots

### Main Dashboard
The central hub showing pending orders count and quick access to all features.

### Add New Order
Modal bottom sheet for adding new customer orders with validation.

### Pending Orders
List view of all pending orders with complete functionality.

### Order History
Historical view of all completed orders for record keeping.

### Daily Reports
Analytics dashboard showing top-selling drinks and order statistics.

## 🔧 Key Components

### OrderManager
Core service class handling:
- Order creation and management
- Data persistence with SharedPreferences
- Business logic for order completion
- Report generation and analytics

### Order Model
Simple data class representing:
- Customer name
- Drink type (shai, Turkish coffee, hibiscus tea, etc.)
- Special instructions
- Completion status

## 📊 Features in Detail

### Order Management
- Add orders with customer name, drink preference, and special notes
- Real-time validation and error handling
- Automatic data persistence

### Status Tracking
- Visual indicators for pending vs completed orders
- One-click order completion
- Automatic history management

### Reporting
- Top-selling drinks analysis
- Total orders served counter
- Most popular drink identification

## 🎯 SOLID Principles Implementation

This project serves as a practical demonstration of SOLID principles in Flutter development:

1. **S**ingle Responsibility: Each class has one clear purpose
2. **O**pen-Closed: Extensible design without modifying existing code
3. **L**iskov Substitution: Components can be replaced without breaking functionality
4. **I**nterface Segregation: Focused, minimal interfaces
5. **D**ependency Inversion: High-level modules don't depend on low-level details

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web (with limitations on SharedPreferences)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

**Abdelrahman Mohammed**
- GitHub: [@zicoovic](https://github.com/zicoovic)
- LinkedIn: [Abdelrahman Mohammed](https://www.linkedin.com/in/abdelrahman-mohammed-b58bb7103/)

## 🙏 Acknowledgments

This project was developed as part of an OOP and SOLID principles assessment, demonstrating practical application of software engineering principles in Flutter development.

---

*Built with ❤️ for traditional Egyptian café owners*