````md
# SwiftNetworkKitDemo

A clean, scalable, and production-ready networking layer built with Swift using async/await.

Designed for modern iOS applications with:
- Environment support
- SSL Pinning
- Centralized error handling
- Generic API requests
- Request/response logging
- Custom headers
- Clean architecture

---

# Features

✅ Async/Await Networking  
✅ Environment Support (Development / QA / Staging / Production)  
✅ Generic API Requests  
✅ Centralized Error Handling  
✅ Optional SSL Pinning  
✅ Request & Response Logger  
✅ Custom Headers Support  
✅ Query Parameters Support  
✅ Encodable Request Body  
✅ Decodable Response Parsing  
✅ Clean & Scalable Architecture  
✅ Easy GitHub Integration  

---

# Folder Structure

```text
SwiftNetworkKitDemo
│
├── Networking
│   ├── APIEnvironment.swift
│   ├── HTTPMethod.swift
│   ├── NetworkError.swift
│   ├── Endpoint.swift
│   ├── AnyEncodable.swift
│   ├── NetworkLogger.swift
│   ├── SSLPinningDelegate.swift
│   └── NetworkManager.swift
│
└── Example
    ├── UserModels.swift
    └── UserEndpoint.swift
````

---

# Requirements

* iOS 15+
* Swift 5.7+
* Xcode 15+

---

# API Environment Support

Supports multiple environments:

```swift
enum APIEnvironment {
    case development
    case staging
    case qa
    case production
}
```

Each environment has:

* Different Base URL
* Different Logging
* Different SSL Pinning Configuration

Example:

```swift
let network = NetworkManager(environment: .staging)
```

---

# Basic Usage

## Create Endpoint

```swift
enum UserEndpoint: Endpoint {

    case getUsers

    var path: String {
        "/users"
    }

    var method: HTTPMethod {
        .GET
    }
}
```

---

## Make API Request

```swift
Task {
    do {

        let users = try await NetworkManager.shared.request(
            endpoint: UserEndpoint.getUsers,
            responseModel: [User].self
        )

        print(users)

    } catch {

        print(error.localizedDescription)
    }
}
```

---

# Endpoint Protocol

Every API endpoint must conform to:

```swift
protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Encodable? { get }
}
```

---

# Error Handling

Centralized error handling using `NetworkError`.

Supported errors:

```swift
.invalidURL
.noInternet
.timeout
.invalidResponse
.decodingFailed
.unauthorized
.forbidden
.notFound
.serverError(Int)
.sslPinningFailed
.custom(String)
```

Example:

```swift
catch let error as NetworkError {

    switch error {

    case .noInternet:
        print("No Internet")

    case .unauthorized:
        print("Session Expired")

    default:
        print(error.localizedDescription)
    }
}
```

---

# SSL Pinning

Supports optional SSL certificate pinning.

## Enable SSL Pinning

```swift
var sslPinningEnabled: Bool {
    true
}
```

## Steps

1. Export server certificate as `.cer`
2. Add certificate into app bundle
3. Set certificate name inside:

```swift
private let pinnedCertificateName = "api_certificate"
```

---

# Request Logging

Automatically logs:

* URL
* HTTP Method
* Headers
* Request Body
* Response Body
* Status Code

Example:

```swift
========== API REQUEST ==========
URL: https://api.example.com/users
METHOD: GET
=================================
```

Disable logs for production:

```swift
var enableLogs: Bool {
    false
}
```

---

# Custom Headers

Supports endpoint-specific headers.

Example:

```swift
var headers: [String : String]? {
    [
        "Authorization": "Bearer TOKEN",
        "X-App-Version": "1.0.0"
    ]
}
```

---

# Query Parameters

Supports query items easily.

Example:

```swift
var queryItems: [URLQueryItem]? {
    [
        URLQueryItem(name: "page", value: "1")
    ]
}
```

---

# POST Request Example

```swift
struct CreateUserRequest: Encodable {
    let name: String
    let email: String
}
```

```swift
case createUser(CreateUserRequest)
```

---

# Production Ready Improvements

You can further extend this networking layer with:

* Token Refresh Flow
* Request Interceptors
* Retry Mechanism
* Multipart Upload
* Download Manager
* Reachability Monitoring
* API Caching
* Request Queueing
* cURL Logger
* Mock APIs
* Unit Testing
* Combine Support

---

# Example Architecture

```text
Presentation Layer
        ↓
Repository Layer
        ↓
NetworkManager
        ↓
Endpoint
        ↓
API
```

---

# Why This Project?

This project is designed as:

* A reusable networking layer
* A clean GitHub portfolio project
* A scalable architecture for production apps
* A modern async/await networking example

---

# License

MIT License

---

# Author

Muhammad Junaid Babar

iOS Developer passionate about building scalable and clean Swift applications.

```
```
