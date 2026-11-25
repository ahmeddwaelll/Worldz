# Worldz

A small desktop social media app built with **Java**, **JavaFX** and **MySQL**.

## Features

- **Register / Login**: sign up with email, password, username, phone number, gender, birthday and an optional bio.
  - Email must be unique, password at least 8 characters, phone number a valid Egyptian mobile number (`010`, `011`, `012`, `015` + 8 digits), and users must be 18 or older.
- **Home feed**: browse everyone's posts, 5 at a time, with the author, date and like count.
- **Likes and comments**: like any post, open it to read and write comments.
- **My posts**: write new posts and view your own.
- **Profile page**: view your info and profile picture.
- **Settings**: change your email, password, username, phone number or bio, and upload a profile picture (PNG / JPG / GIF).

## Tech stack

| | |
|---|---|
| Language | Java 21 |
| UI | JavaFX 21 (FXML) |
| Database | MySQL 8 (via MySQL Connector/J) |
| Build | Maven (wrapper included, no install needed) |

## Requirements

- **JDK 21** or newer
- **MySQL Server 8** running locally (or anywhere you can reach)
- **MySQL Workbench** (optional, makes setting up the database easier)

## Setup

### 1. Clone the project

```bash
git clone https://github.com/ahmeddwaelll/Worldz.git
cd Worldz
```

### 2. Create the database

The full schema is in [`schema.sql`](schema.sql). It creates a database named `worldz` with three tables: `users`, `posts` and `comments`.

**Using MySQL Workbench:** connect to your server, then go to **File → Open SQL Script**, pick `schema.sql`, and press the ⚡ **Execute** button.

**Using the command line:**

```bash
mysql -u root -p < schema.sql
```

> Want a different database name? Change `worldz` in the first two SQL lines of `schema.sql` **and** in the `db.url` of your config file (next step).

### 3. Add your database credentials

The app reads its connection settings from `config/db.properties`. This file is **git-ignored**, so your password is never uploaded.

Copy the template and fill it in:

```bash
cp config/db.properties.example config/db.properties
```

(On Windows you can just copy and rename the file in File Explorer.)

```properties
db.url=jdbc:mysql://127.0.0.1:3306/worldz?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.user=root
db.password=your_password_here
```

| Setting | What to put |
|---|---|
| `db.url` | `jdbc:mysql://<host>:<port>/<database>`. For a local server keep `127.0.0.1:3306`. Change `worldz` if you named the database differently. |
| `db.user` | Your MySQL username (often `root`) |
| `db.password` | That user's password |

### 4. Run the app

```bash
# Windows
mvnw.cmd clean javafx:run

# macOS / Linux
./mvnw clean javafx:run
```

Or open the folder in **IntelliJ IDEA** as a Maven project and run `Main.java`.

> Run the app from the **project root folder**. The app looks for `config/db.properties` relative to it.

## Database schema

```
users                     posts                       comments
─────────────             ─────────────────           ──────────────
id (PK)          ◄──┐     post_id (PK)        ◄──┐    comment_id (PK)
email (unique)      └──── id (FK → users.id)     └─── post_id (FK → posts.post_id)
password                  post_content                commentdata
username                  likes                       commentorname
phone_number              date
gender                    publishername
birthday
age
bio
profilepic (image)
```

Deleting a user also deletes their posts, and deleting a post deletes its comments.

## Troubleshooting

| Error | Fix |
|---|---|
| `Missing config/db.properties` | You skipped step 3, or the app isn't running from the project root folder. |
| `Access denied for user` | Wrong `db.user` / `db.password`. |
| `Unknown database 'worldz'` | Run `schema.sql` first (step 2), or check the name in `db.url`. |
| `Communications link failure` | MySQL isn't running, or the host/port in `db.url` is wrong. |
| `Public Key Retrieval is not allowed` | Make sure `allowPublicKeyRetrieval=true` is in `db.url`. |

## Project structure

```
├── config/
│   ├── db.properties.example   # template, committed
│   └── db.properties           # your credentials, git-ignored
├── schema.sql                  # database schema
├── pom.xml
└── src/main/
    ├── java/com/example/finallproject/
    │   ├── Main.java           # entry point
    │   ├── database.java       # DB connection + register/login
    │   ├── user.java, post.java, comment.java
    │   └── *Controller.java    # one controller per screen
    └── resources/com/example/finallproject/
        └── *.fxml              # screen layouts
```

## Note

Passwords are stored as plain text, so don't use it with real accounts or passwords you use elsewhere.
