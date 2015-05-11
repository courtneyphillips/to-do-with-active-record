require('spec_helper')

describe('List') do

  describe('#save') do
    it('Saves a list to the database') do
    new_list = List.new({:name => ("Pet Chores")})
    new_list.save()
    expect(List.all()).to(eq([new_list]))
    end
  end

  describe('.find') do
    it('returns a specific list from the database') do
    new_list = List.new({:name => ("Pet Chores")})
    new_list.save()
    new_list2 = List.new({:name => ("House Chores")})
    new_list2.save()
    expect(List.find(new_list.id())).to(eq(new_list))
    end
  end

  describe('#update') do
  it('updates the description of an entry') do
    new_list = List.new({:name => ("Pet Chores")})
    new_list.save()
    new_list.update({:name => "Dog To Do"})
    expect(new_list.name).to(eq("Dog To Do"))
    end
  end

  describe('#delete') do
  it('deletes a task from the task table') do
    new_list = List.new({:name => ("Pet Chores")})
    new_list.save()
    new_list2 = List.new({:name => ("House Chores")})
    new_list2.save()
    new_list.delete
    expect(List.all).to(eq([new_list2]))
    end
  end

  describe('#task') do
    it('returns all tasks related to a list id') do
      new_list = List.new({:name => "get it done"})
      new_list.save()
      new_task = Tasks.new({:description => "stuff", :list_id => new_list.id()})
      new_task.save()
      expect(new_list.task).to(eq([new_task]))
    end
  end
end
