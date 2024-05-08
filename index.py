from flask import Flask, jsonify, request , render_template,  redirect, url_for
from flask_mysqldb import MySQL
from geminiapi import *

app = Flask(__name__,static_folder='static',template_folder='templates')

# Required
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "ILibrary"
# Extra configs, optional:
mysql = MySQL(app)

@app.route("/")
def home():
    print("home page")
    return render_template('index.html', prj='Project')

@app.route("/AISupport")
def getGemini():
    return render_template('geminiPage.html')

@app.route('/getGemini/<string:request>', methods=['GET'])
def get_gemini_help(request):
    print("gemini")
    return getGeminiSearch(request);

@app.route("/uploadbook")
def uploadbook():
    return render_template('uploadbook.html')

@app.route("/lendbook")
def lendbook():
    return render_template('lendbook.html')

@app.route("/userlist")
def userlist():
    return render_template('userList.html')


@app.route('/data', methods=['GET'])
def get_data():
    cur = mysql.connection.cursor()
    cur.callproc('GetALLBooks')
    #cur.execute("""SELECT title,keywords,topic FROM Books""")
    data = cur.fetchall()
    cur.close()
    return jsonify(data)

@app.route('/usersranking', methods=['GET'])
def get_usersranking():
    cur = mysql.connection.cursor()
    cur.callproc('GetUsersRating')
    data = cur.fetchall()
    cur.close()
    return jsonify(data)


@app.route('/data/<int:id>', methods=['GET'])
def get_data_by_id(id):
    cur = mysql.connection.cursor()
    cur.execute('''SELECT title, keywords, topic FROM Books WHERE id = %s''', (id,))
    data = cur.fetchall()
    cur.close()
    return jsonify(data)

@app.route('/books/<string:val>', methods=['GET'])
def get_data_by_title(val):
    cur = mysql.connection.cursor()
    val=val.replace(" ","|")
    cur.callproc('GetSearchedBooks', [val])
    #mtitle='%' + title + '%'
    #cur.execute('''SELECT title, keywords, topic FROM Books WHERE title like %s || keywords like %s''', (mtitle,mtitle,))
    # cur.execute('''SELECT title, keywords, topic FROM Books WHERE title like %s''', (mtitle,))
    # cur.execute("SELECT title, keywords, topic FROM Books WHERE title LIKE :search", {"search": '%' + title + '%'})
    data = cur.fetchall()
    cur.close()
    return jsonify(data)


@app.route('/addBook', methods=['POST'])
def add_book():
    print("uploading")
    cur = mysql.connection.cursor()
    result = request.form
    print(len(result))
    # for fieldname, value in result.items():
    #  print(fieldname + ": " +value)

    title = request.form.get('title')
    keywords = request.form.get('keywords')
    topic = request.form.get('topic')
    content = request.form.get('content')
    userid = int(request.form.get('userid'))
    print([title, keywords, topic, content, userid])
    cur.callproc('AddBook', [title, keywords, topic, content, userid])
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Data added successfully'})

@app.route('/setRating', methods=['POST'])
def set_rating():
    print("setting rate")
    cur = mysql.connection.cursor()
    print(request.form);

    bookid = request.form.get('bookid')
    rating = request.form.get('rating')

    cur.callproc('SetRating', [bookid, rating])
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Data added successfully'})

@app.route('/data/<int:id>', methods=['PUT'])
def update_data(id):
    cur = mysql.connection.cursor()
    name = request.form['name']
    age = request.form['age']
    cur.execute('''UPDATE Books SET title = %s WHERE id = %s''', (name, id))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Data updated successfully'})

@app.route('/data/<int:id>', methods=['DELETE'])
def delete_data(id):
    cur = mysql.connection.cursor()
    cur.execute('''DELETE FROM Books WHERE id = %s''', (id,))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Data deleted successfully'})

if __name__ == "__main__":
    app.run(debug=True)