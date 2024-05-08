USE ILibrary;
SELECT title, keywords, topic FROM Books WHERE title like '%cry%' || keywords like '%cry%' ;
SELECT * FROM Books;
SELECT * FROM Messages;
SELECT * FROM Rating order by bookid;
SELECT * FROM Users;

;
SELECT sum(star)/count(*) As "TOTAL" FROM Rating WHERE userid=1 && bookid=1 ;
CALL GetALLBooks();
CALL GetUserName(9);

USE ILibrary;
CALL GetSearchedBooks('python');
CALL AddBook('c PRO','microsoft c open', 'c for begginers',null,1);

SELECT * FROM Books B WHERE B.keywords  REGEXP 'dsa|ml';

INSERT INTO Books (title, keywords, topic,userid)
VALUES ('x.NEt PRO','microsoft .net web open', '.net for begginers',1)
    