**This repository is under very active development, and may have undocumented or messy code. A more formal release of this code with better documentation will be available soon for cities looking to reuse the code for their own business portals.**

----------
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

To *import* CMS fixtures: `docker-compose run web bundle exec rake comfortable_mexican_sofa:fixtures:import FROM=bizport TO=bizport`
To *export* CMS fixtures: `docker-compose run web bundle exec rake comfortable_mexican_sofa:fixtures:export FROM=bizport TO=bizport`

To copy CMS fixtures from remote to local: `docker-compose run web scp -r <username>@<host>:<path/to/app/folder>/db/cms_fixtures/bizport db/cms_fixtures/`

### Starting the Application

You should now be able to boot the application by running `docker-compose up` or `docker-compose up web` if the `db` container is already running. Visit `localhost:3000` to verify that everything is working. The homepage uses a blend of code and database content to render, and so is a fairly complete test that everything is set up correctly.

## Mac OS X

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

# CMS Editing Instructions

## CMS Content Type Examples

### General

Youtube video embed: `{{ cms:partial:shared/video_embed_youtube:"https://www.youtube.com/embed/3ZtdlSmlC44" }}`

### Step Pages

```html
{{ cms:partial:shared/link_box:"https://paydirect.link2gov.com/LBCbuslicense/ItemSearch":"PAY":"Renewal Fee Online" }}
{{ cms:partial:shared/location_map:"SBDC: Downtown Long Beach Office":"309 Pine Ave, Long Beach, CA 90802" }}
{{ cms:partial:shared/contact_box_combo:"(562) 570-6211":"LBBIZ@longbeach.gov" }}
{{ cms:partial:shared/contact_box:"phone":"(562) 570-6105" }}
{{ cms:partial:shared/contact_box:"email":"test@example.com" }}

 <div class='callout'>
    NOTE:
  </div>
```

#### "Read More" Sections

To make a section of content collapse if it goes beyond a certain height (presently set at 600px), simply add the class `readmore-section` to the div wrapper for that content block.

Example:
```html
<div class='readmore-section'>
  <h2>Title of This Section</h2>
  <p>Copy for this section.</p>
</div>
```

### Contact Page

Each contact accordion section (for a particular agency, department, etc.) is created with the following code:

```html
<ul class="accordion modules" data-accordion="true" data-allow-all-closed="true">
  <li class="accordion-item modular-box" data-accordion-item="true">
    <a class="accordion-title step-group-title text-centered">
      <div class="step-group-title-text">
        <div class="text">
          <strong>Long Beach City Hall</strong>
          <div>Protects citizens through legal enforcement</div>
        </div>
        <div class="arrow"></div>
      </div>
    </a>
    <div class="accordion-content" data-tab-content="true">
      {{ cms:partial:shared/modular_box:'phone':'562-570-6555' }}
      {{ cms:partial:shared/modular_box:'hours':'7:30am-4:30pm M-F' }}
      {{ cms:partial:shared/modular_box:'map':"333 W Ocean Blvd, Long Beach, CA 90802" }}
      {{ cms:partial:shared/modular_box:'bus':"Metro Blue Line" }}
      {{ cms:partial:shared/modular_box:'bike':"Bike racks and bike share pods available." }}
      {{ cms:partial:shared/modular_box:'parking':"Parking is available at 332 West Broadway Avenue; the first 30 minutes are free, and each additional 20 minutes cost $1.25, with a maximum fee of $7.50. Metered parking is also available along Broadway and Cedar, directly in front of City Hall." }}
    </div>
  </li>
</ul>
```

Currently supported content types are `phone`, `email`, `hours`, `map`, `bus`, `bike`, `parking`. Note that content with line breaks (e.g. a list of different daily hours) is not supported with this module. If a particular section needs multi-line content, the module (`{{...}}`) can be replaced with the following HTML:

```html
<div class="contact-pane">
  <div class="contact-pane-section">
    <i class="icon icon-hours"></i> <!-- note that the class name here determines the icon -->
  </div>
  <div class="contact-pane-section">
    <!-- YOUR CUSTOM HTML HERE (e.g. list <ul> items) -->
  </div>
</div>
```
