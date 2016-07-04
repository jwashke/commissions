# Commissionrablio

[Heroku](https://trelora-commissions.herokuapp.com/)

## Description

![screenshot](https://s3-us-west-2.amazonaws.com/project-screenshots/commissions_screenshot.jpg)

Commissionrablio allows users who have signed a home buyer agreement with Trelora to view MLS data on commission fees for homes available for sale in the Denver area.

Data is pulled in from a CSV and homes are displayed as pins on a google map of Denver. Users can filter homes by certain attributes or search for homes. Clicking a link in a homes info window takes the user to a show page with more information about the home.

## Setup

#### Run the project locally

clone down the project
```
git clone git@github.com:jwashke/commissions.git
```

cd into the project directory
```
cd commissions
```

Setup the database
```
rake db:create db:migrate
```

Setup environment variables
figaro install will create config/application.yml to store the environment variables in

```
figaro install
```
You'll need a gmail account to send user verification emails,
and a google maps API key.

config/application.yml:
```
GMAIL_USERNAME: YOUR GMAIL USERNAME
GMAIL_PASSWORD: YOUR GMAIL PASSWORD
GOOGLE_API_KEY: YOUR GOOGLE MAPS API KEY
```

Start the server by running
```
rails s
```

#### Run the tests

cd into the main project directory
```
cd commissions
```

run rspec

```
rspec
```


## Seeding the Database

To add the homes data to the database you'll need a CSV file provided by the MLS

With that file you have two options for adding the file to the project.

##### As an Admin user

To upload the file as an admin user locally, you will need to start a redis server and sidekiq along with the rails server.

To start Redis, run the below command from the main project directory.
```
redis-server
```

To start Sidekiq, run the below command the main project directory.
```
Sidekiq
```

As an admin user you will see a option in the navbar to upload a CSV file. Click that link, select the CSV file in the file input and click submit.

![CSVupload](https://s3-us-west-2.amazonaws.com/project-screenshots/csvupload.gif)

##### Through a Rake Task


You can also upload the file through a rake task. Name the file 'Full Export.csv' if it isn't already. Put that file in db/data folder in the project. Then run

```
rake import_csv:listings
```

## Contributors

This project was made by [Josh Washke](https://github.com/jwashke) and [Drew Thompson](https://github.com/drew-t)
