-- Review a book
-- procedure definition
delimiter //
create procedure reviewBook(
    in userID int,
    in ISBN varchar(15),
    in reviewText varchar(500)
)
begin
insert into review(reviewText, userID, ISBN) values(reviewText, userID, ISBN);
end //
delimiter ;

-- call procedure
call reviewBook(4, '123', 'lorem10');

-- drop procedure reviewBook;