# Development Setup Instructions
- [Docker](#docker)
- [Mac OS X / Mac OS](#mac-os-x)

## Docker

### What is Docker?
>Docker containers wrap a piece of software in a complete filesystem that contains everything needed
>to run: code, runtime, system tools, system libraries – anything that can be installed on a server.
>This guarantees that the software will always run the same, regardless of its environment.
[Docker - What is Docker?](https://www.docker.com/what-docker)

#### Installing Docker
The latest Docker downloads and setup instructions for your operating system can be found
in the [Docker downloads page](https://www.docker.com/products/docker).

### Getting Up and Running with Docker

Build the Bizport docker image:
```
$ docker-compose build
```

#### Preparing the Database
First, spin up the DB docker image:
```
$ docker-compose up db
```

Next, access the command line of the Bizport DB docker image:
```
$ docker exec -it bizport_db_1 /bin/bash
```

Switch to the `postgres` user:
```
$ su postgres
```

Create your dev and test databases at the command line with the postgres shortcut `createdb`:
```
$ createdb bizport_development
```

```
$ createdb bizport_test
```

Close/terminate your bash sessions.

Next, setup the database via rake: 
```
$ docker-compose run web rake db:setup
```

#### Loading Seed Data

There are two options for loading seed data: fixtures or a production database import. Fixtures are more portable if you're setting up on a computer without access to the production Heroku account. Importing direct from the Heroku account is likely to produce an environment with better production parity, and is the recommended approach.

##### Production Database Import
Heroku provides a database import feature. Because importing an entire database is a major operation, and has the potential to overwrite or destroy data, the command line utility has several warnings before it begins work.
First, access the command line of the Bizport DB docker image:
```
$ docker exec -it bizport_web_1 /bin/bash
```
Next, login to Heroku with your account credentials:
```
$ heroku
```
Then begin the database copy with:
```
$ heroku pg:pull DATABASE_URL bizport_development
```
Note that you may be prompted to drop your local database before pulling the new one. Also note that `DATABASE_URL` is the default name for the main DB URL of a Heroku application. If this doesn't work, you can use `heroku pg:info` to check the correct URL name for your database.

##### Fixtures
In order to load the `bizport` CMS fixtures, the CMS needs to have a `Site` object in the DB called `bizport` with which to associate the fixtures. To do this, open the Rails console and add a site object with the site name.
```
$ docker-compose run web bundle exec rails console
> Comfy::Cms::Site.create(identifier:'bizport')
```

Close/terminate the `web` image bash session.

Import fixtures. 

To *import* CMS fixtures: `heroku run bundle exec rake comfortable_mexican_sofa:fixtures:import FROM=bizport TO=bizport`
To *export* CMS fixtures: `heroku run bundle exec rake comfortable_mexican_sofa:fixtures:export FROM=bizport TO=bizport`

To copy CMS fixtures from remote to local: `docker-compose run web scp -r <username>@<host>:<path/to/app/folder>/db/cms_fixtures/bizport db/cms_fixtures/`

### Starting the Application

You should now be able to boot the application by running `docker-compose up` or `docker-compose up web` if the `db` container is already running. Visit `localhost:3000` to verify that everything is working. The homepage uses a blend of code and database content to render, and so is a fairly complete test that everything is set up correctly.

### Deploying to Heroku Container Registry and Runtime
Heroku's Container Registry and Runtime is a service specifically for deploying Docker containers. BizPort's docker-compose file specifies two containers, `web` and `db`, but Heroku will simply connect the `web` container to its hosted DB service, so we only need to deploy the `web` container.

If this is the first time you're using Heroku's container service, you'll need to install the plugin with `heroku plugins:install heroku-container-registry`
Further setup instructions, if needed, are available at https://devcenter.heroku.com/articles/container-registry-and-runtime

Log in to Heroku's Docker container registry: `heroku container:login`
The application can then be deployed with `heroku container:push`

That's it!

## Mac OS X Setup (non-Docker option)

### Homebrew
Homebrew is a package manager for system-level packages, and will help with installing a few libraries throughout the setup process. It can be installed by following the instructions at http://brew.sh/. On certain versions of OSX, or if you've recently updated from an older version of OSX or Homebrew, you might have some permissions issues. This article may be helpful: https://github.com/Homebrew/legacy-homebrew/issues/17884

### `rbenv`
BizPort specifies Ruby version 2.3.0 (in the `.ruby_version` file). To use a specific version of Ruby, you'll need a version managment package like `rvm` or `rbenv`. While either will work, we recommend `rbenv`.
To install `rbenv`, follow these instructions *exactly*. https://github.com/rbenv/rbenv#homebrew-on-mac-os-x

### Postgres
After rbenv has installed, navigate to the Rails project's root directory (bizport) and source your bash profile in the shell. If you don't have postgres installed, do so by using `brew install postgres` or another installation method of your choice (e.g. Postgres.app). (Follow instructions here: https://launchschool.com/blog/how-to-install-postgresql-on-a-mac)

Create your dev and test databases at the command line with the postgres shortcut `createdb`:
```
$ createdb bizport_development
```

```
$ createdb bizport_test
```

### Imagemagick
BizPort (more specifically, the CMS) uses the system package Imagemagick to compress and store uploaded images.
```
$ brew install imagemagick
```

### Gems
Rails uses Bundler (http://bundler.io/) to manage gem dependencies. Simply `cd` into the directory where you cloned this repo and run:

```bash
$ gem install bundler
$ bundle install
```

### Loading Seed Data

There are two options for loading seed data: fixtures or a production database import. Fixtures are more portable if you're setting up on a computer without access to the production Heroku account. Importing direct from the Heroku account is likely to produce an environment with better production parity, and is the recommended approach.

#### Production Database Import
Heroku provides a database import feature. Because importing an entire database is a major operation, and has the potential to overwrite or destroy data, the command line utility has several warnings before it begins work.
First, install the Heroku CLI tool:
```
$ brew install heroku
```
Then `cd` into the repo folder and begin the database copy with:
```
$ heroku pg:pull DATABASE_URL bizport_development
```
Note that you may be prompted to drop your local database before pulling the new one. Also note that `DATABASE_URL` is the default name for the main DB URL of a Heroku application. If this doesn't work, you can use `heroku pg:info` to check the correct URL name for your database.

#### Fixtures
In order to load the `bizport` CMS fixtures, the CMS needs to have a `Site` object in the DB called `bizport` with which to associate the fixtures. To do this, open the Rails console and add a site object with the site name.
```
$ bundle exec rails console
> Comfy::Cms::Site.create(identifier:'bizport')
```

Import fixtures. 

To *import* CMS fixtures: `bundle exec rake comfortable_mexican_sofa:fixtures:import FROM=bizport TO=bizport`
To *export* CMS fixtures: `bundle exec rake comfortable_mexican_sofa:fixtures:export FROM=bizport TO=bizport`

To copy CMS fixtures from remote to local: `scp -r <username>@<host>:<path/to/app/folder>/db/cms_fixtures/bizport db/cms_fixtures/`

### Starting the Application
You should now be able to boot the application by running `bundle exec rails server` or simply `bundle exec rails s`. Visit `localhost:3000` to verify that everything is working. The homepage uses a blend of code and database content to render, and so is a fairly complete test that everything is set up correctly.

# Application Architecture

## Request Routing and Rendering

As with all Rails apps, `config/routes.rb` defines the way that routes are initially dispatched to controllers. Routes are read from top to bottom, with the first match taking precedence, and routes further down the file having lower priority. In BizPort, `routes.rb` contains a few types of routes:
- "Static" routes that serve `haml` templates, managed by the StaticController. In spite of the name, these pages may still contain some dynamic content.
- CMS routes (e.g. `comfy_route :cms_admin, path: '/cms'`), which delegates to the CMS for individual page lookups
- Devise routes (e.g. `devise_for :users`), which delegate to the `devise` gem for user accounts/authentication/etc.
- API routes (e.g. `put '/checklist'`), which provide an interface for front-end libs like React to modify DB records.

### Static Routes
These routes call StaticController, which will look for a template with the same name as the controller method called. I.e. a request for `static#home` will cause it to look for `home.haml`.

### CMS Routes
These paths are defined by creating pages in the CMS. Note that the CMS routes are placed near the bottom of `routes.rb` so that any named routes above will take precedence over CMS content.

### Devise Routes
Devise defines a set of default controllers for most things you'll want to do with users, signup, and login. In most cases, therefore, declaring `devise_for :users` to load the default routes is sufficient. Refer to the Devise docs for instructions overriding routes and controllers.

### API Routes
Serving as endpoints for the React portions of the site (`/profile` page at this point), these routes are *approximately* RESTful, but are probably ripe for some rearchitecting as the app grows and matures.

## Page Rendering

### Root Layout
By Rails convention, all pages inherit by default from the site's master layout, `views/layouts/application.haml`. Consequently, this layout includes components present on every page like the sidebar, analytics code, and `<head>` `<meta>` tags. Child templates (i.e. pages that use this layout) are rendered at the `= yield` statement.

### CMS Layouts
The CMS has the ability to manage layouts as content (rather than code), but can also use code-based layouts, and include template partials inside CMS pages. All CMS pages *must* inherit from a root code-based layout - in BizPort, this is always `application.rb`.

For any given CMS page, the path of template/layout inheritance can be traced by the following steps:
1. In the CMS Pages editing interface, look at the "Layout" property for the page
1. In the CMS Layouts editing interface, find the relevant layout. If the layout has a "Parent Layout", go to that parent layout and repeat this step.
1. When you find a layout that does not have a "Parent Layout" value, look at the "App Layout" value. This is the name of the `html.haml` file in the codebase that is serving as the root layout. N.B.: As of `comfortable_mexican_sofa` `1.12.9`, this file *must* contain `html` in the file extension in order for the CMS to recognize it. This appears to be a bug, and is tracked in https://github.com/comfy/comfortable-mexican-sofa/issues/734

Code-based partials can be included in pages with a special tag that the CMS provides: `{{ cms:partial:shared/partial_name:param_1:param_2 }}`. While it's possible to pass arguments to partials, these arguments cannot be named, and are simply called `param_1` and `param_2`. As a result, partials like `shared/_checklist.haml` often use the pattern `- category ||= param_1` at the top of the file to name these params when they're passed in from the CMS. More documentation on these types of CMS tags is available in the gem's wiki.

## Structured Content
Some parts of the application - the checklists and profile page in particular - rely on custom-structured content like checklists and form fields. This content is managed outside of the CMS, and can be viewed and edited via the ActiveAdmin interface at `/admin`.

### Checklist Items

### Glossary Items

## React
In order to allow users to edit their checklist and notebook on their Profile page without refreshing the page on each save, BizPort uses a front-end MVC framework, React, to make calls to an API for each user edit. React was chosen because, at time of writing (October 2016), it had a strong user base, was likely to continue to be supported for the next several years, provided an easy way to pre-render the page on the server (which helps with accessibility, slow internet connections, etc.), and seemed like a generally way to write modular JS.

## Devise
User accounts (signup and login) are managed with Devise, which is the most-used Ruby authentication gem. So far, the app only uses the email/password form of authentication, but modules are available for all manner of OAuth connections like Facebook and Twitter.
