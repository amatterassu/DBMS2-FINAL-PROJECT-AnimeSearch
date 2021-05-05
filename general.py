import cx_Oracle
import config
from flask import Flask, render_template, url_for, request, redirect
cx_Oracle.init_oracle_client(lib_dir=r"C:\instantclient_19_10")

connection=cx_Oracle.connect(config.username, config.password, config.dsn, encoding=config.encoding)

#cursor=connection.cursor()
#cursor.execute('select')
#anime=cursor.fetchall()
#print(anime)

app=Flask(__name__)

@app.route('/')
def index():
    cursor=connection.cursor()
    cursor.execute(f"select * from table(fun_home)")
    animes=cursor.fetchall()
    return render_template('layout.html', animes=animes)

@app.route('/genres')
def categories():
    cursor=connection.cursor()
    cursor.execute("select title , img_url, aired ,genre, episodes,score from anime4 where genre like '%Action%' ")
    animes=cursor.fetchall()
    return render_template('genres.html', animes=animes)

@app.route('/genres/<string:genre>')
def action(genre):
    cursor=connection.cursor()
    cursor.execute(f"select * from table(fun_genre(\'{genre}\'))")
    animes=cursor.fetchall()
    return render_template('action.html', animes=animes)

@app.route('/search', methods = ['GET', 'POST'])
def search():
    cursor=connection.cursor()
    animes=[]
    if request.method == 'POST':
        cursor.execute(f'select * from table(search(\'{request.form["search"]}\'))')
        animes=cursor.fetchall()
        return render_template('search.html', animes=animes)
    return render_template('search.html')

@app.route('/statistics/pie')
def page():
    cursor=connection.cursor()
    cursor.execute(f"select * from table(pie_chart)")
    animes=cursor.fetchall()
    labels = [row[0] for row in animes]
    values = [row[1] for row in animes]
    return render_template('stats.html', animes=animes, labels=labels, values=values)

@app.route('/statistics/line')
def page2():
    cursor=connection.cursor()
    cursor.execute(f"select * from table(line_chart)")
    animes=cursor.fetchall()
    labels = [row[0] for row in animes]
    values = [row[1] for row in animes]
    return render_template('staats.html', animes=animes, labels=labels, values=values)

@app.route('/edits')
def page3():
    cursor=connection.cursor()
    cursor.execute("select title , img_url, aired ,genre, episodes,score from anime4 where genre like '%Action%' ")
    animes=cursor.fetchall()
    return render_template('edit.html', animes=animes)

@app.route('/insert', methods=['POST', 'GET'])
def insert():
    #paket.add_anime(10,'Amaterasu','Hello gues Im so hot','Action','15-fdu-2021',1,5000,12000,16,9,'https://cdn.myanimelist.net/images/anime/3/83528.jpg','www.google.com'); 
    if request.method == 'POST':
        cursor = connection.cursor()
        cursor.execute('begin paket.add_anime(:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12); end;', [
            request.form['id'],
            request.form['title'],
            request.form['description'],
            request.form['genre'],
            request.form['aired'],
            request.form['episodes'],
            request.form['viewers'],
            request.form['popularity'],
            request.form['rank'],
            request.form['score'],
            request.form['poster'],
            request.form['page']
        ])
        connection.commit()

        return redirect('/insert')
    else:
        return render_template('insert.html')


@app.route('/update', methods=['GET', 'POST'])
@app.route('/update', methods=['GET'])
def update():
    if request.method == "POST":
        cursor = connection.cursor()
        cursor.execute('begin paket.upd_anime(:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12); end;', [
            request.form['title'],
            request.form['description'],
            request.form['genre'],
            request.form['aired'],
            request.form['episodes'],
            request.form['viewers'],
            request.form['popularity'],
            request.form['rank'],
            request.form['score'],
            request.form['poster'],
            request.form['page'],
            request.form['id']
        ])
        connection.commit()

        return redirect('/insert')
    else:
        id = request.args.get('id')

        cursor = connection.cursor()
        cursor.execute(f"select * from anime4 where id = {id}")
        anime = cursor.fetchone()

        return render_template('update.html', anime=anime)


@app.route('/delete', methods=['GET', 'POST'])
def delete():
    #paket.del_anime(10);
    if request.method == "POST":
        cursor = connection.cursor()
        cursor.execute("begin paket.del_anime(:1); end;", [request.form['id']])
        connection.commit()

        return redirect('/delete')
    else:
        return render_template('delete.html')


if __name__ == "__main__":
    app.run(debug=True)