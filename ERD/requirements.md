## 🗂️ Entities and Attributes

### 1. User

- `user_id` (Primary Key)
- `first_name`
- `last_name`
- `email` (Unique)
- `password_hash`
- `phone_number` (Optional)
- `role` (ENUM: guest, host, admin)
- `created_at`

---

### 2. Property

- `property_id` (Primary Key)
- `host_id` (Foreign Key → User)
- `name`
- `description`
- `location`
- `pricepernight`
- `created_at`
- `updated_at`

---

### 3. Booking

- `booking_id` (Primary Key)
- `property_id` (Foreign Key → Property)
- `user_id` (Foreign Key → User)
- `start_date`
- `end_date`
- `total_price`
- `status` (ENUM: pending, confirmed, canceled)
- `created_at`

---

### 4. Payment

- `payment_id` (Primary Key)
- `booking_id` (Foreign Key → Booking)
- `amount`
- `payment_date`
- `payment_method` (ENUM: credit_card, paypal, stripe)

---

### 5. Review

- `review_id` (Primary Key)
- `property_id` (Foreign Key → Property)
- `user_id` (Foreign Key → User)
- `rating` (INTEGER: 1 to 5)
- `comment`
- `created_at`

---

### 6. Message

- `message_id` (Primary Key)
- `sender_id` (Foreign Key → User)
- `recipient_id` (Foreign Key → User)
- `message_body`
- `sent_at`

---

## 🔗 Relationships Between Entities (Role-Aware)

| Entity A | Role(s)        | Relationship | Entity B       | Description                                                |
| -------- | -------------- | ------------ | -------------- | ---------------------------------------------------------- |
| User     | **host**       | 1 → ∞        | Property       | A host can list many properties                            |
| User     | **guest**      | 1 → ∞        | Booking        | A guest can make many bookings                             |
| Property |                | 1 → ∞        | Booking        | A property can have many bookings                          |
| Booking  |                | 1 → 1        | Payment        | Each booking has one payment                               |
| Property |                | 1 → ∞        | Review         | A property can have many reviews                           |
| User     | **guest**      | 1 → ∞        | Review         | A guest can write many reviews                             |
| User     | **guest/host** | ∞ → ∞        | Message        | Users can message each other                               |
| User     | **admin**      | -            | (all entities) | Admins can view/manage all records (role-based privileges) |

---

## 🖼️ Entity Relationship Diagram (ERD)

> This diagram is rendered using [Mermaid](https://mermaid.js.org) syntax. It is compatible with GitHub markdown preview.

```mermaid
erDiagram
    USER ||--o{ PROPERTY : hosts
    USER ||--o{ BOOKING : makes
    USER ||--o{ REVIEW : writes
    USER ||--o{ MESSAGE : sends
    USER ||--o{ MESSAGE : receives

    PROPERTY ||--o{ BOOKING : includes
    PROPERTY ||--o{ REVIEW : has

    BOOKING ||--|| PAYMENT : has

    USER {
        UUID user_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email UNIQUE
        VARCHAR password_hash
        VARCHAR phone_number
        ENUM role
        TIMESTAMP created_at
    }

    PROPERTY {
        UUID property_id PK
        UUID host_id FK
        VARCHAR name
        TEXT description
        VARCHAR location
        DECIMAL pricepernight
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    BOOKING {
        UUID booking_id PK
        UUID property_id FK
        UUID user_id FK
        DATE start_date
        DATE end_date
        DECIMAL total_price
        ENUM status
        TIMESTAMP created_at
    }

    PAYMENT {
        UUID payment_id PK
        UUID booking_id FK
        DECIMAL amount
        TIMESTAMP payment_date
        ENUM payment_method
    }

    REVIEW {
        UUID review_id PK
        UUID property_id FK
        UUID user_id FK
        INTEGER rating
        TEXT comment
        TIMESTAMP created_at
    }

    MESSAGE {
        UUID message_id PK
        UUID sender_id FK
        UUID recipient_id FK
        TEXT message_body
        TIMESTAMP sent_at
    }
```
