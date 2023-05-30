from flask import Flask, jsonify
import random

app = Flask(__name__)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
    return jsonify(status=random.choice(['ok', 'fail']))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)