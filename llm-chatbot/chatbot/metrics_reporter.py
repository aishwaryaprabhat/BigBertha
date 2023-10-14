from flask import Flask, Response
import redis

app = Flask(__name__)
r = redis.Redis(host='localhost', port=6379, db=0)

@app.route('/metrics')
def metrics():
    thumbs_down_count = int(r.get('thumbs_down_count') or 0)
    prometheus_data = f'thumbs_down_count {thumbs_down_count}\n'
    return Response(prometheus_data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)