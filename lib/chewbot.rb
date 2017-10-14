require 'discordrb'
require 'rest-client'
require 'json'
require 'yaml'
require 'nokogiri'
require 'open-uri'
puts 'All dependicies loaded'

CONFIG = YAML.load_file('config.yaml')
puts 'Config loaded from file'

bot = Discordrb::Commands::CommandBot.new token: CONFIG['token'], client_id: CONFIG['client_id'], prefix: ["<@#{CONFIG['client_id']}> ", '%^']

puts 'Initial Startup complete, loading all commands...'

starttime = Time.now

bot.command(:restart, min_args: 1, max_args: 1) do |event, task|
  task.downcase!
  if task == 'help'
    event << 'Possible arguments'
    event << '`pushlocal` - Pushes local repository to github. Usually not used.'
    event << '`restartonly` - Restarts bot without pulling code or anything'
    event << '`update` - Restarts the bot and updates the bot'
    event << '`pushonly` - Pushes code (must `git add` and `git commit`)'
  end
  if event.user.id == CONFIG['owner_id']
    if CONFIG['os'] == 'Windows'
      event.respond 'Restarting not supported on Windows!'
    end
    if CONFIG['os'] == 'Mac' || 'Linux'
      if task == 'update'
        begin
          event.respond 'Restarting and Updating!'
          exec('bash scripts/update.sh')
        end
      end
      if task == 'pushlocal'
        begin
          event.respond 'Restarting and uploading all that fancy local code'
          exec('bash scripts/push.sh')
        end
      end
      if task == 'restartonly'
        begin
          event.respond 'Restarting the bot without updating...'
          exec('bash scripts/restartonly.sh')
        end
      end
      if task == 'pushonly'
        begin
          event.respond 'Restarting the bot using saved commits...'
          exec('bash scripts/pushonly.sh')
        end
      end
    end
  else
    event.respond "You can't restart! (If you are the owner of the bot, you did not configure properly! Otherwise, stop trying to restart the bot!)"
  end
end

# Help Command
bot.command([:help, :commands]) do |event|
  event.respond 'You can find all my commands here: https://chew.pro/Chewbotcca/commands'
end

# Ping
bot.command(:ping) do |event, noedit|
  if noedit == 'noedit'
    event.respond "Pong! Time taken: #{((Time.now - event.timestamp) * 1000).to_i} milliseconds."
  else
    m = event.respond('Pinging...')
    m.edit "Pong! Time taken: #{((Time.now - event.timestamp) * 1000).to_i} milliseconds."
  end
end

# Rate Command
bot.command(:rate, min_args: 1, max_args: 1) do |event, rating|
  event.respond "#{event.user.mention} has rated `#{rating}`/10."
end

# Invite Command
bot.command :invite do |event|
  event.user.pm('Hello! Invite me to your server here: http://bit.ly/Chewbotcca')
end

# NameMC Command
bot.command(:namemc, min_args: 1, max_args: 1) do |event, mcsearch|
  event.respond "NameMC Search: http://namemc.com/s/#{mcsearch}"
end

# Stats Command
bot.command :stats do |event|
  t = Time.now - starttime
  mm, ss = t.divmod(60)
  hh, mm = mm.divmod(60)
  dd, hh = hh.divmod(24)
  event << 'Chewbotcca - A basic, yet functioning, discord bot.'
  event << 'Author: Chew#6216 [116013677060161545]'
  event << 'Code: <http://github.com/Chewsterchew/Chewbotcca>'
  event << 'Bot Version: Beta 1.2.1'
  event << 'Library: discordrb 3.2.1'
  event << "Server Count: #{event.bot.servers.count}"
  event << "Total User Count: #{event.bot.users.count}"
  event << 'Uptime: %d days, %d hours, %d minutes and %d seconds' % [dd, hh, mm, ss]
end

# RIP Command
bot.command(:rip, min_args: 1, max_args: 1) do |event, ripwho|
  event.respond "#{ripwho} got #rekt! http://ripme.xyz/#{ripwho}"
end

