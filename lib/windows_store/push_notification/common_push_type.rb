module WindowsStore::PushNotification
  class CommonPushType
    attr_accessor :text, :options

    def initialize(text, options)
      @text, @options = text, options
    end

    def type
      self.class.name.demodulize.downcase
    end

    private

    def encode(val)
      Base64.encode64(val)
    end
  end
end
