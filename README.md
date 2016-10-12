**This repository is under very active development, and may have undocumented or messy code. A more formal release of this code with better documentation will be available soon for cities looking to reuse the code for their own business portals.**

----------
# Setup Instructions

Install Homebrew
On certain versions of OSX, or if you've recently updated from an older version of OSX or Homebrew, you might have some permissions issues. This article may be helpful: https://github.com/Homebrew/legacy-homebrew/issues/17884

Install `rbenv`
BizPort specifies Ruby version 2.3.0 (in the `.ruby_version` file). To use a specific version of Ruby, you'll need a version managment package like `rvm` or `rbenv`. While either will work, we recommend `rbenv`.
To install `rbenv`, follow these instructions *exactly*. https://github.com/rbenv/rbenv#homebrew-on-mac-os-x

After rbenv has installed, navigate to the rails project's root directory (bizport) and source your bash profile in the shell. If you don't have postgres installed, brew install postgres. (Follow instructions here: https://launchschool.com/blog/how-to-install-postgresql-on-a-mac) <br>

Install imagemagick. 
```
$ brew install imagemagick
```

Create your dev and test databases at the command line with the postgres shortcut `createdb`:
```
$ createdb bizport_development
```

```
$ createdb bizport_test
```

Then execute the following commands. 

```
$ gem install bundler
```

```
$ bundle install
```

In order to load the `bizport` CMS fixtures, the CMS needs to have a `Site` object in the DB called `bizport` with which to associate the fixtures. To do this, open the Rails console and add a site object with the site name.
```
$ bundle exec rails console
> Comfy::Cms::Site.create(identifier:'bizport')
```

Import fixtures. 

To *import* CMS fixtures: `bundle exec rake comfortable_mexican_sofa:fixtures:import FROM=bizport TO=bizport`
To *export* CMS fixtures: `bundle exec rake comfortable_mexican_sofa:fixtures:export FROM=bizport TO=bizport`

To copy CMS fixtures from remote to local: `scp -r <username>@<host>:<path/to/app/folder>/db/cms_fixtures/bizport db/cms_fixtures/`


----------
setup key-based SSH


Set secret key on remote server
http://stackoverflow.com/questions/23180650/how-to-solve-error-missing-secret-key-base-for-production-environment-on-h/26172408#26172408


Configure SELinux
http://linux.die.net/man/8/getsebool
https://wiki.apache.org/httpd/13PermissionDenied



----------

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
