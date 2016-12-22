require 'discordrb'
require 'yaml'
puts "All dependicies loaded"

CONFIG = YAML.load_file('config.yaml')
puts "Token loaded from file"
bot = Discordrb::Commands::CommandBot.new token: CONFIG['token'], client_id: 200747094150086657, prefix: '%^'
puts "Initial Startup complete, loading all commands..."

#Help Command
bot.command(:help, description: 'Gives help for a command.') do |event|
  event.user.pm('```Command List:
  %^ping - Replies with "Pong!"
  %^help - Shows a list of commands, if an argument is specified, it will show help for that command.
  %^invite - Shows a link to invite Chewbotcca to your server and a discord invite link to the help server.
  %^code - Shows a link to the GitHub Repository to Chewbotcca.
  %^rate - Rate something /10.
  %^namemc - Shows a link to search results for a response, or if there''s one result, will show detailed info.
  %^memedb - Shows a list of the entire meme database.
  %^memedb submit - Submit a meme to the meme database.
  %^stats - Shows basic stats for Chewbotcca.
  %^rip - Makes someone or something rip. No spaces, letters and numbers only.
  %^namecheap - Searches namecheap.com for a domain name. No spaces or special characters, just a normal domain search.
  %^domainwhois - Returns a link to see the "whois" of a domain.```')
puts "Command `help` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(with_text: '%^info help') do |event|
  event.respond '**__Info for:__** `%^help`
**Description:** PMs the user a link to this list of commands. (See %^commands for commands only)
**Usage:** `%^info ping`'
puts "Command `info help` ran by #{event.user.name} (ID: #{event.user.id})."
end

#Ping
bot.command(:ping) do |event|
  m = event.respond('Pong!')
  m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
puts "Command `ping` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(with_text: '%^info ping') do |event|
  event.respond '**__Info for:__** `%^ping`
**Description:** Replies with "Pong!" and the time taken.
**Usage:** `%^ping`'
puts "Command `info ping` ran by #{event.user.name} (ID: #{event.user.id})."
end

#Rate Command
bot.message(starting_with: '%^rate') do |event|
  _, *rating = event.message.content.split
  event.respond "#{event.user.mention} has rated #{rating.join(' ')}/10."
  puts "Command `rate` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(with_text: '%^info rate') do |event|
  event.respond '**__Info for:__** `%^rate`
**Description:** Rate something out of 10.
**Usage:** `%^rate 10`'
puts "Command `rate` ran by #{event.user.name} (ID: #{event.user.id})."
end

#Code Command
bot.command :code do |event|
  event.respond 'Chewbotcca was written in discordrb, and was made by ChewLeKitten#6216. Source code here: http://github.com/Chewsterchew/Chewbotcca'
puts "Command `code` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(with_text: '%^info code') do |event|
  event.respond '**__Info for:__** `%^code`
**Description:** Shows a link to the GitHub Repository for Chewbotcca.
**Usage:** `%^code`'
puts "Command `info code` ran by #{event.user.name} (ID: #{event.user.id})."
end

#Invite Command
bot.command :invite do |event|
  event.user.pm('Hello! Invite me to your server here: http://chcra.site/Chewbotcca
  Join our support here right here: https://discord.gg/Q8TazNz')
puts "Command `invite` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(with_text: '%^info invite') do |event|
  event.respond '**__Info for:__** `%^invite`
**Description:** PMs the user a link to invite Chewbotcca to your server and a discord invite link to the help server.
**Usage:** `%^invite`'
puts "Command `info invite` ran by #{event.user.name} (ID: #{event.user.id})."
end

#NameMC Command
bot.message(starting_with: '%^namemc') do |event|
  _, *namemc = event.message.content.split
  event.respond "NameMC Search: http://namemc.com/s/#{namemc.join(' ')}"
puts "Command `namemc` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^info namemc') do |event|
  event.respond '**__Info for:__** `%^namemc`
**Description:** Shows a link to search results for a response, or if there''s one result, will show detailed info.
**Usage:** `%^namemc ChewLeKitten` or `%^namemc play.chewcraft.me`'
puts "Command `info namemc` ran by #{event.user.name} (ID: #{event.user.id})."
end

#Stats Command
bot.command :stats do |event|
  event.respond "Chewbotcca - A basic functioning discord bot.
Author: ChewLeKitten#6216 [116013677060161545]
Library: discordrb 3.0.1
Server Count: #{event.bot.servers.count}"
puts "Command `stats` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^info stats') do |event|
  event.respond '__Help for:__ `%^stats`
**Description:** Shows basic stats for Chewbotcca.
**Usage:** `%^stats`'
puts "Command `info stats` ran by #{event.user.name} (ID: #{event.user.id})."
end

#RIP Command
bot.message(starting_with: '%^rip') do |event|
  _, *rip = event.message.content.split
  event.respond "#{rip.join(' ')} got #rekt! http://ripme.xyz/#{rip.join(' ')}"
  puts "Command `rip` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^info rip') do |event|
  event.respond '__Help for:__ `%^rip`
**Description:** Makes someone or something rip. No spaces, letters and numbers only.
**Usage:** `%^rip Chew`'
puts "Command `info rip` ran by #{event.user.name} (ID: #{event.user.id})."
end

#MemeDB
bot.message(with_text: '%^memedb') do |event|
  event.respond 'Find the entire memedb here: http://memedb.chewcraft.me
  Pick a meme with `%^memedb [meme name]` ```Current Memes:
  deanmeme, rickroll, vegans, spotad, petpet, nicememe, paycheck, pokesteak, losthope, timetostop, skypetrash, trap, triggered```'
puts "Command `memedb` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(with_text: '%^info memedb') do |event|
  event.respond '__Help for:__ `%^memedb`
**Description:** Shows a list of the entire meme database, or if arguments are provided, searches for that meme.
**Usage:** `%^memedb` or `%^memedb rickroll`'
puts "Command `info memedb` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb submit') do |event|
  event.respond 'Submit your meme for the database here: http://goo.gl/forms/BRMomYVizsY7SqOg2'
  puts "Command `memedb submit` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb deanmeme') do |event|
  event.respond 'http://memedb.chewcraft.me/memes/deanmeme.png'
  puts "Command `memedb deanmeme` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb rickroll') do |event|
  event.respond 'http://memedb.chewcraft.me/memes/rickroll.gif'
  puts "Command `memedb rickroll` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb vegans') do |event|
  event.respond 'http://memedb.chewcraft.me/memes/vegans.png submitted by Stalemated#4473'
  puts "Command `memedb vegans` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb spotad') do |event|
  event.respond "http://memedb.chewcraft.me/memes/spotad.jpg"
  puts "Command `memedb spotad` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb petpet') do |event|
  event.respond "http://memedb.chewcraft.me/memes/petpet.jpg"
  puts "Command `memedb petpet` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb nicememe') do |event|
  event.respond "http://memedb.chewcraft.me/memes/nicememe.gif submitted by Stalemated#4473"
  puts "Command `memedb nicememe` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb paycheck') do |event|
  event.respond "http://memedb.chewcraft.me/memes/paycheck.JPG"
  puts "Command `memedb paycheck` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb pokesteak') do |event|
  event.respond "http://memedb.chewcraft.me/memes/pokesteak.JPG"
  puts "Command `memedb pokesteak` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb losthope') do |event|
  event.respond "http://memedb.chewcraft.me/memes/losthope.png submitted by Stalemated#4473"
  puts "Command `memedb losthope` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb timetostop') do |event|
  event.respond "http://memedb.chewcraft.me/memes/timetostop.gif"
  puts "Command `memedb timetostop` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb skypetrash') do |event|
  event.respond "http://memedb.chewcraft.me/memes/skypetrash.gif submitted indirectly by SplitPixl#9184"
  puts "Command `memedb skypetrash` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb trap') do |event|
  event.respond "http://memedb.chewcraft.me/memes/trap.jpeg submitted by Mini#5311"
  puts "Command `memedb trap` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^memedb triggered') do |event|
  event.respond "http://memedb.chewcraft.me/memes/triggered.gif submitted indirectly by speedo#0032"
  puts "Command `memedb triggered` ran by #{event.user.name} (ID: #{event.user.id})."
end

#Status Commands
bot.message(with_text: '%^statusservers', from: 116013677060161545) do |event|
  event.bot.game = "on #{event.bot.servers.count} servers."
  event.respond "Enabled Status."
  puts "Command `statusservers` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(with_text: '%^statusservers', from: not!(116013677060161545)) do |event|
  event.respond "Bot Owner Only!"
  puts "Command ran without permission! `statusservers` by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^status', from: 116013677060161545) do |event|
  _, *status = event.message.content.split
  event.respond "Status set to: #{status.join(' ')}"
  event.bot.game = "#{status.join(' ')}"
  puts "Command `status` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^status', from: not!(116013677060161545)) do |event|
  event.respond "Bot Owner Only!"
  puts "Command ran without permission! `sinfo` ran by #{event.user.name} (ID: #{event.user.id})."
end

#Namecheap
bot.message(starting_with: '%^namecheap') do |event|
  _, *domain = event.message.content.split
  event.respond "NameCheap Domain Search Results [only one word]: https://www.namecheap.com/domains/registration/results.aspx?domain=#{domain.join(' ')}"
  puts "Command `namecheap` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(with_text: '%^info namecheap') do |event|
  event.respond '__Help for:__ `%^namecheap`
**Description:** Searches namecheap.com for a domain name. No spaces or special characters, just a normal domain search.
**Usage:** `%^namecheap google.com`'
puts "Command `info namecheap` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^domainwhois') do |event|
  _, *whois = event.message.content.split
  event.respond "Domain Whois Results [only one word]: https://www.namecheap.com/domains/whois/results.aspx?domain=#{whois.join(' ')}"
  puts "Command `domainwhois` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(with_text: '%^info domainwhois') do |event|
  event.respond "__Help for:__ `%^domainwhois`
**Description:** Returns a link to see the Whois of a domain.
**Usage:** `%^domainwhois google.com`"
puts "Command `info domainwhois` ran by #{event.user.name} (ID: #{event.user.id})."
end

#MCAvatar
bot.message(starting_with: '%^mcavatar') do |event|
  _, *thefull = event.message.content.split
  event.respond "Alright, here is a 3D full view of the player for the skin: #{thefull.join(' ')}. https://visage.surgeplay.com/full/512/#{thefull.join(' ')}.png"
  puts "Command `mcavatar` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^info mcavatar') do |event|
  event.respond "**__Info for:__** `%^mcavatar`
**Description:** Returns a link to see a 3d view of a skin. Put a minecraft username to check it out!
**Usage:** `%^mcavatar ChewLeKitten`"
puts "Command `info mcavatar` ran by #{event.user.name} (ID: #{event.user.id})."
end

#Sinfo
bot.command :sinfo do |event|
  event.respond "Server Stats (WORK IN PROGRESS)
Server Name: #{event.server.name}
Server ID: #{event.server.id}
Server Region: #{event.server.region}"
puts "Command `sinfo` ran by #{event.user.name} (ID: #{event.user.id})."
end
bot.message(starting_with: '%^info sinfo') do |event|
  event.respond "**__Info for:__** `%^sinfo`
**Description:** Shows some basic server information stats.
**Usage:** `%^sinfo`"
puts "Command `info mcavatar` ran by #{event.user.name} (ID: #{event.user.id})."
end

#Eval (No %^info)
bot.command(:eval, help_available: false) do |event, *code|
  break unless event.user.id == 116013677060161545

  begin
    eval code.join(' ')
  rescue
    'An error occured'
  end
end

#Shoo (Shutdown, no %^info)
bot.command(:shoo, help_available: false) do |event|
  break unless event.user.id == 116013677060161545

  bot.send_message(event.user.pm, 'Hey, I am shutting down!')
  exit
end

#Voice Stuff, WIP
bot.command(:connect) do |event|
  break unless event.user.id == 116013677060161545
  channel = event.user.voice_channel
  next "You're not in any voice channel!" unless channel
  bot.voice_connect(channel)
  "Connected to voice channel: #{channel.name}. I won't do anything, but I'm here! (I think I'm stuck!)"
end
bot.command(:mrcena) do |event|
  break unless event.user.id == 116013677060161545
  voice_bot = event.voice
  voice_bot.play_file('data/music.mp3')
end

puts "Bot is ready!"
bot.run
