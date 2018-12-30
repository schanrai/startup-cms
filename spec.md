# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- I have installed the Sinatra gem and am using it to build my app.
- [x] Use ActiveRecord for storing information in a database
- All models are inheriting from ActiveRecord Base, migrations have been created and run.
- [x] Include more than one model class (e.g. User, Post, Category)
I am using two model classes - User and StartupProfile
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
The User model has many Startup Profiles, the User also has many mentorships
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
Startup Profile belongs_to User and Mentor
- [x] Include user accounts with unique login attribute (username or email)
Using Active Record validates methods within the model, checking for uniqueness of email
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
The startup profiles resource has full CRUD actions
- [x] Ensure that users can't modify content created by other users
Logic in place to prevent users editing startup profiles that they did not create. Also, mentor profiles are not editable by their user, unless that user is logged in.
- [x] Include user input validations
Checking params is not empty.
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
Flash errors and messages deployed at key points in the user journey.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
Yes, README.md contains all of the above
Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
