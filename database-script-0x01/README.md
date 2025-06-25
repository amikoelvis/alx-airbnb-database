# 🏠 ALX Airbnb Database Schema

This project defines the relational schema for an Airbnb-style platform using standard SQL. The schema is designed to be scalable, normalized (up to 3NF), and optimized for real-world use cases like booking, reviewing, and messaging.

---

## 📂 Files

- `schema.sql`: Contains all `CREATE TABLE` statements, constraints, and indexes.
- `README.md`: Explains the schema structure, relationships, and constraints.

---

## 📄 Schema Overview

### 1. **User**

Stores user details (guests, hosts, admins).

- UUID primary key
- Email is unique and indexed
- Role is constrained to ENUM: guest, host, admin

---

### 2. **Property**

Represents listings hosted by users.

- Linked to `User` via `host_id`
- Has location, price per night, timestamps
- Indexed by `host_id`

---

### 3. **Booking**

Records reservations made by users for properties.

- References both `User` and `Property`
- Tracks start/end dates, total cost, and status
- Indexed for fast lookup by property or user

---

### 4. **Payment**

Tracks payments made for bookings.

- References `Booking`
- Includes amount and payment method
- Supports multiple methods (credit card, PayPal, Stripe)

---

### 5. **Review**

User-generated reviews for properties.

- Links to both `User` (guest) and `Property`
- Includes a 1–5 star rating with a comment

---

### 6. **Message**

User-to-user messaging system.

- Each message has sender and recipient
- Supports direct communication between guests and hosts

---

## 🧠 Design Principles

- **3NF Compliance**: All entities are fully normalized with no transitive dependencies.
- **Foreign Key Constraints**: Ensure referential integrity between entities.
- **Indexed Columns**: Improve performance for frequent queries.
- **UUIDs**: Used for globally unique identification across distributed systems.

---
