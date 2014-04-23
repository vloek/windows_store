module WindowsStore::PushNotification
  class Toast
    attr :text

    def initialize(text)
      @text = text
    end

    def type
      'toast'
    end

    def to_s
      return %Q(
        <toast>
          <visual>
              <binding template="ToastText01">
                  <text id="1">#{text}</text>
              </binding>  
          </visual>
        </toast>
      )
    end
  end
end