DROP DATABASE IF EXISTS ILibrary;
CREATE DATABASE IF NOT EXISTS ILibrary;

USE ILibrary;
DROP TABLE IF EXISTS  Users;
DROP TABLE IF EXISTS  Books;
DROP TABLE IF EXISTS Rating;

USE ILibrary;
CREATE TABLE IF NOT EXISTS Users (
    id int PRIMARY KEY AUTO_INCREMENT,
    name varchar(255),
    pwd varchar(1000)
);


USE ILibrary;
CREATE TABLE IF NOT EXISTS Books (
    id int PRIMARY KEY AUTO_INCREMENT,
    title varchar(255),
    keywords varchar(1000),
    topic varchar(255),
    content MEDIUMBLOB,
	userid int  REFERENCES Users(id)
);

USE ILibrary;
CREATE TABLE IF NOT EXISTS Rating (
    id int PRIMARY KEY AUTO_INCREMENT,
    star int,
    bookid int REFERENCES Books(id)
);

