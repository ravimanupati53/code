# Weather Report
------------

## Description:

This is the weather application that displays weather information based on the location.
          
### Front End:

The user enters the city name in the text box. An API call is made from open weather map API (https://openweathermap.org). 

To fetch the required information we need to signup and get the appid key associated with your account. Copy the appid key in app.py file to get the weather report.

* weather.html is used to plot the data fetched from the API.
* It displays the City name, weather report and the description of the weather.

### Back End:

Flask framework is used to build the backend of the application. It uses the OpenWeatherAPI to fetch the weather data.

### Cloud:

Used Google Cloud Platform to deploy the application on VM instance.


### Prerequisites:

To deploy the application in Google Cloud Platform we need to have some packages installed in the instance. Here are the list of packages we need to install.

* **Python:** We need to make sure that the Python development, including developing Python applications that run on Google Cloud Platform (GCP).

* **pip:** pip is a package management system used to install and manage software packages written in Python.

* **Flask:** Flask is a lightweight WSGI web application framework.

* **Flask-SQLAlchemy:** Flask-SQLAlchemy is an extension for Flask that adds support for SQLAlchemy to your application.

* **Requests:** Requests is the only Non-GMO HTTP library for Python.

* **Sqlite3:** sqlite3 drivers for the 'db' library.


### MicroServices:

***app.py:*** This microservice extracts the data from the API call and displays the output the html file. It imports Flask, Flask_sqlalchemy, Request, Templates to call the API and displays the weather. It saves the city in the database in the form of table.

***API:*** The API calls the value from the URL and reports the weather. `url = 'http://api.openweathermap.org/data/2.5/weather?q={}&units=imperial&appid=de4a7c15191093d3c8c228237f5ea93a'` where appid key is generated key when you signup for OpenWheatherMap.


***DataBase:*** 

Sqlite3 is used as the database.

* It uses the weather.db file where the cities are saved in the table.
* The value returns to the app.py file.

          app = Flask(__name__)
          app.config['DEBUG'] = True
          app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///weather.db'



### Execution:

To deploy the application in Google Cloud Platform follow the below steps.

* Clone the GIT repository to the instance and direct to the directory.
* Install all the Prerequisites needed for the application.
* To run the application you can either use the `flask` command by exporting the FLASK_APP environment variable.

                    export FLASK_APP=app.py
                    flask run
          * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
          127.0.0.1 - - [17/Sep/2018 01:51:12] "GET /?authuser=4 HTTP/1.1" 200 -
 

* The application is running on http://127.0.0.1:5000/

![alt text](https://github.com/ravimanupati53/code-challenge/blob/master/weather/images/flask.png)

* CLick on the URL or copy the URL specified in the shell and direct to the web browser.

![alt text](https://github.com/ravimanupati53/code-challenge/blob/master/weather/images/output.png)

* Enter the name of the city and click on `Add City`.

![alt text](https://github.com/ravimanupati53/code-challenge/blob/master/weather/images/city.png)

* You can add any number of cities and it will automatically stored in the database.

![alt text](https://github.com/ravimanupati53/code-challenge/blob/master/weather/images/cities.png)

* You can access the Database by executing the `sudo sqlite3` command. You can find the list of tables by running `.tables` command and execute the `.open FILENAME` command to access the database.

![alt text](https://github.com/ravimanupati53/code-challenge/blob/master/weather/images/database.png)
