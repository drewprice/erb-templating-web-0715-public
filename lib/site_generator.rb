class SiteGenerator
  def make_index!
    template = '<!DOCTYPE html><html><head><title>'\
               'Movies</title></head><body><ul>'

    Movie.all.each_with_object(template) do |movie|
      template << "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>"
    end << '</ul></body></html>'

    File.open('_site/index.html', 'w') { |f| f.write(template) }
  end

  def generate_pages!
    Dir.mkdir '_site/movies' unless File.exist? '_site/movies'

    template = File.read('lib/templates/movie.html.erb')

    erb_template = ERB.new(template)

    Movie.all.each do |movie|
      html = erb_template.result(binding)

      File.open("_site/movies/#{movie.url}", 'w') { |f| f.write(html) }
    end
  end
end
