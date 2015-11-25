require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'active_support/inflector'

class ControllerBase #applications controller inherits from this
  attr_reader :req, :res, :params
  attr_accessor :already_built_response

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @route_params = route_params
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    !!@already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    @res.header["location"] = url
    @res.status = 302
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise if already_built_response?
    res.body = [content]
    res['Content-Type'] = content_type
    @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    f = File.read(template_name)
    render_content(
        ERB.new("<%= f %>").result(binding),
        'text/html')
    #"views/#{controller_name}/#{template_name}.html.erb"
  end

  # method exposing a `Session` object
  def session
    @session ||=
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    .send :name
  end
end
