# 📈 Partitioning Performance Report: Bookings Table

## 🎯 Objective

Improve performance of date-range queries on a large `bookings` table by applying partitioning based on the `start_date` column.

---

## ⚙️ Implementation Summary

- The `bookings` table was dropped and recreated using `RANGE` partitioning on `YEAR(start_date)`.
- Five partitions were defined: 2022–2025 and a catch-all `pmax`.

---

## 🧪 Test Query

```sql
SELECT booking_id, property_id, user_id
FROM bookings
WHERE start_date BETWEEN '2025-01-01' AND '2025-06-30';
```
