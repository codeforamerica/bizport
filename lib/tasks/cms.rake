namespace :cms do
  task :load_content do
    ENV['FROM'] = 'bizport'
    ENV['TO']   = 'bizport'

    Comfy::Cms::Site.create!(:identifier => 'bizport', :hostname => 'localhost')

    Rake::Task['comfortable_mexican_sofa:fixtures:import'].invoke
  end
end
