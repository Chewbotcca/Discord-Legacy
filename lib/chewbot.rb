require 'discordrb'
require 'rest-client'
require 'json'
require 'yaml'
require 'nokogiri'
require 'open-uri'
puts 'All dependicies loaded'

CONFIG = YAML.load_file('config.yaml')
puts 'Config loaded from file'

Bot = Discordrb::Commands::CommandBot.new token: CONFIG['token'], client_id: CONFIG['client_id'], prefix: ["<@#{CONFIG['client_id']}> ", '%^']

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
  event.bot.game = "on #{event.bot.servers.count} servers | %^help"
  RestClient.post("https://discordbots.org/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', :Authorization => CONFIG['dbotsorg'], :'Content-Type' => :json) unless CONFIG['dbotsorg'].nil?
  RestClient.post("https://bots.discord.pw/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', :Authorization => CONFIG['dbotspw'], :'Content-Type' => :json)
end

Bot.server_delete do |event|
  event.bot.game = "on #{event.bot.servers.count} servers | %^help"
  RestClient.post("https://discordbots.org/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', :Authorization => CONFIG['dbotsorg'], :'Content-Type' => :json) unless CONFIG['dbotsorg'].nil?
  RestClient.post("https://bots.discord.pw/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', :Authorization => CONFIG['dbotspw'], :'Content-Type' => :json) unless CONFIG['dbotspw'].nil?
end

Bot.ready do |event|
  sleep 10
  Bot.game = "on #{event.bot.servers.count} servers | %^help"
  RestClient.post("https://discordbots.org/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', :Authorization => CONFIG['dbotsorg'], :'Content-Type' => :json) unless CONFIG['dbotsorg'].nil?
  RestClient.post("https://bots.discord.pw/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', :Authorization => CONFIG['dbotspw'], :'Content-Type' => :json) unless CONFIG['dbotspw'].nil?
end

puts 'Bot is ready!'
Bot.run
