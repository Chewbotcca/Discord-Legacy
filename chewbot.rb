require 'discordrb'

bot = Discordrb::Bot.new token: '[your token]', application_id: [your application id]

bot.message(with_text: '%^ping') do |event|
  event.respond 'Pong!'
end
bot.message(with_text: '%^who is champ') do |event|
  event.respond 'John Cena!'
end
bot.message(starting_with: '%^rate') do |event|
  _, *rating = event.message.content.split
  event.respond "#{event.user.mention} has rated #{rating.join(' ')}/10."
end
bot.message(with_text: '%^code') do |event|
  event.respond 'Chewbotcca was written in discordrb, and was made by Chew. Source code here: http://github.com/Chewsterchew/Chewbotcca'
end
bot.message(starting_with: '%^invite') do |event|
  event.respond 'Hello! Invite me to your server here: http://chcra.site/Chewbotcca
  Join our support here right here: https://discord.gg/Q8TazNz'
end
bot.message(starting_with: '%^help') do |event|
  event.respond '```Command List:
  %^help - Shows This
  %^code - Shows Code
  %^rate - Rate something /10
  %^ping - Is the bot online?
  %^who is champ - Guess, take a guess.
  %^namemc - Search the NameMC database.
  %^memedb - Find a meme in the meme database.
  %^memedb submit - Submit a meme to the meme database.```'
end
bot.message(starting_with: '%^namemc') do |event|
  _, *namemc = event.message.content.split
  event.respond "NameMC Search: http://namemc.com/s/#{namemc.join(' ')}"
end
bot.message(starting_with: '%^chew', from: "Chew", in: "#beta-testing") do |event|
  event.respond "Event handler was activated!"
end
bot.message(with_text: '%^memedb') do |event|
  event.respond 'Find the entire memedb here: http://memedb.chewcraft.me
  Pick a meme with `%^memedb [meme name]` ```Current Memes:
  deanmeme, rickroll, vegans, spotad, petpet, nicememe, paycheck, pokesteak, losthope```'
end
bot.message(starting_with: '%^memedb submit') do |event|
  event.respond 'Submit your meme for the database here: http://goo.gl/forms/BRMomYVizsY7SqOg2'
end
bot.message(starting_with: '%^memedb deanmeme') do |event|
  event.respond 'http://memedb.chewcraft.me/memes/deanmeme.png'
end
bot.message(starting_with: '%^memedb rickroll') do |event|
  event.respond 'http://memedb.chewcraft.me/memes/rickroll.gif'
end
bot.message(starting_with: '%^memedb vegans') do |event|
  event.respond 'http://memedb.chewcraft.me/memes/vegans.png submitted by Asymmetrically'
end
bot.message(starting_with: '%^memedb spotad') do |event|
  event.respond "http://memedb.chewcraft.me/memes/spotad.jpg"
end
bot.message(starting_with: '%^memedb petpet') do |event|
  event.respond "http://memedb.chewcraft.me/memes/petpet.jpg"
end
bot.message(starting_with: '%^memedb nicememe') do |event|
  event.respond "http://memedb.chewcraft.me/memes/nicememe.gif submitted by Asymmetrically"
end
bot.message(starting_with: '%^memedb paycheck') do |event|
  event.respond "http://memedb.chewcraft.me/memes/paycheck.JPG"
end
bot.message(starting_with: '%^memedb pokesteak') do |event|
  event.respond "http://memedb.chewcraft.me/memes/pokesteak.JPG"
end
bot.message(starting_with: '%^memedb losthope') do |event|
  event.respond "http://memedb.chewcraft.me/memes/losthope.png submitted by Asymmetrically"
end
bot.run