# MemeDB
bot.command(:memedb, min_args: 0, max_args: 1) do |event, meme|
  meme.downcase!
  case meme
  when 'deanmeme'
    event.respond 'http://chew.pro/Chewbotcca/memes/deanmeme.png'
  when 'rickroll'
    event.respond 'http://chew.pro/Chewbotcca/memes/rickroll.gif'
  when 'vegans'
    event.respond 'http://chew.pro/Chewbotcca/memes/vegans.png'
  when 'spotad'
    event.respond 'http://chew.pro/Chewbotcca/memes/spotad.jpg'
  when 'petpet'
    event.respond 'http://chew.pro/Chewbotcca/memes/petpet.jpg'
  when 'nicememe'
    event.respond 'http://chew.pro/Chewbotcca/memes/nicememe.gif'
  when 'paycheck'
    event.respond 'http://chew.pro/Chewbotcca/memes/paycheck.JPG'
  when 'pokesteak'
    event.respond 'http://chew.pro/Chewbotcca/memes/pokesteak.JPG'
  when 'losthope'
    event.respond 'http://chew.pro/Chewbotcca/memes/losthope.png'
  when 'timetostop'
    event.respond 'http://chew.pro/Chewbotcca/memes/timetostop.gif'
  when 'skypetrash'
    event.respond 'http://chew.pro/Chewbotcca/memes/skypetrash.gif'
  when 'trap'
    event.respond 'http://chew.pro/Chewbotcca/memes/trap.jpeg'
  when 'triggered'
    event.respond 'https://chew.pro/Chewbotcca/memes/triggered.gif'
  when 'noot'
    event.respond 'https://chew.pro/Chewbotcca/memes/noot.gif'
  when 'iplayedmyself'
    event.respond 'https://chew.pro/Chewbotcca/memes/iplayedmyself.png'
  when 'submit'
    event.respond 'You can submit a meme here: <http://goo.gl/forms/BRMomYVizsY7SqOg2>'
  else
    event.respond "This meme doesn't exist! Make sure you spell the meme name right (CASE SENSITIVE). Here is a list of the current memes: `deanmeme, rickroll, vegans, spotad, petpet, nicememe, paycheck, pokesteak, losthope, timetostop, skypetrash, trap, triggered, noot, iplayedmyself`"
  end
end

# Namecheap
bot.command(:namecheap, min_args: 1, max_args: 1, usage: 'In order to do a search, you must provide ONE word to search for.') do |event, lookup|
  event.respond "NameCheap Domain Search Results: https://www.namecheap.com/domains/registration/results.aspx?domain=#{lookup}"
end

# MCAvatar
bot.command(:mcavatar, min_args: 1, max_args: 1) do |event, mcuser|
  event.respond "Alright, here is a 3D full view of the player for the skin: #{mcuser}. https://visage.surgeplay.com/full/512/#{mcuser}.png"
end

# Info
bot.command([:sinfo, :serverinfo]) do |event|
  event << 'Server Stats:'
  event << ''
  event << 'Basic Info:'
  event << "Server Name: #{event.server.name}"
  event << "Server ID: #{event.server.id}"
  event << "Server Region: #{event.server.region}"
  event << "Server Owner: #{event.server.owner.name}\##{event.server.owner.discrim}"
  event << ''
  event << 'Members:'
  event << "Total Member Count: #{event.server.members.count}"
  event << ''
  event << 'Channels:'
  event << "Total Channel Count: #{event.server.channels.count}"
  event << "Text Channels: #{event.server.text_channels.count}"
  event << "Voice Channels: #{event.server.voice_channels.count}"
  event << ''
  event << 'Roles:'
  event << "Count: #{event.server.roles.count}"
end

bot.command([:uinfo, :userinfo]) do |event|
  event << 'User Info:'
  event << ''
  event << "Name\#Discrim: #{event.user.name}\##{event.user.discrim}"
  event << "User ID: #{event.user.id}"
  event << "Status: ``#{event.user.status}``"
  event << "User Nickname: `#{event.user.nick}`" unless event.user.nick.nil?
  event << "Currently Playing: `#{event.user.game}`" unless event.user.game.nil?
  event << "Your Avatar: https://cdn.discordapp.com/avatars/#{event.user.id}/#{event.user.avatar_id}.webp?size=1024"
end

# Eval (No %^info)
bot.command(:eval) do |event, *code|
  break unless event.user.id == CONFIG['owner_id']
  begin
    event.respond (eval code.join(' ')).to_s
  rescue => e
    event.respond "Well, excuse me, mr nobrain, cant even eval correctly smh. THE ERROR: ```#{e}```"
  end
end

# Shoo (Shutdown, no %^info)
bot.command(:shoo) do |event|
  break unless event.user.id == CONFIG['owner_id']
  m = event.respond("I am shutting dowm, it's been a long run folks!")
  sleep 3
  m.delete
  exit
end

# Voice Stuff, WIP
bot.command(:connect) do |event|
  channel = event.user.voice_channel
  next "You're not in any voice channel!" unless channel
  bot.voice_connect(channel)
  "Connected to voice channel: #{channel.name}."
end
bot.command(:songs) do |event|
  event << 'Use `%^play [song]` to select a song. YOU CANNOT QUEUE A RANDOM URL (yet), MUST BE FROM THIS DIRCTORY'
  event << '```mrcena, rickroll, wearenum1```'
