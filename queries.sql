CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    first_name CHARACTER VARYING(30),
    last_name CHARACTER VARYING(30),
    faculty_license_code CHARACTER VARYING(30),
    password CHARACTER VARYING(100)
);

CREATE TABLE classes
(
    id SERIAL PRIMARY KEY,
    number INTEGER ,
    seats_count INTEGER ,
    floor INTEGER
);

CREATE TABLE times
(
    id SERIAL PRIMARY KEY,
    class_id INTEGER,
    date VARCHAR(20),
    time_from VARCHAR(20),
    time_to VARCHAR(20),
    FOREIGN KEY (class_id) REFERENCES classes (id) ON DELETE CASCADE
);

CREATE TABLE teachers_schedule
(
    class_id INTEGER,
    time_id INTEGER,
    teacher_name CHARACTER VARYING(100),
    group_name VARCHAR(100),
    FOREIGN KEY (class_id) REFERENCES classes (id) ON DELETE CASCADE,
    FOREIGN KEY (time_id) REFERENCES times (id) ON DELETE CASCADE
);

CREATE TABLE ordinary_users_schedule
(
    class_id INTEGER,
    user_id INTEGER,
    time_id INTEGER,
    FOREIGN KEY (class_id) REFERENCES classes (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (time_id) REFERENCES times (id) ON DELETE CASCADE
);

INSERT INTO users (first_name, last_name, faculty_license_code, password)
VALUES ('Dave', 'Bautista', '12345', 'dave'),
	   ('John', 'Cena', '12346', 'john'),
	   ('Jack', 'Sparrow', '12347', 'jack'),
	   ('Maya', 'Snow', '12348', 'maya'),
	   ('Lake', 'Ocean', '12349', 'lake'),
	   ('Remy', 'Ratty', '12340', 'remy');

INSERT INTO classes (number, seats_count, floor)
VALUES (201, 30, 2),
       (212, 28, 2),
       (324, 40, 3),
       (408, 25, 4),
       (310, 70, 3);

INSERT INTO times (class_id, "date", time_from, time_to)
VALUES (1, '12.04.2021', '9:00', '10:00'),
       (1, '12.04.2021', '10:30', '11:30'),
       (1, '12.04.2021', '12:00', '13:00'),
       (2, '12.04.2021', '9:00', '10:00'),
       (2, '12.04.2021', '10:30', '11:30'),
       (2, '12.04.2021', '12:00', '13:00'),
       (3, '12.04.2021', '9:00', '10:00'),
       (3, '12.04.2021', '10:30', '11:30'),
       (3, '12.04.2021', '12:00', '13:00'),
       (4, '12.04.2021', '9:00', '10:00'),
       (4, '12.04.2021', '10:30', '11:30'),
       (4, '12.04.2021', '12:00', '13:00'),
       (5, '12.04.2021', '9:00', '10:00'),
       (5, '12.04.2021', '10:30', '11:30'),
       (5, '12.04.2021', '12:00', '13:00');

INSERT INTO teachers_schedule (class_id, time_id, teacher_name, group_name)
VALUES (1, 1, 'Georg Marikov', 'TETA-43'),
       (1, 3, 'Barry Allen', 'KAST-21'),
       (2, 5, 'Peris Hilton', 'MIT-11'),
       (3, 7, 'Terry Hills', 'OPD-41'),
       (3, 9, 'Lilly Rose', 'KJA-33'),
       (4, 11, 'Vanya Depp', 'WRT-23'),
       (5, 13, 'Miko Slang', 'YUD-42'),
       (5, 15, 'Sara Lense', 'KAST-21');

INSERT INTO ordinary_users_schedule (class_id, user_id, time_id)
VALUES (1, 1, 2),
       (2, 1, 4),
       (2, 2, 6),
       (3, 3, 8),
       (4, 4, 10),
       (4, 5, 12),
       (5, 3, 14);