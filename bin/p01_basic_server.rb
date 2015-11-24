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

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  res.write(req.fullpath)
  #res.write("Hello Cats")
  res.finish
end
# 5. pass object App.new to Rack::Server#start
# can also pass Proc:
# app = Proc.new { |env| ['200'. {'Content-Type' => 'text/html'}. [''] ] }
Rack::Server.start(
  app: app,
  #port defaults to 8080
  Port: 3000
)

# app = Proc.new do |env|
#   req = Rack::Request.new(env)
#   res = Rack::Response.new #serializes/formats env object
#   #MyController is like ApplicationsController
#   MyController.new(req, res).go #go method build response object
#   res.finish
# end
