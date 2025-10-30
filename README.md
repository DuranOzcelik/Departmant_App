# Department Mobile UI Project

This project is a mobile application prototype built with Flutter, focusing on clean UI/UX design, modular architecture, and secure local authentication flows.

**Author:** Duran Özçelik

---

## 1. Key Features & Implementations

### A. Authentication & Security Layer

The application features a robust login/signup system with several enhancements for user experience and security:

#### Secure Local Storage
- Credentials persisted using `shared_preferences`

#### Form Integrity
- Implemented checks for empty fields and visual loading states on buttons

#### Password Management
- Added a fully functional **Password Visibility Toggle** (`Icons.visibility`) on both login and signup fields
- Designed a secure **Password Reset Flow** that validates the username and forces the user to set a new password, preventing reuse of the old password

#### Aesthetics
- Login and Sign Up screens feature a clean, unified design with optimized button styling

---

### B. Departmental Directory (People & Infrastructure)

The main application features a tabbed interface providing essential department information.

#### People Directory
- **Optimized Layout:** Instructor list cards are optimized for vertical display, featuring professional visuals and clear contact information
- **Call Functionality:** Implemented safe call initiation using `url_launcher`, preceded by a required confirmation dialog

#### Infrastructure Management
- **Capacity Visualization:** Classroom capacities are displayed numerically and visually using a progress bar for instant comparison
- **Image Interaction (UX):** Double-tapping any classroom item opens the associated image in a new screen
- **Advanced Image Viewer:** The enlarged image screen features a dynamic title and utilizes `InteractiveViewer` to enable users to zoom and pan the image for detailed inspection
- **User Hint:** A floating, highly visible `SnackBar` provides the user with an initial hint about the double-tap interaction

---

## 2. Technical Stack & Setup

### Framework & Language
- **Framework:** Flutter SDK
- **Language:** Dart

### Key Packages
- `shared_preferences` (Local Data)
- `url_launcher` (Telephony API)

---

## How to Run Locally

1. **Ensure you have the Flutter SDK installed** on your system
2. **Clone this repository** or extract the project files
3. **Navigate to the project directory** in your terminal:
   ```bash
   cd department_application
   ```
4. **Fetch dependencies** (must be done after project extraction):
   ```bash
   flutter pub get
   ```
5. **Run the application** on an emulator or connected device:
   ```bash
   flutter run
   ```

> **Note:** The project was submitted after running `flutter clean` to minimize repository file size.

---

