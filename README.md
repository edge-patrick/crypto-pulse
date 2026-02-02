# Crypto Pulse Architecture

Welcome to the **Crypto Pulse** codebase! This is a demo project which showcases implementation of MVVM architecture for a SwiftUI project. This document is designed to help you understand how the app is structured, why we chose this architecture, and how to work with it.

## 🏗 Architecture Overview

The app follows **Clean Architecture** principles combined with the **MVVM (Model-View-ViewModel)** pattern in SwiftUI. We prioritize **separation of concerns**, **testability**, and **scalability**.

### Project Structure

```text
crypto-pulse/
├── Application/          # App entry point & Dependency Injection setup
├── Models/              # Plain Data Objects (DTOs)
├── Networking/          # Generic API client & Endpoint definitions
├── Routers/            # Feature-specific API routing (URL construction)
├── Services/           # Business logic & Data fetching (Domain layer)
├── Scenes/             # UI Features (Views & ViewModels)
└── Utilities/          # Shared helpers & UI state management
```

---

## 층 Layers of the App

### 1. Networking Layer (`Networking/` & `Routers/`)
We use a protocol-oriented networking layer. 
- **`APIService`**: A generic engine that handles the heavy lifting of `URLSession` and JSON decoding.
- **`Routers`**: Enums that define our API endpoints. Instead of hardcoding URLs everywhere, we ask a router for an `Endpoint`. This makes changing API paths or adding parameters very easy.

### 2. Service Layer (`Services/`)
This is the **Domain Layer**. Services are responsible for fetching data (using the Networking layer) and providing it to the ViewModels.
- **Why?** It keeps business logic out of the UI. If we ever switch from an API to a local database, we only change the Service, and the UI never knows the difference.
- **Protocols**: Every service has a protocol (e.g., `CoinServiceProtocol`). This is the secret sauce for testability.

### 3. Presentation Layer (`Scenes/`)
We use **MVVM** with SwiftUI's modern `@Observable` framework.
- **Views**: Purely declarative. They observe the ViewModel and render the UI.
- **ViewModels**: Manage the state of the view. They call Services to get data and update a `ViewState`.
- **`ViewState`**: A generic enum (`idle`, `loading`, `loaded`, `failed`) that ensures the UI always handles every possible state (like showing a spinner or an error message).

---

## 💉 Dependency Injection (DI)

We use a centralized DI container in `AppDependencies.swift`.

### How it works:
1. We define all our services in a `AppDependencies` struct.
2. We inject this container into the SwiftUI environment at the root of the app (`crypto_pulseApp.swift`).
3. Views can access any service using `@Environment(\.dependencies)`.

### Why we do this:
- **Decoupling**: Views don't need to know how to create a `CoinService`. They just ask for one.
- **Testing**: In our unit tests, we can easily swap a real `CoinService` (which hits the internet) for a `MockCoinService` (which returns static data).

---

## 🧪 Testability

Testability is baked into the architecture. Because we use **Protocols** and **Dependency Injection**, we can test our ViewModels in isolation.

**Example of a test flow:**
1. Create a `MockCoinService` that conforms to `CoinServiceProtocol`.
2. Initialize a `CoinsListViewModel` with that mock service.
3. Call `fetchCoins()` on the ViewModel.
4. Assert that the ViewModel's state changes from `.loading` to `.loaded`.

You can find these tests in the `crypto-pulseTests` folder.

---

## 🛠 Best Practices for New Features

When adding a new feature (e.g., "User Favorites"):
1. **Model**: Create the data structure in `Models/`.
2. **Router**: Add the API endpoint to a new or existing Router.
3. **Service**: Create a `FavoriteServiceProtocol` and its implementation.
4. **DI**: Register the new service in `AppDependencies.swift`.
5. **ViewModel**: Create a ViewModel that takes the service as a dependency.
6. **View**: Build the SwiftUI view and connect it to the ViewModel.
7. **Test**: Write a unit test using a mock version of your service.
