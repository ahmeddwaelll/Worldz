-- Schema reconstructed from the Java source (every SQL statement in the project).
-- Run in MySQL Workbench: File > Open SQL Script > this file > Execute (lightning icon).

-- To use a different database name, change "worldz" on the next two lines AND in config/db.properties (db.url).
CREATE DATABASE IF NOT EXISTS worldz;
USE worldz;

-- database.java, LoginController, RegisterController, SettingsController, user.java, profilepagecontroller
CREATE TABLE IF NOT EXISTS users (
    id           INT AUTO_INCREMENT PRIMARY KEY,      -- rs.getInt("id")
    email        VARCHAR(255) NOT NULL UNIQUE,        -- login key; app checks for duplicates
    password     VARCHAR(255) NOT NULL,               -- stored as plain text by the app
    username     VARCHAR(100) NOT NULL,
    phone_number VARCHAR(11)  NOT NULL,               -- Egyptian format 01xxxxxxxxx (leading 0, so not INT)
    gender       CHAR(1)      NULL,                   -- 'M' / 'F' from ComboBox; may be null if not chosen
    birthday     DATE         NOT NULL,               -- inserted as 'YYYY-MM-DD' string
    age          INT          NOT NULL,
    bio          TEXT         NULL,                   -- setNull when empty
    profilepic   LONGBLOB     NULL                    -- setBytes / getBytes (png/jpg/gif)
);

-- dashboardcontroller, mypostscontroller, commentcontroller
CREATE TABLE IF NOT EXISTS posts (
    post_id       INT AUTO_INCREMENT PRIMARY KEY,     -- rs.getInt("post_id")
    id            INT          NOT NULL,              -- author's users.id (LoginController.u.getID())
    post_content  TEXT         NOT NULL,
    likes         INT          NOT NULL DEFAULT 0,
    date          DATE         NOT NULL,              -- LocalDate.now().toString()
    publishername VARCHAR(100) NOT NULL,              -- author's username at time of posting
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);

-- commentcontroller
CREATE TABLE IF NOT EXISTS comments (
    comment_id    INT AUTO_INCREMENT PRIMARY KEY,     -- not read by the app, but every table needs a key
    post_id       INT          NOT NULL,
    commentdata   TEXT         NOT NULL,
    commentorname VARCHAR(100) NOT NULL,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);
