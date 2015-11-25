class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern, @http_method, @controller_class, @action_name =
      pattern, http_method, controller_class, action_name
  end

  # checks if pattern matches path and method matches request method
  def matches?(req)
    pattern =~ req
  end

  # use pattern to pull out route params (save for later?)
  # instantiate controller and call controller action
  def run(req, res)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def run(req, res)
    route = req.match(res)
    if route.nil?
      res.status = 404
      res.content = "Not Found"
    else
      route.run(req.res)
    end
  end

  # simply adds a new route to the list of routes
  def add_route(pattern, method, controller_class, action_name)
    route = Route.new(pattern, method, controller_class, action_name)
    @routes << route
  end

  # evaluate the proc in the context of the instance
  # for syntactic sugar :)
  def draw(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|

  end

  # should return the route that matches this request
  def match(req)
    @routes.each do |route|
      return route if route.matches? req
    end
    nil
  end

  # either throw 404 or call run on a matched route
  def run(req, res)
  end
end
