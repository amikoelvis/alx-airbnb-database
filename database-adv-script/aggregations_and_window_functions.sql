-- 1. Aggregation Query – Total Bookings Per User
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

-- 2. Window Function Query – Rank Properties by Total Bookings
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
    ROW_NUMBER() OVER (ORDER BY ranked.total_bookings DESC) AS booking_row_number
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
