require 'discordrb'
require 'rest-client'
require 'json'
require 'yaml'
puts "All dependicies loaded"

CONFIG = YAML.load_file('config.yaml')
puts "Config loaded from file"

bot = Discordrb::Commands::CommandBot.new token: CONFIG['token'], client_id: CONFIG['client_id'], prefix: '%^'

puts "Initial Startup complete, loading all commands..."

starttime = Time.now

bot.command(:uptime) do |event|
  t = Time.now-starttime
  mm, ss = t.divmod(60)            #=> [4515, 21]
  hh, mm = mm.divmod(60)           #=> [75, 15]
  dd, hh = hh.divmod(24)           #=> [3, 3]
  event.respond "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
end

bot.command(:restart, min_args: 1, max_args:1) do |event, task|
  if (event.user.id == CONFIG['owner_id'])
    if (CONFIG['os'] == "Windows")
      event.respond "Restarting not supported on Windows!"
    end
    if (CONFIG['os'] == "Mac" || "Linux")
      if (task == "update")
        begin
          event.respond "Restarting and Updating!"
          exec('bash scripts/update.sh')
        end
      end
      if (task == "help")
        event.respond "No Problem! I have PM'd you how to restart the bot."
        event.respond "Wait, I forgot how to PM! Please just guess for now."
      end
      if (task == "pushlocal")
        begin
          event.respond "Restarting and uploading all that fancy local code"
          exec('bash scripts/push.sh')
        end
      end
      if (task == "restartonly")
        begin
          event.respond "Restarting the bot without updating..."
          exec('bash scripts/restartonly.sh')
        end
      end
      if (task == "pushonly")
        begin
          event.respond "Restarting the bot using saved commits..."
          exec('bash scripts/pushonly.sh')
        end
      end
    end
  else
    event.respond "You can't restart! (If you are the owner of the bot, you did not configure properly! Otherwise, stop trying to restart the bot!)"
  end
end

#Help Command
bot.command(:help) do |event|
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
bot.command(:ping) do |event, noedit|
  if (noedit == "noedit")
    event.respond "Pong! Time taken: #{Time.now - event.timestamp} seconds."
  else
    m = event.respond('Pinging...')
    m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
  end
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
Library: discordrb 3.2.1
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
  event.respond "https://chew.pro/Chewbotcca/memes/triggered.gif"
elsif list == "noot"
  event.respond "https://chew.pro/Chewbotcca/memes/noot.gif"
elsif list == "submit"
  event.respond "You can submit a meme here: <http://goo.gl/forms/BRMomYVizsY7SqOg2>"
else
  event.respond "This meme doesn't exist! Make sure you spell the meme name right (CASE SENSITIVE). Here is a list of the current memes: `deanmeme, rickroll, vegans, spotad, petpet, nicememe, paycheck, pokesteak, losthope, timetostop, skypetrash, trap, triggered`"
end
end

#Status Commands
bot.command(:setstatusserver, from: 348607473546035200) do |event|
  event.bot.game = "on #{event.bot.servers.count} servers."
  event.respond "Enabled Status."
end
bot.command(:status, from: 348607473546035200) do |event|
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
  event.respond "Server Stats:

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
  event.respond  "User Info:

Name\#Discrim: #{event.user.name}\##{event.user.discrim}
User ID: #{event.user.id}
Status: #{event.user.status}
Currently Playing: #{event.user.game}
Your Avatar: https://cdn.discordapp.com/avatars/#{event.user.id}/#{event.user.avatar_id}.webp?size=1024"
end

#Eval (No %^info)
bot.command(:eval, help_available: false, from: 348607473546035200) do |event, *code|
  begin
    eval code.join(' ')
  rescue => e
    "Well, excuse me, mr nobrain, cant even eval correctly smh. THE ERROR: #{e}"
  end
end

#Shoo (Shutdown, no %^info)
bot.command(:shoo, help_available: false) do |event|
  break unless event.user.id == 348607473546035200
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
end

bot.command(:cat) do |event|
  event.respond "#{["Aww!","Adorable."].sample} #{JSON.parse(RestClient.get('http://random.cat/meow'))['file']}"
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
elsif com == "trbmb"
  event.respond "**Info For**: `%^trbmb`
**Description**: Generates a random phrase. Based on http://trbmb.chew.pw.
**Usage:** `%^trbmb`"
elsif com == "uptime"
  event.respond "**Info For**: `%^uptime`
**Description**: Show bot uptime.
**Usage:** `%^uptime`"
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

bot.command(:trbmb) do |event|
  event.respond "That really #{["bites","highs","burns","ruins","humids","leans","quiets","traffics","homes","crashes","trumps","backs","salts","xboxs","closes","records","stops","sevens","pollutes","kills","rents","cleans","extras","boggles","Taylor's","snaps","questions","coffee's","clicks","pops","ticks","maintains","stars","ties","nys","bills","defends","opens","airs","Americans","steals","drinks","yous","businesses","teleys","invents","thanks","students","computers","frees","weathers","vends","severs","allergies","silences","fires","ambers","pushes","screws","smokes","mrs","reds","consumes","let's","classes","makes","draws","lights","butters","celebrates","drives","pulls","toxics","finds","waters","pets","lags","types","environments","grows","builds","moos","tunas","confuses","classifies","births","fails","breaks","emotionals","booms","calls","taxes","burgers","4s","gases","potatoes","pre owns","sends","mows","tickles","lefts","Saharas","nals","unites","camps","roses","shuts down","macs","apples","cheeses","turns","flexes","moves","trucks","necks","swallows","Harry's","flushes","pays","eyes","cities","increases","trains","cooks","i's","cringes","unders","folds","enters","speeds","roads","spends","tacos","pumps","hearts","Willows","reads","suhs","dogs","rocks","cookies"].sample} my #{["bites","voices","rubber","jokes","weather","dabs","time","jams","depots","parties","country","Clinton","fires","grasses","one","door","videos","signs","elevens","air","mood","movie","rooms","roads","brain cells","points","mind","Swifts","chats","vibe","motives","mugs","pens","buttons","sanity","tocks","office","scouts","shoes","keys","nyes","freedom","will to live","force","flags","Gatorade","sprite","tubes","service","phones","wheel","yous","services","labs","tuition","ford","machines","warnings","alert","phone","extinguishers","dexterious","driver","detector","jos","cross","M&Ms","goes","days","pictures","poles","biscuit","75 years","cars","levers","waters","ways out","burgers","dogs","minecraft","emojis","sciences","trees","legos","buildings","cows","fish","conversation","animals","certificates","science classes","hearts","issues","roasted","horns","friends","kings","Gs","birthdays","stations","chips","vehicles","texts","lawns","pickles","lanes","deserts","genes","rocks","states","outs","coffee","reds","computers","books","watches","milk","steaks","teens","wheels","muscles","homes","stops","self","tattoos","food","Potters","toilets","brows","limits","toasts","towers","volume","tracks","wears","bones","oragamies","zones","kills","money","bells","ups","radios","ways","Donald's","springs","elections","walls","corn","dudes","filters","rolls","tongues"].sample}"
end

puts "Bot is ready!"
bot.run
