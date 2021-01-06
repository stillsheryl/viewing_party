# Viewing Party

This is a three-person group project as part of Turing School of Software and Design's Back-End Engineering program, Module 3.  We utilized our knowledge in Ruby on Rails, ActiveRecord and PostgreSQL to build a website for creating movie watch parties created by users, for users.  We introduced our new knowledge of consuming APIs to pull movie data from TheMovieDB's API.

#### [Visit Deployed Application](https://viewing-party-13.herokuapp.com/)
    (Note: it may load slowly)

## Table of Contents

  - [Introduction](#introduction)
  - [Functional Overview](#functional-overview)
  - [Setup](#setup)
  - [Runing the tests](#running-the-tests)
  - [Deployment](#deployment)
  - [Authors](#authors)

## Introduction
  * [Project Requirements](https://backend.turing.io/module3/projects/viewing_party/index)
  * [Original Project Repo](https://github.com/turingschool-examples/viewing_party)

## Functional Overview

In this website, a visitor can register as a user to begin.  Once an account is created, that user is brought to their dashboard where they can see a bar to search for friends and and a space to see what parties they are a part of.  Clicking on the `discover` button, they get an option to either search movies by title or to discover the forty top-rated movies, according to the API.  Clicking on a movie title in the results displays that movie's information, and the user can choose to create a viewing party.  On this form, they can extend the viewing party duration to be longer than the movie runtime, select a date and time for the party, as well as friends to invite.  The details of this created party then show up on both the host user's and invited users' pages, with respective labels showing their role in the party.

### Database Structure

<img src="https://i.postimg.cc/d324DsL9/Viewing-Party-DB-Schema.png" alt="viewing_party_schema">

This project introduced us to the concept of a self-referential relationship.  We utilized this relationship to embody a 'follower' style of friendship between users.  When User 1 searches for and adds User 2 to their friends list, User 2 does not show User 1 in his or her friends list, but User 2 does show any viewing party listed on their dashboard that User 1 has invited him or her to.

There is a many-to-many relationship set up between Users and Parties through the Guests table.  The host of the party is determined by including their ID in the parties table when they create the viewing party.  This allows for a user to both attend and host multiple parties.

To save space in our database, we rely on API calls to provide movie data and store that information to the database when that movie's information is viewed.  This keeps us from initializing our database with thousands of movies' details from the get-go.

## Setup

### Prerequisites

These setup instructions are for Mac OS.

This project requires the use of `Ruby 2.5.3` and `Rails 5.2.4.3`.
We also use `PostgreSQL` as our database.

### Local Setup

To setup locally, follow these instructions:
  * __Fork & Clone Repo__
    * Fork this repo to your own GitHub account.
    * Create a new directory locally or `cd` into whichever directory you wish to clone down to.
    * Enter `git clone git@github.com:<<YOUR GITHUB USERNAME>>/viewing_party.git`
  * __Install Gems__
    * Run `bundle install` to install all gems in the Gemfile
  * __Set Up Local Database and Migrations__
    * Run `rails db:create`
    * Run `rake db:migrate`

## Running the tests

Run the command `bundle exec rspec` in the terminal.  You should see all passing tests.

## Deployment

The current live deployment of this project can be found [here](https://viewing-party-13.herokuapp.com/).

To run this site locally on your device, enter `rails server` in the terminal to start up a local server, then visit `http://localhost:3000/` in your browser.

## Contributors

  - **Roberto Basulto** - *Turing Student* - [Github Profile](https://github.com/Eternal-Flame085) - [Turing Alum Profile] - [LinkedIn](https://www.linkedin.com/in/roberto-basulto-9051941b9/)
  - **Sheryl Stillman** - *Turing Student* - [Github Profile](https://github.com/stillsheryl) - [Turing Alum Profile](https://alumni.turing.io/alumni/sheryl-stillman) - [LinkedIn](https://www.linkedin.com/in/sherylstillman1/)
  - **Zach Stearns** - *Turing Student* - [Github Profile](https://github.com/Stearnzy) - [Turing Alum Profile](https://alumni.turing.io/alumni/zach-stearns) - [LinkedIn](https://www.linkedin.com/in/zach-stearns/)

