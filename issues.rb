require 'csv' #Requiring external Libraries Similar to import statement in Java

#modules are a way to support Multiple Inheritance in ruby similar to Interfaces in Java
module Planner
  def getHighestRankedIssue list
    list.sort_by!{ |item| item.priority.to_i}
    puts list.first
  end
  def get_todo_list
      "Here are the things you have to do before hand #{self.prerequisities.join(" ")}"
  end
  def filter_list list
    list.reject! { |i| i.percentComplete.to_i < 90 }
  end
end
class Issue
  include Comparable,Planner
attr_accessor :name,:priority,:estimatedManHours,:percentComplete,:prerequisities #Getters and Setters
  def initialize issue
    @name,@priority,@estimatedManhours,@percentComplete,*@prerequisities=issue
    @percentComplete=@percentComplete.to_f
  end
  def to_s
    "#{name} This task has a priority of #{priority} and estimated man hours for this are #{estimatedManHours}. Percentage of work finished up to now is #{percentComplete}
and PreRequisities for this task are #{prerequisities.join(" ")}"
  end
  def <=> (other)
    priority <=> other.priority = 0 ? estimatedManHours <=> other.estimatedManHours : priority <=> other.priority
  end
  class << self
    include Planner
    def filter_list list
      super(list)
    end
  end
end
Issue_Array=[]
hash=Hash.new
File.open("ruby.txt", "r+") do |f|
  f.each_line do |line|
    arr= line.chomp.gsub(/"/,"").split ","
    Issue_Array << Issue.new(arr[0..arr.size])
    hash[arr[0]]=Issue_Array.last
  end
end
p Issue_Array
p "The TODO list for the given task is #{Issue_Array[1].get_todo_list}"
puts "Filtering List Based on Percent Complete #{Issue.filter_list Issue_Array}"