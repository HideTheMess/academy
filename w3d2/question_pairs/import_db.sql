CREATE TABLE users
(
	id INTEGER PRIMARY KEY,
	fname VARCHAR(255) NOT NULL,
	lname VARCHAR(255) NOT NULL
);

INSERT INTO
	users (fname, lname)
VALUES
	('Albert', 'Einstein'), ('Kurt', 'Godel'), ('Babe', 'Ruth'),
	('Freddie', 'Wong');

CREATE TABLE questions
(
	id INTEGER PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	body TEXT NOT NULL,
	author_id INTEGER NOT NULL,
	FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
	questions (title, body, author_id)
VALUES
	('Albie', 'Yoyoyo', 1);

CREATE TABLE question_followers
(
	id INTEGER PRIMARY KEY,
	follower_id INTEGER NOT NULL,
	question_id INTEGER NOT NULL,
	FOREIGN KEY (follower_id) REFERENCES users(id),
	FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
	question_followers (follower_id, question_id)
VALUES
	(2, 1);

CREATE TABLE replies
(
	id INTEGER PRIMARY KEY,
	reply TEXT NOT NULL,
	question_id INTEGER NOT NULL,
	parent_id INTEGER,
	user_id INTEGER NOT NULL,
	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (parent_id) REFERENCES replies(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
	replies (reply, question_id, parent_id, user_id)
VALUES
	('Not Cool', 1, NULL, 3),
	('Naw, very cool', 1, 1, 4);

CREATE TABLE question_likes
(
	id INTEGER PRIMARY KEY,
	user_id INTEGER NOT NULL,
	question_id INTEGER NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
	question_likes (user_id, question_id)
VALUES
	(4, 1);
