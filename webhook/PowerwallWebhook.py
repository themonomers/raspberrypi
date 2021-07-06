import requests

from flask import Flask, request


# an object of WSGI application
app = Flask(__name__)   # Flask constructor
  

# A decorator used to tell the application
# which URL is associated function
@app.route('/powerwallwebhook', methods=['GET', 'POST'])
def index():
  if len(request.json['evalMatches']) > 0:
    value1 = round(request.json['evalMatches'][0]['value'], 1)
    requests.get('https://maker.ifttt.com/trigger/<event>/with/key/<key>?value1=' + str(value1))

  return 'success'
  

if __name__=='__main__':
   app.run(debug=True, host='<IP/hostname>')
