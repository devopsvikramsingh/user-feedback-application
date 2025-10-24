User Feedback Application

** My project is in the master branch.

The **User Feedback Application** is a modern mobile app built using **Flutter** and **Dart**, designed to collect and manage user feedback effortlessly.
It integrates **Firebase Authentication** for secure Google sign-in and uses the **Hive database** for temporary local storage.

The app guides users through an intuitive flow: login → fill personal details → provide feedback → attach media → submit → exit.

---


## 🌟 Features

* Secure **Google login** with Firebase Authentication
* Simple **user details form** (name, phone, email)
* Dedicated **feedback page** for text input
* Option to **attach screenshots, images, or short videos**
* **Temporary local storage** via Hive database
* **Smooth navigation** between app pages
* **Modern Flutter UI** following Material Design principles

---

##  Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **Authentication:** Firebase (Google Sign-In)
* **Database:** Hive (temporary local storage)
* **State Management:** Stateful Widgets
* **Platform:** Android & iOS

---

## 🔄 Application Flow

1. **Login Page:**
   The user logs in using their **Google account** via Firebase Authentication.

2. **User Details Page:**
   After successful login, the user enters personal details — name, phone number, and email.

3. **Feedback Page:**
   The user writes feedback about their experience.

4. **Media Attachment Page:**
   The user can attach screenshots, images, or short videos related to the feedback.

5. **Submission Page:**
   The feedback and attachments are submitted and stored temporarily in Hive.

6. **Exit:**
   After submission, the user exits the app.

---

## ⚙️ Installation

Follow these steps to set up and run my project locally:

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/user-feedback-app.git
   cd user-feedback-app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up Firebase**

   * Go to [Firebase Console](https://console.firebase.google.com/)
   * Create a new Firebase project
   * Enable **Google Sign-In** under **Authentication**
   * Download the `google-services.json` file → place it in `android/app/`
   * For iOS: add `GoogleService-Info.plist` → `ios/Runner/`

4. **Run the app**

   ```bash
   flutter run
   ```

---

## 💡 Usage

* Launch the app and **sign in with Google**.
* Fill out your **user details** form.
* Write your **feedback** and attach optional media.
* Submit the feedback to complete the process.
* Exit the app — your data is temporarily stored locally.



### first page (screenshot):

 Screenshots![Screenshot 2025-10-18 013525](https://github.com/user-attachments/assets/6a397ae8-fc41-43f8-9efd-f36981c0a9eb)

### login screen (screenshot):
 
login Screen![Uploading Screenshot 2025-10-18 014823.png…]()


### user detail page(screenshot page): 

<img width="1546" height="959" alt="Screenshot 2025-10-18 015052" src="https://github.com/user-attachments/assets/11e693ee-fdd8-4b14-aad0-d7ec04434001" />




### Feedback Page(screen shot):

<img width="1530" height="967" alt="Screenshot 2025-10-18 015227" src="https://github.com/user-attachments/assets/bedb1d2c-a559-4d22-8eaf-7a821362a007" />


### attech media Page(screen shot):

<img width="1388" height="588" alt="Screenshot 2025-10-18 015344" src="https://github.com/user-attachments/assets/9d986e6a-99cf-412a-90c3-567ccdc4ff3a" />


### user feedback data info Page(screen shot):

<img width="1561" height="953" alt="Screenshot 2025-10-18 015413" src="https://github.com/user-attachments/assets/9f5cdf6f-cd11-4ba6-ad10-c18b5fc341c2" />



## Future Improvements

* Integrate **Firestore** for permanent data storage
* Add **sentiment analysis** for intelligent feedback insights
* Include **multi-language support**
* Add **real-time feedback confirmation** and push notifications

---

## Contributing

Contributions are welcome!

1. Fork this repository
2. Create a new branch (`feature-branch-name`)
3. Commit and push your changes
4. Open a Pull Request

---

## Contact

**Author:** Vikram singh
📧 Email: vikramsingh.dev25@gmail.com



