class Course < ApplicationRecord
  belongs_to :program
  has_many :sections
  has_many :student_sections
  has_many :users, :through => :student_sections
  has_many :sections, :through => :student_sections
  has_many :users, :through => :sections
  has_many :semesters, :through => :sections
  
  #TODO: return all sections of this course
  def sections
    return Section.where(course_id: self.id)
  end
end
