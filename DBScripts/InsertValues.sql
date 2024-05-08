USE ILibrary;
DELETE FROM Users;
DELETE FROM  Books;
DELETE FROM  Rating;


INSERT INTO Users (name)
VALUES ('Raj'),
('Mini'),
('San');

INSERT INTO Books (title, keywords, topic,userid)
VALUES ('.NEt PRO','microsoft .net web open', '.net for begginers',1),
('PYTHON 101','Ppython web script', 'python for begginers',1),
('BLOCKCHAIN TECH','crypto blockchain currency mining', 'blockchian to learn crypto',3),
('START AI','AI ML deep learning', 'AI basics',2),
('Data Structures and Algorithms in Java (6th Edition)','DSA linked list stack queue', 'Advance DSa tips',1),
('CPP for you','system programming', 'CPP for begginers',2),
('Cyber Security','web security encryption', 'yber ecurity intro',1),
('Web Applications','web pages', 'web apps net',2),
('Linked Lists in Python: A Practical Guide','python linnked list', 'python book on linked list dsa',3),
('OPEN AI','open ai chat gpt', 'openai introduction',2),
('Deep Learning with Kera','kera deep tensorflow', 'AI for advance users',1),
('Best from Java','java jsp web', 'java for begginers',3);

INSERT INTO Rating(star, bookid)
VALUES (2,1),(5,3),(5,5),(2,7),(5,9),(5,11),
(4,2),(5,4),(5,6),(2,8),(5,10),
(5,1),(3,2),(5,3);