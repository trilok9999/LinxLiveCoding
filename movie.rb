class Movie
  def self.has_many(names)
    p "#{self} has many #{names}"

    define_method(names) do
      p "dynamically generated method"
    end
  end

  has_many :reviews

  def method_missing(name,*args)
    case name
      when /^find_by_([a-z]+)_and_([a-z]+)/
        find($1.to_sym => args[0],$2.to_sym => args[1])
      when /^find_by_([a-z]+)/
        find($1.to_sym => args)
    end
  end

  def find(*args)
puts "finding by #{args.join(" ")}"
    end
end
Movie.new.find_by_nisanth("trilok","yalakaturi")