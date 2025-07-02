-- 📁 database_index.sql

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

-- Before Indexing
EXPLAIN
SELECT u.first_name, b.start_date
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.start_date >= '2025-01-01';

-- After Indexing
EXPLAIN
SELECT u.first_name, b.start_date
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.start_date >= '2025-01-01';
