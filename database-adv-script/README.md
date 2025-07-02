# 🧩 SQL Join Practice – Complex Queries

## 🎯 Objective

Master SQL joins by writing **complex queries** using `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` to retrieve and combine data across multiple related tables.

This exercise uses a normalized schema similar to an Airbnb-like system, including `users`, `properties`, `bookings`, and `reviews`.

---

## ✅ 1. INNER JOIN – Bookings and Users

**Retrieve all bookings and the respective users who made those bookings.**

```sql
SELECT
    b.booking_id,
    b.user_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at,
    u.first_name,
    u.last_name,
    u.email,
    u.password_hash,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id;
```

---

🔎 **Explanation:** Returns only bookings that have a matching user. Unmatched data from either table is excluded.

---

## ✅ 2. LEFT JOIN – Properties and Reviews

**Retrieve all properties and their reviews, including properties that have no reviews.**

```sql
SELECT
    p.property_id,
    p.host_id,
    p.name,
    p.description,
    p.location,
    p.price_per_night,
    p.created_at,
    p.updated_at,
    r.review_id,
    r.property_id AS review_property_id,
    r.user_id AS reviewer_id,
    r.rating,
    r.comment,
    r.created_at AS review_created_at
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;
```

---

🔎 Explanation: Returns all properties, along with any matching reviews. If a property has no reviews, the review fields will be NULL.

---

## ✅ 3. FULL OUTER JOIN (Emulated) – Users and Bookings

**Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.**

```sql
-- Emulating FULL OUTER JOIN using UNION of LEFT and RIGHT JOINs
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.password_hash,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at,
    b.booking_id,
    b.user_id AS booking_user_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id

UNION

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.password_hash,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at,
    b.booking_id,
    b.user_id AS booking_user_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at
FROM users u
RIGHT JOIN bookings b ON u.user_id = b.user_id;
```

---

**Explanation:** Combines the results of a LEFT JOIN and a RIGHT JOIN to simulate a FULL OUTER JOIN. Ensures:

Users without bookings are included.

Bookings not linked to valid users are also included.

---

# 🔄 SQL Subqueries Practice

## 🎯 Objective

Practice writing both **correlated** and **non-correlated** subqueries using a normalized Airbnb-style database schema. The goal is to filter data using nested queries while ensuring all relevant fields are retrieved.

---

## ✅ 1. Non-Correlated Subquery – Properties with High Average Ratings

**Task**: Find all properties where the **average review rating** is greater than `4.0`.

```sql
SELECT
    p.property_id,
    p.host_id,
    p.name,
    p.description,
    p.location,
    p.price_per_night,
    p.created_at,
    p.updated_at
FROM properties p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);
```

---

📌 **Explanation:**

The subquery calculates the average rating for each property.

The outer query retrieves all property details for those meeting the rating threshold.

This is a non-correlated subquery — it runs independently of the outer query.

---

## ✅ 2. Correlated Subquery – Users with More Than 3 Bookings

**Task**: Task: Find all users who have made more than three bookings..

```sql
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.password_hash,
    u.phone_number,
    u.role,
    u.created_at
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;

```

---

📌 **Explanation:**

The subquery counts bookings per user by referencing the outer query’s u.user_id.

Users with more than 3 bookings are returned.

This is a correlated subquery — it runs once per row in the outer query.

---

# 📊 SQL Aggregations & Window Functions Practice

## 🎯 Objective

Apply SQL **aggregation functions** and **window functions** to analyze data from a normalized Airbnb-style database schema.

---

## ✅ 1. Aggregation: Total Bookings per User

**Task**: Use `COUNT()` and `GROUP BY` to find the total number of bookings made by each user.

```sql
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.password_hash,
    u.phone_number,
    u.role,
    u.created_at,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.password_hash,
    u.phone_number,
    u.role,
    u.created_at;
```

---

📌 **Explanation:**

COUNT(b.booking_id) counts how many bookings each user has made.

LEFT JOIN ensures users with zero bookings are included.

All fields from the users table are selected for completeness and potential auditing.

---

## ✅ 2. Window Function: Rank Properties by Total Bookings

**Task**: Use a window function to rank properties based on the total number of bookings they’ve received..

```sql
SELECT
    ranked.property_id,
    ranked.host_id,
    ranked.name,
    ranked.description,
    ranked.location,
    ranked.price_per_night,
    ranked.created_at,
    ranked.updated_at,
    ranked.total_bookings,
    ROW_NUMBER() OVER (ORDER BY ranked.total_bookings DESC) AS row_number,
    RANK() OVER (ORDER BY ranked.total_bookings DESC) AS booking_rank
FROM (
    SELECT
        p.property_id,
        p.host_id,
        p.name,
        p.description,
        p.location,
        p.price_per_night,
        p.created_at,
        p.updated_at,
        COUNT(b.booking_id) AS total_bookings
    FROM properties p
    LEFT JOIN bookings b ON p.property_id = b.property_id
    GROUP BY
        p.property_id,
        p.host_id,
        p.name,
        p.description,
        p.location,
        p.price_per_night,
        p.created_at,
        p.updated_at
) AS ranked;
```

---

🔍 **Explanation:**
ROW_NUMBER() gives a strict sequence (1, 2, 3…) — even when booking counts are tied.

RANK() gives equal ranking for ties (e.g., 1, 1, 3…).

Both rankings help you analyze and compare property performance more flexibly.
