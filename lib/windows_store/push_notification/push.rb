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
      end

      headers = {
        "Content-Type"  => "text/xml", 
        "X-WNS-Type"    => "wns/#{notify.type}",
        "Authorization" => "#{@auth_info['token_type'].capitalize} #{@auth_info['access_token']}", 
        "Host"=>"db3.notify.windows.com"
      }

      begin 
        url = 'https://' + @device_token
        RestClient.post(url, notify.to_s, headers )
      rescue => e
        $stderr.puts "Error #{e}"
        $stderr.puts "Headers: #{headers}"
        $stderr.puts "Notify: #{notify.to_s}"
        $stderr.puts "URI: #{@device_token}"
        $stderr.puts '-----'
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