module WindowsStore::PushNotification
  class Tile < CommonPushType

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
