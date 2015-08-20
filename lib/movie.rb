class Movie
  attr_accessor :title, :release_date, :director, :summary

  @all = []

  class << self
    attr_accessor :all

    def reset_movies!
      all.clear
    end

    def make_movies!
      File.foreach('spec/fixtures/movies.txt') do |line|
        new(*attributes_from(line))
      end
    end

    def attributes_from(line)
      line.split(' - ')
    end

    def recent
      all.select { |movie| movie.release_date >= 2012 }
    end
  end

  def initialize(title, release_date, director, summary)
    @title        = title
    @release_date = release_date.to_i
    @director     = director
    @summary      = summary

    Movie.all << self
  end

  def url
    "#{urlize(title)}.html"
  end

  private

  def urlize(title)
    title.downcase.tr(' ', '_')
  end
end
