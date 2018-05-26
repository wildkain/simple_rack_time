require_relative '../time_formatter'

class TimeOutput

  def call(env)
    @request = Rack::Request.new(env)
    if valid_path?
      time = TimeFormatter.new(@request.query_string)
      response(time.status, time.body)
    else
      response(404, "Not found\n")
    end
  end

  private

  def response(status, body)
    [
      status,
      { 'Content-Type' => 'text/plain' },
      [body]
    ]
  end

  def valid_path?
    @request.path_info == '/time'
  end


end
