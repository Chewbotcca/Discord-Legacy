require 'discordrb'
require 'rest-client'
require 'json'
puts "All dependicies loaded"

bot = Discordrb::Commands::CommandBot.new token: 'your_token', client_id: bot_id, prefix: '%^'
puts "Initial Startup complete, loading all commands..."

#Help Command
bot.command(:help, description: 'Gives help for a command.') do |event|
  m = event.respond("I have sent you a list of commands!")
  event.user.pm('```Command List:
  %^ping - Replies with "Pong!"
  %^help - Shows a list of commands.
  %^commands - Shows a list of only commands, no descriptions.
  %^info - Type in a command (NO PREFIX) and it will give info on the command.
  %^invite - Shows a link to invite Chewbotcca to your server and a discord invite link to the help server.
  %^code - Shows a link to the GitHub Repository to Chewbotcca.
  %^rate - Rate something /10.
  %^namemc - Shows a link to search results for a response, or if there''s one result, will show detailed info.
  %^memedb - Shows a list of the entire meme database.
  %^memedb submit - Submit a meme to the meme database.
  %^stats - Shows basic stats for Chewbotcca.
  %^rip - Makes someone or something rip. No spaces, letters and numbers only.
  %^namecheap - Searches namecheap.com for a domain name. No spaces or special characters, just a normal domain search.
  %^uinfo - Shows basic stats for the user.
  %^sinfo - Shows basic stats for the server.
  %^cat - Shows a random cat. meow.```')
  sleep 5
  m.delete
end
bot.command(:commands) do |event|
  m = event.respond("I have sent you a list of only commands.")
  event.user.pm('```Command List:
  %^ping, %^help, %^commands, %^info, %^invite, %^code, %^rate, %^namemc, %^memedb, %^memedb submit, %^stats, %^rip, %^namecheap, %^uinfo, %^sinfo```')
  sleep 5
  m.delete
end

#Ping
bot.command(:ping) do |event|
  m = event.respond('Pinging...')
  m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
end

#Rate Command
bot.command(:rate, min_args: 1, max_args: 1) do |event|
  _, *rating = event.message.content.split
  event.respond "#{event.user.mention} has rated `#{rating.join(' ')}`/10."
end

#Code Command
bot.command :code do |event|
  event.respond 'Chewbotcca was written in discordrb, and was made by Chew#6216. Source code here: http://github.com/Chewsterchew/Chewbotcca'
end

#Invite Command
bot.command :invite do |event|
  event.user.pm('Hello! Invite me to your server here: http://bit.ly/Chewbotcca
  Join our support here right here: https://discord.gg/Q8TazNz')
end

#NameMC Command
bot.command(:namemc, min_args: 1, max_args: 1) do |event|
  _, *rating = event.message.content.split
  event.respond "NameMC Search: http://namemc.com/s/#{rating.join(' ')}"
end

#Stats Command
bot.command :stats do |event|
  event.respond "Chewbotcca - A basic, yet functioning, discord bot.
Author: Chew#6216 [116013677060161545]
Library: discordrb 3.2.0.1
Server Count: #{event.bot.servers.count}
Total User Count: #{event.bot.users.count}"
end

#RIP Command
bot.command(:rip, min_args: 1, max_args: 1) do |event|
  _, *rating = event.message.content.split
  event.respond "#{rating.join(' ')} got #rekt! http://ripme.xyz/#{rating.join(' ')}"
end

#MemeDB
bot.command(:memedb, min_args: 0, max_args: 1) do |event, list|
if list == "deanmeme"
  event.respond "http://chew.pro/Chewbotcca/memes/deanmeme.png"
elsif list == "rickroll"
  event.respond "http://chew.pro/Chewbotcca/memes/rickroll.gif"
elsif list == "vegans"
  event.respond "http://chew.pro/Chewbotcca/memes/vegans.png"
elsif list == "spotad"
  event.respond "http://chew.pro/Chewbotcca/memes/spotad.jpg"
elsif list == "petpet"
  event.respond "http://chew.pro/Chewbotcca/memes/petpet.jpg"
elsif list == "nicememe"
  event.respond "http://chew.pro/Chewbotcca/memes/nicememe.gif"
elsif list == "paycheck"
  event.respond "http://chew.pro/Chewbotcca/memes/paycheck.JPG"
elsif list == "pokesteak"
  event.respond "http://chew.pro/Chewbotcca/memes/pokesteak.JPG"
elsif list == "losthope"
  event.respond "http://chew.pro/Chewbotcca/memes/losthope.png"
elsif list == "timetostop"
  event.respond "http://chew.pro/Chewbotcca/memes/timetostop.gif"
elsif list == "skypetrash"
  event.respond "http://chew.pro/Chewbotcca/memes/skypetrash.gif"
elsif list == "trap"
  event.respond "http://chew.pro/Chewbotcca/memes/trap.jpeg"
elsif list == "triggered"
  event.respond "http://chew.pro/Chewbotcca/memes/triggered.gif"
elsif list == "submit"
  event.respond "You can submit a meme here: <http://goo.gl/forms/BRMomYVizsY7SqOg2>"
else
  event.respond "This meme doesn't exist! Make sure you spell the meme name right (CASE SENSITIVE). Here is a list of the current memes: `deanmeme, rickroll, vegans, spotad, petpet, nicememe, paycheck, pokesteak, losthope, timetostop, skypetrash, trap, triggered`"
end
end

#Status Commands
bot.command(:setstatusserver, from: 116013677060161545) do |event|
  event.bot.game = "on #{event.bot.servers.count} servers."
  event.respond "Enabled Status."
end
bot.command(:status, from: 116013677060161545) do |event|
  _, *status = event.message.content.split
  event.respond "Status set to: #{status.join(' ')}"
  event.bot.game = "#{status.join(' ')}"
end

#Namecheap
bot.command(:namecheap, min_args: 1, max_args: 1) do |event|
  _, *rating = event.message.content.split
  event.respond "NameCheap Domain Search Results [only one word]: https://www.namecheap.com/domains/registration/results.aspx?domain=#{rating.join(' ')}"
end

#MCAvatar
bot.command(:mcavatar, min_args: 1, max_args: 1) do |event|
  _, *rating = event.message.content.split
  event.respond "Alright, here is a 3D full view of the player for the skin: #{rating.join(' ')}. https://visage.surgeplay.com/full/512/#{rating.join(' ')}.png"
end

#Info
bot.command([:sinfo, :serverinfo]) do |event|
  m = event.respond "Looking up server info, this may take a minute..."
  m.edit "Server Stats:

Basic Info:
Server Name: #{event.server.name}
Server ID: #{event.server.id}
Server Region: #{event.server.region}
Server Owner: #{event.server.owner.name}\##{event.server.owner.discrim}

Members:
Total Member Count: #{event.server.members.count}

Channels:
Total Channel Count: #{event.server.channels.count}
Text Channels: #{event.server.text_channels.count}
Voice Channels: #{event.server.voice_channels.count}

Roles:
Count: #{event.server.roles.count}"
end

bot.command([:uinfo, :userinfo]) do |event|
  m = event.respond "Looking up information about you, please wait..."
  m.edit "User Info:

Name\#Discrim: #{event.user.name}\##{event.user.discrim}
Status: #{event.user.status}
Currently Playing: #{event.user.game}"
end

#Eval (No %^info)
bot.command(:eval, help_available: false, from: 116013677060161545) do |event, *code|
  begin
    eval code.join(' ')
  rescue
    'Well, excuse me, mr nobrain, cant even eval correctly smh.'
  end
end

#Shoo (Shutdown, no %^info)
bot.command(:shoo, help_available: false) do |event|
  break unless event.user.id == 116013677060161545
  m = event.respond("I am shutting dowm, it's been a long run, folks!")
  bot.send_message(event.user.pm, 'Hey, I am shutting down!')
  sleep 3
  m.delete
  exit
end

#Voice Stuff, WIP
bot.command(:connect) do |event|
  channel = event.user.voice_channel
  next "You're not in any voice channel!" unless channel
  bot.voice_connect(channel)
  "Connected to voice channel: #{channel.name}."
end
bot.command(:songs) do |event|
  event.respond "Use `%^[song] to select a song. YOU CANNOT QUEUE A RANDOM URL, MUST BE FROM THIS DIRCTORY
mrcena, rickroll, wearenum1"
end
bot.command(:mrcena) do |event|
  voice_bot = event.voice
  voice_bot.play_file('data/music.mp3')
end
bot.command(:rickroll) do |event|
  voice_bot = event.voice
  voice_bot.play_file('data/rickroll.mp3')
end
bot.command(:wearenum1) do |event|
  voice_bot = event.voice
  voice_bot.play_file('data/wearenum1.mp3')
end

bot.ready do |event|
  event.bot.game = "on #{event.bot.servers.count} servers."
  bot.send_message(272918497489846272, "Bot has restarted/reloaded or something.")
end

bot.command(:cat) do |event|
  event.respond "#{JSON.parse(RestClient.get('http://random.cat/meow'))['file']}"
end

bot.command(:catfact) do |event|
  event.respond "#{JSON.parse(RestClient.get('http://catfacts-api.appspot.com/api/facts'))['facts'][0]}"
end

bot.command(:info, min_args: 1, max_args: 1) do |event, com|
  if com == "ping"
  event.respond "**Info For**: `%^ping`
**Description**: Replies with \"Pong!\" and time in seconds.
**Usage:** `%^ping`"
elsif com == "help"
  event.respond "**Info For**: `%^help`
**Description**: PMs you a list of commands. (See `%^commands` for commands only)
**Usage:** `%^help`"
elsif com == "commands"
  event.respond "**Info For**: `%^commands`
**Description**: PMs you a list of commands only, no basic descriptions are given.
**Usage:** `%^commands`"
elsif com == "info"
  event.respond "**Info For**: `%^info`
**Description**: When a command is specified, it gives more info on a command.
**Usage:** `%^info help`"
elsif com == "invite"
  event.respond "**Info For**: `%^info`
**Description**: PMs the user a link to invite Chewbotcca to your server, as well as a discord invite link to the bot server.
**Usage:** `%^invite`"
elsif com == "code"
  event.respond "**Info For**: `%^code`
**Description**: Shows a link to the GitHub repository for Chewbotcca
**Usage:** `%^code`"
elsif com == "rate"
  event.respond "**Info For**: `%^rate`
**Description**: Rate something out of 10.
**Usage:** `%^rate 9.2`"
elsif com == "namemc"
  event.respond "**Info For**: `%^namemc`
**Description**: Returns a link to search results for <http://namemc.com>. If there is one result, it will show a profile.
**Usage:** `%^namemc ChewLeKitten` or `%^namemc us.mineplex.com`"
elsif com == "memedb"
  event.respond "**Info For**: `%^memedb`
**Description**: Shows a list of all the memes in the meme database, if arguments are provided, it \"searches\" for that meme.
**Usage:** `%^memedb` or `%^memedb rickroll`"
elsif com == "stats"
  event.respond "**Info For**: `%^stats`
**Description**: Shows some basic stats for Chewbotcca.
**Usage:** `%^stats`"
elsif com == "rip"
  event.respond "**Info For**: `%^rip`
**Description**: Returns a <http://ripme.xyz> link.
**Usage:** `%^rip Chew`"
elsif com == "namecheap"
  event.respond "**Info For**: `%^rip`
**Description**: Returns a <http://namecheap.com> search results link.
**Usage:** `%^namemc google`"
elsif com == "uinfo"
  event.respond "**Info For**: `%^uinfo`
**Description**: Shows some basic stats for the user.
**Usage:** `%^uinfo`"
elsif com == "sinfo"
  event.respond "**Info For**: `%^sinfo`
**Description**: Shows some basic stats for the server.
**Usage:** `%^sinfo`"
elsif com == "cat"
  event.respond "**Info For**: `%^cat`
**Description**: Shows a RANDOM CAT AWWWWWWW.
**Usage:** `%^cat`"
else
  event.respond "You failed, possible causes: 1) You spelled the command wrong. 2) You used improper capitalization, make sure there are no capital letters, or 3) That command doesn\'t exist."
end
end

bot.server_create do |event|
  event.bot.game = "on #{event.bot.servers.count} servers."
end

bot.server_delete do |event|
  event.bot.game = "on #{event.bot.servers.count} servers."
end

puts "Bot is ready!"
bot.run
