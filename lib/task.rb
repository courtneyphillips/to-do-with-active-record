class Tasks < ActiveRecord::Base
  attr_reader(:description, :list_id, :id)

  define_method(:initialize) do |attributes|
    @description = attributes[:description]
    @list_id = attributes[:list_id]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    all_tasks = []
    results = DB.exec("SELECT * FROM tasks")
    results.each do |task|
      description = task.fetch('description')
      list_id = task.fetch('list_id').to_i()
      id = task.fetch('id').to_i()
      all_tasks.push(Tasks.new({:description => description, :list_id => list_id, :id => id}))
    end
    all_tasks
  end

  define_method(:==) do |another_task|
    (self.description) == (another_task.description) && (self.list_id) == (another_task.list_id)
  end

  define_singleton_method(:find) do |identification|
      found_task = nil
      Tasks.all().each() do |task|
        if task.id() == identification
          found_task = task
        end
      end
      found_task
    end

  define_method(:update) do |attributes|
    @description = attributes.fetch(:description, @description)
    @id = self.id
    @list_id = attributes.fetch(:list_id, @list_id)
    DB.exec("UPDATE tasks SET description = '#{@description}' WHERE id = #{@id};")
    DB.exec("UPDATE tasks SET list_id = #{@list_id} WHERE id = #{@id};")
  end

  define_method(:delete) do
    @id = self.id
    DB.exec("DELETE FROM tasks WHERE id = #{@id};")
  end
end
