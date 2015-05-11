require('sinatra')
require('pg')
require('sinatra/reloader')
require('./lib/list')
require('./lib/task')
also_reload('lib/**/*.rb')


DB = PG.connect({:dbname => 'to_do'})

get ('/') do
  @lists = List.all()
  erb(:index)
end

post ('/list/new') do
  name = params.fetch("name")
  new_list = List.new({:name => name})
  new_list.save()
  @id = new_list.id().to_i
  redirect("/list/#{@id}")
end




post ('/task/new') do
  description = params.fetch("description")
  @id = params.fetch("list_id")
  list_id = params.fetch("list_id")
  new_task = Tasks.new({:description => description, :list_id => list_id})
  new_task.save()
  redirect("/list/#{@id}")
end


get ('/list_new') do
  erb(:list_new)
end

get('/list/:id') do
  specific_list = List.find(params.fetch("id").to_i())
  @tasks = specific_list.task()
  @id = specific_list.id
  erb(:list_info)
end
