# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://bizport.longbeach.gov"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # CONTROLLERS

  routes = Rails.application.routes.routes.map do |route|
    {alias: route.name, path: route.path.spec.to_s, controller: route.defaults[:controller], action: route.defaults[:action]}
  end
  
  # opt-in controllers
  selected_routes = routes.select do |route|
    [
      'static',
    ].include? route[:controller]
  end

  controller_paths = selected_routes.map { |route| route[:path][0..-('(.:format)'.size+1)] }

  # remove specific undesired routes
  controller_paths.reject! do |path|
    [
    ].include? path
  end

  controller_paths.uniq!

  controller_paths.each { |path| add path }

end

