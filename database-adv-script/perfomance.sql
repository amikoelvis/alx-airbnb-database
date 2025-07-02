-- 1️. INITIAL COMPLEX QUERY (Unoptimized)
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
-- - No WHERE, LIMIT, or date filtering—this can lead to high cost on large datasets.
-- - May result in large result set and slower execution due to full scans if not indexed.

-- 2️. REFACTORED OPTIMIZED QUERY

-- Optimization strategies:
-- Use of WHERE clause to reduce scope (e.g., recent bookings).
-- Ensured proper indexes exist on user_id, property_id, booking_id.
-- Reduce selected columns to only what's necessary for business logic.
-- Use of pagination (LIMIT) to avoid large unbounded result sets.

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
LIMIT 100;

-- Notes:
-- - Added WHERE clause on booking date for better performance.
-- - Reduced column selection to just those required.
-- - Used LIMIT to cap large result loads.
-- - Relies on existing indexes:
--   → idx_bookings_user_id
--   → idx_bookings_property_id
--   → idx_users_user_id
--   → idx_properties_host_id
--   → idx_payments_booking_id
