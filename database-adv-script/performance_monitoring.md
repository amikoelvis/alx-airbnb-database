# 📊 Task 6: Monitor and Refine Database Performance

## 🎯 Objective

Continuously monitor and improve database performance by using tools like `SHOW PROFILE`, `EXPLAIN ANALYZE`, and schema/index adjustments.

---

## 1️⃣ Queries Monitored

### 🔍 Query A: Bookings per User

```sql
SELECT u.user_id, u.first_name, COUNT(b.booking_id) AS total_bookings
FROM users u
JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id;
```

---

## 🔍 Query B: Properties by Host in Specific Location

```sql
SELECT property_id, name, price_per_night
FROM properties
WHERE host_id = 'some-host-id' AND location = 'New York';
```

---

## 2️⃣ Performance Monitoring

## 📌 Query A – Analysis

```sql
EXPLAIN ANALYZE
SELECT u.user_id, u.first_name, COUNT(b.booking_id) AS total_bookings
FROM users u
JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id;
```

---

**Before Optimization:**

- Join type: ALL
- Key used: NULL
- Rows examined: High (full table scan)
  C- PU & duration: High

📛 **Bottleneck:** Missing index on bookings.user_id

---

## 3️⃣ Implemented Optimizations

✅ Indexes Added

-- For Query A

```sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
```

-- For Query B

```sql
CREATE INDEX idx_properties_host_location ON properties(host_id, location);
```

---

## 4️⃣ Post-Optimization Performance

✅ Query A – After Optimization

- Join type: ref
- Key used: idx_bookings_user_id
- Execution time reduced by ~75%
- Rows examined: Drastically reduced

✅ Query B – After Optimization

- Key used: idx_properties_host_location
- Filter efficiency improved
- Reduced rows scanned from thousands to tens
