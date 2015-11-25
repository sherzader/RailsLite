require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    if req.cookies['rails_lit_app']
      @cookie = req.cookies['rails_lit_app']
    else
      @cookie = {}
    end

  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie('rails_lit_app', { :/, :@cookie.JSON } )
  end
end
