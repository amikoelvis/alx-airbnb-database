-- BEFORE INDEXING: PERFORMANCE TESTS

-- 1. Bookings per user (before indexing)
EXPLAIN
SELECT 
    u.first_name,
    COUNT(b.booking_id) AS total_bookings
FROM users u
JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.first_name;

-- 2. Properties by host (before indexing)
EXPLAIN
SELECT 
    property_id,
    name,
    location
FROM properties
WHERE host_id = 'sample-host-id';

-- 3. Booking lookup by date range (before indexing)
EXPLAIN
SELECT 
    booking_id,
    user_id,
    property_id,
    start_date,
    end_date
FROM bookings
WHERE start_date >= '2025-01-01' AND end_date <= '2025-12-31';

-- INDEXES

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

-- AFTER INDEXING: PERFORMANCE TESTS

-- 1. Bookings per user (after indexing)
EXPLAIN
SELECT 
    u.first_name,
    COUNT(b.booking_id) AS total_bookings
FROM users u
JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.first_name;

-- 2. Properties by host (after indexing)
EXPLAIN
SELECT 
    property_id,
    name,
    location
FROM properties
WHERE host_id = 'sample-host-id';

-- 3. Booking lookup by date range (after indexing)
EXPLAIN
SELECT 
    booking_id,
    user_id,
    property_id,
    start_date,
    end_date
FROM bookings
WHERE start_date >= '2025-01-01' AND end_date <= '2025-12-31';
