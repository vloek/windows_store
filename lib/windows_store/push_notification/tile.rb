module WindowsStore::PushNotification
  class Tile < CommonPushType

    def to_xml
      return %Q(
        <tile>
          <visual version="2">
            <binding template="TileWide310x150Text01" fallback="TileWideText01">
              <text id="1">#{text}</text>
            </binding>
            <binding template="TileSquare150x150Text01" fallback="TileSquareText01">
              <text id="1">#{text}</text>
            </binding>
          </visual>
        </tile>
      )
    end

  end
end
