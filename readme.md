# 🚀 Project Idea Generator (API-Based)

A Java Full-Stack Web Application that dynamically generates project ideas using GitHub API.

---

## 🔥 Features

### 👤 User Side
- Select domain & difficulty
- Fetch real project ideas from GitHub
- Clean modern UI
- Dynamic results

### 🔐 Admin Panel
- Secure login
- Add / Edit / Delete domains (CRUD)
- Manage GitHub search keywords
- Enable/Disable domains

---

## 🛠 Tech Stack

- Java (Servlet, JSP)
- MySQL
- JDBC
- Bootstrap
- GitHub Public API
- Apache Tomcat 9

---

## 🗄 Database Tables

1. admin_users
2. domains

---

## ⚙ How It Works

1. Admin configures domain keywords.
2. User selects a domain.
3. Backend fetches keywords from DB.
4. GitHub API is called dynamically.
5. JSON response parsed using Gson.
6. Results displayed on UI.

---

## ▶ How To Run

1. Import into Eclipse
2. Configure Tomcat 9
3. Create database using `database/project_idea_db.sql`
4. Update DB credentials in servlet
5. Run on server

---

## 📚 Learning Outcomes

- REST API consumption
- JSON parsing (Gson)
- JDBC & SQL (CRUD)
- Session-based authentication
- MVC architecture
- Dynamic configuration system
