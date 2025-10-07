import os
import psycopg2
from flask import Flask, jsonify

app = Flask(__name__)

db_host = os.getenv("DATABASE_HOST")
db_name = os.getenv("DATABASE_NAME")
db_user = os.getenv("DATABASE_USER")
db_password = os.getenv("DATABASE_PASSWORD")

def get_db_connection():
    try:
        conn = psycopg2.connect(
            host=db_host,
            database=db_name,
            user=db_user,
            password=db_password
        )
        return conn
    except Exception as e:
        print(f"Veritabanı bağlantı hatası: {e}")
        return None

@app.route("/", methods=['GET'])
def get_status():
    return jsonify({"status": "ok", "message": "Poll-API is running!"})

@app.route("/db-check", methods=['GET'])
def db_check():
    conn = get_db_connection()
    if conn is None:
        return jsonify({"status": "error", "message": "Database connection failed"}), 500
    
    try:
        cur = conn.cursor()
        cur.execute('SELECT version()')
        db_version = cur.fetchone()
        cur.close()
        conn.close()
        return jsonify({"status": "ok", "message": "Database connection successful", "db_version": db_version})
    except Exception as e:
        return jsonify({"status": "error", "message": f"Database query failed: {e}"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)