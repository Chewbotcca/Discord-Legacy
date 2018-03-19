module MemeDB
  extend Discordrb::Commands::CommandContainer

  command(:memedb, min_args: 0, max_args: 1) do |event, meme|
    meme.downcase! unless meme.nil?
    prefix = ''
    prefix = '.gif' if %w[rickroll nicememe timetostop triggered noot skypetrash].include? meme
    prefix = '.png' if %w[deanmeme vegans losthope iplayedmyself nottheadmin pineapplepringle grupingseveryone grueveryonenotif].include? meme
    prefix = '.jpg' if %w[spotad petpet youarerobot].include? meme
    prefix = '.JPG' if %w[paycheck pokesteak].include? meme
    prefix = '.jpeg' if %w[trap].include? meme
    if prefix == '' && meme != 'submit'
      event << "This meme doesn't exist! Make sure you spell the meme name right (CASE SENSITIVE)." unless meme.nil?
      event << 'Here is a list of the current memes: `deanmeme, rickroll, vegans, spotad, petpet, nicememe, paycheck, pokesteak, losthope, timetostop, skypetrash, trap, triggered, noot, iplayedmyself, nottheadmin, pineapplepringle, youarerobot, grupingseveryone, grueveryonenotif`'
    elsif meme == 'submit'
      event.respond 'You can submit a meme here: <http://goo.gl/forms/BRMomYVizsY7SqOg2>'
    else
      event.respond "https://chewbotcca.co/memedb/#{meme}#{prefix}"
    end
  end
end
