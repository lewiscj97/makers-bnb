CREATE TABLE spaces(id SERIAL PRIMARY KEY, space_name VARCHAR(60), description VARCHAR(500), rate INT, user_id INT);
CREATE TABLE users(id SERIAL PRIMARY KEY, username VARCHAR(20), email VARCHAR(50), password VARCHAR(20));
