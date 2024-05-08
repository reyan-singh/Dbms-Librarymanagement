USE ILibrary;
DROP PROCEDURE IF EXISTS  GetALLBooks;
DROP PROCEDURE IF EXISTS  SetRating;
DROP PROCEDURE IF EXISTS  GetSearchedBooks;
DROP PROCEDURE IF EXISTS  GetBooksRating;
DROP FUNCTION IF EXISTS  GetBookRating;
DROP PROCEDURE IF EXISTS  GetUsersRating;
DROP PROCEDURE IF EXISTS  AddBook;
DROP FUNCTION IF EXISTS  GetUserName;
DROP TRIGGER IF EXISTS  after_books_insert;

use ILibrary;
DELIMITER //
CREATE PROCEDURE GetUsersRating()
BEGIN
	SELECT B.userid,U.name,(sum(R.star)/count(*)) FROM Books B
	INNER JOIN Rating R ON B.id=R.bookid 
    INNER JOIN Users U ON B.userid=U.id 
	GROUP BY B.userid,U.name;
END //
DELIMITER ;


use ILibrary;
DELIMITER //
CREATE FUNCTION GetBookRating(id int)  RETURNS int DETERMINISTIC
BEGIN
	DECLARE total int;
	SELECT (sum(R.star)/count(*)) into total FROM Books B
    INNER JOIN Rating R ON B.id=R.bookid 
	WHERE  B.id=id
	GROUP BY B.id;
    RETURN total;
END //
DELIMITER ;

use ILibrary;
DELIMITER //
CREATE FUNCTION GetUserName(id int)  RETURNS varchar(255) DETERMINISTIC
BEGIN
	DECLARE uname varchar(255);
	SELECT U.name into uname FROM Users U
	INNER JOIN Books B ON B.userid=U.id 
	WHERE  B.id=id;
	RETURN uname;
END //
DELIMITER ;

USE ILibrary;
DELIMITER //
CREATE PROCEDURE GetALLBooks() 
BEGIN
	SELECT DISTINCT B.id,B.title,B.keywords,B.topic,GetBookRating(B.id) AS Rating, GetUserName(B.id) AS UserName  FROM Books B LEFT JOIN Rating R ON B.id=R.bookid;
END //
DELIMITER ;

use ILibrary;
DELIMITER //
CREATE PROCEDURE SetRating(bookid int, rating int) 
BEGIN
	INSERT INTO Rating(bookid,star)
    VALUES(bookid,rating);
END //
DELIMITER ;

use ILibrary;
DELIMITER //
CREATE PROCEDURE GetSearchedBooks(val varchar(1000)) 
BEGIN
	SELECT DISTINCT  B.id,B.title,B.keywords,B.topic,GetBookRating(B.id) AS Rating 
    FROM Books B LEFT JOIN Rating R ON B.id=R.bookid 
    WHERE B.title   REGEXP val OR 
    B.keywords   REGEXP val OR
    B.topic   REGEXP val;
END //
DELIMITER ;

use ILibrary;
DELIMITER //
CREATE PROCEDURE GetBooksRating() 
BEGIN
	SELECT B.id,sum(star)/count(*) As "TotalRating"  FROM Books B 
	INNER JOIN Rating R ON B.id=R.bookid 
	GROUP BY B.id;
END //
DELIMITER ;

use ILibrary;
DELIMITER //
CREATE PROCEDURE AddBook(title varchar(255),
    keywords varchar(1000),
    topic varchar(255),
    content MEDIUMBLOB,
	userid int)
BEGIN
	INSERT INTO Books (title, keywords, topic,content,userid)
    VALUES(title,keywords,topic,content,userid);
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER after_books_insert
AFTER INSERT
ON Books
FOR EACH ROW
BEGIN
	DECLARE uname varchar(255);
    DECLARE txt varchar(255);
	Select GetUserName(NEW.userid) into uname;
    SELECT CONCAT("Thanks UserId:" , CAST(NEW.userid as char) , " for adding new book title ", NEW.title) into txt;
    INSERT INTO Messages(userid, msg)
    VALUES (NEW.userid, txt);
END; //
DELIMITER ;


