class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def self.all
    @@all
  end

  def initialize(student_hash)
    self.add_student_attributes(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each{|student| self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each{|k, v| self.send(("#{k}="), v)}
    self
  end


end
