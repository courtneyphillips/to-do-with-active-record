require('spec_helper')

describe('Task') do

  describe('#save') do
    it('Saves a task to the database') do
    new_task = Tasks.new({:description => "Wash the Dog", :list_id => 1})
    new_task.save()
    expect(Tasks.all()).to(eq([new_task]))
    end
  end

  describe('.find') do
    it('returns a specific entry from the database') do
    new_task = Tasks.new({:description => "Wash the Dog", :list_id => 1})
    new_task.save()
    new_task2 = Tasks.new({:description => "Dry the Dog", :list_id => 1})
    new_task2.save()
    expect(Tasks.find(new_task.id())).to(eq(new_task))
    end
  end

describe('#update') do
  it('updates the description of an entry') do
    new_task = Tasks.new({:description => "Wash the Dog", :list_id => 1})
    new_task.save()
    new_task.update({:description => "dont wash the cat"})
    expect(new_task.description).to(eq("dont wash the cat"))
    end
  end

describe('#delete') do
  it('deletes a task from the task table') do
    new_task = Tasks.new({:description => "Wash the Dog", :list_id => 1})
    new_task.save()
    new_task2 = Tasks.new({:description => "Dry the Dog", :list_id => 1})
    new_task2.save()
    new_task.delete
    expect(Tasks.all).to(eq([new_task2]))
    end
  end


end
