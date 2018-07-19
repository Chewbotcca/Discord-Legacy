require 'dblruby'
require 'discordrb'
require 'rest-client'
require 'json'
require 'yaml'
require 'nokogiri'
require 'open-uri'
require 'listcordrb'
puts 'All dependencies loaded'

CONFIG = YAML.load_file('config.yaml')
puts 'Config loaded from file'

DBL = DBLRuby.new(CONFIG['dbotsorg'], CONFIG['client_id'])
puts 'Properly Instantiated DBL!'

LC = ListCordRB.new(CONFIG['listcord'], CONFIG['client_id'])
puts 'Properly Instantiated ListCord!'

Bot = Discordrb::Commands::CommandBot.new token: CONFIG['token'],
                                          client_id: CONFIG['client_id'],
                                          prefix: ["<@#{CONFIG['client_id']}> ", CONFIG['prefix']]

puts 'Initial Startup complete, loading all plugins...'

Starttime = Time.now

Dir["#{File.dirname(__FILE__)}/plugins/*.rb"].each { |file| require file }

Dir["#{File.dirname(__FILE__)}/plugins/*.rb"].each do |wow|
  bob = File.readlines(wow) { |line| line.split.map(&:to_s).join }
  command = bob[0][7..bob[0].length]
  command.delete!("\n")
  command = Object.const_get(command)
  Bot.include! command
  puts "Plugin #{command} successfully loaded!"
end

puts 'Done loading plugins! Finalizing start-up'

Bot.server_create do |event|
  DBL.stats.updateservercount(event.bot.servers.count) unless CONFIG['dbotsorg'].nil?
  LC.stats.servers = event.bot.servers.count unless CONFIG['listcord'].nil?
  RestClient.post("https://bots.discord.pw/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', Authorization: CONFIG['dbotspw'], 'Content-Type': :json)
  Bot.channel(427_152_376_357_584_896).send_embed do |e|
    e.title = 'I did a join'

    e.add_field(name: 'Server Name', value: event.server.name, inline: true)
    e.add_field(name: 'Server ID', value: event.server.id, inline: true)
    e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)
    e.add_field(name: 'User Count', value: event.server.members.count, inline: true)

    userid = CONFIG['owner_id'].to_i
    user = Bot.user(userid)

    e.add_field(name: 'Are you on it?', value: event.server.members.include?(user), inline: true)

    e.color = '00FF00'
  end
end

Bot.server_delete do |event|
  DBL.stats.updateservercount(event.bot.servers.count) unless CONFIG['dbotsorg'].nil?
  LC.stats.servers = event.bot.servers.count unless CONFIG['listcord'].nil?
  RestClient.post("https://bots.discord.pw/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', Authorization: CONFIG['dbotspw'], 'Content-Type': :json) unless CONFIG['dbotspw'].nil?
  Bot.channel(427_152_376_357_584_896).send_embed do |e|
    e.title = 'I did a leave'

    e.add_field(name: 'Server Name', value: event.server.name, inline: true)
    e.add_field(name: 'Server ID', value: event.server.id, inline: true)
    e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)

    e.color = 'FF0000'
  end
end

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

pre = CONFIG['prefix']

STATUS = [
  "Leave feedback with #{pre}feedback",
  'Need help? Try',
  "Vote with #{pre}votes!",
  "Lost? Join our support server with #{pre}invite"
].freeze

Bot.ready do |_event|
  Bot.game = "#{STATUS.sample} | #{pre}help"
  sleep 180
  redo
end

puts "Bot is ready!"
Bot.run
