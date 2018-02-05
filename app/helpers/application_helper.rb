module ApplicationHelper
  def trace(*message)
    puts "----------"
    puts message
    puts "----------"
  end
end
