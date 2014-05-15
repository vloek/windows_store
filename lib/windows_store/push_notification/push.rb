module WindowsStore::PushNotification
  class Push
    attr :secret, :app_id, :auth_info, :device_token

    
    def initialize(secret, app_id, device_token)
      @secret, @app_id = secret, app_id
      @device_token    = device_token
      auth! 
    end


    def send_notify(msg, type='toast', options={})
      notify = ''
      case type
      when 'toast'
        notify = Toast.new(msg)
      when 'tile'
        notify = Tile.new(msg)
      end

      begin 
        uri = URI.parse ('https://' + @device_token)
        req = Net::HTTP::Post.new uri.request_uri
        req['content-type']  = "text/xml"
        req['X-WNS-Type']    = "wns/#{notify.type}"
        req['Authorization'] = "#{@auth_info['token_type'].capitalize} #{@auth_info['access_token']}"
        req.body = notify.to_s

        Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request req }
        # RestClient.post(url, notify.to_s, headers) do |response|
          # puts response.headers
        # end
      rescue => e
        $stderr.puts "Error #{e}"
      end
    end

    def auth!
      response = RestClient.post('https://login.live.com/accesstoken.srf', 
        {
          grant_type:     'client_credentials',
          client_id:      @app_id,
          client_secret:  @secret,
          scope:          'notify.windows.com'
        }, content_type:  'application/x-www-form-urlencoded')
      @auth_info = JSON.parse(response)
    end
  end
end