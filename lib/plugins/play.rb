module Play
  extend Discordrb::Commands::CommandContainer

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
end
