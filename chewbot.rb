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
  event.respond 'Chewbotcca was written in discordrb, and was made by Chew. Source code coming soon.'
end
bot.message(starting_with: 'ayy') do |event|
  event.respond 'Speak english.'
end
bot.message(starting_with: '%^invite') do |event|
  event.respond 'Hello! Invite me to your server here: http://chcra.site/Chewbotcca
  Join our support here right here: https://discord.gg/Q8TazNz'
end
bot.run
