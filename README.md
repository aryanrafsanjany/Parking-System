# 🅿️ Dhaka Mall Parking System

A simple PHP-based parking reservation system that allows users to sign up, log in, book parking spots by area, cancel manually, and auto-cancel after 1 hour if not reached. Includes a points reward system (10 bookings = 1 free).

## 🔧 Technologies Used

- **Frontend**: HTML, CSS
- **Backend**: PHP
- **Database**: MySQL
- **Server**: XAMPP (Localhost)
- **OS**: macOS
- **Automation**: Cron job for auto-cancel

## 📦 Features

- User Sign Up & Log In
- Area & Parking Location Selection
- Real-time Spot Availability
- Manual Cancel Option
- Auto Cancel after 1 Hour (Cron Job)
- Points Reward System
- Clean UI with background image

### 📁 Folder Structure

```
Project/
├── auto_cancel/
│   ├── auto_cancel.php
│   ├── cron_log.txt
│   └── debug_log.txt
├── css/
│   ├── style.css
│   └── background.jpg
├── includes/
│   ├── db.php
│   └── functions.php
├── pages/
│   ├── login.php
│   ├── signup.php
│   ├── area.php
│   ├── book.php
│   ├── cancel.php
│   └── dashboard.php
├── logout.php
├── index.php
├── .gitignore
├── README.md
└── project_2.0.sql
```




## 🗃️ Database Schema

- **Tables**: `USER`, `AREA`, `PARKING_LOCATION`, `BOOKING`
- **Foreign Keys**: Follow the schema diagram (included)

## 🛠 Setup Instructions

1. Clone or download this repository
2. Copy it to `htdocs/` in XAMPP
3. Import the database from provided SQL file
4. Configure DB credentials in `/includes/db.php`
5. Run the project on `localhost/Project/pages/login.php`
6. Set up cron job for auto-cancel (`auto_cancel.php` runs every minute)

## 📝 Author

**Aryan Rafsanjany**  
GitHub: [@aryanrafsanjany](https://github.com/aryanrafsanjany)

---

