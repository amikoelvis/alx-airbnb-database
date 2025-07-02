-- INNER JOIN – All Bookings with User Details
SELECT 
    b.booking_id,
    b.user_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at,
    u.user_id AS user_user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id;

-- LEFT JOIN – All Properties and Their Reviews (including those with no reviews)
SELECT 
    p.property_id AS property_id,
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
ORDER BY p.property_id, r.created_at;

-- FULL OUTER JOIN (Emulated) – All Users and All Bookings, Even Unlinked Ones
-- Emulates FULL OUTER JOIN using UNION in MySQL
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
