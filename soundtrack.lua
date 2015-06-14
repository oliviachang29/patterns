--soundtrack.lua
local soundtrack = {}
 
local trackIndex = 1
local trackMax = 2
local savedVolume = 0
local isActive = false
 
local ST_CHANNEL = 1
 
audio.reserveChannels( 1 )
 
function soundtrack:start()
  soundtrack:stop()
 
  local track = audio.loadStream( "audio/music/track" .. trackIndex .. ".mp3" )
  local function playNextTrack( obj )
    if isActive then
 
      trackIndex = trackIndex + 1
      if trackIndex == trackMax then
        trackIndex = 1
      end
 
      audio.dispose( obj.handle )
      soundtrack:start()
    end
  end
 
  isActive = true
  audio.play( track, { channel = ST_CHANNEL, onComplete = playNextTrack } )
end
 
function soundtrack:stop()
  if audio.isChannelPlaying( ST_CHANNEL ) then
    isActive = false
    audio.stop( ST_CHANNEL )
  end
end
 
function soundtrack:mute()
  savedVolume = audio.getVolume( { channel = ST_CHANNEL } )
  audio.setVolume( 0, { channel = ST_CHANNEL } )
end
 
function soundtrack:unmute()
  audio.setVolume( savedVolume, { channel = ST_CHANNEL } )
end
 
return soundtrack