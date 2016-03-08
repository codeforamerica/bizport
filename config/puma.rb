directory "/var/www/bizport/current"
environment 'production'
workers 1
threads 1, 8

bind 'tcp://0.0.0.0:9951'
pidfile "/var/www/bizport/current/tmp/puma/pid"
state_path "/var/www/bizport/current/tmp/puma/state"

preload_app!
activate_control_app
