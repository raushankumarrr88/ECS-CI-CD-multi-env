from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/micros1/')
def hello():
    return "Hello, World! from route"

@app.route('/micros1/demo')
def demo():
    return "Hello, World! This is from demo endpoint"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
