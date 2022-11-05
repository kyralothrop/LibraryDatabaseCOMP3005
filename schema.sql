
--Author: Kyra Lothrop

BEGIN TRANSACTION;

drop table if exists cardholders;
drop table if exists books;
drop table if exists borrowed;
drop table if exists authors;
drop table if exists publishers;
drop table if exists bookcopies;

-- R2.3 Table Schema that Matches ER Diagram
create table cardholders (library_card_num integer PRIMARY KEY NOT NULL, cardholder_name text, username text, user_password text);
create table books (book_num integer PRIMARY KEY NOT NULL, title text, book_description text, year_released integer, author integer, publisher integer);
create table borrowed (library_card_num integer NOT NULL, book_num integer NOT NULL, book_copy_num integer NOT NULL, date_borrowed text, return_deadline text, PRIMARY KEY(library_card_num, book_num, book_copy_num));
create table authors (author_id integer PRIMARY KEY NOT NULL, author_name text);
create table publishers (publisher_id integer PRIMARY KEY NOT NULL, publisher_name text);
create table bookcopies (book_num integer NOT NULL, book_copy_num integer NOT NULL, location_status text, PRIMARY KEY(book_copy_num, book_num));

-- SAMPLE DATA
-- Cardholders
insert into cardholders (cardholder_name, username, user_password) values ('1', '1', '1');
insert into cardholders (cardholder_name, username, user_password) values ('Kyra Lothrop', 'klothrop', 'testing');
insert into cardholders (cardholder_name, username, user_password) values ('Barry Allan', 'ballan', 'speed');
insert into cardholders (cardholder_name, username, user_password) values ('Cara Danvers', 'cdanvers', 'monel');
insert into cardholders (cardholder_name, username, user_password) values ('Peter Parker', 'pparker', 'spider');
insert into cardholders (cardholder_name, username, user_password) values ('Tony Stark', 'tstark', 'pepper');
insert into cardholders (cardholder_name, username, user_password) values ('Mon El', 'monel', 'cara');
insert into cardholders (cardholder_name, username, user_password) values ('Lena Luthor', 'lluthor', 'cryptonite');
insert into cardholders (cardholder_name, username, user_password) values ('Alex Danvers', 'adanvers', 'deo');
insert into cardholders (cardholder_name, username, user_password) values ('Winn Schott', 'wschott', 'computers');

-- Books
insert into books (title, book_description, year_released, author, publisher) values ('Lorem Ipsum', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 2201, 1, 1);
insert into books (title, book_description, year_released, author, publisher) values ('Dolor Sit', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 2022, 2, 2);
insert into books (title, book_description, year_released, author, publisher) values ('Amet', 'A cras semper auctor neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Netus et malesuada fames ac turpis egestas integer.', 2023, 3, 3);
insert into books (title, book_description, year_released, author, publisher) values ('Consectetur', 'Netus et malesuada fames ac turpis egestas integer. Quis risus sed vulputate odio ut enim.', 2024, 4, 4);
-- Infromation provided from https://en.wikiquote.org/wiki/Harry_Potter_(series)
insert into books (title, book_description, year_released, author, publisher) values ("Harry Potter and the Philosopher's Stone", "Harry Potter and the Philosopher's Stone is the first book of the Harry Potter series, written by J.K. Rowling. It was first published in 1997. In America, it is known as Harry Potter and the Sorcerer's Stone. In this book, Harry discovers on his eleventh birthday that he is a wizard after many years living with his non magical relatives who don't accept him, before discovering friendship and adventure by attending Hogwarts School of Witchcraft and Wizardry.", 1997, 5, 5);
insert into books (title, book_description, year_released, author, publisher) values ("Harry Potter and the Chamber of Secrets", "Harry Potter and the Chamber of Secrets is the second book in the Harry Potter series, written by J.K. Rowling.", 1998, 5, 5);
insert into books (title, book_description, year_released, author, publisher) values ("Harry Potter and the Prisoner of Azkaban", "Harry Potter and the Prisoner of Azkaban is the third book in the Harry Potter series, written by J.K. Rowling.", 1999, 5, 5);
insert into books (title, book_description, year_released, author, publisher) values ("Harry Potter and the Goblet of Fire", "Harry Potter and the Goblet of Fire is the fourth book in the Harry Potter series, written by J.K. Rowling and first published in 2000. It follows Harry Potter, a wizard in his fourth year at Hogwarts School of Witchcraft and Wizardry, and the mystery surrounding the entry of Harry's name into the Triwizard Tournament, in which he is forced to compete.", 2000, 5, 5);
insert into books (title, book_description, year_released, author, publisher) values ("Harry Potter and the Order of the Phoenix", "Harry Potter and the Order of the Phoenix is the fifth book in the Harry Potter series, written by J.K. Rowling.", 2003, 5, 5);
insert into books (title, book_description, year_released, author, publisher) values ("Harry Potter and the Half-Blood Prince", "Harry Potter and the Half-Blood Prince is the sixth book in the Harry Potter series, written by J.K. Rowling.", 2005, 5, 5);
insert into books (title, book_description, year_released, author, publisher) values ("Harry Potter and the Deathly Hallowse", "Harry Potter and the Deathly Hallows (2007) by J. K. Rowling is the seventh and final book in the Harry Potter series.", 2007, 5, 5);
--
insert into books (title, book_description, year_released, author, publisher) values ('Adipiscing Elit', 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 2222, 1, 1);
insert into books (title, book_description, year_released, author, publisher) values ('Sed Do', 'Etiam sit amet nisl purus in mollis nunc sed id. Venenatis urna cursus eget nunc scelerisque.', 2223, 1, 1);
insert into books (title, book_description, year_released, author, publisher) values ('Eiusmod Tempor', 'Quis lectus nulla at volutpat diam ut venenatis tellus in. Quis blandit turpis cursus in. Facilisi nullam vehicula ipsum a arcu.', 2223, 2, 2);

