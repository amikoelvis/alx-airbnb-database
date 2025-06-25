# 🧼 Normalization Review of the ALX Airbnb Database

This document analyzes the ALX Airbnb Database schema using database normalization principles as explained by Leah Nguyen in _"A Brief Guide to Database Normalization."_

---

## 🔍 Purpose of Normalization

Database normalization helps reduce redundancy and prevent update, insert, and delete anomalies. This review checks the schema against:

- ✅ **First Normal Form (1NF)**: Atomic attributes and unique rows.
- ✅ **Second Normal Form (2NF)**: No partial dependency on part of a composite key.
- ✅ **Third Normal Form (3NF)**: No transitive dependencies (non-key attributes depending on other non-key attributes).

---

## 🧩 Entity Analysis

### 1. **User**

| Attribute | Notes                    |
| --------- | ------------------------ |
| `user_id` | Primary key, UUID        |
| `role`    | ENUM: guest, host, admin |

- ✅ **1NF**: All values are atomic.
- ✅ **2NF**: Primary key is simple; no partial dependencies.
- ✅ **3NF**: All fields depend directly on `user_id`.

🔎 **No issues. Fully normalized to 3NF.**

---

### 2. **Property**

| Attribute | Notes                 |
| --------- | --------------------- |
| `host_id` | FK to `User(user_id)` |

- ✅ **1NF**: All values are atomic.
- ✅ **2NF**: Depends fully on `property_id`.
- ✅ **3NF**: No transitive dependencies.

🔎 **No changes required.**

---

### 3. **Booking**

| Attribute                | Notes                               |
| ------------------------ | ----------------------------------- |
| `property_id`, `user_id` | FKs to respective tables            |
| `status`                 | ENUM (pending, confirmed, canceled) |

- ✅ **1NF**: Atomic values only.
- ✅ **2NF**: No composite primary key, so partial dependencies don't apply.
- ✅ **3NF**: No transitive dependency (e.g., `status` does not depend on another non-key).

🔎 **Booking is normalized.**

---

### 4. **Payment**

| Attribute    | Notes                                           |
| ------------ | ----------------------------------------------- |
| `booking_id` | 1:1 FK to Booking                               |
| `amount`     | Might seem derivable from `Booking.total_price` |

- ✅ **1NF**: Atomic values.
- ✅ **2NF**: All fields depend on `payment_id`.
- ⚠️ **3NF Risk**: `amount` may be a derived or repeated value from `Booking`.

💡 **Design Decision**: `Payment.amount` is retained to allow flexibility (partial payments, discounts, adjustments). This is a **controlled denormalization**, which is acceptable in real-world transactional systems.

---

### 5. **Review**

| Attribute | Notes                   |
| --------- | ----------------------- |
| `rating`  | Integer between 1 and 5 |

- ✅ **1NF**: All fields atomic.
- ✅ **2NF**: `review_id` is a single primary key.
- ✅ **3NF**: All fields depend on `review_id`.

🔎 **Fully normalized.**

---

### 6. **Message**

| Attribute                   | Notes       |
| --------------------------- | ----------- |
| `sender_id`, `recipient_id` | FKs to User |

- ✅ **1NF**: Atomic fields.
- ✅ **2NF**: No partial dependency.
- ✅ **3NF**: Message text and timestamp depend only on `message_id`.

🔎 **No issues found.**

---

## 📦 Summary of Normalization Status

| Table    | 1NF | 2NF | 3NF | Notes                                  |
| -------- | --- | --- | --- | -------------------------------------- |
| User     | ✅  | ✅  | ✅  | No issues                              |
| Property | ✅  | ✅  | ✅  | No issues                              |
| Booking  | ✅  | ✅  | ✅  | Well-structured                        |
| Payment  | ✅  | ✅  | ⚠️  | `amount` is denormalized by design     |
| Review   | ✅  | ✅  | ✅  | No redundancy or transitive dependency |
| Message  | ✅  | ✅  | ✅  | Well-structured communication table    |

---

## ✅ Final Thoughts

The schema is fully normalized up to **Third Normal Form (3NF)**. The only exception is a deliberate and justifiable use of denormalization in the `Payment` table to allow **business flexibility** for payment processing.

This normalization ensures:

- Efficient data storage
- Easier updates and inserts
- Reduced redundancy
- Logical data separation

> 🧠 Based on Leah Nguyen’s principles, this schema is robust and production-ready with regard to normalization.
