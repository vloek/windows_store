module WindowsStore::PushNotification
  class Push
    attr :secret, :app_id, :auth_info

    
    def initialize(secret, app_id)
      @secret, @app_id = secret, app_id
      auth! 
    end


    def send_notify(msg, type='toast', options={})
      case type
      when 'toast'
        notify = Toast.new(msg)
      end

      headers = {
        "Content-Type"  => "text/xml", 
        "X-WNS-Type"    => "wns/tile", 
        "Authorization" => "Bearer EgAdAQMAAAAEgAAAC4AAZWP9Y2TS8I+YMZCGERD4BVDQ6OOa+4WDM4FeFMMnG5e+T7tJV0Kyz/vmxsrMAYLKutBSKTq9By4FyzUey+3y9WoGspxYdVdzgH6IYoMA57RSGzZaQMBPaoqTKtlWWA8RhWxBnxJz++j/OIYOZTOyE3jS3VMgH2z5dH4LxwOaOT6MAFoAjAAAAAAAi2URRFVdVlNVXVZT60gEAA4AODQuNDcuMTUyLjI0MgAAAAAAXgBtcy1hcHA6Ly9zLTEtMTUtMi0yNjg3NTM2MDYzLTM1ODc4MzUwMzEtMzQyMDUwMjUzLTE4OTI2ODUxMzAtMTE3OTgyNTI1My0zMDY3NTIwOTgwLTE1OTAxODc0OTcA", 
        "Host"=>"db3.notify.windows.com"}

      RestClient.post(@app_id, notify.to_s, content_type: 'text/xml', 'X-WNS-Type' => "wns/#{notify.type}", authorization: "#{@auth_info['token_type'].capitalize} #{@auth_info['access_token']}")
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