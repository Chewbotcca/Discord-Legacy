module MemeDB
  extend Discordrb::Commands::CommandContainer

  command(:memedb, min_args: 0, max_args: 1) do |event, meme|
    meme.downcase!
    case meme
    when 'deanmeme'
      event.respond 'http://chewbotcca.github.io/memedb/deanmeme.png'
    when 'rickroll'
      event.respond 'http://chewbotcca.github.io/memedb/rickroll.gif'
    when 'vegans'
      event.respond 'http://chewbotcca.github.io/memedb/vegans.png'
    when 'spotad'
      event.respond 'http://chewbotcca.github.io/memedb/spotad.jpg'
    when 'petpet'
      event.respond 'http://chewbotcca.github.io/memedb/petpet.jpg'
    when 'nicememe'
      event.respond 'http://chewbotcca.github.io/memedb/nicememe.gif'
    when 'paycheck'
      event.respond 'http://chewbotcca.github.io/memedb/paycheck.JPG'
    when 'pokesteak'
      event.respond 'http://chewbotcca.github.io/memedb/pokesteak.JPG'
    when 'losthope'
      event.respond 'http://chewbotcca.github.io/memedb/losthope.png'
    when 'timetostop'
      event.respond 'http://chewbotcca.github.io/memedb/timetostop.gif'
    when 'skypetrash'
      event.respond 'http://chewbotcca.github.io/memedb/skypetrash.gif'
    when 'trap'
      event.respond 'http://chewbotcca.github.io/memedb/trap.jpeg'
    when 'triggered'
      event.respond 'https://chewbotcca.github.io/memedb/triggered.gif'
    when 'noot'
      event.respond 'https://chewbotcca.github.io/memedb/noot.gif'
    when 'iplayedmyself'
      event.respond 'https://chewbotcca.github.io/memedb/iplayedmyself.png'
    when 'submit'
      event.respond 'You can submit a meme here: <http://goo.gl/forms/BRMomYVizsY7SqOg2>'
    else
      event << "This meme doesn't exist! Make sure you spell the meme name right (CASE SENSITIVE)."
      event << 'Here is a list of the current memes: `deanmeme, rickroll, vegans, spotad, petpet, nicememe, paycheck, pokesteak, losthope, timetostop, skypetrash, trap, triggered, noot, iplayedmyself`'
    end
  end
end
