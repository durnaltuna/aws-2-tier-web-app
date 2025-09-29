from flask import Flask, jsonify
import psycopg2 # or other database driver
import os

app = Flask(__name__)

# Assuming database credentials are in environment variables
db_host = os.environ.get('DB_HOST')
db_user = os.environ.get('DB_USER')
db_password = os.environ.get('DB_PASSWORD')
db_name = os.environ.get('DB_NAME')

@app.route('/')
def home():
    return "Hello, this is a basic web app!"

@app.route('/health')
def health_check():
    return jsonify({"status": "healthy"})

@app.route('/database_check')
def database_check():
    try:
        conn = psycopg2.connect(host=db_host, user=db_user, password=db_password, dbname=db_name)
        cur = conn.cursor()
        cur.execute("SELECT 1")
        cur.close()
        conn.close()
        return jsonify({"database_status": "connected"})
    except Exception as e:
        return jsonify({"database_status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)