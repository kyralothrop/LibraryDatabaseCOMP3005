COMP 3005 winter 2022 README for Library Database Term Project Assignment, Version 1.0, 2022-04-10

Program can be reached at:
Web site: https://github.com/kyralothrop

Accessing the sqlite3 Database (R2.1):
-----------------
In the current directory(same as readme.txt) filename 'database.db'
Direct to : KyraLothropCOMP3005TermProject/Final Project/database.db

YouTube video demonstration (R3.1, R3.2, R3.3, R3.4, R3.5, R3.6):
-----------------
https://youtu.be/TZJIJNaKZEc

Description:
-----------------
 - This applications allows users to search, borrow, and return books.
 - The database is wrapped in a user interface web app using sqlite3, Flask and Python (R2.2)
 - The project is composed of the following files:
    \templates
        book.html           webpage for a specific book
        index.html          main page with the list of books
        login.html          login page for users
        myBooks.html        list of books the current user owns
        ownedBook.html      page for a rented book by the current user
    app.py
    database.db
    init_db.py
    schema.sql

Installation:
-----------------
Python 3.9.1 or later must be installed
Flask 2.1.0 or later must be installed

Usage:
-----------------
set FLASK_APP=app
set FLASK_ENV=development
In the current directory run 'flask run' on the command prompt
Search http://127.0.0.1:5000/login in a browser

Credits:
-----------------
 - Authors:
	Kyra Lothrop