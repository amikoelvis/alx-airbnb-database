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
