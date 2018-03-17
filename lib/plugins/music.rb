module Music
  extend Discordrb::Commands::CommandContainer

  command(:songs) do |event|
    event << 'Use `%^play [song]` to select a song. YOU CANNOT QUEUE A RANDOM URL (yet), MUST BE FROM THIS DIRCTORY'
    event << '```mrcena, rickroll, wearenum1```'
  end

  command(:play) do |event, song|
    song.downcase!
    case song
    when 'mrcena'
      event.voice.play_file('data/music.mp3')
    when 'rickroll'
      event.voice.play_file('data/rickroll.mp3')
    when 'wearenum1'
      event.voice.play_file('data/wearenum1.mp3')
    else
      event.respond 'Song doesnt exist in the database! Check database with `%^songs`'
    end
  end

  command(:connect) do |event|
    channel = event.user.voice_channel
    next "You're not in any voice channel!" unless channel
    Bot.voice_connect(channel)
    "Connected to voice channel: #{channel.name}."
  end
end
