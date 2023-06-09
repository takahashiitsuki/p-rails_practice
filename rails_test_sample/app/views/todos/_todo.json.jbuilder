json.extract! todo, :id, :title, :string, :body, :created_at, :updated_at
json.url todo_url(todo, format: :json)
