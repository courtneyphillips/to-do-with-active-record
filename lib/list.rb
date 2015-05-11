class List
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    all_lists = []
    results = DB.exec("SELECT * FROM lists")
    results.each do |list|
      name = list.fetch('name')
      id = list.fetch('id').to_i()
      all_lists.push(List.new({:name => name, :id => id}))
    end
    all_lists
  end

  define_method(:==) do |another_list|
    self.name. == (another_list.name())
  end

  define_singleton_method(:find) do |identification|
      found_list = nil
      List.all().each() do |list|
        if list.id() == identification
          found_list = list
        end
      end
      found_list
    end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id
    DB.exec("UPDATE lists SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    @id = self.id
    DB.exec("DELETE FROM lists WHERE id = #{@id};")
  end

  define_method(:task) do
    list_tasks = []
    tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{self.id};")
    tasks.each do |task|
      description = task.fetch('description')
      list_id = task.fetch('list_id').to_i()
      task_id = task.fetch('id').to_i()
      list_tasks.push(Tasks.new({:description => description, :id => task_id, :list_id => list_id}))
    end
    list_tasks
  end
end
