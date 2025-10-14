# 📝 Flutter To-Do App (CSV + JSON Import)

A simple and clean **To-Do App built with Flutter**, where all your tasks are **stored locally in a CSV file** on the device.  
You can also **import tasks from a JSON file** to quickly add multiple to-dos at once — all without any external backend or database.

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

## 💾 Local File Storage

- All to-dos are saved as a **CSV file** in the app's local storage directory.  
  Example path (Android):  
