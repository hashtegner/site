require 'builder'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

data.projects.all.each do |item|
  proxy "#{item.url}/index.html", "projects/show.html", locals: {project: item}, ignore: true
end

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

set :build_dir, 'alesshh.github.io'

set :protocol, 'http://'
set :host, 'alesshh.com'
set :port, 80

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload

  set :host, 'localhost'
  set :port, 4567
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def optional_port
    config.port if config.port != 80
  end

  def host_with_port
    [config.host, optional_port].compact.join(':')
  end

  def site_url(path)
    [config.protocol, host_with_port, path].join
  end

  def image_url(source)
    [config.protocol, host_with_port, image_path(source)].join
  end

  def page_title
    [current_page.data.title, data.site.title].compact.join(' - ')
  end

  def page_description
    current_page.data.description || data.site.description
  end

  def page_image
    current_page.data.image || image_url('images/me.png')
  end

  def grouped_projects
    data.projects.all.group_by(&:year)
  end
end

# Build-specific configuration
# activate :imageoptim
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :minify_html

  activate :gzip
end
