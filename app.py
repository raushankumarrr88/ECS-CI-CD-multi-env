from flask import Flask, jsonify

@app.route('/micros1/')
def hello():
    return "Hello, World! from route"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
