Config = {}

Config.Timeout          = 8000          -- Overridden by the `timeout` param
Config.Position         = "bottomleft"     -- Overridden by the `position` param
Config.Progress         = true          -- Overridden by the `progress` param
Config.Theme            = "default"     -- Overridden by the `theme` param
Config.Queue            = 4             -- No. of notifications to show before queueing
Config.Stacking         = true
Config.ShowStackedCount = true
Config.AnimationOut     = "fadeOut";    -- Exit animation - 'fadeOut', 'fadeOutLeft', 'flipOutX', 'flipOutY', 'bounceOutLeft', 'backOutLeft', 'slideOutLeft', 'zoomOut', 'zoomOutLeft'
Config.AnimationTime    = 500           -- Entry / exit animation interval
Config.FlashCount       = 5             -- No. of times to flash the notification
Config.FlashType       = "flash"        -- No. of times to flash the notification
Config.SoundFile        = false         -- Sound file stored in ui/audio used for notification sound. Leave as false to disable.
Config.SoundVolume      = 0.4           -- 0.0 - 1.0

-- Pictures for advanced notifications
--
-- You can add custom icons by uploading a 64x64 jpeg image to the ui/images directory then adding the code and filename here
--
-- e.g. MY_CUSTOM_ICON_CODE = "my_custom_icon_image.jpg"
--
-- ShowAdvancedNotification(message, title, subject, "MY_CUSTOM_ICON_CODE")
--

Config.Pictures = {
    BLUESTARK = "bluestark.png",
    CALL = "call.png",
    POLICE = "police.png",
}