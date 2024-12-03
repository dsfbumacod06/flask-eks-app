from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify(message="Welcome to the Flask application!")

@app.route('/hello/<name>')
def hello(name):
    return jsonify(message=f"Hello, {name}. You are in the second version!")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)