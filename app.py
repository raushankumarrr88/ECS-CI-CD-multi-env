from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, World!"

@app.route('/demo')
def hello():
    return "Hello, World! This is from demo endpoint"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
