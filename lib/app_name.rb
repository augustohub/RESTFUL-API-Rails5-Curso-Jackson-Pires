class AppName
  def initialize(app, app_name)
    @app = app
    @app_name = app_name
  end

  def call(env)
    if env["ORIGINAL_FULLPATH"] == "/"
      ['200', { 'Content-Type' => 'text/html' }, ['Teste!']]
    else
      status, headers, response = @app.call(env)
      headers['X-App-Name'] = @app_name.to_s
      #headers.merge!({ 'X-App-Name' => 'Notebook API' })
      [status, headers, [response.body]]
    end
  end
end
