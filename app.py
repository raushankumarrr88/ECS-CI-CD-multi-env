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
    return "Hello, World!"

@app.route('/demo')
def demo():
    return "Hello, World! This is from demo endpoint"

@app.route('/metadata')
def metadata():
    ecs_metadata = get_ecs_metadata()
    return jsonify(ecs_metadata)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
