# 1. require rack library
require 'rack'

class App
# 3. #call takes on arg, env
# env holds request data
  def call(env)
# 2. create an object that responds to #call
    http_status = '200'
    headers = { 'Content-Type' => 'text/html' }
    body = ['hello world']

    [http_status, headers, body]
# 4. #call returns: HTTP status, headers {}, response body
  end
end

# 5. pass object App.new to Rack::Server#start
# can also pass Proc:
# Proc.new { |env| ['200'. {'Content-Type' => 'text/html'}. [''] ] }
Rack::Server.start(
  app: App.new,
  #port defaults to 8080
  Port: 3000
)
