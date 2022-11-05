import sqlite3
from flask import Flask, render_template, request, url_for, flash, redirect, session
from werkzeug.exceptions import abort
from datetime import date
from dateutil.relativedelta import relativedelta

def get_db_connection():
    conn = sqlite3.connect('database.db')
    conn.row_factory = sqlite3.Row
    return conn

def get_book(book_num):
    conn = get_db_connection()
    book = conn.execute("select * from books where book_num = " + str(book_num) + ";").fetchone()
    conn.close()
    if book is None:
        abort(404)
    return book

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your secret key'

@app.route('/')
def index():
    conn = get_db_connection()

    #R3.6 A query that involves a secondairy refinement, or query based on the results of the first query
    books = conn.execute("select * from books").fetchall()
    conn.close()
    library_card_num = request.args['library_card_num'] 
    library_card_num = session['library_card_num'] 
    return render_template('index.html', books=books, library_card_num = library_card_num)

@app.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        library_card_num = request.form['library_card_num']
        username = request.form['username']
        password = request.form['password']

        if not library_card_num or not username or not password:
            flash('Please Complete All The Fields')
        else:
            conn = get_db_connection()
            verified_user = conn.execute("select * from cardholders where library_card_num =" + library_card_num + " and username ='" + username + "' and user_password = '" + password + "';").fetchone()
            conn.close()
            if verified_user != None:
                session['library_card_num'] = library_card_num
                return redirect(url_for('index', library_card_num = library_card_num))
            else:
                flash('Incorrect Credentials')

    return render_template('login.html')

@app.route('/myBooks')
def myBooks():
    library_card_num = request.args['library_card_num'] 
    library_card_num = session['library_card_num']

    conn = get_db_connection()
    books = conn.execute("select * from books natural join (select book_num from borrowed where library_card_num = " + library_card_num + ");").fetchall()
    conn.close()

    return render_template('myBooks.html', library_card_num = library_card_num, books = books)

@app.route('/OwnedBook<int:book_num>', methods=('GET', 'POST'))
def ownedBook(book_num):
    book = get_book(book_num)
    
    library_card_num = request.args['library_card_num'] 
    library_card_num = session['library_card_num'] 

    conn = get_db_connection()

    author_id = conn.execute("select author from books where book_num =" + str(book_num) + ";").fetchone()
    author_id = author_id['author']
    author = conn.execute("select * from authors where author_id =" + str(author_id) + ";").fetchone()

    publisher_id = conn.execute("select publisher from books where book_num =" + str(book_num) + ";").fetchone()
    publisher_id = publisher_id['publisher']
    publisher = conn.execute("select * from publishers where publisher_id =" + str(author_id) + ";").fetchone()

    return_information = conn.execute("select date_borrowed, return_deadline from borrowed where library_card_num = " + library_card_num + " and book_num = " + str(book_num) + ";").fetchone()
    conn.close()

    if request.method == 'POST':
        conn = get_db_connection()

        # R3.5 A query that involves an N:N relationship
        borrowed_info = conn.execute("select * from borrowed where library_card_num = " + library_card_num + "  and book_num = " + str(book_num) + " LIMIT 1;").fetchone()
        book_copy_num = borrowed_info['book_copy_num']

        conn.execute("delete from borrowed where library_card_num = " + library_card_num + " and book_num = " + str(book_num) + ";")
        conn.commit()

        conn.execute("update bookcopies set location_status = 'SHELF' where book_num = " + str(book_num) + " and book_copy_num = " + str(book_copy_num) + ";")
        conn.commit()

        books = conn.execute('select * from books natural join (select book_num from borrowed where library_card_num = ' + library_card_num + ');').fetchall()
        conn.close()

        return redirect(url_for('myBooks', library_card_num = library_card_num, books = books))

    return render_template('ownedBook.html', book = book, library_card_num = library_card_num, author = author, publisher = publisher, return_information = return_information)

@app.route('/<int:book_num>', methods=('GET', 'POST'))
def book(book_num):
    book = get_book(book_num)
    
    library_card_num = request.args['library_card_num'] 
    library_card_num = session['library_card_num'] 

    if request.method == 'POST':
        conn = get_db_connection()

        book_copy = conn.execute("select * from bookcopies where book_num = " + str(book_num) + " and location_status = 'SHELF' LIMIT 1;").fetchone()
        book_copy_num = book_copy['book_copy_num']

        conn.execute("update bookcopies set location_status = 'BORROWED' where book_num = " + str(book_num) + " and book_copy_num = " + str(book_copy_num) + ";")
        conn.commit()

        today = date.today()
        return_deadline = today + relativedelta(months = 1)

        conn.execute("insert into borrowed (library_card_num, book_num, book_copy_num, date_borrowed, return_deadline) values (" + library_card_num + ", " + str(book_num) + ", " + str(book_copy_num) + ", '" + str(today) +"' , '" + str(return_deadline) + "');")
        conn.commit()
        conn.close()

    conn = get_db_connection()

    author_id = conn.execute("select author from books where book_num =" + str(book_num) + ";").fetchone()
    author_id = author_id['author']
    author = conn.execute("select * from authors where author_id =" + str(author_id) + ";").fetchone()

    publisher_id = conn.execute("select publisher from books where book_num =" + str(book_num) + ";").fetchone()
    publisher_id = publisher_id['publisher']
    publisher = conn.execute("select * from publishers where publisher_id =" + str(author_id) + ";").fetchone()

    already_borrowed = conn.execute("select * FROM borrowed where library_card_num = " + library_card_num + " and book_num = " + str(book_num) + ";").fetchone()

    copies_left = conn.execute("select * from bookcopies where book_num =" + str(book_num) + " and location_status = 'SHELF';").fetchall()

    #R3.6 A query that involves a secondairy refinement, or query based on the results of the first query
    bookcopies = conn.execute("select * from bookcopies where book_num =" + str(book_num) + ";").fetchall()

    conn.close()

    if already_borrowed is None and copies_left:
        return render_template('book.html', book=book, library_card_num=library_card_num, bookcopies = bookcopies, author = author, publisher = publisher, can_borrow = 1)
    else:
        return render_template('book.html', book=book, library_card_num=library_card_num, bookcopies = bookcopies, author = author, publisher = publisher)
    
