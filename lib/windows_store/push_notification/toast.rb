module WindowsStore::PushNotification
  class Toast < CommonPushType

    def to_xml
      return %Q(
        <toast launch='#{launch_link}'>
          <visual>
            <binding template="ToastText01">
              <text id="1">#{text}</text>
            </binding>
          </visual>
        </toast>
      )
    end

    def launch_link
      link = '' unless options[:book_id] || options[:toast_action]
      link ||=  case options[:toast_action].to_s
                when 'open'
                  "orfogr://book/open?id=#{options[:book_id].to_i}"
                when 'download'
                  "orfogr://book/download?id=#{options[:book_id].to_i}"
                else
                  ''
                end
      encode(link)
    end

  end
end
