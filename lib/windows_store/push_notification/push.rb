module WindowsStore::PushNotification
  class Push
    attr_accessor :secret, :app_id, :auth_info, :device_token

    def initialize(secret, app_id, device_token)
      @secret, @app_id = secret, app_id
      @device_token    = device_token
      authenticate!
    end

    def send_notify(msg, options={})
      notify =  case options[:type].to_s
                when 'toast'
                  Toast.new(msg, options)
                when 'tile'
                  Tile.new(msg, options)
                else
                  raise "#{options[:type].to_s} is unknown type of push"
                end

      uri = URI.parse('https://' + @device_token)
      req = Net::HTTP::Post.new(uri.request_uri)
      req['content-type']  = "text/xml"
      req['X-WNS-Type']    = "wns/#{notify.type}"
      req['Authorization'] =
        "#{@auth_info['token_type'].capitalize} #{@auth_info['access_token']}"
      req.body = notify.to_xml

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request req
      end
    rescue => e
      $stderr.puts("Error #{e}")
      raise StandardError
    end

    private

    def authenticate!
      @auth_info =  JSON.parse(
                      RestClient.post(
                        'https://login.live.com/accesstoken.srf',
                        {
                          grant_type:    'client_credentials',
                          client_id:     @app_id,
                          client_secret: @secret,
                          scope:         'notify.windows.com'
                        },
                        content_type: 'application/x-www-form-urlencoded'
                      )
                    )
    end
  end
end
