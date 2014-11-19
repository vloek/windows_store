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
      ''
    end

  end
end
