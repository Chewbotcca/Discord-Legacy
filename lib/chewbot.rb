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

Starttime = Time.now

Dir["#{File.dirname(__FILE__)}/plugins/*.rb"].each { |file| require file }

Dir["#{File.dirname(__FILE__)}/plugins/*.rb"].each do |wow|
  bob = File.readlines(wow) { |line| line.split.map(&:to_s).join }
  command = bob[0][7..bob[0].length]
  command.delete!("\n")
  command = Object.const_get(command)
  bot.include! command
  puts "Command #{command} successfully loaded!"
end

bot.server_create do |event|
  event.bot.game = "on #{event.bot.servers.count} servers | %^help"
end

bot.server_delete do |event|
  event.bot.game = "on #{event.bot.servers.count} servers | %^help"
end

bot.command(:connect) do |event|
  channel = event.user.voice_channel
  next "You're not in any voice channel!" unless channel
  bot.voice_connect(channel)
  "Connected to voice channel: #{channel.name}."
end

bot.ready do |event|
  sleep 10
  bot.game = "on #{event.bot.servers.count} servers | %^help"
end

puts 'Bot is ready!'
bot.run
