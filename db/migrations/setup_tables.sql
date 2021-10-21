CREATE TABLE spaces(id SERIAL PRIMARY KEY, space_name VARCHAR(60), description VARCHAR(500), rate INT, user_id INT);
CREATE TABLE users(id SERIAL PRIMARY KEY, username VARCHAR(20), email VARCHAR(50), password VARCHAR(20));
CREATE TABLE bookings(id SERIAL PRIMARY KEY, space_id INT, user_id INT, date_from DATE, date_to DATE, confirmed BIT);