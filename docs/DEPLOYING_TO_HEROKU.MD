# Heroku Deployment Instructions 

Make sure that all changes have been committed and pushed up to your remote Github repository. 

Make sure to set up a heroku Account - [Set up a Heroku Account](https://signup.heroku.com/login)
 
If you need more info on Heroku, get it here  - [What is Heroku ?](https://www.heroku.com/what)

Open your Terminal/Command Prompt and navigate to the Bizport project directory. 

Then enter the following commands in the terminal:

 ```heroku create``

This should buld a new heroku app for your bizport application. You should see an URL given for your app. 

Next you should enter: 

```git push heroku <branch>``` 

where <branch> equals the name of the repo branch you going to deploy from. In most cases, this would be the master branch. So\, it should look something like this:

``` git push heroku master ```

After that you will need to migrate your database over with the following command:

```heroku pg:push bizport_development DATABASE_URL```


This should get your home screen for the app up and running. 

# Bucketeer Add-on

Naviagte to www.heroku.com and sign-in. Click on the name of your app in the menu. In the dashboard, click on the 'Resources' tab. There you should see a "Add-ons" section. Here search for the "Bucketeer" add on. Make sure to add this your appn in Heroku. 

