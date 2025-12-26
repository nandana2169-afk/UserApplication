# User Management Application (MVC + Provider)

This application was developed as part of a technical interview assessment. It demonstrates a complete user management flow, including authentication UI, search capabilities, and category-based filtering.

##  Key Features
- **Authentication Flow:** Includes a Mobile Login screen with validation and an OTP Verification screen featuring a real-time countdown timer.
- **User Management:** Ability to add new users with Name, Phone Number, and Age.
- **Search Functionality:** Users can search the list dynamically by Name or Phone Number.
- **Age-Based Sorting:** Implemented sorting categories as per requirements:
    - **Older:** Users aged 60 and above.
    - **Younger:** Users aged below 60.

##  Technical Implementation
- **Architecture:** Follows the **MVC (Model-View-Controller)** pattern for clear separation of concerns.
- **State Management:** Powered by **Provider** for efficient UI updates and state handling.
- **Asynchronous Logic:** Uses **Async/Await** for fetching and managing user data.
- **Clean Code:** Modularized code structure ensuring readability and maintainability.

##  Folder Structure
- `lib/model/` - Data structures (User class).
- `lib/provider/` - Business logic and state handling (UserController).
- `lib/main/` -  Application entry point and Mobile Login UI.
- `lib/` - UI screens (Login, OTP, and User List).

##  How to Run the App
1. Clone the repository:
   ```bash
   git clone -b userapplication https://github.com/nandana2169-afk/UserApplication.git    