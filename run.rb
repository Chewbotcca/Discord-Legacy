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

DBL = DBLRuby.new(CONFIG['dbotsorg'], CONFIG['client_id'])
puts 'Properly Instantiated DBL!'

Bot = Discordrb::Commands::CommandBot.new token: CONFIG['token'],
                                          client_id: CONFIG['client_id'],
                                          prefix: ["<@#{CONFIG['client_id']}> ", CONFIG['prefix']],
                                          num_shards: CONFIG['shards'],
                                          shard_id: ARGV[0].to_i,
                                          ignore_bots: true

require_relative 'lib/chewbot'