end
bot.command(:play) do |event, song|
  song.downcase!
  case song
  when 'mrcena'
    event.voice.play_file('data/music.mp3')
  when 'rickroll'
    event.voice.play_file('data/rickroll.mp3')
  when 'wearenum1'
    event.voice.play_file('data/wearenum1.mp3')
  else
    event.respond 'Song doesnt exist in the database! Check database with `%^songs`'
  end
end

bot.ready do |event|
  event.bot.game = "on #{event.bot.servers.count} servers | %^help"
end

bot.command(:cat) do |event|
  jsoncat = JSON.parse(RestClient.get('http://random.cat/meow'))['file']
  xmlcat = Nokogiri::XML(open('http://thecatapi.com/api/images/get?format=xml&results_per_page=1')).xpath('//url').text
  event.respond "#{['Aww!', 'Adorable.'].sample} #{[jsoncat, xmlcat].sample}"
end

bot.command(:catfact) do |event|
  event.respond (JSON.parse(RestClient.get('https://catfact.ninja/fact'))['fact']).to_s
end

bot.command(:info, min_args: 0, max_args: 1) do |event, com|
  com.downcase!
  case com
  when 'ping'
    event << '**Info For**: `%^ping`'
    event << '**Description**: Replies with "Pong!" and time in seconds'
    event << '**Arguments**: `noedit` (Pings without editing the message)'
    event << '**Usage:** `%^ping` or `%^ping noedit`'
  when 'help'
    event << '**Info For**: `%^help`'
    event << '**Description**: PMs you a list of commands. (See `%^commands` for commands only)'
    event << '**Usage:** `%^help`'
  when 'commands'
    event << '**Info For**: `%^commands`'
    event << '**Description**: PMs you a list of commands only, no command descriptions are given.'
    event << '**Usage:** `%^commands`'
  when 'info'
    event << '**Info For**: `%^info`'
    event << '**Description**: When a command is specified, it gives more info on a command.'
    event << '**Usage:** `%^info help`'
  when 'invite'
    event << '**Info For**: `%^invite`'
    event << '**Description**: PMs the user a link to invite Chewbotcca to your server, as well as a discord invite link to the bot server.'
    event << '**Usage:** `%^invite`'
  when 'rate'
    event << '**Info For**: `%^rate`'
    event << '**Description**: Rate something out of 10.'
    event << '**Arguments**: Enter a string (pls numbers) after the command.'
    event << '**Usage:** `%^rate 9.2`"'
  when 'namemc'
    event << '**Info For**: `%^namemc`'
    event << '**Description**: Returns a link to search results for <http://namemc.com>. If there is one result, it will show a profile.'
    event << '**Arguments**: Enter a string after the command to search for that.'
    event << '**Usage:** `%^namemc ChewLeKitten` or `%^namemc us.mineplex.com`'
  when 'memedb'
    event << '**Info For**: `%^memedb`'
    event << '**Description**: Shows a list of all the memes in the meme database, if arguments are provided, it "searches" for that meme.'
    event << '**Usage:** `%^memedb` or `%^memedb rickroll`'
  when 'stats'
    event << '**Info For**: `%^stats`'
    event << '**Description**: Shows some basic stats for Chewbotcca.'
    event << '**Usage:** `%^stats`'
  when 'rip'
    event << '**Info For**: `%^rip`'
    event << '**Description**: Returns a <http://ripme.xyz> link.'
    event << '**Arguments**: Put a string after the command.'
    event << '**Usage:** `%^rip Chew`'
  when 'namecheap'
    event << '**Info For**: `%^namecheap`'
    event << '**Description**: Returns a <http://namecheap.com> search results link.'
    event << '**Arguments**: Enter a domain or search string.'
    event << '**Usage:** `%^namecheap google`'
  when 'uinfo'
    event << '**Info For**: `%^uinfo`'
    event << '**Description**: Shows some basic stats for the user.'
    event << '**Usage:** `%^uinfo`'
  when 'sinfo'
    event << '**Info For**: `%^sinfo`'
    event << '**Description**: Shows some basic stats for the server.'
    event << '**Usage:** `%^sinfo`'
  when 'cat'
    event << '**Info For**: `%^cat`'
    event << '**Description**: Shows a RANDOM CAT AWWWWWWW.'
    event << '**Usage:** `%^cat`'
  when 'catfact'
    event << '**Info For**: `%^catfact`'
    event << '**Description**: Shows a random catfact. For example: cats meow.'
    event << '**Usage**: `%^catfact`'
  when 'trbmb'
    event << '**Info For**: `%^trbmb`'
    event << '**Description**: Generates a random phrase. Based on http://trbmb.chew.pw.'
    event << '**Usage:** `%^trbmb`'
  when 'uptime'
    event << '**Info For**: `%^uptime`'
    event << '**Description**: Show bot uptime.'
    event << '**Usage:** `%^uptime`'
  else
    event.respond 'You failed, possible causes: You spelled the command wrong or that command doesn\'t exist. Use `%^help` to see commands.'
  end
