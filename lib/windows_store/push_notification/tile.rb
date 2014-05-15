module WindowsStore::PushNotification
  class Tile
    attr :text

    def initialize(text)
      @text = text
    end

    def type
      'tile'
    end

    def to_s
      return %Q(
        <tile>
          <visual>
              <binding template="TileWideText01">
                  <text id="1">#{text}</text>
              </binding>  
          </visual>
        </tile>
      )
    end
  end
end