import requests
from flask import Flask, jsonify

app = Flask(__name__)

# Fetch ECS metadata
def get_ecs_metadata():
    try:
        response = requests.get("http://169.254.170.2/v3/task")
        if response.status_code == 200:
            return response.json()
        else:
            return {"error": "Unable to fetch metadata"}
    except Exception as e:
        return {"error": str(e)}

@app.route('/')
def hello():
    return "Hello, World!  Welcome to the home page This is only for health check"

@app.route('/demo/raushan')
def demo():
    return "Hello, raushan! This is from demo endpoint"

@app.route('/demo/happy')
def demo():
    return "Hello, It worked"

@app.route('/demo/metadata')
def metadata():
    ecs_metadata = get_ecs_metadata()
    return jsonify(ecs_metadata)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
