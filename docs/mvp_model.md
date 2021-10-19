# Models for MakersBnB MVP
## CRC

### Space

| **Behaviours**       | **Collaborators** |
|----------------------|-------------------|
| - Create a new space | - User            |
| - Has a name              |
| - Has a short description |
| - Has a rate              |
| - Has available dates     |
| - Is associated with a user |

### User

| **Behaviours**                        | **Collaborators** |
|---------------------------------------|-------------------|
| - Has a profile (name/email/password) | - Space           |
| - List a new space              |
| - View the user's spaces |
| - View other spaces              |

## Table models
### spaces

| id                 | name    | description   | rate | user_id |
|--------------------|---------|---------------|------|---------|
| SERIAL PRIMARY KEY | VARCHAR | VARCHAR       | INT  | INT     |
| 5                  | Foo     | A lovely home | 50   | 23      |

### users

| id                 | username    | email       | password |
|--------------------|-------------|-------------|----------|
| SERIAL PRIMARY KEY | VARCHAR     | VARCHAR     | VARCHAR  |
| 23                 | Bar         | bar@foo.com | password |

Users and spaces have a one-to-many relationship.
