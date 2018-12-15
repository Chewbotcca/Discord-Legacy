require 'dblruby'
require 'discordrb'
require 'rest-client'
require 'json'
require 'yaml'
require 'nokogiri'
require 'open-uri'
puts 'All dependencies loaded'

puts "Starting bot on shard #{ARGV[0]}!"

CONFIG = YAML.load_file('config.yaml')
puts 'Config loaded from file'

# DBL = DBLRuby.new(CONFIG['dbotsorg'], CONFIG['client_id'])
# puts 'Properly Instantiated DBL!'

Bots = Array.new(CONFIG['shards'], nil)

Bots.length.times do |amount|
  Bots[amount] = Discordrb::Commands::CommandBot.new(token: CONFIG['token'],
                                                     client_id: CONFIG['client_id'],
                                                     prefix: ["<@#{CONFIG['client_id']}> ", '%^'],
                                                     ignore_bots: true,
                                                     num_shards: CONFIG['shards'],
                                                     shard_id: amount.to_i,
                                                     spaces_allowed: true,
                                                     compress_mode: :stream)
end

require_relative 'lib/chewbot'
