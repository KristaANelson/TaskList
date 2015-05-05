class Seed
  def initialize
     generate_tasks
  end

  def generate_tasks
    100.times do |i|
      task = Task.create(
      title:       "task#{i+1}",
      due_date:  Date.today + rand(10)
      )
    end
  end
end

Seed.new
puts "#{Task.count} tasks created"
