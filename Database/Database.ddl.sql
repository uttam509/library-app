create database iitilrc;
use iitilrc;
-- drop database iitilrc;
set sql_safe_update = 0;

/*
Entities
1. Account
2. Users
3. Librarian
4. Reviews
5. Books
6. Author
7. Shelf
8. Book-Copies
9. Hold-Requests
10. Rating
11. Friend-Requests
*/

-- Entities
create table account(
accountID int,
password varchar(200),
accountType varchar(20),
primary key(accountID)
);
-- drop table account;

create table user(
userID int,
name varchar(50),
email varchar(70),
address varchar(500),
unpaidFines int,
primary key(userID),
foreign key(userID) references account(accountID)
);
-- drop table user;

create table librarian(
librarianID int,
name varchar(50),
address varchar(500),
email varchar(70),
primary key(librarianID),
foreign key(librarianID) references account(accountID) on delete cascade
);
-- drop table librarian;

create table book(
ISBN varchar(15),
title varchar(100),
yearOfPublication int,
totalCopies int,
noOfCopiesOnShelf int,
primary key(ISBN)
);
-- drop table book;

create table review(
reviewID int,
reviewText varchar(500),
userID int,
ISBN varchar(15),
primary key(reviewID),
foreign key(userID) references user(userID) on delete cascade,
foreign key(ISBN) references book(ISBN) on delete cascade
);
-- drop table review;

create table author(
authorID int,
name varchar(50),
primary key(authorID)
);
-- drop table author;

create table shelf(
shelfID int,
capacity int,
primary key(shelfID)
);
-- drop table shelf;

create table bookCopies(
ISBN varchar(15),
copyID int,
bookStatus varchar(20),
dueDate date,
shelfID int,
primary key(ISBN, copyID),
foreign key(ISBN) references book(ISBN),
foreign key(shelfID) references shelf(shelfID)
);
-- drop table bookCopies

create table holdRequest(
ISBN varchar(15),
userID int,
holdTime datetime,
primary key(ISBN, userID),
foreign key(ISBN) references book(ISBN) on delete cascade,
foreign key(userID) references user(userID) on delete cascade
);
-- drop table holdRequest

create table rating(
ratingID int,
ISBN varchar(15),
userID int,
rating int,
primary key(ratingID),
foreign key(ISBN) references book(ISBN) on delete cascade,
foreign key(userID) references user(userID) on delete set null
);
-- drop table rating

create table friendRequest(
requesterID int,
requestedID int,
primary key(requesterID, requestedID),
foreign key(reuesterID) references user(userID) on delete cascade,
foreign key(requestedID) references user(userID) on delete cascade
);
-- drop table friendRequest

/*
Relationships
1. Friend-User relation
2. User-BookCopies   
3. Reading-List relation 
4. Book-Author relation
*/

-- Relations
create table friendUser(
userID int,
friendID int,
primary key(userID, friendID),
foreign key(userID) references user(userID) on delete cascade,
foreign key(userID) references user(userID) on delete cascade
);
-- drop table friendUser

create table bookCopiesUser(
ISBN varchar(15),
copyID int,
userID int,
action varchar(20),
primary key(ISBN, copyID, userID),
foreign key(ISBN) references bookCopies(ISBN),
foreign key(copyID) references bookCopies(copyID),
foreign key(userID) references user(userID)
);
-- drop table bookCopiesUser

create table readingList(
ISBN varchar(15),
userID int,
status varchar(20),
primary key(ISBN, userID),
foreign key(ISBN) references book(ISBN) on delete cascade,
foreign key(userID) references user(userID) on delete cascade
);
-- drop table readingList

create table authorBook(
ISBN varchar(15),
authorID int,
primary key(ISBN, authorID),
foreign key(ISBN) references book(ISBN) on delete cascade,
foreign key(authorID) references author(authorID) on delete cascade
);
-- drop table authorBook

