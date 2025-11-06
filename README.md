 # 📝 Flutter To-Do App (CSV + JSON Import) | 🧑‍💻 Author - Tanvir Hasan (💬 Flutter Developer) | 📧 tanvirhasanemn@gmail.com

A simple and clean **To-Do App built with Flutter**, where all your tasks are **stored locally in a CSV file** on the android device's **Download Folder**.  
You can also **import tasks from a JSON file** to quickly add multiple to-dos at once — all without any external backend or database.

---


## 🎥 Demo Video

👉 **Watch the full demo on YouTube:**  
[![Flutter To-Do App Demo](https://img.youtube.com/vi/aemjQodfqQA/0.jpg)](https://youtu.be/aemjQodfqQA)

> Click the image above or [this link](https://youtu.be/aemjQodfqQA) to watch the demo.

---

## 📱 Download APK

📦 **Download and try the app on your Android device:**  
👉 [Download APK from Google Drive](https://drive.google.com/drive/folders/1IVxNZRtaNrrDVQYEZX6dJo7jR1uifHL2?usp=sharing)

---

## 🚀 Features

### ✅ Core Functionalities
- **Add To-Do:** Create new to-do items with a title and description.
- **View To-Dos:** Display all saved to-dos in a clean Material UI.
- **Edit Status:** Update the status of each to-do (`ready`, `pending`, or `completed`).
- **Delete To-Do:** Remove existing to-dos with a single tap.
- **CSV Sync:** Every change (add, edit, delete, status update) automatically updates the local CSV file.
- **JSON Import:** Upload a `.json` file from your device to import multiple to-dos instantly.



Each to-do item includes:
| Field        | Type   | Description |
|---------------|--------|-------------|
| `id`          | int    | Unique ID of the task |
| `title`       | String | Title of the task |
| `description` | String | Short description |
| `created_at`  | int    | Timestamp (milliseconds since epoch) |
| `status`      | String | One of: `ready`, `pending`, or `completed` |

---

- When you **import a JSON file**, its data is parsed and merged into the existing to-do list, and the CSV file is updated immediately.

---

⚙️ Setup & Run

Step1: Clone this repository - 
git clone https://github.com/TanvirHasanEmn/ToDo.git

Step2: Install dependencies - 
flutter pub get

Step3:Run the app - 
flutter run



## 📂 Example JSON Format

Here’s how your JSON file should look when you upload it:

```json
[
{
  "id": 1,
  "title": "Buy Groceries",
  "description": "Milk, eggs, bread",
  "created_at": 1717331200000,
  "status": "pending"
},
{
  "id": 2,
  "title": "Finish Flutter Project",
  "description": "Todo app with CSV and JSON import",
  "created_at": 1717335200000,
  "status": "ready"
}
]



