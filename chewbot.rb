require 'discordrb'

bot = Discordrb::Bot.new token: '[your token]]', application_id: [your application id]

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
bot.message(starting_with: 'ayy') do |event|
  event.respond 'Speak english.'
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
bot.message(starting_with: '(╯°□°）╯︵ ┻━┻') do |event|
  event.respond 'Get anger management.'
end
bot.message(starting_with: '%^namemc') do |event|
  _, *namemc = event.message.content.split
  event.respond "NameMC Search: http://namemc.com/s/#{namemc.join(' ')}"
end
bot.message(starting_with: '%^memedb rickroll') do |event|
  event.respond 'https://media.giphy.com/media/AXQaLoWMeSmRy/giphy.gif'
end
bot.message(starting_with: '%^memedb deanmeme') do |event|
  event.respond 'http://zounce.ga/deanmemes.png'
end
bot.message(with_text: '%^memedb') do |event|
  event.respond 'Check out the meme database here: [Link]'
end
bot.message(starting_with: '%^memedb submit') do |event|
  event.respond 'Submit your meme for the database here: http://goo.gl/forms/BRMomYVizsY7SqOg2'
end
bot.message(starting_with: '%^memedb vegans') do |event|
  event.respond 'https://gyazo.com/8d96d2ccc67b324ea2e5780166e90756 submitted by Asymmetrically'
end
bot.run
