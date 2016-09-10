require 'discordrb'

bot = Discordrb::Bot.new token: '[your bot token]', application_id: [your bot application id]

bot.message(starting_with: '%^help') do |event|
  event.respond '```Command List:
  %^ping - Is the bot online? Well, yes, you issued this command..
  %^help - Shows This.
  %^invite - Invite the bot to your server.
  %^code - Shows Code.
  %^rate - Rate something /10.
  %^namemc - Search the NameMC database.
  %^memedb - Find a meme in the meme database.
  %^memedb submit - Submit a meme to the meme database.
  %^stats - Show some stats for Chewbotcca
  %^rip - RIP a user! Do not mention them or link will also rip```'
end
bot.message(with_text: '%^ping') do |event|
  event.respond 'Pong!'
end
bot.message(with_text: '%^help help') do |event|
  event.respond '**__Help for:__** `%^help`
**Description:** Shows a list of commands, if an argument is specified, it will show help for that command.
**Usage:** `%^help` or `%^help ping`'
end
bot.message(starting_with: '%^rate') do |event|
  _, *rating = event.message.content.split
  event.respond "#{event.user.mention} has rated #{rating.join(' ')}/10."
end
bot.message(with_text: '%^help ping') do |event|
  event.respond '**__Help for:__** `%^ping`
**Description:** Replies with "Pong!"
**Usage:** `%^ping`'
end
bot.message(with_text: '%^code') do |event|
  event.respond 'Chewbotcca was written in discordrb, and was made by @Chew#6216. Source code here: http://github.com/Chewsterchew/Chewbotcca'
end
bot.message(with_text: '%^help code') do |event|
  event.respond '**__Help for:__** `%^code`
**Description:** Shows a link to the GitHub Repository to Chewbotcca."
**Usage:** `%^code`'
end
bot.message(starting_with: '%^invite') do |event|
  event.respond 'Hello! Invite me to your server here: http://chcra.site/Chewbotcca
  Join our support here right here: https://discord.gg/Q8TazNz'
end
bot.message(with_text: '%^help invite') do |event|
  event.respond '**__Help for:__** `%^invite`
**Description:** Shows a link to invite Chewbotcca to your server and a discord invite link to the help server.
**Usage:** `%^invite`'
end
bot.message(starting_with: '%^namemc') do |event|
  _, *namemc = event.message.content.split
  event.respond "NameMC Search: http://namemc.com/s/#{namemc.join(' ')}"
end
bot.message(starting_with: '%^help namemc') do |event|
  event.respond '__Help for:__ `%^namemc`
**Description:** Shows a link to search results for a response, or if there''s one result, will show detailed info.
**Usage:** `%^namemc ChewLeKitten` or `%^namemc play.chewcraft.me`'
end
bot.message(starting_with: '%^stats') do |event|
  event.respond "```xl
Chewbotcca - A basic functioning discord bot
Author: ChewLeKitten#6216 [116013677060161545]
Library: discordrb
Server Count: #{event.bot.servers.count}```"
end
bot.message(starting_with: '%^help stats') do |event|
  event.respond '__Help for:__ `%^stats`
**Description:** Shows basic stats for Chewbotcca.
**Usage:** `%^stats`'
end
bot.message(starting_with: '%^rip') do |event|
  _, *rip = event.message.content.split
  event.respond "#{rip.join(' ')} got #rekt! http://ripme.xyz/#{rip.join(' ')}"
end
bot.message(starting_with: '%^help rip') do |event|
  event.respond '__Help for:__ `%^rip`
**Description:** Makes someone or something rip. No spaces, letters and numbers only.
**Usage:** `%^rip Chew`'
end
bot.message(with_text: '%^memedb') do |event|
  event.respond 'Find the entire memedb here: http://memedb.chewcraft.me
  Pick a meme with `%^memedb [meme name]` ```Current Memes:
  deanmeme, rickroll, vegans, spotad, petpet, nicememe, paycheck, pokesteak, losthope, timetostop, skypetrash, trap, triggered``'
end
bot.message(with_text: '%^help memedb') do |event|
  event.respond '__Help for:__ `%^memedb`
**Description:** Shows a list of the entire meme database.
**Usage:** `%^memedb` or `%^memedb rickroll`'
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
  event.respond 'http://memedb.chewcraft.me/memes/vegans.png submitted by Stalemated#4473'
end
bot.message(starting_with: '%^memedb spotad') do |event|
  event.respond "http://memedb.chewcraft.me/memes/spotad.jpg"
end
bot.message(starting_with: '%^memedb petpet') do |event|
  event.respond "http://memedb.chewcraft.me/memes/petpet.jpg"
end
bot.message(starting_with: '%^memedb nicememe') do |event|
  event.respond "http://memedb.chewcraft.me/memes/nicememe.gif submitted by Stalemated#4473"
end
bot.message(starting_with: '%^memedb paycheck') do |event|
  event.respond "http://memedb.chewcraft.me/memes/paycheck.JPG"
end
bot.message(starting_with: '%^memedb pokesteak') do |event|
  event.respond "http://memedb.chewcraft.me/memes/pokesteak.JPG"
end
bot.message(starting_with: '%^memedb losthope') do |event|
  event.respond "http://memedb.chewcraft.me/memes/losthope.png submitted by Stalemated#4473"
end
bot.message(starting_with: '%^memedb timetostop') do |event|
  event.respond "http://memedb.chewcraft.me/memes/timetostop.gif"
end
bot.message(starting_with: '%^memedb skypetrash') do |event|
  event.respond "http://memedb.chewcraft.me/memes/skypetrash.gif submitted indirectly by SplitPixl#9184"
end
bot.message(starting_with: '%^memedb trap') do |event|
  event.respond "http://memedb.chewcraft.me/memes/trap.jpeg submitted by Mini#5311"
end
bot.message(starting_with: '%^memedb triggered') do |event|
  event.respond "http://memedb.chewcraft.me/memes/triggered.gif submitted indirectly by speedo#0032"
end
bot.message(with_text: '%^status auto servers', from: 116013677060161545) do |event|
  event.bot.game = "on #{event.bot.servers.count} servers."
  event.respond "Enabled Status."
end
bot.message(with_text: '%^status auto servers', from: not!(116013677060161545)) do |event|
  event.respond "Bot Owner Only!"
end
bot.message(starting_with: '%^status set', from: 116013677060161545) do |event|
  _, *status = event.message.content.split
  event.respond "Status set to: #{status.join(' ')}"
  event.bot.game = "#{status.join(' ')}"
end
bot.message(starting_with: '%^status set', from: not!(116013677060161545)) do |event|
  event.respond "Bot Owner Only!"
end
bot.message(starting_with: '%^namecheap') do |event|
  _, *domain = event.message.content.split
  event.respond "NameCheap Domain Search Results [only one word]: https://www.namecheap.com/domains/registration/results.aspx?domain=#{domain.join(' ')}"
end
bot.message(with_text: '%^help namecheap') do |event|
  event.respond '__Help for:__ `%^namecheap`
**Description:** Searches namecheap.com for a domain name. No spaces or special characters, just a normal domain search.
**Usage:** `%^namecheap google.com`'
end
bot.run
