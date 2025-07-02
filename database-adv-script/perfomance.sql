-- 1️. INITIAL COMPLEX QUERY (Unoptimized)
-- =========================================

-- This query retrieves all bookings with full user, property, and payment details.
-- It may include unnecessary data and join all rows without filters or pagination.

-- Performance Analysis (Before Optimization)
EXPLAIN
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,

    u.user_id,
    u.first_name,
    u.last_name,
    u.email,

    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,

    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date

FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON pay.booking_id = b.booking_id;

-- Notes:
-- - Includes LEFT JOIN for payments since not all bookings may be paid.
-- - No WHERE, LIMIT, or date filtering — this can lead to high cost on large datasets.
-- - May result in large result set and slower execution due to full scans if not indexed.

-- 2️. REFACTORED OPTIMIZED QUERY

-- Optimization strategies:
-- WHERE clause to reduce scope.
-- Use of AND condition for more precise filtering.
-- LIMIT clause to paginate results.
-- Reduced selected columns.
-- Relies on proper indexing.

-- Performance Analysis (After Optimization)
EXPLAIN
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,

    u.first_name,
    u.last_name,
    u.email,

    p.name AS property_name,
    p.location,

    pay.amount,
    pay.payment_method

FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON pay.booking_id = b.booking_id
WHERE b.created_at >= '2025-01-01'
  AND b.status = 'confirmed'
LIMIT 100;

-- Notes:
-- - Added WHERE clause with AND condition (date + status).
-- - Used LIMIT to cap large result loads.
-- - Reduced column selection to just those required.
-- - Relies on existing indexes:
--   → idx_bookings_user_id
--   → idx_bookings_property_id
--   → idx_bookings_dates
--   → idx_users_user_id
--   → idx_payments_booking_id
