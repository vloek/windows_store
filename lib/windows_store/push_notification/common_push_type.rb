module WindowsStore::PushNotification
  class CommonPushType
    attr_accessor :text

    def initialize(text)
      @text = text
    end

    def type
      self.class.name.downcase
    end
  end
end
