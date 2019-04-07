from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/test/route')
def hello():
    return jsonify({'message': 'hello'})
