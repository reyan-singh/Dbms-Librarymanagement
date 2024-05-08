USE ILibrary;
SELECT title, keywords, topic FROM Books WHERE title like '%cry%' || keywords like '%cry%' ;
SELECT * FROM Books;
SELECT * FROM Rating order by bookid;
SELECT * FROM Users;

SELECT sum(star)/count(*) As "TOTAL" FROM Rating WHERE userid=1 && bookid=1 ;
CALL GetUsersRating();

USE ILibrary;
CALL GetSearchedBooks('python');

SELECT * FROM Books B WHERE B.keywords  REGEXP 'dsa|ml'
    