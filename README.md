# Sinatra Startup Database & CMS

## Overview

This is a simple Ruby app built with Sinatra that give users a database/directory platform in which to list their startup and find support from mentors who are also listed within the database. I organize events for Product Hunt in South Florida, and we needed a way to keep track of users wishing to list their startup and users wishing to mentor the various startups that pitch at our events.

User have the ability to:
- Create one or more directory entries for startups they are involved with (known as 'startup profiles')
- Create mentor profiles for themselves. Only one mentor profile per user account can be created.
- Appoint themselves as mentors to startups that are currently 'un-mentored'. Startups can be assigned to only one mentor at a time.
- Edit or delete their own mentor profile.
- Edit or delete startup profiles they have created as needed.
- Browse all the mentor and startup profiles within the directory when logged in.

 Future improvements planned:
 - Approval workflow for startup to review and consent to mentor's requests. The workflow would includes a notification/communication  component  to notify the  ‘startup user’ of ‘mentor user’ requests, and convey approval or rejection notifications back to the mentor.
 - Aggregate and display user's contributions
 - Better design

Video walkthough on Youtube: https://www.youtube.com/watch?v=PTRAOBUQE5Q

## Contributing

You can make a request or report a bug by creating an issue. Or write your own code an submit a pull request:

1. Fork and clone the repository, following the steps below.
2. Create a branch named after the feature or bug. For example: `git checkout -b feature/new-feature` or `git checkout -b bug/bug-fix`.
3. Write your code and commit changes with an understandable commit message.
4. Push to the branch with `git push origin feature/new-feature`.
5. Create a pull request: Explain the reason for the change, why the code was written the way it was, etc.

## Set up

### Prerequisites

- Ruby
- SQLite3

### Installation

1. Fork the repository and clone it.
2. Run `bundle install` to install gems (If you don't have bundler, first run `gem install bundler`)
3. Set up the database with `rake db:migrate`.
4. Run `shotgun` to run the app locally at `http://localhost:9393/`. That should be it!


## License
Startup CMS is available as open source under the terms of the [MIT License](https://github.com/schanrai/startup-cms/blob/master/LICENSE).
