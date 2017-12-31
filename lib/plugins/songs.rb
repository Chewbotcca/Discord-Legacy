module Songs
  extend Discordrb::Commands::CommandContainer

  command(:songs) do |event|
    event << 'Use `%^play [song]` to select a song. YOU CANNOT QUEUE A RANDOM URL (yet), MUST BE FROM THIS DIRCTORY'
    event << '```mrcena, rickroll, wearenum1```'
  end
end
