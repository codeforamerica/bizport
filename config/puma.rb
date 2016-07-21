# TODO: this should actually read Rails.env.production?
# this needs to be set up such that it can deploy on city server and Heroku equally smoothly
if false 
  directory '/var/www/bizport/current'
  environment 'production'
  workers 2
  threads 1, 8

  bind 'tcp://0.0.0.0:9951'
  pidfile '/var/www/bizport/current/tmp/puma/pid'
  state_path '/var/www/bizport/current/tmp/puma/state'

  preload_app!
  activate_control_app
end
