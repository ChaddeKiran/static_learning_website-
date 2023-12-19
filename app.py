from flask import Flask, render_template

app = Flask(__name__, static_url_path='/static')
#app = Flask(__name__, static_url_path='F:\flask\terraform-flask-app\static')
#app = Flask(__name__)

@app.route("/")
def hello():
    #return "Hello, Terraform!"
    #this is to check github actions.
    return render_template("home.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
