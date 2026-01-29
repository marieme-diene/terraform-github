from flask import Flask, request, render_template
import requests
import os

try:
    from dotenv import load_dotenv
    load_dotenv()  # Charge les variables du fichier .env
except ImportError:
    pass  # python-dotenv non installé : utilisez les variables d'environnement système

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("form.html")

@app.route("/trigger", methods=["POST"])
def trigger_pipeline():
    github_token = os.getenv("GITHUB_TOKEN")  # Token depuis variable d'environnement
    owner = "marieme-diene"
    repo = "terraform-github"
    workflow_file = "terraform.yml"
    
    url = f"https://api.github.com/repos/{owner}/{repo}/actions/workflows/{workflow_file}/dispatches"
    
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {github_token}",
        "X-GitHub-Api-Version": "2022-11-28"
    }
    
    data = {
        "ref": "main",
        "inputs": {
            "instance_name": request.form["instance_name"],
            "instance_os": request.form["instance_os"],
            "instance_size": request.form["instance_size"],
            "instance_env": request.form["instance_env"]
        }
    }
    
    response = requests.post(url, json=data, headers=headers)

    # GitHub renvoie 204 (No Content) quand le workflow est déclenché avec succès
    if response.status_code == 204:
        return "reponse : 201 ", 201
    else:
        return f"❌ Erreur: {response.status_code}<br>{response.text}", response.status_code

if __name__ == "__main__":
    app.run(debug=True)
