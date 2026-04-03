from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def home():
    return """
    <h1>DevOps Portfolio — Stage 1</h1>
    <p>Flask app running on AWS EC2</p>
    <p>Built by: Pulunuwan Jayasekera</p>
    """

@app.route('/health')
def health():
    return{'status':'healthy'}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
