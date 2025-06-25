-- =======================================
-- 🚀 Airbnb Sample Data Seeder (seed.sql)
-- =======================================

-- Clear tables if needed
-- TRUNCATE TABLE messages, reviews, payments, bookings, properties, users RESTART IDENTITY CASCADE;

-- =================
-- 1. Users
-- =================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  ('c4d8a1d2-0001-4abc-888a-000000000001', 'Alice', 'Smith', 'alice@example.com', 'hashed_pw_1', '555-0101', 'host'),
  ('c4d8a1d2-0002-4abc-888a-000000000002', 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw_2', '555-0202', 'guest'),
  ('c4d8a1d2-0003-4abc-888a-000000000003', 'Carol', 'Lee', 'carol@example.com', 'hashed_pw_3', '555-0303', 'guest'),
  ('c4d8a1d2-0004-4abc-888a-000000000004', 'Dave', 'Brown', 'dave@example.com', 'hashed_pw_4', NULL, 'admin');

-- =================
-- 2. Properties
-- =================
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
VALUES
  ('prop-0001-uuid-0001-000000000001', 'c4d8a1d2-0001-4abc-888a-000000000001', 'Cozy Cottage', 'A small cozy cottage near the lake.', 'Lakeside, Countryville', 75.00),
  ('prop-0002-uuid-0001-000000000002', 'c4d8a1d2-0001-4abc-888a-000000000001', 'Modern Loft', 'Spacious loft with a great view.', 'City Center, Metropolis', 120.00);

-- =================
-- 3. Bookings
-- =================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  ('book-0001-uuid-0001', 'prop-0001-uuid-0001-000000000001', 'c4d8a1d2-0002-4abc-888a-000000000002', '2025-07-01', '2025-07-05', 300.00, 'confirmed'),
  ('book-0002-uuid-0002', 'prop-0002-uuid-0001-000000000002', 'c4d8a1d2-0003-4abc-888a-000000000003', '2025-07-10', '2025-07-15', 600.00, 'pending');

-- =================
-- 4. Payments
-- =================
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
  ('pay-0001-uuid-0001', 'book-0001-uuid-0001', 300.00, 'credit_card');

-- =================
-- 5. Reviews
-- =================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
  ('rev-0001-uuid-0001', 'prop-0001-uuid-0001-000000000001', 'c4d8a1d2-0002-4abc-888a-000000000002', 5, 'Loved the cozy cottage! Peaceful and clean.'),
  ('rev-0002-uuid-0002', 'prop-0002-uuid-0001-000000000002', 'c4d8a1d2-0003-4abc-888a-000000000003', 4, 'Loft had a nice view but noisy at night.');

-- =================
-- 6. Messages
-- =================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
  ('msg-0001-uuid-0001', 'c4d8a1d2-0002-4abc-888a-000000000002', 'c4d8a1d2-0001-4abc-888a-000000000001', 'Hi, is the cottage available this weekend?'),
  ('msg-0002-uuid-0002', 'c4d8a1d2-0001-4abc-888a-000000000001', 'c4d8a1d2-0002-4abc-888a-000000000002', 'Yes, it is available. You can book now.');
