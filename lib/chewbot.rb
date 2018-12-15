puts 'Initial Startup complete, loading all plugins...'

Starttime = Time.now

def loadpls
  Bots.each(&:clear!)
  Dir["#{File.dirname(__FILE__)}/plugins/*.rb"].each do |wow|
    load wow
    require wow
    bob = File.readlines(wow) { |line| line.split.map(&:to_s).join }
    command = bob[0][7..bob[0].length]
    command.delete!("\n")
    command = Object.const_get(command)
    Bots.each do |bot|
      bot.include! command
    end
    puts "Plugin #{command} successfully loaded!"
  end
end

puts 'Done loading plugins! Finalizing start-up'

def uptime
  t = Time.now - Starttime
  mm, ss = t.divmod(60)
  hh, mm = mm.divmod(60)
  dd, hh = hh.divmod(24)
  days = format('%d days, ', dd) if dd != 0
  hours = format('%d hours, ', hh) if hh != 0
  mins = format('%d minutes, ', mm) if mm != 0
  secs = format('%d seconds', ss) if ss != 0
  "#{days}#{hours}#{mins}#{secs}"
end

loadpls

Bots.each do |bot|
  bot.command(:reload) do |event|
    break unless event.user.id == CONFIG['owner_id']

    loadpls
    event.respond 'Reloaded sucessfully!'
  end

  bot.server_create do |event|
    ServerManager.post(event.bot.servers.count, event.bot.shard_key[0])
    event.bot.channel(427_152_376_357_584_896).send_embed do |e|
      e.title = 'I did a join'

      e.add_field(name: 'Server Name', value: event.server.name, inline: true)
      e.add_field(name: 'Server ID', value: event.server.id, inline: true)
      e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)
      e.add_field(name: 'Shard', value: event.bot.shard_key[0].to_s, inline: true)
      e.add_field(name: 'User Count', value: event.server.members.count, inline: true)

      e.color = '00FF00'
    end
  end

  bot.server_delete do |event|
    ServerManager.post(event.bot.servers.count, event.bot.shard_key[0])
    event.bot.channel(427_152_376_357_584_896).send_embed do |e|
      e.title = 'I did a leave'

      e.add_field(name: 'Server Name', value: event.server.name, inline: true)
      e.add_field(name: 'Server ID', value: event.server.id, inline: true)
      e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)
      e.add_field(name: 'Shard', value: event.bot.shard_key[0].to_s, inline: true)

      e.color = 'FF0000'
    end
  end

  # Bot.message(contains: /'hq, '/) do |event|
  #  Commands.add
  #  puts "Command ran by #{event.user.distinct} (#{event.user.id}): #{event.message.content}"
  #  nil
  # end

  puts 'Done loading plugins! Finalizing start-up'

  STATUS = [
    'Leave feedback with %^feedback',
    'Need help? Try',
    'Lost? Join our support server with %^invite'
  ].freeze

  bot.ready do |_event|
    bot.game = "#{STATUS.sample} | %^help"
    sleep 180
    redo
  end

  puts 'Bot is ready!'
end

Bots.each do |bot|
  bot.run(:async)
end

loop do
end
