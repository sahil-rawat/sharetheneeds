import matplotlib.pyplot as plt
from firebase import firebase
import os
from flask import Flask, render_template

firebase = firebase.FirebaseApplication("https://hackathon-data-b8c3e.firebaseio.com/", None)
result = firebase.get('/hackathon-data-b8c3e/Volunteer', '')
users = firebase.get('/hackathon-data-b8c3e/Users', '')

item = []
state = []
for i in result:
	item.append(result[i]['Item'])
	state.append(result[i]['State'])

item1 = set(item)
state1 = set(state)

item2 = {}
state2 = {}
for j in item1:
	item2[j] = item.count(j)

for k in state1:
	state2[k] = state.count(k)


x = []
y = []
for key, values in item2.items():
	x.append(key)
	y.append(values)



p = []
q = []

for key, values in state2.items():
	p.append(key)
	q.append(values)



r = ['Volunteers', 'Users']
s = [len(result), len(users)]
print(s)
plt.subplot(2, 2, 1)
plt.bar(x, y, label='bar1', color='b')
plt.title('Number of items available')
plt.xlabel('Item Type')
plt.ylabel('Number of volunteers')
plt.savefig('Static/assets/images/r1.png',transparent=True,bbox_inches='tight',dpi=200)
plt.clf()

cols = ['c', 'm', 'r', 'b']
plt.subplot(2, 2, 2)
plt.pie(y, labels=x, colors=cols, startangle=90, shadow=True, autopct='%1.1f%%')
plt.savefig('Static/assets/images/r2.png',transparent=True,bbox_inches='tight',dpi=200)
plt.clf()

plt.subplot(2, 2, 3)
plt.bar(p, q, label='bar2', color='g')
plt.title('Number of volunteer in states')
plt.xlabel('States')
plt.ylabel('Number of volunteers')
plt.savefig('Static/assets/images/r3.png',transparent=True,bbox_inches='tight',dpi=200)
plt.clf()

plt.subplot(2, 2, 4)
plt.bar(r, s, label='bar3', color='g')
plt.title('Total no of volunteers and Users')
plt.xlabel('x')
plt.ylabel('Number')
plt.savefig('Static/assets/images/r4.png',transparent=True,bbox_inches='tight',dpi=200)
plt.clf()	

PEOPLE_FOLDER = os.path.join('static', 'assets/images')
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = PEOPLE_FOLDER
	
@app.route('/')
@app.route('/index')
def firstflask():

	full_filename1 = os.path.join(app.config['UPLOAD_FOLDER'], 'r1.png')
	full_filename2 = os.path.join(app.config['UPLOAD_FOLDER'], 'r2.png')
	full_filename3 = os.path.join(app.config['UPLOAD_FOLDER'], 'r3.png')
	full_filename4 = os.path.join(app.config['UPLOAD_FOLDER'], 'r4.png')

	return render_template("about.html", no_of_volu=s[0],no_of_user=s[1],user_image1 = full_filename1,user_image2 = full_filename2,user_image3 = full_filename3,user_image4 = full_filename4)

if __name__ == '__main__':
	app.run(debug=True)