# 🚀 Task 3: Implement Indexes for Optimization

## 🎯 Objective

Improve SQL query performance by creating indexes on high-usage columns. Understand how different types of indexes work and how they affect read/write operations in a relational database.

---

## 🧠 What is an Index?

An **index** is a data structure that helps the database engine find rows faster, reducing query execution time. Think of it as a book’s table of contents — it allows you to jump straight to the page you need.

---

## 🔍 Why Use Indexes?

- 🚀 Speed up `SELECT`, `JOIN`, `WHERE`, and `ORDER BY` queries
- 📉 Reduce full table scans
- ✅ Enforce data integrity (e.g., uniqueness)

---

## 🧱 Types of Indexes

| Index Type          | Description                                                             |
| ------------------- | ----------------------------------------------------------------------- |
| **Primary Index**   | Auto-created for the `PRIMARY KEY`; enforces uniqueness                 |
| **Unique Index**    | Ensures values in a column are unique (e.g., `users.email`)             |
| **Composite Index** | Covers multiple columns (e.g., `(start_date, end_date)` in `bookings`)  |
| **Full-Text Index** | Supports keyword-based text searches (e.g., `reviews.comment`)          |
| **Clustered Index** | Sorts and stores rows in order (InnoDB: the PK is clustered by default) |
| **Non-Clustered**   | Separate structure that points to actual data rows                      |

---

## 🛠 Index Implementation Strategy

### ✅ Step 1: Identify High-Usage Columns

| Table        | Columns Indexed                          | Reason                               |
| ------------ | ---------------------------------------- | ------------------------------------ |
| `users`      | `email`, `user_id`                       | Login lookups, joins with `bookings` |
| `bookings`   | `user_id`, `property_id`, `start_date`   | Joins, filtering, date range queries |
| `properties` | `host_id`, `location`, `price_per_night` | Search/filtering and joins           |
| `messages`   | `sender_id`, `recipient_id`              | Fast retrieval of message threads    |
| `reviews`    | `property_id`, `user_id`                 | Review filtering per property/user   |

---

### ✅ Step 2: Create Indexes

```sql
-- Users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_user_id ON users(user_id);

-- Bookings
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);

-- Properties
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price_per_night);

-- Messages
CREATE INDEX idx_messages_sender_id ON messages(sender_id);
CREATE INDEX idx_messages_recipient_id ON messages(recipient_id);

-- Reviews
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);
```

---

## ✅ Step 3: Verify Performance with EXPLAIN

## 🐢 Before Indexing:

```sql
EXPLAIN
SELECT u.first_name, b.start_date
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.start_date >= '2025-01-01';
```

---

**Look for:**

"type" = ALL → Full Table Scan

"key" = NULL → No index used

---

## ⚡ After Indexing:

```sql
EXPLAIN
SELECT u.first_name, b.start_date
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.start_date >= '2025-01-01';
```

**Expect:**

"type" = ref or range → Indexed lookup

"key" = idx_bookings_user_id or idx_bookings_dates