-- Borrowed
insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (3, 1, 1, '2022-02-02', '2022-03-02');
insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (3, 2, 1, '2022-02-02', '2022-03-02');
insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (4, 5, 1, '2022-02-02', '2022-03-02');
insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (5, 5, 2, '2022-02-03', '2022-03-03');
insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (6, 5, 3, '2022-02-04', '2022-03-04');
insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (7, 5, 4, '2022-02-05', '2022-03-05');
insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (2, 2, 2, '2022-04-10', '2022-05-10');
insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (2, 4, 3, '2022-04-10', '2022-05-10');
insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (2, 5, 9, '2022-04-10', '2022-05-10');

-- Authors
insert into authors (author_name) values ('Sample Author 1');
insert into authors (author_name) values ('Sample Author 2');
insert into authors (author_name) values ('Sample Author 3');
insert into authors (author_name) values ('Sample Author 4');
insert into authors (author_name) values ('J. K. Rowling');

-- Publishers
insert into publishers (publisher_name) values ('Sample Publisher 1');
insert into publishers (publisher_name) values ('Sample Publisher 2');
insert into publishers (publisher_name) values ('Sample Publisher 3');
insert into publishers (publisher_name) values ('Sample Publisher 4');
insert into publishers (publisher_name) values ('Bloomsbury Publishing');

--- Book Copies
insert into bookcopies (book_num, book_copy_num, location_status) values (1, 1, 'BORROWED');
insert into bookcopies (book_num, book_copy_num, location_status) values (2, 1, 'BORROWED');
insert into bookcopies (book_num, book_copy_num, location_status) values (2, 2, 'BORROWED');
insert into bookcopies (book_num, book_copy_num, location_status) values (3, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (3, 2, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (3, 3, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (4, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (4, 2, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (4, 3, 'BORROWED');
insert into bookcopies (book_num, book_copy_num, location_status) values (4, 4, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 1, 'BORROWED');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 2, 'BORROWED');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 3, 'BORROWED');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 4, 'BORROWED');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 5, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 6, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 7, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 8, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 9, 'BORROWED');
insert into bookcopies (book_num, book_copy_num, location_status) values (5, 10, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (6, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (7, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (8, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (9, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (10, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (11, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (12, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (13, 1, 'SHELF');
insert into bookcopies (book_num, book_copy_num, location_status) values (14, 1, 'SHELF');

COMMIT;
