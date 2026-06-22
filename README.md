# Device Care - Order Management System

Device Care is a Flutter-based Order Management System designed for managing electronic device repair orders. The application allows service centers to create, track, update, and manage repair requests efficiently using Firebase Authentication and Cloud Firestore.

## Features

### Authentication

* User Registration
* User Login
* Firebase Authentication
* Persistent Login Session
* Logout Functionality

### Order Management

* Create New Repair Orders
* View Order Details
* Edit Existing Orders
* Delete Orders
* Search Orders
* Filter Orders by Status

### Dashboard

* Total Received Orders
* Total Repairing Orders
* Total Ready for Pickup Orders
* Total Delivered Orders
* Recent Orders Section

### Profile Management

* View User Information
* Logout

## Order Status Workflow

```text
Received
    ↓
Repairing
    ↓
Ready for Pickup
    ↓
Delivered
```

## Technologies Used

* Flutter
* Firebase Authentication
* Cloud Firestore
* Provider (State Management)
* Material Design

## Project Structure

```text
lib/
│
├── models/
│   └── order.dart
│
├── repository/
│   └── order/
│       └── repository.dart
│
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── dashboard_screen.dart
│   ├── all_orders_screen.dart
│   ├── filtered_orders_screen.dart
│   ├── order_details_screen.dart
│   ├── add_edit_order_screen.dart
│   └── profile_screen.dart
│
├── providers/
│
└── main.dart
```

## Firestore Collection Structure

### orders

```json
{
  "customerName": "John Doe",
  "phoneNumber": "9876543210",
  "deviceBrand": "Apple",
  "deviceModel": "iPhone 15",
  "issue": "Screen Damage",
  "estimatedCost": 5000,
  "assignedTechnician": "Mike",
  "status": "Received",
  "createdAt": "Timestamp",
  "updatedAt": "Timestamp"
}
```

## Screens

### Splash Screen

Animated splash screen with automatic login check.

### Login Screen

User authentication using Firebase Authentication.

### Signup Screen

New user registration.

### Dashboard Screen

Displays:

* Order Statistics
* Search Orders
* Filter Orders
* Recent Orders

### All Orders Screen

Displays all repair orders with search and status filters.

### Order Details Screen

Displays complete order information.

### Add/Edit Order Screen

Create and update repair orders.

### Profile Screen

Displays current user information and logout option.

## Getting Started

### Clone Repository

```bash
git clone https://github.com/your-username/Order-Management.git
```

### Install Dependencies

```bash
flutter pub get
```

### Configure Firebase

1. Create a Firebase Project.
2. Enable Authentication (Email & Password).
3. Create a Cloud Firestore Database.
4. Add Android/iOS application.
5. Download Firebase configuration files.
6. Run:

```bash
flutterfire configure
```

### Run Application

```bash
flutter run
```

## Future Improvements

* Push Notifications
* Technician Management
* Order History
* Analytics Dashboard
* Dark Mode Support
* Image Upload for Devices

## Author

Developed using Flutter and Firebase as a demonstration of a modern Order Management System for electronic device repair centers.