end

bot.server_create do |event|
  event.bot.game = "on #{event.bot.servers.count} servers | %^help"
end

bot.server_delete do |event|
  event.bot.game = "on #{event.bot.servers.count} servers | %^help"
end

bot.command(:trbmb) do |event|
  event.respond "That really #{['bites', 'highs', 'burns', 'ruins', 'humids', 'leans', 'quiets', 'traffics', 'homes', 'crashes', 'trumps', 'backs', 'salts', 'xboxs', 'closes', 'records', 'stops', 'sevens', 'pollutes', 'kills', 'rents', 'cleans', 'extras', 'boggles', "Taylor's", 'snaps', 'questions', "coffee's", 'clicks', 'pops', 'ticks', 'maintains', 'stars', 'ties', 'nys', 'bills', 'defends', 'opens', 'airs', 'Americans', 'steals', 'drinks', 'yous', 'businesses', 'teleys', 'invents', 'thanks', 'students', 'computers', 'frees', 'weathers', 'vends', 'severs', 'allergies', 'silences', 'fires', 'ambers', 'pushes', 'screws', 'smokes', 'mrs', 'reds', 'consumes', "let's", 'classes', 'makes', 'draws', 'lights', 'butters', 'celebrates', 'drives', 'pulls', 'toxics', 'finds', 'waters', 'pets', 'lags', 'types', 'environments', 'grows', 'builds', 'moos', 'tunas', 'confuses', 'classifies', 'births', 'fails', 'breaks', 'emotionals', 'booms', 'calls', 'taxes', 'burgers', '4s', 'gases', 'potatoes', 'pre owns', 'sends', 'mows', 'tickles', 'lefts', 'Saharas', 'nals', 'unites', 'camps', 'roses', 'shuts down', 'macs', 'apples', 'cheeses', 'turns', 'flexes', 'moves', 'trucks', 'necks', 'swallows', "Harry's", 'flushes', 'pays', 'eyes', 'cities', 'increases', 'trains', 'cooks', "i's", 'cringes', 'unders', 'folds', 'enters', 'speeds', 'roads', 'spends', 'tacos', 'pumps', 'hearts', 'Willows', 'reads', 'suhs', 'dogs', 'rocks', 'cookies'].sample} my #{['bites', 'voices', 'rubber', 'jokes', 'weather', 'dabs', 'time', 'jams', 'depots', 'parties', 'country', 'Clinton', 'fires', 'grasses', 'one', 'door', 'videos', 'signs', 'elevens', 'air', 'mood', 'movie', 'rooms', 'roads', 'brain cells', 'points', 'mind', 'Swifts', 'chats', 'vibe', 'motives', 'mugs', 'pens', 'buttons', 'sanity', 'tocks', 'office', 'scouts', 'shoes', 'keys', 'nyes', 'freedom', 'will to live', 'force', 'flags', 'Gatorade', 'sprite', 'tubes', 'service', 'phones', 'wheel', 'yous', 'services', 'labs', 'tuition', 'ford', 'machines', 'warnings', 'alert', 'phone', 'extinguishers', 'dexterious', 'driver', 'detector', 'jos', 'cross', 'M&Ms', 'goes', 'days', 'pictures', 'poles', 'biscuit', '75 years', 'cars', 'levers', 'waters', 'ways out', 'burgers', 'dogs', 'minecraft', 'emojis', 'sciences', 'trees', 'legos', 'buildings', 'cows', 'fish', 'conversation', 'animals', 'certificates', 'science classes', 'hearts', 'issues', 'roasted', 'horns', 'friends', 'kings', 'Gs', 'birthdays', 'stations', 'chips', 'vehicles', 'texts', 'lawns', 'pickles', 'lanes', 'deserts', 'genes', 'rocks', 'states', 'outs', 'coffee', 'reds', 'computers', 'books', 'watches', 'milk', 'steaks', 'teens', 'wheels', 'muscles', 'homes', 'stops', 'self', 'tattoos', 'food', 'Potters', 'toilets', 'brows', 'limits', 'toasts', 'towers', 'volume', 'tracks', 'wears', 'bones', 'oragamies', 'zones', 'kills', 'money', 'bells', 'ups', 'radios', 'ways', "Donald's", 'springs', 'elections', 'walls', 'corn', 'dudes', 'filters', 'rolls', 'tongues'].sample}"
end

puts 'Bot is ready!'
bot.run
